class Prize < ActiveRecord::Base
        enum status: [:unclaimed, :claimed]
end
