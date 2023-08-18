class UsersController < ApplicationController
    protect_from_forgery


    def create
            @user = User.create(:username => params[:name], :email => params[:email], :password => params[:password])
            render json: @user, status: :created
    end

    def index
        @user = User.all
        render json: @user, status: :ok
    end
end
