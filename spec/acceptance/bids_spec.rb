require 'acceptance_helper'
resource 'Bid', acceptance: true do
  before do
    create(:bid, country: 'us', category: 'finance', channel: 'ca', amount: 4.0)
    create(:bid, country: 'uk', category: 'sports', channel: '*', amount: 3.0)
    create(:bid, country: 'us', category: '*', channel: '*', amount: 2.0)
    create(:bid, country: '*', category: '*', channel: '*', amount: 1.0)
    header 'Content-Type', 'application/json'
  end

  get '/bids' do
    example 'Search Bids' do
      explanation 'Search Bids based on countries, categories and channels combination'
      do_request({ countries: 'us,uk', categories: 'finance,sports', channels: 'ca,ga' })
      expect(status).to eq 200
    end
  end
end
