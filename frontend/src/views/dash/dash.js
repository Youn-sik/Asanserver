import React, {useState} from 'react';
import axios from 'axios';
import {Link} from 'react-router-dom';
import StbList from '../List/StbList/StbList';
import MainList from '../List/MainList/MainList';
import server_jso from '../../server.json'
import { Typography, Button, Form, message, Input } from 'antd'; 
import "antd/dist/antd.min.css";

const backend_url = server_jso.base_url;
const { Title } = Typography;

function Dash(){
    const [ButtonDisplay, setButtonDisplay] = useState(false);
    const [STBInfo, setSTBInfo] = useState({
        uid: "",
        main_stb_sn: "",
        sub_stb_sn: "",
        update_time: "",
        network_status: ""
    });
    const [MAINInfo, setMAINInfo] = useState(new Set());
    const [checkedItems, setCheckedItems] = useState(new Set());

    async function distribution(){ 
        let uid = [];
        for(let item of checkedItems){
            uid.push(item)
        }
        
        let body = {
            "stb_sn": STBInfo.main_stb_sn,
            "values": uid
        }
        const res = await axios.post(backend_url+"/meditation/distribution", body);
        if(res.data.result == "ok"){
            alert("대기화면을 배포 하였습니다."); 
        } else {
            alert("대기화면을 배포하지 못했습니다.");
        }
    }

    async function distroy(){ 
        let uid = [];
        for(let item of checkedItems){
            uid.push(item)
        }

        let body = {
            "uid": uid
        }
        const res = await axios.delete(backend_url+"/meditation", {data: body});
        if(res.data.result == "ok"){
            alert("대기화면을 삭제 하였습니다.");
        } else {
            alert("대기화면을 삭제하지 못했습니다.");
        }
    }
    

    function checkDataValueDistribution(){
        console.log("=====");
        console.log(STBInfo);
        console.log(MAINInfo);
        distribution();
        console.log("=====");
    }

    function checkDataValueDelete(){
        console.log("=====");
        console.log(STBInfo);
        console.log(MAINInfo);
        distroy();
        console.log("=====");
    }
    
    return (
        <div style = {{maxWidth:'450px', margin:'auto'}}>
            <div style = {{textAlign:'center', marginBottom:'2rem', border: '2px solid gold'}}><br/>
                <Title level={2}>대기화면 배포 페이지</Title>
                {/* <StbList setSTBInfo={setSTBInfo} setButtonDisplay={setButtonDisplay} /> */}
                <StbList setSTBInfo={setSTBInfo} setButtonDisplay={setButtonDisplay} setMAINInfo={setMAINInfo} setCheckedItems={setCheckedItems} />
                <MainList stb_sn={STBInfo.main_stb_sn} setMAINInfo={setMAINInfo} setButtonDisplay={setButtonDisplay} checkedItems={checkedItems} setCheckedItems={setCheckedItems} /><br/>
                <div display={{width: "400px", justifyContent:'space-between'}} >
                    <Link to="/schedule_upload">
                        <Button>스케줄 지정</Button>
                    </Link>
                    <Link to="/main">
                        <Button>대기 화면 등록</Button>
                    </Link>
                    { ButtonDisplay == true && MAINInfo.uid !== "" ? 
                        <Button type="primary" onClick={checkDataValueDistribution}>배포</Button> : 
                        <Button type="primary" onClick={checkDataValueDistribution} disabled >배포</Button> }
                    { ButtonDisplay == true && MAINInfo.uid !== "" ? 
                        <Button type="danger" onClick={checkDataValueDelete}>삭제</Button> : 
                        <Button type="danger" onClick={checkDataValueDelete} disabled >삭제</Button> }
                </div><br/>
            </div><br/>
        </div>
    );
}

export default Dash;