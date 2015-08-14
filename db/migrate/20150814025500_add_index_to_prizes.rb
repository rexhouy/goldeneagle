class AddIndexToPrizes < ActiveRecord::Migration
        def change
                add_index(:prizes, [:tel], unique: true)
        end
end
