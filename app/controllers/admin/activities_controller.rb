class Admin::ActivitiesController < AdminController
        skip_load_and_authorize_resource
        def index
                @prizes = Prize.where("prize is not null").paginate(:page => params[:page])
                # Pool size
                @pool_1_size, @pool_2_size = LotteryService.pool_size
                # Lottery count
                @lottery_pool_1 = Pool.find(1).count
                @lottery_pool_2 = Pool.find(2).count
                @lottery_pool_1 = @pool_1_size if @lottery_pool_1 > @pool_1_size
                @lottery_pool_2 = @pool_2_size if @lottery_pool_2 > @pool_2_size
                # Claim count
                @claim_count = Prize.where(status: Prize.statuses[:claimed]).count
        end

end
