require 'station'

describe Station do

  let(:station) { described_class.new("Hammersmith", 1) }

  it "Station#new takes two arguments: Name" do
    expect(station.name).to eq("Hammersmith")
  end

  it "Station#new takes two arguments: Zone" do
    expect(station.zone).to eq(1)
  end
end
