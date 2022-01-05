import React, {useState} from 'react';
import axios from 'axios';
import { Typography, Button, Form, message, Input } from 'antd'; 
import StbList from '../List/StbList/StbList';
import ScheduleList from '../List/ScheduleList/ScheduleList';
import server_jso from '../../server.json'
import "antd/dist/antd.css";

const backend_url = server_jso.base_url;
const { Title } = Typography;

function Schedule(){
    const [ButtonDisplay, setButtonDisplay] = useState(false);
    const [VideoTitle, setVideoTitle] = useState("");
    const [Thumbnail, setThumbnail] = useState("");
    const [FileName, setFileName] = useState("");
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
        distribution_name: "",
        schedule: "",
        schedule_date: "",
        schedule_start: "",
        schedule_end: "",
    })

    function onTitleChange(e){
        setVideoTitle(e.currentTarget.value);
    }

    function handleChange(e){
        const {id, value} = e.target;
        setState({
            ...state,
            [id] : value
        });
    }

    async function distribution(){ // backend 로 폼 전송(axios)
        let body = {
            "distribution": {
                "stb_sn": STBInfo.main_stb_sn,
                "name": state.distribution_name,
                "update_time": ""
            },
            "schedule": SCHEDULEInfo
        }
        const res = await axios.post(backend_url+"/distribution_schedule/register", body);
        if(res.data.result == "ok"){
            return "스케줄 등록을 완료하였습니다.";
        } else {

            return "스케줄 등록을 실패하였습니다.";
        }
    }

    function checkDataValue(){
        console.log("=====");
        console.log(state);
        console.log(STBInfo);
        console.log(SCHEDULEInfo);
        // distribution();
        console.log("=====");
    }

    return (
        <div style = {{maxWidth:'450px', margin:'2erm auto'}}>
            <div style = {{textAlign:'center', marginBottom:'2rem'}}>
                <Title level={2}>스케줄 작성</Title><hr/>
                <h3>배포 이름</h3><Input id="distribution_name" placeholder="배포 이름" onChange={handleChange} style = {{width:'200px'}} /><br/><hr/>
                <StbList setSTBInfo={setSTBInfo} />
                <ScheduleList stb_sn={STBInfo.main_stb_sn} setSCHEDULEInfo={setSCHEDULEInfo} setButtonDisplay={setButtonDisplay} />
                { ButtonDisplay == true && state.distribution_name !== "" ? <Button type="primary" onClick={checkDataValue}>등록</Button> : null }
                <div>이 밑으로는 depth2 이상</div>
                <hr/>
                <h3>스케줄 이름</h3><Input id="schedule" placeholder="스케줄 이름" onChange={handleChange} style = {{width:'200px'}}></Input><br/><hr/>
                <h3>스케줄 날짜</h3><Input id="schedule_date" placeholder="스케줄 날짜" onChange={handleChange} style = {{width:'200px'}}></Input><br/><br/>
                <h3>스케줄 시작 시간</h3><Input id="schedule_start" placeholder="스케줄 시작 시간" onChange={handleChange} style = {{width:'200px'}}></Input><br/><hr/>
                <h3>스케줄 종료 시간</h3><Input id="schedule_end" placeholder="스케줄 종료 시간" onChange={handleChange} style = {{width:'200px'}}></Input><br/><hr/>
                
                
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