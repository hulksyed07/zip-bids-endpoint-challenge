class BidsController < ApplicationController
  def index
    bid_search = BidSearch.new(params)
    bid_search.call
    render json: { bids: bid_search.bids }
  end
end
