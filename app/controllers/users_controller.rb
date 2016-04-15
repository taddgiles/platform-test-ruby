class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  skip_before_action :authenticate_request, only: [:authenticate]

  def index
    @users = User.limit(100)
    render json: @users
  end

  def show
    render json: @user
  end

  def current
    render json: current_user
  end

  def authenticate
    @user = User.find_by(email: params[:email])
    return head 404 unless @user
    return head 401 unless @user.authenticate(params[:password])

    payload = { user_id: @user.id.to_s }
    jwt = JWT.encode payload, ENV['JWT_SECRET'] || 'secret'

    render json: { auth_token: jwt }, status: :ok
  end

  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy

    head :no_content
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:name, :email, :password)
    end
end
