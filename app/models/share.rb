class Share < ActiveRecord::Base

        self.per_page = 10

        before_create do
                self.fav = 0
                self.status = Share.statuses[:unhandled]
        end

        enum status: [:unhandled, :passed, :rejected]

        def self.passed
                where(status: Share.statuses[:passed])
        end

        def self.unhandled
                where(status: Share.statuses[:unhandled])
        end

        def self.filter(status)
                status = 0 if status.nil? || status.empty?
                return all if status.eql? "all"
                where(status: status)
        end

end
