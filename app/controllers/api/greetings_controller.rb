class Api::GreetingsController < ApplicationController
  def index
    render json: { message: "Hello, #{@current_user.name}" }
  end
end
