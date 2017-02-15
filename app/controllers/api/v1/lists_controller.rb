module Api::V1
  class ListsController < ApiController
    before_action :authenticated?

    def create
      user = User.find(params[:user_id])
      list = user.lists.create(list_params)
      if list.save
        render json: list
      else
        render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private
    def list_params
      params.require(:list).permit(:title, :private)
    end
  end
end
