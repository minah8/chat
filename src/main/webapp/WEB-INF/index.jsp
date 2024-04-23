<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <title>채팅</title>
</head>

<body>
    <form action="">
        <div class="wrapper">
            <div class="msgArea"></div>
            <input type="text" placeholder="메시지를 입력하세요." class="content">
            <button type="button" class="sendBtn">전송</button>
        </div>
    </form>
    <input type="button" id="test" value="테스트">
</body>

<script>
    document.addEventListener("DOMContentLoaded", function () {
        fetch("ws://localhost:8282/ws/chat", {
            method: "POST",
            body: JSON.stringify({
                "type": "ENTER",
                "roomId": "room8282",
                "sender": "테스트1",
                "message": ""
            })
        })
    })

    document.getElementById('test').onclick,
        function () {
            fetch("http://localhost:8282/chat?name=test");
        }
</script>

</html>