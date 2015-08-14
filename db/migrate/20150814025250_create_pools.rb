class CreatePools < ActiveRecord::Migration
        def change
                create_table :pools do |t|
                        t.integer :count, null: false
                        t.timestamps null: false
                end
        end
end
