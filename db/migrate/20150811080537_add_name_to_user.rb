class AddNameToUser < ActiveRecord::Migration
        def change
                add_column :users, :name, :string
                remove_column :users, :email
                add_index :users, :name, :unique => true
        end
end
