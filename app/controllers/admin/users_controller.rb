class Admin::UsersController < AdminController
        def index
                @users = User.paginate(:page => params[:page])
        end

        def edit
                @user = User.find(params[:id])
        end

        def update
                if params[:user][:password].blank?
                        params[:user].delete(:password)
                        params[:user].delete(:password_confirmation)
                end
                @user = User.find(params[:id])
                if @user.update(user_params)
                        redirect_to :action => "show", :id => @user.id
                else
                        render "edit"
                end
        end

        def create
                if params[:user][:password].blank?
                        params[:user].delete(:password)
                        params[:user].delete(:password_confirmation)
                end
                @user = User.new(user_params)
                if @user.save
                        redirect_to :action => "show", :id => @user.id
                else
                        render "new"
                end
        end

        def new
                @user = User.new
        end

        def destroy
                @user = User.find(params[:id])
                @user.destroy
                redirect_to :action => "index"
        end

        private
        def user_params
                params.require(:user).permit(:id, :role, :password, :password_confirmation, :name)
        end

end
