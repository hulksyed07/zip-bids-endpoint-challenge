class BidsController < ApplicationController
  def index
    searched_countries = params[:countries].split(',')
    searched_categories = params[:categories].split(',')
    searched_channels = params[:channels].split(',')

    bids = []
    searched_countries.each do |country|
      searched_categories.each do |category|
        searched_channels.each do |channel|
          amount = Bid.find_by_sql(["SELECT amount
                                    FROM
                                    #{Bid.table_name}
                                    where country in (?) AND category in (?) AND channel in (?)
                                    ORDER BY (
                                       CASE
                                         WHEN (country != '*' AND category != '*' AND channel != '*') THEN 1
                                         WHEN (country != '*' AND category != '*' AND channel = '*') THEN 2
                                         WHEN (country != '*' AND category = '*' AND channel != '*') THEN 3
                                         WHEN (country != '*' AND category = '*' AND channel = '*') THEN 4
                                         WHEN (country = '*' AND category != '*' AND channel != '*') THEN 5
                                         WHEN (country = '*' AND category != '*' AND channel = '*') THEN 6
                                         WHEN (country = '*' AND category = '*' AND channel != '*') THEN 7
                                         WHEN (country = '*' AND category = '*' AND channel = '*') THEN 8
                                         ELSE 8
                                       END
                                    ) ASC
                                    LIMIT 1
                                 ", [country, '*'], [category, '*'], [channel, '*']]).first.amount
          bids << { country: country, category: category, channel: channel, amount: amount }
        end
      end
    end

    render json: { bids: bids }
  end
end
