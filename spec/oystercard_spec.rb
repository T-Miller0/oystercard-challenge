require 'oystercard'

describe Oystercard do
  it "New Oystercard#balance returns 0" do
    expect(subject.balance).to eq 0
  end

  context "testing Oystercard#top_up" do

    it "Oystercard#top_up increases balance" do
      expect(subject.top_up(20)).to eq 20
    end

    it "Oystercard#top_up raises error if balance would exceed maximum" do
      max_balance = Oystercard::MAX_BALANCE
      expect { subject.top_up(max_balance + 1) }.to raise_error("Balance would exceed #{max_balance}")
    end
  end


  # context "testing Oystercard#deduct" do
  #
  #   it "Oystercard#deduct reduces balance" do
  #     subject.top_up(20)
  #     expect(subject.deduct(4)).to eq 16
  #   end
  # end
  describe "Oystercard#touch_in requires double tube_stop variable" do

    let(:tube_stop) { double :tube_stop }

    context "testing touch in" do

      it "Oystercard#touch_in sets card as 'in use'" do
        subject.top_up(5)
        expect(subject.touch_in(tube_stop)).to eq true
      end

      it "Oystercard#touch_in throws error due to insufficient funds" do
        expect { subject.touch_in(tube_stop) }.to raise_error("Insufficient funds. Balance: #{subject.balance}")
      end

      it "Oystercard#touch_in remembers station" do
        subject.top_up(5)
        subject.touch_in(tube_stop)
        expect(subject.station).to eq tube_stop
      end
    end

    context "testing touch out" do

      it "Oystercard#touch_out sets card to 'not in use'" do
        subject.top_up(5)
        subject.touch_in(tube_stop)
        expect(subject.touch_out).to eq false
      end

      it "Oystercard#touch_out deduct cost from balance" do
        subject.top_up(5)
        subject.touch_in(tube_stop)
        expect {subject.touch_out}.to change {subject.balance}.by(-Oystercard::MIN_CHARGE)
      end

      it "Oystercard#in_journey?" do
        subject.top_up(5)
        subject.touch_in(tube_stop)
        expect(subject.in_journey?).to eq true
      end

    end
  end
end
