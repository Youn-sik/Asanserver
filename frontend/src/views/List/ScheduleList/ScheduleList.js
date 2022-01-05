import React, { useEffect, useState } from 'react';
import axios from 'axios';
import { Typography, Button, Form, message, Input } from 'antd'; 
import "antd/dist/antd.css";
import server_jso from '../../../server.json'

const backend_url = server_jso.base_url;

const ScheduleList = (props)=> {
    const [loading, setLoading] = useState(true);
    const [state, setState] = useState([{
        uid: '',
        main_stb_sn: '',
        sub_stb_sn: '',
        update_time: '',
        network_status: ''
    }]);
    let [checkedItems, setCheckedItems] = useState(new Object());

    function checkItemHandler(e, rowData){
        if(e.target.checked){
            checkedItems = rowData;
            setCheckedItems(checkedItems);

            props.setSCHEDULEInfo({
                uid: rowData.uid,
                stb_sn: rowData.stb_sn,
                name: rowData.name,
                update_time: rowData.update_time,
                order: rowData.order,
                start: rowData.start,
                end: rowData.end,
                main_name: rowData.main_name,
                home_name: rowData.home_name,
                checklist_name: rowData.checklist_name,
                layout_name: rowData.layout_name,
                media_name: rowData.media_name
            });
            props.setButtonDisplay(true);
        }
        // console.log(checkedItems);
    }

    useEffect(async()=> {
        try{
            if(props.stb_sn !== ""){ //해당 조건문이 없으면 랜더링 마다 요청을 보내서 서버에 과부하
                const res = await axios.get(backend_url+"/schedule/"+props.stb_sn);
                if(res.data.result == "ok"){
                    const _state = await res.data.values.map((rowData)=> (
                        {
                            uid: rowData.uid,
                            stb_sn: rowData.stb_sn,
                            name: rowData.name,
                            update_time: rowData.update_time,
                            order: rowData.order,
                            start: rowData.start,
                            end: rowData.end,
                            main_name: rowData.main_name,
                            home_name: rowData.home_name,
                            checklist_name: rowData.checklist_name,
                            layout_name: rowData.layout_name,
                            media_name: rowData.media_name
                        })
                    )
                    setState({state : _state});
                    setLoading(false);
                } else {
                    console.error("schedule 목록을 가져오는 과정에서 문제가 발생하였습니다.");
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
            <h3>스케줄 목록</h3>
                {Array.isArray(state.state) && state.state.length !== 0 ? 
                    state.state.map(rowData=> (
                        <div key={rowData.uid} style={{textAlign:'center'}}>
                            <label>
                                <input name="schedule" type="radio" onChange={(e)=> {checkItemHandler(e, rowData)}} />
                                <div>uid: {rowData.uid}</div>
                                <div>stb_sn: {rowData.stb_sn}</div>
                                <div>name: {rowData.name}</div>
                                <div>update_time: {rowData.update_time}</div>
                                {/* <div>order: {rowData.order}</div> */}
                                <div>start: {rowData.start}</div>
                                <div>end: {rowData.end}</div>
                                <div>main_name: {rowData.main_name}</div>
                                <div>home_name: {rowData.home_name}</div>
                                <div>checklist_name: {rowData.checklist_name}</div>
                                <div>layout_name: {rowData.layout_name}</div>
                                <div>media_name: {rowData.media_name}</div>
                                <hr/>
                            </label>
                        </div>
                    )):
                    <div>저장 된 세탑이 없습니다.</div>
                }
            </div>
        );
    }
}

export default ScheduleList;