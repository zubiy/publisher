RSpec.describe 'Shop API', type: :request do
  # rubocop:disable Naming/VariableNumber
  describe 'POST /shops/:id/sold_out' do
    it 'mark specific books in shop as sold out' do
      book_1 = create(:book, title: 'Book 1')
      book_2 = create(:book, title: 'Book 2')
      book_3 = create(:book, title: 'Book 3')
      shop_1 = create(:shop, name: 'Shop 1')
      shop_2 = create(:shop, name: 'Shop 2')

      stock_1_1 = create(:stock, shop: shop_1, book: book_1, amount: 7)
      stock_1_2 = create(:stock, shop: shop_1, book: book_2, amount: 5)
      stock_1_3 = create(:stock, shop: shop_1, book: book_3, amount: 11)

      stock_2_1 = create(:stock, shop: shop_2, book: book_1, amount: 0)
      stock_2_2 = create(:stock, shop: shop_2, book: book_2, amount: 3)
      stock_2_3 = create(:stock, shop: shop_2, book: book_3, amount: 19)

      post "/shops/#{shop_1.id}/sold_out", params: { ids: [book_1.id, book_3.id] }

      expect(response).to have_http_status(200)
      expect(json).to eq(count: 2)

      expect(stock_1_1.reload.amount).to eq(0)
      expect(stock_1_2.reload.amount).to eq(5)
      expect(stock_1_3.reload.amount).to eq(0)
      expect(stock_2_1.reload.amount).to eq(0)
      expect(stock_2_2.reload.amount).to eq(3)
      expect(stock_2_3.reload.amount).to eq(19)
    end

    it 'correct process invalid shop id' do
      post '/shops/unknown/sold_out', params: { ids: [] }

      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Shop/)
    end

    it 'correct process invalid book ids' do
      book = create(:book, title: 'Book 1')
      shop = create(:shop, name: 'Shop 1')
      stock = create(:stock, shop: shop, book: book, amount: 4)

      post "/shops/#{shop.id}/sold_out", params: { ids: ['invalid'] }

      expect(response).to have_http_status(200)
      expect(json).to eq(count: 0)

      expect(stock.reload.amount).to eq(4)
    end

    it 'does not update record for empty load' do
      book = create(:book, title: 'Book 1')
      shop = create(:shop, name: 'Shop 1')
      stock = create(:stock, shop: shop, book: book, amount: 4)

      post "/shops/#{shop.id}/sold_out", params: { ids: [] }

      expect(response).to have_http_status(200)
      expect(json).to eq(count: 0)

      expect(stock.reload.amount).to eq(4)
    end
  end
  # rubocop:enable Naming/VariableNumber
end
