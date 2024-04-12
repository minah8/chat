<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Insert Your Title</title>
</head>
<body>
    <input type="text" placeholder="메시지를 입력하세요." class="content">
    <button type="button" class="sendBtn" onclick="sendMessage()">전송</button>
    <div class="msgArea"></div>
</body>
<script>
    let socket = new WebSocket("ws://localhost:8000/websocket");

    socket.onopen = function (event) {
        console.log("웹 소켓 연결 성공!");
    };

    socket.onerror = function (error) {
        console.log(`에러 발생: ${error}`);
    };

    socket.onmessage = function (event) {
        let msgArea = document.querySelector('.msgArea');
        let newMsg = document.createElement('div');
        newMsg.innerText = event.data;
        msgArea.appendChild(newMsg);
    };

    function sendMessage() {
        let content = document.querySelector('.content').value;
        socket.send(content);
    }
</script>
</html>