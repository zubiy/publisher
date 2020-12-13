Rails.application.routes.draw do
  get 'publishers/:id/shops', to: 'publisher#shops'
  post 'shops/:id/sold_out', to: 'shop#sold_out'
end
