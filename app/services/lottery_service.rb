# -*- coding: utf-8 -*-
class LotteryService

        @@pool_empty = {1 => false, 2 => false}
        @@pool1 = [5, 200, 5, 5, 5, 10, 5, 10, 10, 50, 5, 20, 10, 20, 20, 5, 20, 20, 50, 50, 10, 50, 5, 50, 5, 20, 20, 5, 20, 5, 10, 5, 10, 5, 100, 10, 20, 10, 100, 5, 50, 10, 5, 20, 20, 20, 10, 10, 20, 20, 20, 5, 200, 20, 10, 5, 10, 10, 50, 5, 20, 20, 5, 5, 20, 10, 10, 20, 20, 10, 10, 10, 10, 5, 20, 50, 10, 20, 20, 5, 5, 50, 200, 5, 10, 5, 50, 10, 5, 10, 10, 10, 50, 5, 50, 20, 10, 20, 10, 50, 10, 5, 5, 20, 20, 100, 100, 50, 10, 20, 20, 10, 20, 10, 10, 20, 10, 5, 10, 50, 50, 10, 10, 20, 5, 10, 50, 10, 5, 20, 5, 10, 10, 10, 20, 10, 5, 10, 5, 20, 50, 10, 10, 5, 5, 5, 10, 50, 10, 20, 20, 20, 50, 5, 20, 100, 10, 5]
        @@pool2 = [20, 10, 10, 50, 20, 20, 10, 100, 50, 10, 50, 10, 20, 10, 10, 10, 20, 5, 10, 20, 5, 10, 10, 20, 20, 20, 5, 10, 20, 50, 5, 5, 5, 50, 10, 20, 10, 20, 5, 50, 10, 10, 10, 10, 10, 20, 10, 5, 5, 10, 5, 20, 5, 20, 10, 10, 50, 20, 10, 10, 10, 5, 20, 20, 20, 100, 5, 10, 50, 50, 10, 5, 10, 20, 20, 5, 50, 20, 20, 5, 5, 10, 10, 5, 5, 5, 200, 50, 50, 10, 200, 50, 50, 5, 10, 5, 20, 50, 10, 20, 5, 5, 50, 50, 5, 5, 5, 5, 10, 5, 20, 50, 100, 5, 20, 10, 20, 10, 10, 20, 5, 5, 10, 10, 20, 20, 100, 5, 50, 10, 100, 10, 50, 20, 10, 5, 20, 10, 10, 5, 20, 10, 5, 5, 20, 10, 10, 20, 5, 5, 5, 10, 20, 20, 20, 20, 10]

        START_DATE_1 = DateTime.new(2015, 8, 14, 10, 0, 0, "+8" )
        START_DATE_2 = DateTime.new(2015, 8, 14, 14, 0, 0, "+8")

        def self.pool_size
                [@@pool1.size, @@pool2.size]
        end

        def check
                @now = Time.now
                return {error: "活动尚未开始。20日15:00 20:00开抢"} if @now < START_DATE_1
                if @now > START_DATE_2
                        return {error: "很抱歉，您来晚了一步，红包已被抢完"} if lottery2_empty?
                else
                        return {error: "红包已被抢完，下次开抢时间20：00"} if lottery1_empty?
                end
        end

        def lottery
                val = check
                return val unless val.nil?
                pool, id = which_pool
                index = get_and_update_pool_count(id, pool)
                if index >= pool.size
                        return [id.eql?(1) ? {error: "红包已被抢完，下次开抢时间20：00"} : {error: "很抱歉，您来晚了一步，红包已被抢完"}, false]
                end
                [pool[index], true]
        end

        private
        def get_and_update_pool_count(id, pool)
                pl = Pool.lock(true).find(id)
                index = pl.count
                pl.count += 1
                pl.save!
                @@pool_empty[id] = true if pl.count >= pool.size
                index
        end

        def which_pool
                return [@@pool1, 1] if @now < START_DATE_2
                [@@pool2, 2]
        end

        def lottery1_empty?
                @@pool_empty[1]
        end

        def lottery2_empty?
                @@pool_empty[2]
        end

end
