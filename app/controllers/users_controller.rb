class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :edit_basic_info, :update_basic_info]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy, :edit_basic_info, :update_basic_info]
  before_action :set_one_month, only: :show

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @worked_sum = @attendances.where.not(started_at: nil).count
  end

  def new
    @user = User.new # ユーザーオブジェクトを生成し、インスタンス変数に代入します。
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user # 保尊成功後、ログインします。
      # 保存に成功した場合は、ここに記述した処理が実行されます。
      flash[:success] = '新規作成に成功しました。'
      redirect_to @user
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      # 更新に成功した場合の処理を記述します。
      flash[:success] = "ユーザー情報を更新しました。"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "#{@user.name}のデータを削除しました。"
    redirect_to users_url
  end

  def edit_basic_info
  end

  def update_basic_info
    if @user.update_attributes(basic_info_params)
      # 更新成功時の処理
      flash[:success] = "#{@user.name}の基本情報を更新しました。"
    else
      # 更新失敗時の処理
      flash[:danger] = "#{@user.name}の更新は失敗しました。<br>" + @user.errors.full_messages.join("<br>")
    end
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :department, :password, :password_confirmation)
    end

    def basic_info_params
      params.require(:user).permit(:department, :basic_time, :work_time)
    end
end