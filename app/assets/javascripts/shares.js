//= require jquery
(function(){
        var uploader = function(){
                var self = {};
                var images = [];

                self.open = function() {
                        $("#image_upload").click();
                };

                self.upload = function(event) {
                        if (images.length >= 1) {
                                alert("最多只允许上传一张图片");
                                return false;
                        }
                        var files = event.target.files;
                        var data = new FormData();
                        $.each(files, function(index, file) {
                                data.append("file", file, file.name);
                        });
                        $(".block-layer").show();
                        $(".block-layer-text").show();
                        $.ajax({
                                url: "/images",
                                type: 'POST',
                                data: data,
                                cache: false,
                                dataType: 'json',
                                processData: false, // Don't process the files
                                contentType: false, // Set content type to false as jQuery will tell the server its a query string request
                                success: function(data, textStatus, jqXHR) {
                                        images.push(data.filelink);
                                        $("#image_"+images.length).val(data.filelink);
                                        $("#preview_"+images.length).attr("src", data.filelink).show();
                                        $(".block-layer").hide();
                                        $(".block-layer-text").hide();
                                }
                        });
                };

                return self;
        }();

        window.uploader = uploader;
        var like = [];
        var include = function(list, val) {
                for (var i = 0; i < list.length; i++) {
                        if (list[i] ==val) {
                                return true;
                        }
                }
                return false;
        };
        window.good = function(id) {
                if (include(like, id)) {
                        return false;
                }
                var value = $("#like_"+id).html();
                $("#like_"+id).html(parseInt(value)+1);
                like.push(id);
                $.ajax({
                        url: "/shares/like/"+id,
                        type: 'POST',
                        cache: false,
                        dataType: 'json',
                        processData: false, // Don't process the files
                        contentType: false
                });
        };
        window.confirm = function() {
                var textMessage = $("#text_message").val();
                if (!textMessage) {
                        alert("请先输入留言");
                        return false;
                } else if (textMessage.length > 50) {
                        alert("留言最多50字");
                        return false;
                }
                $("input[name='share[content]']").val(textMessage);
                if (!$("#image_1").val()) {
                        alert("请上传一张图片");
                        return false;
                }
                $("#message_section").hide();
                $("#user_info_section").show();
        };

        window.submitShare = function() {
                var name = $("#name").val();
                var tel = $("#tel").val();
                if (!name) {
                        alert("请输入昵称");
                        return false;
                }
                if (name.length > 20) {
                        alert("昵称太长");
                        return false;
                }
                if (!tel || isNaN(tel) || tel.length != 11) {
                        alert("请输入正确的手机号");
                        return false;
                }
                return true;
        };

        $(function(){
                $("#upload_btn").click(function(){
                        uploader.open();
                });
        });

})();
