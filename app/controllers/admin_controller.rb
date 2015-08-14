# -*- coding: utf-8 -*-
class AdminController < ApplicationController

        before_action :menu
        before_action :authenticate_user!
        load_and_authorize_resource
        layout "application"

        private
        def menu
                return if current_user.nil?
                @menus = [
                          # {url: admin_products_url, text: "实时监控", class: "", resource: Monitor },
                          {url: admin_shares_url, text: "大屏分享审核", class: "", resource: Share },
                          {url: admin_users_url, text: "用户管理", class: "", resource: User },
                          {url: admin_prizes_url, text: "中奖信息查询", class: "", resource: Prize },
                          {url: admin_activities_url, text: "活动信息", class: "", resource: Pool }
                         ]
                @menus.select! do |menu|
                        menu[:class] = "active" if menu[:url].end_with? controller_name
                        can? :manage, menu[:resource]
                end
        end


end
