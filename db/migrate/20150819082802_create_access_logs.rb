class CreateAccessLogs < ActiveRecord::Migration
        def change
                create_table :access_logs do |t|
                        t.string :app
                        t.string :ip
                        t.timestamps null: false
                end
        end
end
