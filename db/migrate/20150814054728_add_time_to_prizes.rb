class AddTimeToPrizes < ActiveRecord::Migration
        def change
                add_column :prizes, :time, :datetime
        end
end
