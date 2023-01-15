# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Bid, type: :model do
  before :all do
    4.times { create(:bid) }
  end

  it 'should get count of existing bids' do
    expect(Bid.count).to eq 4
  end

  it 'should destroy bid' do
    Bid.last.destroy
    expect(Bid.count).to eq 3
  end

  it 'should create bid and assign correct priority to it' do
    bid = create(:bid)
    expect(bid.priority).to eq 1

    bid = create(:bid, channel: '*')
    expect(bid.priority).to eq 2

    bid = create(:bid, category: '*')
    expect(bid.priority).to eq 3

    bid = create(:bid, category: '*', channel: '*')
    expect(bid.priority).to eq 4

    bid = create(:bid, country: '*')
    expect(bid.priority).to eq 5

    bid = create(:bid, country: '*', channel: '*')
    expect(bid.priority).to eq 6

    bid = create(:bid, country: '*', category: '*')
    expect(bid.priority).to eq 7

    bid = create(:bid, country: '*', category: '*', channel: '*')
    expect(bid.priority).to eq 8
  end
end
