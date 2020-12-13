class ShopController < ApplicationController
  def sold_out
    shop = Shop.find(params[:id])
    result = shop.sold_out!(params[:ids])

    render json: { count: result }, status: :ok
  end
end
