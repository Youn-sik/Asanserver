import os, sys, getopt

# 기본 선언
argv = sys.argv

PROCESS_NAME = argv[0]
IMAGE_PATH = ""
OUTPUT_PATH = ""


def printHelp():
    print(PROCESS_NAME, "-f <Image path>, --file=<Image path>")
    print("-o, --output=<Output path>. Default: <Image path>_output")
    sys.exit(2)


try:
    opts, etc_args = getopt.getopt(
        argv[1:],
        "f:o:",
        [
            "help",
            "file=",
            "output=",
        ],
    )

except getopt.GetoptError:
    printHelp()

for opt, arg in opts:  # 옵션이 파싱된 경우
    if opt in ("-h", "--help"):  # HELP 요청인 경우 사용법 출력
        printHelp()

    elif opt in ("-f", "--file"):
        IMAGE_PATH = arg

    elif opt in ("-o", "--output"):
        OUTPUT_PATH = arg

if len(IMAGE_PATH) < 1:  # 필수항목 값이 비어있다면
    printHelp()

if len(OUTPUT_PATH) < 1:  # 필수항목 값이 비어있다면
    filename, file_extension = os.path.splitext(IMAGE_PATH)
    OUTPUT_PATH = filename + '_output' + file_extension

# 파일 확인
if not os.path.isfile(IMAGE_PATH):
    print("Input image is not a file.")
    print("")
    printHelp()
    sys.exit(2)

import cv2
import csv
import numpy as np
from centerface import CenterFace

def blend_transparent(face_img, overlay_t_img):
    # Split out the transparency mask from the colour info
    overlay_img = overlay_t_img[:,:,:3] # Grab the BRG planes
    overlay_mask = overlay_t_img[:,:,3:]  # And the alpha plane

    # Again calculate the inverse mask
    background_mask = 255 - overlay_mask

    # Turn the masks into three channel, so we can use them as weights
    overlay_mask = cv2.cvtColor(overlay_mask, cv2.COLOR_GRAY2BGR)
    background_mask = cv2.cvtColor(background_mask, cv2.COLOR_GRAY2BGR)

    # Create a masked out face image, and masked out overlay
    # We convert the images to floating point in range 0.0 - 1.0
    face_part = (face_img * (1 / 255.0)) * (background_mask * (1 / 255.0))
    overlay_part = (overlay_img * (1 / 255.0)) * (overlay_mask * (1 / 255.0))

    # And finally just add them together, and rescale it back to an 8bit integer image    
    return np.uint8(cv2.addWeighted(face_part, 255.0, overlay_part, 255.0, 0.0))


with open("/var/www/backend/face_cut/mask.csv") as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=",")
    src_pts = []
    for i, row in enumerate(csv_reader):
        # skip head or empty line if it's there
        try:
            src_pts.append(np.array([float(row[1]), float(row[2])]))
        except ValueError:
            continue
src_pts = np.array(src_pts, dtype="float32")

mask_img = cv2.imread("/var/www/backend/face_cut/mask.png", -1)

input_img = cv2.imread(IMAGE_PATH)
#input_img = cv2.cvtColor(input_img, cv2.COLOR_BGR2RGB)

h, w = input_img.shape[:2]
centerface = CenterFace()

dets, lms = centerface(input_img, h, w, threshold=0.35)
for lm in lms:

    # 마스크를 씌워보자.
    dst_pts = np.array(
        [
            [lm[0], lm[1]],
            [lm[2], lm[3]],
            [lm[4], lm[5]],
            [lm[6], lm[7]],
            [lm[8], lm[9]],
        ],
        dtype="float32",
    )

    M, _ = cv2.findHomography(src_pts, dst_pts)

    # transformed masked image
    transformed_mask = cv2.warpPerspective(
        mask_img,
        M,
        (input_img.shape[1], input_img.shape[0]),
        None,
        cv2.INTER_LINEAR,
        cv2.BORDER_CONSTANT,
    )

    #print(transformed_mask)

    # mask overlay
    input_img = blend_transparent(input_img, transformed_mask)

cv2.imwrite(OUTPUT_PATH, input_img)
                    lms.append(lm)
            boxes = np.asarray(boxes, dtype=np.float32)
            keep = self.nms(boxes[:, :4], boxes[:, 4], 0.3)
            boxes = boxes[keep, :]
            if self.landmarks:
                lms = np.asarray(lms, dtype=np.float32)
                lms = lms[keep, :]
        if self.landmarks:
            return boxes, lms
        else:
            return boxes

    def nms(self, boxes, scores, nms_thresh):
        x1 = boxes[:, 0]
        y1 = boxes[:, 1]
        x2 = boxes[:, 2]
        y2 = boxes[:, 3]
        areas = (x2 - x1 + 1) * (y2 - y1 + 1)
        order = np.argsort(scores)[::-1]
        num_detections = boxes.shape[0]
        suppressed = np.zeros((num_detections,), dtype=np.bool)

        keep = []
        for _i in range(num_detections):
            i = order[_i]
            if suppressed[i]:
                continue
            keep.append(i)

            ix1 = x1[i]
            iy1 = y1[i]
            ix2 = x2[i]
            iy2 = y2[i]
            iarea = areas[i]

            for _j in range(_i + 1, num_detections):
                j = order[_j]
                if suppressed[j]:
                    continue

                xx1 = max(ix1, x1[j])
                yy1 = max(iy1, y1[j])
                xx2 = min(ix2, x2[j])
                yy2 = min(iy2, y2[j])
                w = max(0, xx2 - xx1 + 1)
                h = max(0, yy2 - yy1 + 1)

                inter = w * h
                ovr = inter / (iarea + areas[j] - inter)
                if ovr >= nms_thresh:
                    suppressed[j] = True

        return keep