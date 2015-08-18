class Admin::PrizesController < AdminController

        def index
        end

        def detail
        end

        def search
                @tel = params[:tel]
                @prize = Prize.find_by_tel(params[:tel])
                render :detail
        end

        def claim
                @prize = Prize.find(params[:id])
                @prize.name = params[:name]
                @prize.claim_time = Time.now
                @prize.status = Prize.statuses[:claimed]
                @prize.save!
                render :detail
        end

end
