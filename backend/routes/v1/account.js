const express = require('express');
const router = express.Router();
const db = require('../../db');
const scrypt = require('scrypt');
const crypto = require('crypto');

let moment = require('moment');
const { emitWarning } = require('process');
require('moment-timezone');
moment.tz.setDefault("Asia/Seoul");

router.get('/', async (req, res)=> {
    db.query('select userID, userNAME from g_account', (err, account)=> {
        if(err) console.log(err)
        if(account.length == 0) res.send("계정이 존재하지 않습니다.");
        else res.send(account);
    })
});

router.get('/name/:name', async (req, res)=> {
    let name = req.params.name;

    db.query('select userID, userNAME from g_account where userNAME = ?', name, (err, account)=> {
        if(err) console.log(err)
        if(account.length == 0) res.send("존재하지 않는 계정입니다.");
        else res.send(account);
    })
})

router.get('/id/:id', async (req, res)=> {
    let id = req.params.id;

    db.query('select userID, userNAME from g_account where userID = ?', id, (err, account)=> {
        if(err) console.log(err)
        if(account.length == 0) res.send("존재하지 않는 계정입니다.")
        else res.send(account);
    })
})

//비밀번호 확인 로직
router.get('/password/:id/:password', async (req, res)=> {
    try{
        let id = req.params.id; //0
        let password = req.params.password;
        let salt;
        let salt_pw;

        const pwd_verify = async (pwd, salt) => new Promise((resolve, reject) => { //3
            let result = '';
            
            crypto.scrypt(pwd, salt, 64, (err, key) => {
                if (err) return reject(err);
                result = key.toString('base64');
                
                if(result === salt_pw) res.send("해당 아이디의 비밀번호가 일치합니다.") //4
                else res.send("해당 아이디의 비밀번호가 일치하지 않습니다.")

                return resolve(); //5
            });
        });

        db.query('select userPW, salt from g_account where userID = ?', id, (err, account)=> {//1
            if(err) console.log(err)
            if(account.length == 0) res.send("존재하지 않는 계정입니다.")
            else {            
                salt = account[0].salt;
                salt_pw = account[0].userPW;    
                pwd_verify(password, salt); //2      
            }                
        })
    } catch(err){
        res.status(400).send({err:"잘못된 형식 입니다."})
    }
})

router.post('/', async (req, res)=> {
    let time = moment().format('YYYY-MM-DD HH:mm:ss');
    const pwd_encrypt = async (pwd)=> new Promise((resolve, reject)=> {
        const salt = crypto.randomBytes(64).toString('base64');
        let salt_pw = '';
        crypto.scrypt(pwd, salt, 64, (err, key)=> {
            if(err) return reject(err);
            salt_pw = key.toString('base64');
            return resolve({salt_pw, salt})
        })
    }); 
    let pwd_ecrypt_result = await pwd_encrypt(req.body.userPW);
    let value = [];
    value.push(req.body.userID);
    value.push(pwd_ecrypt_result.salt_pw);
    value.push(pwd_ecrypt_result.salt);
    value.push(req.body.userNAME);
    value.push(time)
    console.log(value)

    db.query('insert into g_account(userID, userPW, salt, userNAME, create_at) '+
    'values (?, ?, ?, ?, ?)', value, (err, account)=> {
        if(err) console.log(err)
        res.send("계정 생성이 완료 되었습니다.")
    })
})

/*
router.put('/', async (req, res)=> { //수정기능은 put 하나로만 구현되지 않기 때문에 보류.
    
})
*/

router.delete('/', async(req, res)=>{
    let id = req.body.userID;
    let password = req.body.userPW;

    db.query('select userPW, salt from g_account where userID = ?', id, (err, account)=> {
        if(err) console.log(err)
        if(account.length == 0) res.send("존재하지 않는 계정입니다.");
        else {
            let salt = account[0].salt;
            let salt_pw = account[0].userPW;
            console.log(salt);
            console.log(salt_pw);

            const pwd_verify = async (pwd, salt) => new Promise((resolve, reject) => {
                let result = '';
                crypto.scrypt(pwd, salt, 64, (err, key) => {
                if (err) return reject(err);
                result = key.toString('base64');
                return resolve(result === salt_pw);
                });
            });

            if(pwd_verify(password, salt)) {
                db.query('delete from g_account where userID = ?', id, (err, user)=> {
                    if(err) console.log(err);
                    res.send("해당 아이디의 계정이 삭제되었습니다.")
                })
            } else res.send("해당 아이디의 비밀번호가 일치하지 않아 계정을 삭제할 수 없습니다.")
        }
    })
})

module.exports = router;