class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new # ユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      # 保存に成功した場合は、ここに記述した処理が実行されます。
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
