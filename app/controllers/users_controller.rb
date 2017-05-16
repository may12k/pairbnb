class UsersController < Clearance::UsersController
before_action :find_user, only: [:show, :edit, :update]
  def new
    @user = User.new
    render template: "users/new"
  end

  def create
    # byebug
    @user = User.new(user_from_params)
    @message = "This post is wrong"
    if @user.save
      sign_in @user
      redirect_back_or url_after_create
    else
      flash[:notice] = @user.errors.messages
      # redirect_to "/sign_up"
      respond_to do |format|
       format.html  
       format.js
      end
    end
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_from_params
   params.require(:user).permit(:email, :name, :password)
  end

  def update
    if @user.update(user_params)
      flash[:success] = "Successfully updated the user"
      redirect_to @user
    else
      flash[:error] = "Error updating user"
      render :edit
    end
  end

end