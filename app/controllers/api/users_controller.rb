class Api::UsersController < ApplicationController
  skip_before_action :authenticate 

  def create
    user = User.new(user_params)
    if user.save
      render json: { message: 'user created'}
    else
      render json: { error: user.errors.messages }, status: 400
    end
  end

  def login
    user = User.find_by_name(params[:name])
    if user && user.try(:authenticate, params[:password])
      loop do
        token = SecureRandom.hex(16)
        unless User.exists?(token: token)
          user.token = token 
          break
        end
      end
      user.save
      render json: { message: 'login successful', token: user.token }
    else
      render json: { error: 'login failed' }, status: 401
    end
  end

  def logout
    user = User.find_by_token(params[:token])
    if user
      user.token = nil
      user.save
    end
  end

  def user_params
    params.permit(:name, :password)
  end
end
