class User < ActiveRecord::Base
        # Include default devise modules. Others available are:
        # :confirmable, :lockable, :timeoutable and :omniauthable
        devise :database_authenticatable, :authentication_keys => [:name]
        enum role: [:share_manager, :admin, :lottery_manager, :activity_manager]

end
