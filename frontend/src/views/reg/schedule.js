import React, {useState} from 'react';
import axios from 'axios';
import Dropzone from 'react-dropzone';
import { Typography, Button, Form, message, Input } from 'antd'; 
import plus from '../../plus.png';
import StbList from '../List/StbList/StbList';
import ScheduleList from '../List/ScheduleList/ScheduleList';
import server_jso from '../../server.json'
import "antd/dist/antd.css";

const backend_url = server_jso.base_url;

const { Title } = Typography;

function Schedule(){
    const [VideoTitle, setVideoTitle] = useState("");
    const [FilePath, setFilePath] = useState("");
    const [Thumbnail, setThumbnail] = useState("");
    const [Duration, setDuration] = useState("");
    const [STBInfo, setSTBInfo] = useState({
        uid: "",
        main_stb_sn: "",
        sub_stb_sn: "",
        update_time: "",
        network_status: ""
    });
    const [SCHEDULEInfo, setSCHEDULEInfo] = useState({
        uid: "",
        stb_sn: "",
        name: "",
        update_time: "",
        order: "",
        start: "",
        end: "",
        main_name: "",
        home_name: "",
        checklist_name: "",
        layout_name: "",
        media_name: ""
    });
    const [state, setState] = useState({
        stb: ""
    });

    function onTitleChange(e){
        setVideoTitle(e.currentTarget.value);
    }

    function handleChange(e){
        const {id, value} = e.target;
        setState((prevState) => ({
            ...prevState,
            [id]: value,
        }));
    }

    function stb_select(stb_sn_func){
        setState({
            stb: stb_sn_func
        })
        // console.log(stb_sn_func);
    }

    function checkDataValue(){
        console.log(STBInfo);
        console.log(SCHEDULEInfo);
    }

    function onDrop(files){
        let formData = new FormData();
        const config = {
            header: {'content-type' : 'multipart/form-data'}
        }
        formData.append("file", files[0]);

        console.log(files);

        axios.post(backend_url+"/meditation/upload", formData, {config})
            .then((response) => {
                if(response.data.success){
                    let variable = {
                        filePath: response.data.filePath,
                        fileName: response.data.fileName
                    }
                    
                    // setFileName 추가 필요
                    setFilePath(response.data.filePath);
                    alert("서버에 저장 완료")
                    console.log(response.data) // filePath, fileName 정보 가지고 있다가 submit 하면 같이 보내기(폼은 file_path, file_name 으로)
                    
                    axios.post(backend_url+'/meditation/thumbnail', variable)
                        .then(response => {
                            if (response.data.success) {
                                console.log(response.data); 
                                setDuration(response.data.fileDuration)
                                setThumbnail(response.data.thumbsFilePath)
                            } else {
                                alert('Failed to make the thumbnails');
                            }
                        });

                } else {
                    alert("Failed to save the video in server");
                }
            })
    }
    return (
        <div style = {{maxWidth:'300px', margin:'2erm auto'}}>
            <div style = {{textAlign:'center', marginBottom:'2rem'}}>
                <Button type="primary" onClick={checkDataValue}>데이터 값 확인</Button>
                <Title level={2}>스케줄 작성</Title><hr/>
                <h3>배포 이름</h3><Input id="distribution" placeholder="배포 이름" onChange={handleChange} style = {{width:'200px'}}></Input><br/><hr/>
                {/* 세탑 목록 -> 고른 세탑 시리얼 props 로 하위 선택지에 저장(하나 택 하면 연관성 있는 정보들만 보이게) 
                -> 하위 데이터들은 visible x 로 */}
                <h2>세탑 목록</h2>
                <StbList stb_select={stb_select} setSTBInfo={setSTBInfo} />
                <h3>스케줄 목록</h3>
                <ScheduleList stb_sn={state.stb} setSCHEDULEInfo={setSCHEDULEInfo} />
                <Button type="primary" style={{display:"none"}}>등록</Button>
                <div>이 밑으로는 depth2 이상</div>
                <hr/>
                <h3>스케줄 이름</h3><Input id="schedule" placeholder="스케줄 이름" onChange={handleChange} style = {{width:'200px'}}></Input><br/><hr/>
                <h3>스케줄 날짜</h3><Input id="schedule_date" placeholder="스케줄 날짜" onChange={handleChange} style = {{width:'200px'}}></Input><br/><br/>
                <h3>스케줄 시작 시간</h3><Input id="schedule_start" placeholder="스케줄 시작 시간" onChange={handleChange} style = {{width:'200px'}}></Input><br/><hr/>
                <h3>스케줄 종료 시간</h3><Input id="schedule_end" placeholder="스케줄 종료 시간" onChange={handleChange} style = {{width:'200px'}}></Input><br/><hr/>
                
                <h3>대기화면 파일</h3>
                <Form onSubmit>
                    <div style = {{display:'flex', justifyContent:'space-between'}}>
                        <Dropzone
                            onDrop={onDrop}
                            multiple={false}
                            maxSize={800000000}>
                                {({ getRootProps, getInputProps}) => (
                                <div style = {{width:'200px', height:'240px', border:'1px solid lightgray', display:'flex', alignItems:'center', 
                                justifyContent:'center'}} {...getRootProps()}>
                                    <input {...getInputProps()} />
                                    <img style={{width:"50px"}} src={plus} />
                                </div>
                            )}
                        </Dropzone>
                         <div>
                             <img src alt />
                         </div>
                    </div>
                    <br/>
                    <br/>
                    <h3>대기화면 이름</h3>
                    <label>제목: </label>
                    <Input
                        onChange = {onTitleChange}
                        value = {VideoTitle}
                    /><br/><br/>
                    <Input id="main" placeholder="대기화면 이름" onChange={handleChange} style = {{width:'200px'}}></Input><br/><br/>
                    <Button type="primary" size="large" onClick >
                        등록
                    </Button>
                    {/* 선택 or 생성 */}
                </Form><br/>
                <h3>홈 화면 선택</h3><Input id="home" placeholder="홈 화면 선택" onChange={handleChange} style = {{width:'200px'}}></Input><br/><br/>
                <h3>홈 화면 이름</h3><Input id="" placeholder="홈 화면 이름" onChange={handleChange} style = {{width:'200px'}}></Input><br/><br/>
                <h3>의료진 선택</h3><Input id="staff" placeholder="의료진 선택" onChange={handleChange} style = {{width:'200px'}}></Input>
                <div>의료진 등록 시 이름/position 지정</div><br/><br/>
                <h3>환자 선택</h3><Input id="patient" placeholder="환자" onChange={handleChange} style = {{width:'200px'}}></Input>
                <h3>환자 이름</h3><Input id="patient_name" placeholder="환자 이름" onChange={handleChange} style = {{width:'200px'}}></Input>
                <h3>환자 성별</h3><Input id="patient_gender" placeholder="환자 성별" onChange={handleChange} style = {{width:'200px'}}></Input>
                <h3>환자 나이</h3><Input id="patient_age" placeholder="환자 나이" onChange={handleChange} style = {{width:'200px'}}></Input>
                <h3>환자 수술 부위</h3><Input id="" placeholder="환자 수술 부위" onChange={handleChange} style = {{width:'200px'}}></Input>
                <div>수술 같은 경우 환자를 선택하면 자동 지정</div>
                <h3>수술 이름</h3><Input id="" placeholder="수술 이름" onChange={handleChange} style = {{width:'200px'}}></Input>
                <div>수술 시간 / 수술 시작 시간 ?</div>
                <h3>Process</h3><Input id="Process" placeholder="Process" onChange={handleChange} style = {{width:'200px'}}></Input>
                <div>Process 원하는 개수로 늘려서 추가해서 order 달아서 전송 필요</div><br/><br/>
                <h3>의료기기 이름</h3><Input id="instrument" placeholder="의료기기 이름" onChange={handleChange} style = {{width:'200px'}}></Input>
                <h3>의료기기 사진/영상</h3><Input id="" placeholder="의료기기 사진 또는 영상" onChange={handleChange} style = {{width:'200px'}}></Input>
                <div>의료기기기 부분 제외 가능 ?</div><br/><br/>
                <h3>레이아웃 선택(used)</h3><Input id="" placeholder="레이아웃 선택" onChange={handleChange} style = {{width:'200px'}}></Input>
                <div>레이아웃 생성 시</div>
                <h3>레이아웃 이름</h3><Input id="layout" placeholder="레이아웃 이름" onChange={handleChange} style = {{width:'200px'}}></Input>
                <h3>레이아웃 선택(new)</h3><Input id="" placeholder="레이아웃 선택" onChange={handleChange} style = {{width:'200px'}}></Input>
                <div>레이아웃 생성 부분 제외 가능 ?</div>
                <h3>담당 의료진 선택</h3><Input id="" placeholder="의료진 선택" onChange={handleChange} style = {{width:'200px'}}></Input>
                <div>의료진 추가 시</div>
                <h3>의료진 이름</h3><Input id="" placeholder="의료진 이름" onChange={handleChange} style = {{width:'200px'}}></Input>
                <h3>의료진 역할(position)</h3><Input id="" placeholder="의료진 역할(position)" onChange={handleChange} style = {{width:'200px'}}></Input>
                <h3>체크리스트 선택</h3><Input id="checklist" placeholder="체크리스트 선택" onChange={handleChange} style = {{width:'200px'}}></Input>
                <div>체크리스트 생성 시</div>
                <h3>체크리스트 이름</h3><Input id="checklist" placeholder="체크리스트 이름" onChange={handleChange} style = {{width:'200px'}}></Input>
                <h3>체크리스트 내용</h3><Input id="checklist" placeholder="체크리스트 내용" onChange={handleChange} style = {{width:'200px'}}></Input>
            </div>
        </div>
    );
}

export default Schedule;