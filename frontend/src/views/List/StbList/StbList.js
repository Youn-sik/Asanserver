import React, { useEffect, useState } from 'react';
import axios from 'axios';
import server_jso from '../../../server.json'

const backend_url = server_jso.base_url;

const StbList = (props)=> {
    const [loading, setLoading] = useState(true);
    // const [checkedItems, setCheckedItems] = useState(new Set());
    let [checkedItems, setCheckedItems] = useState(new Object());
    const [state, setState] = useState([{
        uid: '',
        main_stb_sn: '',
        sub_stb_sn: '',
        update_time: '',
        network_status: ''
    }]);

    function checkItemHandler(e, rowData){
        // if(e.target.checked){
        //     checkedItems.add(rowData);
        //     setCheckedItems(checkedItems);
        // } else if(!e.target.checked && checkedItems.has(rowData)){
        //     checkedItems.delete(rowData);
        //     setCheckedItems(checkedItems);
        // }
        if(e.target.checked){
            checkedItems = rowData;
            setCheckedItems(checkedItems);
            
            props.stb_select(rowData.main_stb_sn)
        }
        // console.log(checkedItems);
    }

    useEffect(async()=> {
        try{
            const res = await axios.get(backend_url+"/stb");
            if(res.data.result == "ok"){
                const _state = await res.data.values.map((rowData)=> (
                    {
                        uid: rowData.uid,
                        main_stb_sn: rowData.main_stb_sn,
                        sub_stb_sn: rowData.sub_stb_sn,
                        update_time: rowData.update_time,
                        network_status: rowData.network_status
                    })
                )
                setState({state : _state});
                setLoading(false);
            } else {
                console.error("stb 목록을 가져오는 과정에서 문제가 발생하였습니다.");
            }
        }catch(err){
            console.error(err);
        }
    }, []);
    if (loading) return (<div>Loading ...</div>);
    return (
        <div>
            {Array.isArray(state.state) && state.state.length !== 0 ? 
                state.state.map(rowData=> (
                    <div key={rowData.uid} style={{textAlign:'center'}}>
                        <label>
                            <input name="stb_cb" type="radio" onChange={(e)=> {checkItemHandler(e, rowData)}} />
                            <div>uid: {rowData.uid}</div>
                            <div>main_stb_sn: {rowData.main_stb_sn}</div>
                            <div>sub_stb_sn: {rowData.sub_stb_sn}</div>
                            <div>update_time: {rowData.update_time}</div>
                            <div>network_status: {rowData.network_status}</div>
                            <hr/>
                        </label>
                    </div>
                )):
                <div>저장 된 세탑이 없습니다.</div>
            }
        </div>
    );
}

export default StbList;