require "journey"

describe Journey do
  it "Journey#touch_in" do
    expect(subject.touch_in("Hammersmith")).to eq true
  end

  it "Journey#touch_out" do
    expect(subject.touch_out("Old Street")).to eq false
  end

  it "Journey#in_journey?" do
    expect(subject.in_journey?).to eq false
  end
end
