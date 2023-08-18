class UsersController < ApplicationController
    before_action :authorized, only: [:show, :create, :update, :destroy]

    def get
        @users = User.all
        render json: @users, status: 200
    end

    def create
            @user = User.create(user_params)
            render json: @user, status: :created
    end

private
    def user_params
        params.require(:user).permit(:username, :password)
    end
end
