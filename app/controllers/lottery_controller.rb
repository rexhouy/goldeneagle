# -*- coding: utf-8 -*-
require "securerandom"
class LotteryController < ApplicationController

        def index
                render layout: false
        end

        def send_sms
                result = LotteryService.new.check
                return render json: result unless result.nil?
                prize = Prize.find_by_tel(params[:tel])
                if !prize.nil? && !prize.prize.nil?
                        return render json: {error: "一个号码只能参与一次"}
                end
                prize ||= Prize.new
                if prize.tel.nil?
                        prize.tel = params[:tel]
                        prize.code = random_captcha
                        prize.save
                end
                SmsService.new.send_captcha(prize.tel, prize.code)
                render json: {result: "ok"}
        end

        def sign_in
                tel = params[:tel]
                code = params[:captcha]
                prize = Prize.where(tel: tel).where(code: code).first
                if prize.nil?
                        render json: {error: "短信验证码错误"}
                else
                        render json: random_prize(prize)
                end
        end

        private
        def random_prize(lottery)
                return {error: "一个号码只能抢一次"} unless lottery.prize.nil?
                prize, success = LotteryService.new.lottery
                return prize unless success
                lottery.prize = prize
                lottery.time = Time.now
                lottery.status = Prize.statuses[:unclaimed]
                lottery.save!
                lottery
        end

        def random_captcha
                SecureRandom.random_number(10**6).to_s.rjust(6,"0")
        end

end
