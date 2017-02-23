include ActionController::HttpAuthentication::Basic::ControllerMethods
include ActionController::HttpAuthentication::Token::ControllerMethods

module Api::V1
  class ApiController < ApplicationController
    # skip_before_action :verify_authenticity_token

    private

    def authenticated?
      authenticate_or_request_with_http_basic {|username, password| User.where( name: username, password_digest: password).present? }
    end

    def authorized?
      user = User.find_by_id(session[:user_id])

      authenticate_or_request_with_http_basic do |username, password|
        username == user.username and password == user.password_digest
      end
    end
  end
end
