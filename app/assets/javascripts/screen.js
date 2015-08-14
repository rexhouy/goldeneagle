//= require jquery
(function(){

        var share = function(id) {
                var self = {};
                var section = "#section_"+id;
                var name = "#name_"+id;
                var content = "#content_"+id;
                var image = "#image_"+id;
                var duration = "#duration_"+id;

                var refresh = function() {
                        $.ajax({
                                url: "/admin/shares/screen.json",
                                type: 'GET',
                                cache: false,
                                dataType: 'json',
                                processData: false, // Don't process the files
                                contentType: false,
                                success: function(data) {
                                        if (data) {
                                                show(data);
                                        }
                                        self.register();
                                },
                                error: function() {
                                        self.register();
                                }
                        });
                };
                var show = function(data) {
                        var old = $(section);
                        var template = old.clone();
                        old.css("z-index", 999);
                        template.find(name).html(data.name);
                        template.find(content).html(data.content);
                        template.find(image).attr("src", data.image_1).one("load", function(){
                                template.find(duration).val(data.duration);
                                showAnimation(template, old);
                        });
                };
                var showAnimation = function(template, old) {
                        template.appendTo($(document.body));
                        old.animate({
                                top: "600px"
                        }, 1000, function(){
                                old.remove();
                        });
                };

                self.register = function() {
                        var d = $(duration).val() || 5;
                        setTimeout(function(){
                                try {
                                        refresh();
                                } catch(e) {
                                        alert("...");
                                        self.register();
                                }
                        }, d*1000);
                };

                return self;
        };

        var share1 = share(1);
        var share2 = share(2);

        $(function(){
                share1.register();
                share2.register();
        });

})();
