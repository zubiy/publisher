class PublisherController < ApplicationController
  def shops
    publisher = Publisher.find(params[:id])

    render(
      status: :ok,
      json: publisher,
      serializer: PublisherShopsSerializer,
      include: '**',
      shops: Shops.sort_shop(publisher),
      books: Books.new.amount_publisher(publisher)
    )
  end
end
