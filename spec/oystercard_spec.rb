require 'oystercard'

describe Oystercard do
  it "New Oystercard#balance returns 0" do
    expect(subject.balance).to eq 0
  end

  it "Oystercard#top_up increases balance" do
    expect(subject.top_up(20)).to eq 20
  end

end
