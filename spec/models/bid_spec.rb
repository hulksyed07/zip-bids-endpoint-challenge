# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bid, type: :model do
  before :all do
    4.times { create(:bid) }
  end

  it 'should get count of existing bids' do
    expect(Bid.count).to eq 4
  end
end
