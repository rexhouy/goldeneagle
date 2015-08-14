class CreatePrizes < ActiveRecord::Migration
        def change
                create_table :prizes do |t|
                        t.string :name
                        t.string :prize
                        t.string :tel, null: false
                        t.integer :status
                        t.datetime :claim_time
                        t.string :code

                        t.timestamps null: false
                end
        end
end
