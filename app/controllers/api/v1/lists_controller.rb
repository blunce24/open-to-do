module Api::V1
  class ListsController < ApiController
    #before_action :authenticated?

    def index
      lists = List.all
      render json: lists, each_serializer: ListSerializer
    end

    def create
      user = User.find(params[:user_id])
      list = user.lists.create(list_params)
      if list.save
        render json: list
      else
        render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      begin
          #user = User.find_by_id(session[:user_id])
          list = List.find(params[:id])
          if authorized?
            list.destroy
            render json: {}, status: :no_content
          else
            render json: { errors: list.errors.full_messages }, status: :unprocessable_entity
          end
        rescue ActiveRecord::RecordNotFound
          render :json => {}, :status => :not_found
        end
    end

    def update
      #user = User.find_by_id(session[:user_id])
      list = List.find(params[:id])
      authorized?(list)

      if list.update(list_params)
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
