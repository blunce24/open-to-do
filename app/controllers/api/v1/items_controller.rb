module Api::V1
  class ItemsController < ApiController
    before_action :authenticated?

    def index
      items = Item.all
      render json: items, each_serializer: ItemSerializer
    end

    def create
      list = List.find(params[:list_id])
      item = list.items.create(item_params)
      if item.save
        render json: item
      else
        render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
      item = Item.find(params[:id])
      if item.update(item_params)
        render json: item
      else
        render json: { errors: item.errors.full_messages }, status: :unprocessable_entity
      end
    end

    private
    def item_params
      params.require(:item).permit(:description, :completed)
    end
  end
end
