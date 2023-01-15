# Class to handle search filters in Bids and return qualified bids
class BidSearch
  attr_accessor :countries, :categories, :channels
  attr_reader :bids

  def initialize(params)
    @countries = (params[:countries] || '*').split(',')
    @categories = (params[:categories] || '*').split(',')
    @channels = (params[:channels] || '*').split(',')
  end

  def call
    @bids = []
    @countries.each do |country|
      @categories.each do |category|
        @channels.each do |channel|
          amount = Bid.select(:amount)
                      .where(country: [country, '*'], category: [category, '*'], channel: [channel, '*'])
                      .order(:priority)
                      .first&.amount
          @bids << { country: country, category: category, channel: channel, amount: amount }
        end
      end
    end
  end
end
