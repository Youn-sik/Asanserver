import React, { useEffect, useState } from 'react';
import axios from 'axios';
import server_jso from '../../../server.json'
const backend_url = server_jso.base_url;
const MainList = (props)=> {
    const [loading, setLoading] = useState(true);
    const [state, setState] = useState([{
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
    }]);
    let [checkedItems, setCheckedItems] = useState(new Object());
    let [NothingInMain, setNothingInMain] = useState(false)

    function checkItemHandler(e, rowData){
        if(e.target.checked){
            checkedItems = rowData;
            setCheckedItems(checkedItems);

            props.setMAINInfo({
                uid: rowData.uid,
                stb_sn: rowData.stb_sn,
                name: rowData.name,
                update_time: rowData.update_time,
                // start: rowData.start,
                // end: rowData.end,
                user: rowData.user,
                file_path: rowData.file_path,
                file_name: rowData.file_name,
                file_ext: rowData.file_ext,
                file_url: rowData.file_url
            });
            props.setButtonDisplay(true);
        }
        // console.log(checkedItems);
    }

    useEffect(async()=> {
        try{
            if(props.stb_sn !== ""){ //해당 조건문이 없으면 랜더링 마다 요청을 보내서 서버에 과부하
                const res = await axios.get(backend_url+"/main/"+props.stb_sn);
                if(res.data.result == "ok"){
                    // console.log(res.data);
                    const _state = await res.data.values.map((rowData)=> (
                        {
                            uid: rowData.uid,
                            stb_sn: rowData.stb_sn,
                            name: rowData.name,
                            update_time: rowData.update_time,
                            // start: rowData.start,
                            // end: rowData.end,
                            user: rowData.user,
                            file_path: rowData.file_path,
                            file_name: rowData.file_name,
                            file_ext: rowData.file_ext,
                            file_url: rowData.file_url
                        })
                    )
                    setState({state : _state});
                    setLoading(false);
                    setNothingInMain(false);
                } else {
                    // console.error("main 목록을 가져오는 과정에서 문제가 발생하였습니다.");
                    setLoading(false); 
                    setNothingInMain(true);
                }
            } else {
                
            }
        }catch(err){
            console.error(err);
        }
    }, [props]);

    if(props.stb_sn == ""){ //세탑 지정이 안되면 렌더링을 빈 값으로
        return (<div></div>);
    } else {
        if (loading) return (<div>Loading ...</div>);
        return (
            <div>
            <h2>대기화면 목록</h2>
                {Array.isArray(state.state) && state.state.length !== 0 && !NothingInMain? 
                    state.state.map(rowData=> (
                        <div key={rowData.uid} style={{textAlign:'center'}}>
                            <label>
                                <input name="main" type="radio" onChange={(e)=> {checkItemHandler(e, rowData)}} />
                                <div>uid: {rowData.uid}</div>
                                <div>stb_sn: {rowData.stb_sn}</div>
                                <div>name: {rowData.name}</div>
                                <div>update_time: {rowData.update_time}</div>
                                <div>user: {rowData.user}</div>
                                {/* <div>start: {rowData.start}</div> */}
                                {/* <div>end: {rowData.end}</div> */}
                                {/* <div>file_path: {rowData.file_path}</div> */}
                                <div>file_name: {rowData.file_name}</div>
                                {/* <div>file_ext: {rowData.file_ext}</div> */}
                                {/* <div>file_url: {rowData.file_url}</div> */}
                                <hr/>
                            </label>
                        </div>
                    )):
                    <div>저장 된 대기화면이 없습니다.</div>
                }
            </div>
        );
    }
}

export default MainList;