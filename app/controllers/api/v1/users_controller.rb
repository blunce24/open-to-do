module Api::V1
  class UsersController < ApiController
    # before_action :authenticated?

    def index
      users = User.all
      render json: users, each_serializer: UserSerializer
    end

    def create
      user = User.new(user_params)
      if user.save
        render json: user
      else
        render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      begin
        user = User.find(params[:id])
        user.destroy
        render json: {}, status: :no_content
      rescue ActiveRecord::RecordNotFound
        render :json => {}, :status => :not_found
      end
    end

    def show
      user = User.find(params[:id])
      lists = user.lists
    end

    def find_user
      p params
      user = User.find_by_email(params[:email])
      render json: user, each_serializer: UserSerializer
    end

    private
    def user_params
      params.require(:user).permit(:name, :email, :password_digest)
    end
  end
end
