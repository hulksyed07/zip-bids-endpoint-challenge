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
    context 'With Proper Params' do
      example 'Search Bids' do
        explanation 'Search Bids based on countries, categories and channels combination'
        do_request({ countries: 'us,uk', categories: 'finance,sports', channels: 'ca,ga' })
        expect(status).to eq 200
        expect(JSON.parse(response_body)['bids']).to match_array(
          [
            { 'country' => 'us', 'category' => 'finance', 'channel' => 'ca', 'amount' => '4.0' },
            { 'country' => 'us', 'category' => 'finance', 'channel' => 'ga', 'amount' => '2.0' },
            { 'country' => 'us', 'category' => 'sports', 'channel' => 'ca', 'amount' => '2.0' },
            { 'country' => 'us', 'category' => 'sports', 'channel' => 'ga', 'amount' => '2.0' },
            { 'country' => 'uk', 'category' => 'finance', 'channel' => 'ca', 'amount' => '1.0' },
            { 'country' => 'uk', 'category' => 'finance', 'channel' => 'ga', 'amount' => '1.0' },
            { 'country' => 'uk', 'category' => 'sports', 'channel' => 'ca', 'amount' => '3.0' },
            { 'country' => 'uk', 'category' => 'sports', 'channel' => 'ga', 'amount' => '3.0' }
          ]
        )
      end
    end

    context 'With Blank Country Param' do
      example 'Search Bids without Country' do
        explanation 'Search Bids based on countries, categories and channels combination'
        do_request({ categories: 'finance,sports', channels: 'ca,ga' })
        expect(status).to eq 200
        expect(JSON.parse(response_body)['bids']).to match_array(
          [
            {'country' => '*', 'category' => 'finance', 'channel' => 'ca', 'amount' => '1.0' },
            {'country' => '*', 'category' => 'finance', 'channel' => 'ga', 'amount' => '1.0' },
            {'country' => '*', 'category' => 'sports', 'channel' => 'ca', 'amount' => '1.0' },
            {'country' => '*', 'category' => 'sports', 'channel' => 'ga', 'amount' => '1.0' }
          ]
        )
      end
    end
  end
end
