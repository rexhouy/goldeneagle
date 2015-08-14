//= require jquery
(function(){

        var validTel = function(tel) {
                return tel && !isNaN(tel) && tel.length ==11;
        };

        var countDown = function(time) {
                var captcha_btn = document.getElementById("get_captcha");
                if (time == 0) {
                        captcha_btn.disabled = false;
                        captcha_btn.innerHTML = "获取验证码";
                        return;
                }
                captcha_btn.disabled = true;
                captcha_btn.innerHTML = "获取验证码("+time+")";
                setTimeout(function(){
                        countDown(time-1);
                }, 1000);
        };

        window.getCaptcha = function() {
                var tel = document.getElementById("tel").value;
                if (!validTel(tel)) {
                        alert("请输入一个合法的手机号码");
                        return false;
                }
                countDown(120);
                $.ajax({
                        url: "/lottery/sms",
                        type: 'POST',
                        data: {tel: tel},
                        cache: false,
                        success: function(data, textStatus, jqXHR) {
                                if (data.error) {
                                        alert(data.error);
                                }
                        }
                });
                return false;
        };

        window.openEnvelope = function() {
                $(".cover").css("height", 0);
                setTimeout(function(){
                        $("#win").css("opacity", "1");
                        $("#ins_title").hide();
                }, 500);
        };

        window.signIn = function() {
                var tel = $("#tel").val();
                var captcha = $("#captcha").val();
                if (!validTel(tel)) {
                        alert("请输入一个合法的手机号码，获取短信验证码后登录");
                        return false;
                }
                if (!captcha) {
                        alert("请输入短信验证码");
                }
                $(".spinner").show();
                $.ajax({
                        url: "/lottery/sign_in",
                        type: 'POST',
                        data: {tel: tel, captcha: captcha},
                        cache: false,
                        dataType: 'json',
                        success: function(data, textStatus, jqXHR) {
                                $(".spinner").hide();
                                if (data.error) {
                                        alert(data.error);
                                        return false;
                                }
                                $("article.hidden").css("margin-left", "0");
                                $("#money").html(data.prize);
                                $(".cover").height($(".cover").height());// Set the image height so the transition can work.
                        }
                });

                return false;
        };

})();
