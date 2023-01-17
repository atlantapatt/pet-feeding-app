class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessible_entity

    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: :created
    end

    def index
        users = User.all
        render json: users, status: :ok
    end

    private

    def user_params
        params.permit(:username, :password, :password_confirmation)
    end

    def render_unprocesable_entity(invalid)
        render json: {errors: invalid.record.errors.full_messagess}, status: 422
    end
end
