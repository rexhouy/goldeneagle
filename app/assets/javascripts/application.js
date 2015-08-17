// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

(function() {
        window.updateDurationAll = function() {
                var duration = $("#duration").val();
                if (!duration || isNaN(duration) || duration <= 0 || duration > 1000) {
                        alert("请输入一个正确的值");
                        return false;
                }
                $.ajax({
                        url: "/admin/shares/duration/all",
                        type: 'POST',
                        data: {
                                duration: duration
                        },
                        cache: false
                }).done(function(){
                        alert("修改成功");
                });
        };
        window.updateDuration = function(id) {
                var duration = $("#duration").val();
                if (!duration || isNaN(duration) || duration <= 0 || duration > 1000) {
                        alert("请输入一个正确的值");
                        return false;
                }
                $.ajax({
                        url: "/admin/shares/duration/"+id,
                        type: 'POST',
                        data: {
                                duration: duration
                        },
                        cache: false
                }).done(function(){
                        alert("修改成功");
                });
        };
        $(function(){
                setTimeout(function(){
                        window.location.reload();
                }, 20*1000);
        });
})();
