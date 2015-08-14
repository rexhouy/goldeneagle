# -*- coding: utf-8 -*-
module Admin::ActivitiesHelper

        def prize_status(prize)
                return "已兑奖" if prize.claimed?
                "未兑奖"
        end

end
