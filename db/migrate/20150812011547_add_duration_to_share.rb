class AddDurationToShare < ActiveRecord::Migration
        def change
                add_column :shares, :duration, :integer
        end
end
