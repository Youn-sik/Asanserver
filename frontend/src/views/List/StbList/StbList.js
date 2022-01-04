import React, { useEffect, useState } from 'react';
import axios from 'axios';
import server_jso from '../../../server.json'

const backend_url = server_jso.base_url;
let stbs = [];

function StbList () {
    const [state, setState] = useState([{
        uid: '',
        main_stb_sn: '',
        sub_stb_sn: '',
        update_time: '',
        network_status: ''
    }])

    useEffect(async()=> {
        try{
            const res = await axios.get(backend_url+"/stb");
            if(res.data.result == "ok"){
                const _state = await res.data.values.map((rowData)=> {
                    console.log(rowData);
                    // uid: rowData.uid,
                    // main_stb_sn: rowData.main_stb_sn,
                    // sub_stb_sn: rowData.sub_stb_sn,
                    // update_time: rowData.update_time,
                    // network_status: rowData.network_status
                })
            } else {

            }
        }catch(err){
            console.error(err);
        }
        
    }, []);

    return (
        <div>
            hi
        </div>
    );
}

export default StbList;