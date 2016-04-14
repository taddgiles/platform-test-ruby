class ApplicationController < ActionController::API
  before_action :authenticate

  helper_method :current_user

  protected

  def authenticate
    return head 401 unless current_user
  end

  def current_user
    @current_user ||= user_via_bearer_token
  end

  def user_via_bearer_token
    return false unless bearer_token
    decoded_token = JWT.decode bearer_token,
                    PlatformTestRuby::Application.config.secret_token
    User.find(decoded_token.first['user_id'])
  end

  def bearer_token
    pattern = /^Bearer /
    header  = request.headers['HTTP_AUTHORIZATION']
    header.gsub(pattern, '') if header && header.match(pattern)
  end
end
