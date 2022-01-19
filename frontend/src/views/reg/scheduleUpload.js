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
    
    function onDrop(files){
        
    }

    return (
        <div style = {{maxWidth:'450px', margin:'auto'}}>
            <div style = {{textAlign:'center', marginBottom:'2rem', border: '2px solid gold'}}><br/>
                <Title level={2}>스케줄 업로드</Title><br/>
                <a href={backend_url+"/csv/schedule.xlsx"}>엑셀 파일 다운로드</a><br/><br/>
                <div>
                        <Dropzone
                            onDrop={onDrop}
                            multiple={false}
                            maxSize={800000000}>
                                {({ getRootProps, getInputProps}) => (
                                <div style = {{width:'450px', height:'240px', border:'1px solid lightgray', display:'flex', alignItems:'center', 
                                justifyContent:'center'}} {...getRootProps()}>
                                    <input {...getInputProps()} />
                                    <UploadOutlined />
                                    <div>엑셀 파일을 업로드해주세요</div>
                                </div>
                            )}
                        </Dropzone>
                    </div><br/>
            </div><br/>
        </div>
    );
}

export default ScheduleUpdate;