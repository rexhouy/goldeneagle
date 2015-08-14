# -*- coding: utf-8 -*-
module AdminHelper

        def readable_time(date)
                return "" if date.nil?
                date.strftime("%Y-%m-%d %H:%M:%S")
        end

end
