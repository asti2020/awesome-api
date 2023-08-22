class AuthController < ApplicationController

    skip_before_action :authorized, only: [:login]
    rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found

    def login
        @user = User.find_by!(username: params[:username])

        if @user
            @user.authenticate(params[:password])
            @token = encode_token(user_id: @user.id)
        render json: {
            user: UserSerializer.new(@user),
            token: @token
        }, status: :ok
        else
            render json: {message: 'invalid password'}, status: :unauthorized
        end
    end


    private
    # def authenticate(username, password)
    #         user = User.find_by(username: username)
    #     if user && user.password == password
    #         return user
    #     else
    #         return nil
    #     end
    # end

    def login_params
        params.permit(:username, :password)
    end

    def handle_record_not_found
        render json: {message: 'user not exit'}, status: :unauthorized
    end

end
