RSpec.describe 'BidSearch' do
  before do
    create(:bid, country: 'us', category: 'finance', channel: 'ca', amount: 4.0)
    create(:bid, country: 'uk', category: 'sports', channel: '*', amount: 3.0)
    create(:bid, country: 'us', category: '*' , channel: '*', amount: 2.0)
    create(:bid, country: '*', category: '*', channel: '*', amount: 1.0)
  end

  it 'should search and return matching bids' do
    bid_search = BidSearch.new({ countries: 'us,uk', categories: 'finance,sports', channels: 'ca,ga' })
    bid_search.call
    expect(bid_search.bids).to match_array(
      [
        { country: 'us', category: 'finance', channel: 'ca', amount: BigDecimal('4.0') },
        { country: 'us', category: 'finance', channel: 'ga', amount: BigDecimal('2.0') },
        { country: 'us', category: 'sports', channel: 'ca', amount: BigDecimal('2.0') },
        { country: 'us', category: 'sports', channel: 'ga', amount: BigDecimal('2.0') },
        { country: 'uk', category: 'finance', channel: 'ca', amount: BigDecimal('1.0') },
        { country: 'uk', category: 'finance', channel: 'ga', amount: BigDecimal('1.0') },
        { country: 'uk', category: 'sports', channel: 'ca', amount: BigDecimal('3.0') },
        { country: 'uk', category: 'sports', channel: 'ga', amount: BigDecimal('3.0') }
      ]
    )
  end
end
