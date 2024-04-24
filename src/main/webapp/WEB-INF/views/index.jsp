<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <style>
    *{
        box-sizing: border-box;
    }

    #chatt{
        width: 800px;
        margin: 20px auto;
    }

    #chatt #talk{
        width: 800px;
        height: 400px;
        overflow: scroll;
        border : 1px solid #aaa;
    }
    #chatt #msg{
        width: 740px;
        height:100px;
        display: inline-block;
    }

    #chatt #sendZone > *{
        vertical-align: top;

    }
    #chatt #btnSend{
        width: 54px;
        height: 100px;
    }

    #chatt #talk div{
        width: 70%;
        display: inline-block;
        padding: 6px;
        border-radius:10px;

    }

    #chatt .me{
        background-color : #ffc;
        margin : 1px 0px 2px 30%;
    }

    #chatt .other{
        background-color : #eee;
        margin : 2px;
    }</style>
</head>
<body>
<div id='chatt'>
    <h1>WebSocket Chatting</h1>
    <input type='text' id='mid' value='홍길동'>
    <input type='button' value='로그인' id='btnLogin'>
    <br/>
    <div id='talk'></div>
    <div id='sendZone'>
        <textarea id='msg' value='hi...' ></textarea>
        <input type='button' value='전송' id='btnSend'>
    </div>
</div>
<script>
let ws;
const mid = getId('mid');
const btnLogin = getId('btnLogin');
const btnSend = getId('btnSend');
const talk = getId('talk');
const msg = getId('msg');

// 2022.10.26[프뚜]: 전송 데이터(JSON)
const data = {};

function getId(id) {
    return document.getElementById(id);
}

btnLogin.onclick = function() {
    // 2022.10.26[프뚜]: 서버와 webSocket 연결
    ws = new WebSocket("ws://" + location.host + "/chatt");

    // 2022.10.26[프뚜]: 서버에서 받은 메세지 처리
    ws.onmessage = function(msg) {
        const data = JSON.parse(msg.data);
        let css;

        if (data.mid === mid.value) {
            css = 'class=me';
        } else {
            css = 'class=other';
        }

        const item = `<div ${css} >
		                <span><b>${data.mid}</b></span> [ ${data.date} ]<br/>
                      <span>${data.msg}</span>
						</div>`;

        talk.innerHTML += item;

        // 2022.10.26[프뚜]: 스크롤바 하단으로 이동
        talk.scrollTop=talk.scrollHeight;
    }
}

msg.onkeyup = function(ev) {
    if (ev.keyCode === 13) {
        send();
    }
}

btnSend.onclick = function() {
    send();
}

function send() {
    if (msg.value.trim() !== '') {
        data.mid = getId('mid').value;
        data.msg = msg.value;
        data.date = new Date().toLocaleString();
        const temp = JSON.stringify(data);
        ws.send(temp);
    }

    msg.value = '';
}
</script>
</body>
</html>