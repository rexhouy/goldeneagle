class Admin::ActivitiesController < AdminController
        skip_load_and_authorize_resource
        def index
                search
        end

        def search
                @tel = params[:tel]
                if @tel.nil? || @tel.empty?
                        @prizes = Prize.where("prize is not null").paginate(:page => params[:page])
                else
                        @prizes = Prize.where("prize is not null").where(tel: @tel).paginate(:page => params[:page])
                end
                statistics
                render :index
        end

        def export
                @prizes = Prize.all
                response.headers["Content-disposition"] = "attachment; filename=statistics.xls"
                response.headers["Pragma"] = "no-cache"
                response.headers["Content-Type"] = "application/vnd.ms-excel; charset=UTF-8"
                render layout: false
        end

        private
        def statistics
                pool_size
                lottery_count
                claim_count
        end

        def pool_size
                @pool_1_size, @pool_2_size = LotteryService.pool_size
        end

        def lottery_count
                @lottery_pool_1 = Pool.find(1).count
                @lottery_pool_2 = Pool.find(2).count
                @lottery_pool_1 = @pool_1_size if @lottery_pool_1 > @pool_1_size
                @lottery_pool_2 = @pool_2_size if @lottery_pool_2 > @pool_2_size
        end

        def claim_count
                @claim_count = Prize.where(status: Prize.statuses[:claimed]).count
        end

end
