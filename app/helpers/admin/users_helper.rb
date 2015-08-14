# -*- coding: utf-8 -*-
module Admin::UsersHelper

        def role_name(user)
                return "超级管理员" if user.admin?
                return "大屏互动管理员" if user.share_manager?
                return "兑奖人员" if user.lottery_manager?
                return "活动管理员" if user.activity_manager?
        end

end
