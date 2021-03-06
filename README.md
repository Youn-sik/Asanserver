아산병원 프로토콜 페이지: https://docs.google.com/spreadsheets/d/1AFYo4wo9pJe4voFpl1NF9R_l9ljBCYhVcpXnAF1UlpA/edit?hl=ko#gid=0

Asancloud 서버 설치

TMS 서버 설치 문서 진행(.insightface 도 추가) -얼굴 인식 유의 사항: -얼굴인식 데이터 : TMS 등록 후 MongoExport를 통해서 진행(users, groups) -등록 된 사람일 시 서버에 등록 된 사진을 단말에게 전송 함 : /home/kool/asan/backend/uploads/image/ 에 사진 넣기 (TMS 의 /var/www/backend/image/의 사진들을)

cd ~/asan npm install

cd ~/asan/frontend npm install

cd ~/asan/backend npm install

ip 설정파일 변경 /backend/db.js /backend/cloud44.json /backend/face-cut/cloud40.json /frontend/src/server.json

서버 기타 수정 /backend/face-cut/access_realtime.py

with open 부분 계정 명 변경하기(L.42,45)
"/var/www" 부분 있으면 모두 /home/kool/asan... 으로 변경하기
mkdir /home/kool/asan/backend/uploads chmod 777 /home/kool/asan/backend/uploads mkdir /home/kool/asan/backend/image pinky 서버에서 /backend/image 하위의 얼굴 사진 불러오기(위의 디렉터리로)

mkdir /home/kool/asan/backend/uploads/
mkdir /home/kool/asan/backend/uploads/contents/
mkdir /home/kool/asan/backend/uploads/contents/meditation/
chmod 777 -R /home/kool/asan/backend/uploads/

pm2 start 및 startup 파일 목록 access_realtime index matt

mysql 설치 sudo apt update sudo apt install mysql-server

sudo mysql

SET PASSWORD FOR 'root'@'localhost' = PASSWORD('master'); FLUSH PRIVILEGES;

CREATE DATABASE asancloud; CREATE USER 'asan'@'localhost' IDENTIFIED BY 'master123'; GRANT ALL ON asancloud.* TO 'asan'@'localhost'; FLUSH PRIVILEGES;

sudo apt-get install nginx 후 nginx 설정: https://codechacha.com/ko/deploy-react-with-nginx/

sudo systemctl enable emqx sudo systemctl enable nginx sudo systemctl enable mysql sudo systemctl enable mongod

==================================================================================================

이 문서는 asancloud 에 사용되는 MYSQL table 에 대한 설명으로, 데이터 excel 을 작성 할 때의 도움이 되는 것을 목적으로 한다.

테이블 목록: | g_distribution : 스케줄이 배포되는 배포에 대한 테이블이다. | g_schedule : 스케줄 목록에 대한 테이블이다. | g_checklist : 스케줄 중 체크리스트 목록에 대한 테이블이다. | g_checklist_list : 스케줄 중 체크리스트 값에 대한 테이블이다. | g_home : 스케줄 중 의사의 홈 화면 목록에 대한 테이블이다. (| g_home_list : 스케줄 중 의사의 홈 화면 값에 대한 테이블이다.) | g_layout : 스케줄 중 레이아웃 목록에 대한 테이블이다. | g_layout_list_define : 스케줄 중 레이아웃의 정의 값에 대한 테이블이다. | g_layout_list_layout : 스케줄 중 레이아웃의 값에 대한 테이블이다. | g_main : 스케줄 중 대기화면 목록에 대한 테이블이다. (| g_main_list : 스케줄 중 대기화면 값에 대한 테이블이다.) | g_media : 스케줄 중 미디어 목록에 대한 테이블이다. | g_media_list : 스케줄 중 미디어 값에 대한 테이블이다. | g_stb : 아산 서버에 동작하는 세탑에 대한 테이블이다. | g_patient : 환자 정보에 대한 테이블이다. | g_staff : 의료진 정보에 대한 테이블이다. | g_process : 수술 진행 과정 목록에 대한 테이블이다. | g_process_list : 수술 진행 과정 값에 대한 테이블이다. | g_surgery : 수술에 대한 테이블이다.(기존 g_main_list 와 g_home_list 를 통합하였다.)

g_distribution -uid: 고유 값이다. -stb_sn: 세텁 시리얼 번호 값이다. -name: 배포 명이다. -update_time: 셍성 시간(수정 시간) 이다.

g_schedule -uid: 고유 값이다. -stb_sn: 세텁 시리얼 번호 값이다. -name: 스케줄 이름 값이다. -update_time: 생성 시간(수정 시간) 이다. -order: 테이블 간의 값 참조를 위한 고유 값이다. -start: 스케줄 시작 예정 시간이다. -end: 스케줄 종료 예정 시간이다. -main_name: 어떤 대기 화면을 사용할 지 지정하는 값이다. -home_name: 어떤 홈 화면을 사용할 지 지정하는 값이다. -checklist_name: 어떤 체크리스트를 사용할 지 지정하는 값이다. -layout_name: 어떤 레이아웃을 사용할 지 지정하는 값이다. -media_name: 어떤 미디어를 사용할 지 지정하는 값이다.

g_checklist -uid : 고유 값이다. -name : 체크리스트의 이름이다. -update_time : 생성 시간(수정 시간) 이다. -order : 테이블 간의 값 참조를 위한 고유 값이다. -stb_sn : 세텁 시리얼 번호이다.

