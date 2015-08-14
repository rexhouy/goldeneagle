class CreateShares < ActiveRecord::Migration
        def change
                create_table :shares do |t|
                        t.string :name
                        t.string :content
                        t.string :image_1
                        t.string :image_2
                        t.string :image_3
                        t.string :tel
                        t.integer :status
                        t.integer :fav
                        t.timestamps null: false
                end
        end
end
