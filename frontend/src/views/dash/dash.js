import React, {useState} from 'react';
import axios from 'axios';
import {Link} from 'react-router-dom';
import StbList from '../List/StbList/StbList';
import MainList from '../List/MainList/MainList';
import server_jso from '../../server.json'
import { Typography, Button, Form, message, Input } from 'antd'; 
import "antd/dist/antd.css";

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
    const [MAINInfo, setMAINInfo] = useState({
        uid: "",
        stb_sn: "",
        name: "",
        update_time: "",
        // start: "",
        // end: "",
        user: "",
        file_path: "",
        file_name: "",
        file_ext: "",
        file_url: ""
    });

    async function distribution(){ 
        let body = {
            "values":[{
                "stb_sn": STBInfo.main_stb_sn,
                "file_name": MAINInfo.file_name
            }]
        }
        const res = await axios.post(backend_url+"/meditation/distribution", body);
        if(res.data.result == "ok"){
            alert("대기화면을 배포 하였습니다."); 
        } else {
            alert("대기화면을 배포하지 못했습니다.");
        }
    }

    async function distroy(){ 
        let body = {
            file_name: MAINInfo.file_name
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
        <div style = {{maxWidth:'450px', margin:'2erm auto'}}>
            <div style = {{textAlign:'center', marginBottom:'2rem'}}>
                <h1>대기화면 배포 페이지</h1>
                <StbList setSTBInfo={setSTBInfo} setButtonDisplay={setButtonDisplay} />
                <MainList stb_sn={STBInfo.main_stb_sn} setMAINInfo={setMAINInfo} setButtonDisplay={setButtonDisplay} /><br/>
                <div display={{width: "400px", justifyContent:'space-between'}} >
                    <Link to="/main">
                        <Button>대기 화면 등록</Button>
                    </Link>
                    { ButtonDisplay == true && MAINInfo.file_name !== "" ? 
                        <Button type="primary" onClick={checkDataValueDistribution}>배포</Button> : 
                        <Button type="primary" onClick={checkDataValueDistribution} disabled >배포</Button> }
                    { ButtonDisplay == true && MAINInfo.file_name !== "" ? 
                        <Button type="danger" onClick={checkDataValueDelete}>삭제</Button> : 
                        <Button type="danger" onClick={checkDataValueDelete} disabled >삭제</Button> }
                </div>
            </div>
        </div>
    );
}

export default Dash;