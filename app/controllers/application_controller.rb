class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  def authenticate
    authenticate_token || render_unauthorized
  end

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(token: token)
    end
  end

  def render_unauthorized(realm = "Application")
    render json: { error: 'bad credentials' }, status: :unauthorized
  end
end