g_checklist_list -uid: 고유 값이다. -name: 체크리스트 내용의 이름이다. -update_time: 생성 시간(수정 시간) 이다. -order: 테이블 간의 값 참조를 위한 고유 값이다. -checklist_order: 해당 값이 1일 경우, g_checkList 의 order 값이 1인 체크리스트에 이 체크리스트 내용이 속하게 된다. -value: 체크리스트 내용 란 이다.

g_home -uid: 고유 값이다. -name: 홈 화면 이름이다. -update_time: 생성 시간(수정 시간) 이다. -order: 테이블 간의 값 참조를 위한 고유 값이다. -stb_sn: 세텁 시리얼 번호 값이다.

(6. g_home_list -uid: 고유 값이다. -name: 홈 화면 내용의 이름이다. -update_time: 생성 시간(수정 시간) 이다. -order: 테이블 간의 값 참조를 위한 고유 값이다. -start: 홈 화면 시작 예정 시간이다. -end: 홈 화면 종료 예정 시간이다. -g_home_order: 해당 값이 1일 경우, g_home 의 order 값이 1인 홈 화면에 이 홈 화면 내용이 속하게 된다.)

g_layout -uid: 고유 값이다. -name: 레이아웃 이름이다. -update_time: 생성 시간(수정 시간) 이다. -order: 테이블 간의 값 참조를 위한 고유 값이다. -stb_sn: 세텁 시리얼 번호 값이다.

g_layout_list_define -uid: 고유 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -x: x좌표 값이다. -y: y좌표 값이다. -width: 디스플레이의 가로 픽셀 값이다. -height: 디스플레이의 세로 픽셀 값이다. -content_id: 콘텐츠를 또 다른 테이블에 따로 저장한다면, 해당 값을 가르키는 값이다. -contents: 콘텐츠 내용 값이다.

g_layout_list_layout -uid: 고유 값이다. -name: 레이아웃 내용의 이름 값이다. -update_time: 생성 시간(수정 시간) 값이다. -imageurl: 해당 레이아웃의 이미지 주소 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -g_layout_order: 해당 값이 1일 경우, g_layout 의 order 값이 1인 레이아웃에 이 레이아웃 내용이 속하게 된다.

g_main -uid: 고유 값이다. -name: 대기화면 이름 값이다. -update_time: 생성 시간(수정 시간) 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -stb_sn: 세텁 시리얼 번호 값이다.

(11. g_main_list -uid: 고유 값이다. -name: 대기화면 내용의 이름 값이다. -update_time: 생성 시간(수정 시간) 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -start: 대기화면 시간 예정 시간이다. -end: 대기화면 종료 예정 시간이다. -g_main_order: 해당 값이 1일 경우, g_main 의 order 값이 1인 대기화면에 이 대기화면 내용이 속하게 된다.)

g_media -uid: 고유 값이다. -name: 미디어 이름 값이다. -update_time: 생성 시간(수정 시간) 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -stb_sn: 세텁 시리얼 번호 값이다.

g_media_list -uid: 고유 값이다. -name: 미디어 내용 이름 값이다. -update_time: 생성 시간(수정 시간) 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -g_media_order: 해당 값이 1일 경우 g_media 의 order 값이 1인 미디어에 이 미디어 내용이 속하게 된다.

g_stb -uid: 고유 값이다. -main_stb_sn: 세텁 시리얼 번호 값이다. -sub_stb_sn: 테블릿 시리얼 번호 값이다. -update_time: 생성 시간(수정 시간) 값이다. -network_status: 네트워크 연결 상태(서버 연결 상태) 값이다.

g_patient -uid: 고유 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -id: 환자 id 값이다. -name: 환자 이름 값이다. -gender: 환자 성별 값이다. -age: 환자 나이 값이다. -dob: 환자 생년월일 값이다. -surgicalsite: 환자 수술 부위 값이다. -g_surgery_order: 해당 값이 1일 경우 g_home_list 의 order 값이 1인 대기화면 내용에 이 환자 내용이 속하게 된다.

g_staff -uid: 고유 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -id: 의료진 id 값이다. -name: 의료진 이름 값이다. -position: 의료진 직급(위치, 직위 등) 값이다. -g_surgery_order: 해당 값이 1일 경우 g_home_list 의 order 값이 1인 대기화면 내용에 이 의료진 내용이 속하게 된다.

g_process -uid: 고유 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -g_surgery_order: 해당 값이 1일 경우 g_home_list 의 order 값이 1인 대기화면 내용에 이 진행 과정 목록이 속하게 된다.

g_process_list -uid: 고유 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -value: 진행 과정 값이다. -process_order: 해당 값이 1일 경우 g_process 의 order 값이 1인 진행 과정에 이 진행 과정 내용이 속하게 된다.

g_surgery -uid: 고유 값이다. -name: 수술의 이름이다. -update_time: 생성 시간(수정 시간) 값이다. -order: 테이블 값 참조를 위한 고유 값이다. -start: 수술 시작 예정 시간이다. -end: 수술 종료 예정 시간이다. g_main_home_order: 해당 값이 1일 경우 g_home 과 g_main 의 order 값이 1인 홈화면과 대기화면에 이 수술 정보가 속하게 된다.
