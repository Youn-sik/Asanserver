import React, {useState} from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';
import Dropzone from 'react-dropzone';
import { Typography, Button, Form, message, Input } from 'antd'; 
import {UploadOutlined} from '@ant-design/icons';
import StbList from '../List/StbList/StbList';
import server_json from '../../server.json'
import "antd/dist/antd.min.css";

const backend_url = server_json.base_url;
const { Title } = Typography;

function ScheduleUpdate(){
    const [Loading, setLoading] = useState(false);
    const [ButtonDisplay, setButtonDisplay] = useState(false);
    
    async function onDrop(files){
        // console.log(files[0])
        setLoading(true);
        let formData = new FormData();
        const config = {
            header: {'content-type' : 'multipart/form-data'}
        }
        formData.append("file", files[0]);
        
        let res = await axios.post(backend_url+"/meditation/excelScheduleSave", formData, {config});
        if(res.data.result) {
            setLoading(false);
            setButtonDisplay(true);
            alert("엑셀 파일을 서버에 저장 하였습니다.")
        } else {
            setLoading(false);
            setButtonDisplay(false);
            alert("엑셀 파일을 서버에 저장 실패 하였습니다.")
            alert("파일 확장자가 .xlsx 인지 확인 해 주세요.")
        }
    }

    async function onButton() {
        let body = {
            
        }
        let res = await axios.post(backend_url+"/meditation/excelScheduleDistribution", body);
    }

    return (
        <div style = {{maxWidth:'450px', margin:'auto'}}>
            <div style = {{textAlign:'center', marginBottom:'2rem', border: '2px solid gold'}}><br/>
                <Title level={2}>스케줄 업로드</Title><br/>
                <a href={backend_url+"/csv/schedule.xlsx"}>엑셀 파일 다운로드</a><br/><br/>
                {Loading && 
                    <div style = {{color:'blue', fontSize:'30px', margin:'auto'}}>
                        파일 업로드 중 ...
                    </div>
                }
                <div>
                        <Dropzone
                            onDrop={onDrop}
                            multiple={false}
                            maxSize={800000000}>
                                {({ getRootProps, getInputProps}) => (
                                <div style = {{width:'450px', height:'140px', border:'1px solid lightgray', display:'flex', alignItems:'center', 
                                justifyContent:'center'}} {...getRootProps()}>
                                    <input {...getInputProps()} />
                                    <UploadOutlined />
                                    <div>엑셀(xlse) 파일을 업로드해주세요</div>
                                </div>
                            )}
                        </Dropzone>
                </div><br/>
                <div>
                    <Link to="/">
                        <Button type="danger" size="large">
                            취소
                        </Button> 
                    </Link>

                    
                    <Link to="/">
                    { ButtonDisplay !== true ?
                        <Button type="primary" size="large" onClick={onButton} disabled>
                            등록
                        </Button> 
                    : 
                    <Button type="primary" size="large">
                        등록
                    </Button>
                    }
                        
                    </Link>
                </div><br/>
            </div><br/>
        </div>
    );
}

export default ScheduleUpdate;