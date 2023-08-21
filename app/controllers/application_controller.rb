class ApplicationController < ActionController::Base
    protect_from_forgery
    before_action :authorized


    def encode_token(playload)
        # JWT.encode(playload, Rails.application.secrets.secret_key_base, 'HS256')
        JWT.encode(playload, 'awsome101')
    end

    def decoded_token
        header = request.headers['Authorization']
        if header
            token = header.split(" ")[1]
            begin
                JWT.decode(token, 'awsome101')
                rescure JWT::DecodeError
                nil
            end
        end
    end

    def current_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    def authorized
        unless !!current_user
            render json: { message: "Please log in"}, status: :unauthorized
        end
    end

    
end
