import React, { useEffect, useState } from 'react';
import axios from 'axios';
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
        }
        console.log(checkedItems);
    }

    useEffect(async()=> {
        try{
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