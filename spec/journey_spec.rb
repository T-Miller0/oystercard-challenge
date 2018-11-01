require "journey"

describe Journey do
  it "Journey#touch_in" do
    expect(subject.touch_in("Hammersmith")).to eq true
  end

  it "Journey#touch_out" do
    subject.touch_in("Hammersmith")
    expect(subject.touch_out("Old Street")).to eq({ :entry_station => "Hammersmith", :exit_station => "Old Street" })
  end

  it "Journey#in_journey?" do
    expect(subject.in_journey?).to eq false
  end

  # describe "fare" do
  #   context "calculate standard fare" do
  #
  #     it "standard journy" do
  #       subject.touch_in("Hammersmith")
  #       subject.touch_out("Old Street")
  #       expect(subject.fare).to eq 1
  #     end
  #   end
  #
  # end
end
