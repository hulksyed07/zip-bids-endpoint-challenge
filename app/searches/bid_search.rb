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
          amount = Bid.select('amount')
                      .where(country: [country, '*'], category: [category, '*'], channel: [channel, '*'])
                      .order(Arel.sql("(CASE
                                WHEN (country != '*' AND category != '*' AND channel != '*') THEN 1
                                WHEN (country != '*' AND category != '*' AND channel = '*') THEN 2
                                WHEN (country != '*' AND category = '*' AND channel != '*') THEN 3
                                WHEN (country != '*' AND category = '*' AND channel = '*') THEN 4
                                WHEN (country = '*' AND category != '*' AND channel != '*') THEN 5
                                WHEN (country = '*' AND category != '*' AND channel = '*') THEN 6
                                WHEN (country = '*' AND category = '*' AND channel != '*') THEN 7
                                WHEN (country = '*' AND category = '*' AND channel = '*') THEN 8
                                ELSE 8
                              END)"))
                      .first&.amount
          @bids << { country: country, category: category, channel: channel, amount: amount }
        end
      end
    end
  end
end
