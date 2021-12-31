import React, {useState} from 'react';
import axios from 'axios';
import Dropzone from 'react-dropzone';
import { Typography, Button, Form, message, Input } from 'antd'; 
import plus from '../../plus.png';

const { Title } = Typography;

function Schedule(){
    const [state, setState] = useState({
        distribution: "",
        schedule: "",
        main: "",
        home: "",
        checklist: "",
    });
    const handleChange = (e) => {
        const {id, value} = e.target;
        setState((prevState) => ({
            ...prevState,
            [id]: value,
        }));
    };

    const onDrop = (files) => {
        let formData = new FormData();
        const config = {
            header: {'content-type' : 'multipart/form-data'}
        }
        formData.append("file", files[0]);

        console.log(files);

        axios.post("/api/", formData, config)
            .then((response) => {
                if(response.data.success){
                    let variable = {
                        filePath: response.data.filePath,
                        fileName: response.data.fileName
                    }
                    //useState 로 set 메서드로 경로 저장 등
                } else {
                    alert("Failed to save the video in server");
                }
            })
    }
    return (
        <div style = {{maxWidth:'700px', margin:'2erm auto'}}>
            <div style = {{textAlign:'center', marginBottom:'2rem'}}>
                <Title level={2}>스케줄 작성</Title><br/>
                <h3>배포 이름</h3><Input id="distribution" placeholder="배포 이름" onChange={handleChange} style = {{width:'300px'}}></Input><br/><br/>
                <h3>스케줄 배포 단말기 시리얼</h3><Input id="stb_sn" placeholder="스케줄 배포 단말기 시리얼" onChange={handleChange} style = {{width:'300px'}}></Input><br/><br/>
                <h3>스케줄 이름</h3><Input id="schedule" placeholder="스케줄 이름" onChange={handleChange} style = {{width:'300px'}}></Input><br/><br/>
                <h3>스케줄 날짜</h3><Input id="schedule_date" placeholder="스케줄 날짜" onChange={handleChange} style = {{width:'300px'}}></Input><br/><br/>
                <h3>스케줄 시작 시간</h3><Input id="schedule_start" placeholder="스케줄 시작 시간" onChange={handleChange} style = {{width:'300px'}}></Input><br/><br/>
                <h3>스케줄 종료 시간</h3><Input id="schedule_end" placeholder="스케줄 종료 시간" onChange={handleChange} style = {{width:'300px'}}></Input><br/><br/>
                
                <h3>대기화면 파일</h3>
                <Form onSubmit>
                    <div style = {{display:'flex', justifyContent:'space-between'}}>
                        <Dropzone
                            onDrop={onDrop}
                            multiple={false}
                            maxSize={800000000}>
                                {({ getRootProps, getInputProps}) => (
                                <div style = {{width:'300px', height:'240px', border:'1px solid lightgray', display:'flex', alignItems:'center', 
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
                    <Input id="main" placeholder="대기화면 이름" onChange={handleChange} style = {{width:'300px'}}></Input><br/><br/>
                    <Button type="primary" size="large" onClick >
                        등록
                    </Button>
                </Form><br/>
                <h3>홈 화면 이름</h3><Input id="home" placeholder="홈 화면 이름" onChange={handleChange} style = {{width:'300px'}}></Input><br/><br/>
                <h3>의료진</h3><Input id="staff" placeholder="의료진" onChange={handleChange} style = {{width:'300px'}}></Input>
                <div>의료진 등록 시 이름/position 지정</div><br/><br/>
                <h3>환자</h3><Input id="patient" placeholder="환자" onChange={handleChange} style = {{width:'300px'}}></Input>
                <div>환자 등록 시 이름/성별/나이/수술 부위</div><br/><br/>
                <h3>Process</h3><Input id="Process" placeholder="Process" onChange={handleChange} style = {{width:'300px'}}></Input>
                <div>Process 등록 시 Process</div><br/><br/>
                <h3>의료기기</h3><Input id="instrument" placeholder="의료기기" onChange={handleChange} style = {{width:'300px'}}></Input>
                <div>의료기기기 등록 시 이름/사진/영상</div><br/><br/>
                <h3>레이아웃</h3><Input id="layout" placeholder="레이아웃" onChange={handleChange} style = {{width:'300px'}}></Input>
                <div>레이아웃 등록 시 이름/사진(/x/y/가로/세로)</div><br/><br/>
                <h3>체크리스트</h3><Input id="checklist" placeholder="체크리스트" onChange={handleChange} style = {{width:'300px'}}></Input>
                <div>체크리스트 등록 시 checklist</div><br/><br/>
            </div>
        </div>
    );
}

export default Schedule;