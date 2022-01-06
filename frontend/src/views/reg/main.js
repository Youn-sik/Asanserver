import React, {useState} from 'react';
import {Link} from 'react-router-dom';
import axios from 'axios';
import Dropzone from 'react-dropzone';
import { Typography, Button, Form, message, Input } from 'antd'; 
import {UploadOutlined} from '@ant-design/icons';
import StbList from '../List/StbList/StbList';
import server_json from '../../server.json'
import "antd/dist/antd.css";

const backend_url = server_json.base_url;
const { Title } = Typography;

function Schedule(){
    const [Thumbnail, setThumbnail] = useState("");
    const [STBInfo, setSTBInfo] = useState({
        uid: "",
        main_stb_sn: "",
        sub_stb_sn: "",
        update_time: "",
        network_status: ""
    });
    const [FILEInfo, setFILEInfo] = useState({
        file_path: "",
        file_name: "",
    })
    const [state, setState] = useState({
        main_list_name: "",
        // main_list_start: "",
        // main_list_end: "",
    });

    const [ButtonDisplay, setButtonDisplay] = useState(false);

    function handleChange(e){
        const {id, value} = e.target;
        setState({
            ...state,
            [id] : value
        });
    }

    async function meditation_reg(){
        let body = {
            name: state.main_list_name,
            stb_sn: STBInfo.main_stb_sn,
            // start: state.main_list_start,
            // end: state.main_list_end,
            file_name: FILEInfo.file_name,
            file_path: FILEInfo.file_path
        }
        const res = await axios.post(backend_url+"/meditation", body);
        if(res.data.result == "ok"){
            alert("대기화면 등록을 완료하였습니다.");
        } else {
            alert("대기화면 등록을 실패하였습니다.");
        }
    }

    function checkDataValue(){
        console.log("=====");
        console.log(state);
        console.log(STBInfo);
        console.log(FILEInfo);
        meditation_reg();
        console.log("=====");
    }

    function onDrop(files){
        let formData = new FormData();
        const config = {
            header: {'content-type' : 'multipart/form-data'}
        }
        formData.append("file", files[0]);

        // console.log(files);

        axios.post(backend_url+"/meditation/upload", formData, {config})
            .then((response) => {
                if(response.data.success){
                    // console.log(response.data) 
                    let variable = {
                        filePath: response.data.filePath,
                        fileName: response.data.fileName
                    }

                    setFILEInfo({
                        file_name: response.data.fileName,
                        file_path: response.data.filePath
                    });

                    alert("서버에 저장이 완료 되었습니다. 썸네일 생성을 시작합니다.")
                    // response.data의 filePath, fileName 정보 가지고 있다가 submit 하면 같이 보내기(폼은 file_path, file_name 으로)
                    
                    axios.post(backend_url+'/meditation/thumbnail', variable)
                        .then(response => {
                            if (response.data.success) {
                                // console.log(response.data); 
                                setThumbnail(response.data.thumbsFilePath)
                            } else {
                                alert('썸네일 저장에 실패하였습니다.');
                                alert("확장자가 .mp4 파일인지 확인해 주세요.")
                            }
                        });

                } else {
                    alert("동영상 저장에 실패하였습니다.");
                }
            })
    }
    // console.log(state);
    // console.log(STBInfo);
    return (
        <div style = {{maxWidth:'450px', margin:'2erm auto'}}>
            <div style = {{textAlign:'center', marginBottom:'2rem'}}>
                <Title level={2}>대기화면 등록</Title>
                <Form onSubmit>
                    <Input
                        id="main_list_name" 
                        placeholder = "컨텐츠 명을 입력해주세요"
                        onChange={handleChange} 
                        style = {{width:'300px'}}
                    /><br/><br/>
                    {/* <Input
                        id="main_list_start" 
                        placeholder = "시작 시간을 입력해주세요(08:00)"
                        onChange = {handleChange}
                        style = {{width:'300px'}}
                    /><br/><br/>
                    <Input
                        id="main_list_end" 
                        placeholder = "종료 시간을 입력해주세요(09:00)"
                        onChange = {handleChange}
                        style = {{width:'300px'}}
                    /><br/><br/> */}
                    <StbList setSTBInfo={setSTBInfo} setButtonDisplay={setButtonDisplay} />
                    <h3>동영상 파일 지정 후 사진이 로딩 될 때까지 기다려주세요.</h3>
                    <div style = {{display:'flex', justifyContent:'space-between'}}>
                        <Dropzone
                            onDrop={onDrop}
                            multiple={false}
                            maxSize={800000000}>
                                {({ getRootProps, getInputProps}) => (
                                <div style = {{width:'450px', height:'240px', border:'1px solid lightgray', display:'flex', alignItems:'center', 
                                justifyContent:'center'}} {...getRootProps()}>
                                    <input {...getInputProps()} />
                                    <UploadOutlined />
                                    <div>동영상을 업로드해주세요</div>
                                </div>
                            )}
                        </Dropzone>
                    </div><br/><br/>
                        {Thumbnail && 
                            <div style = {{width:'300px'}}>
                                <div>
                                    <img src= {`${backend_url}${Thumbnail}`} alt= "thumbnail" />
                                </div>
                                <div>파일명: {FILEInfo.file_name}</div>
                            </div>
                        }
                    <br/> 
                    <Link to="/">
                        <Button type="danger" size="large">
                            취소
                        </Button> 
                    </Link>
                    <Link to="/">
                        { STBInfo.main_stb_sn !== "" && state.main_list_name !== "" && Thumbnail ?
                            <Button type="primary" size="large"  onClick={checkDataValue} >
                                등록
                            </Button> : 
                            <Button type="primary" size="large" disabled>
                                등록
                            </Button>
                        }
                    </Link>
                </Form><br/>
            </div>
        </div>
    );
}

export default Schedule;