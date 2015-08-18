//= require jquery
(function(){

        var item = function(id) {
                var self = {};
                var section = "#section_"+id;
                var name = "#name_"+id;
                var content = "#content_"+id;
                var image = "#image_"+id;
                var duration = "#duration_"+id;

                self.section = $(section);

                self.duration = function() {
                        $(duration).val();
                };

                self.setContent = function(data) {
                        console.log(data);
                        $(name).html(data.name);
                        $(content).html(data.content);
                        $(image).attr("src", data.image_1);
                        $(image).attr("duration", data.duration);
                };

                self.registerLoadEvent = function(callback) {
                        $(image).one("load", callback);
                };

                return self;
        };

        var share = function(id) {
                var self = {};
                var f = item(id);
                var b = item(id+2);

                var log = function(data) {
                        console.log(id + " " + data);
                };

                var load = function(data) {
                        log("started to load.");
                        $.ajax({
                                url: "/admin/shares/screen.json",
                                type: 'GET',
                                cache: false,
                                dataType: 'json',
                                processData: false, // Don't process the files
                                contentType: false,
                                success: function(data) {
                                        log("data loaded.");
                                        b.setContent(data);
                                        b.registerLoadEvent(imageLoad);
                                        swapFrontBack();
                                        setPosition();
                                        setZindex();
                                        log("Position & Index reset");
                                },
                                error: function() {
                                        self.register();
                                }
                        });
                };

                var setZindex = function() {
                        f.section.css("z-index", "10");
                        b.section.css("z-index", "1");
                };

                var setPosition = function() {
                        f.section.css("top", "42px");
                        b.section.css("top", "42px");
                };

                var swapFrontBack = function() {
                        var tmp = f;
                        f = b;
                        b = tmp;
                };

                var imageLoad = function() {
                        log("Image loaded");
                        move();
                        self.register();
                };

                var move = function() {
                        f.section.animate({
                                top: "600px"
                        }, 1000);
                };

                self.register = function() {
                        var d = f.duration() || 5;
                        log("register duration ["+d+"]");
                        setTimeout(function(){
                                try {
                                        load();
                                } catch(e) {
                                        self.register();
                                }
                        }, d*1000);
                };
                return self;
        };

        var share1 = share(1);
        var share2 = share(2);

        window.onload = function() {
                share1.register();
                share2.register();
        };

})();
