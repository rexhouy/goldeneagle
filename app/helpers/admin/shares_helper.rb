# -*- coding: utf-8 -*-
module Admin::SharesHelper

        def status(share)
                return "等待审核" if share.unhandled?
                return "审核通过" if share.passed?
                return "审核失败" if share.rejected?
                ""
        end

end
