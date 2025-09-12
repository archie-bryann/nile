module Api
  module V1
    class AuthenticationController < ApplicationController
        class AuthenticationError < StandardError; end # custom error created here
        rescue_from ActionController::ParameterMissing, with: :parameter_missing
        rescue_from AuthenticationError, with: :handle_unauthenticated

        def create
            # p params.require(:username).inspect
            # p params.require(:password).inspect

            user = User.find_by(username: params.require(:username))

            # raise custom error if password is incorrect
            raise AuthenticationError unless user.authenticate(params.require(:password))
            token = AuthenticationTokenService.call(user.id)

            render json: { token: token }, status: :created
        end

        private

        def user
          @user ||= User.find_by(username: params.require(:username)) # memoized value (||) for this controller
        end

        def parameter_missing(e)
            render json: { error: e.message }, status: :unprocessable_entity
        end

        def handle_unauthenticated
          head :unauthorized
        end
    end 
  end
end