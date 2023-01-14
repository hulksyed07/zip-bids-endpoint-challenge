class BidsController < ApplicationController
  def index
    searched_countries = params[:countries].split(',')
    searched_categories = params[:categories].split(',')
    searched_channels = params[:channels].split(',')

    bids = []
    searched_countries.each do |country|
      searched_categories.each do |category|
        searched_channels.each do |channel|
          amount = Bid.select("amount")
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
                      .first.amount
          bids << { country: country, category: category, channel: channel, amount: amount }
        end
      end
    end

    render json: { bids: bids }
  end
end
