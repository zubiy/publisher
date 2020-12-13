RSpec.describe 'Publisher API', type: :request do
  # rubocop:disable Naming/VariableNumber
  describe 'GET /publishers/:id/shops' do
    # For a specific Publisher it should return the list of shops selling at
    # least one book of that publisher. Shops should be ordered by the number
    # of books sold. Each shop should include the list of Publisher's books
    # that are currently in stock.
    it 'returns shops ' do
      publisher_1 = create(:publisher)
      publisher_2 = create(:publisher)
      book_1 = create(:book, publisher: publisher_1, title: 'Book 1')
      book_2 = create(:book, publisher: publisher_1, title: 'Book 2')
      book_3 = create(:book, publisher: publisher_2, title: 'Book 3')
      shop_1 = create(:shop, name: 'Shop 1')
      shop_2 = create(:shop, name: 'Shop 2')
      shop_3 = create(:shop, name: 'Shop 3')

      create(:stock, shop: shop_1, book: book_1, amount: 7)
      create(:stock, shop: shop_1, book: book_2, amount: 5)
      create(:stock, shop: shop_1, book: book_3, amount: 11)

      create(:stock, shop: shop_2, book: book_1, amount: 0)
      create(:stock, shop: shop_2, book: book_2, amount: 3)
      create(:stock, shop: shop_2, book: book_3, amount: 19)

      create(:stock, shop: shop_3, book: book_3, amount: 55)

      create_list(:purchase, 7, book: book_2, shop: shop_2)
      create_list(:purchase, 11, book: book_3, shop: shop_2)
      create_list(:purchase, 2, book: book_3, shop: shop_3)

      get "/publishers/#{publisher_1.id}/shops"

      expect(response).to have_http_status(200)
      expect(json).to eq(
        "shops": [
          {
            "id": 1,
            "name": 'Shop 1',
            "books_sold_count": 0,
            "books_in_stock": [
              {
                "id": 1,
                "title": 'Book 1',
                "copies_in_stock": 7
              },
              {
                "id": 2,
                "title": 'Book 2',
                "copies_in_stock": 5
              }
            ]
          },
          {
            "id": 2,
            "name": 'Shop 2',
            "books_sold_count": 7,
            "books_in_stock": [
              {
                "id": 2,
                "title": 'Book 2',
                "copies_in_stock": 3
              }
            ]
          }
        ]
      )
    end

    it 'returns status code 404' do
      get '/publishers/unknown/shops'

      expect(response).to have_http_status(404)
      expect(response.body).to match(/Couldn't find Publisher/)
    end
  end
  # rubocop:enable Naming/VariableNumber
end
