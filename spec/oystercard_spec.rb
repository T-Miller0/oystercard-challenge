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

    let(:tube_stop) { double :entry_station }
    let(:tube_stop2) { double :exit_station }

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
        expect(subject.entry_station).to eq tube_stop
      end
    end

    context "testing touch out" do

      before(:each) do
        subject.top_up(5)
        subject.touch_in(tube_stop)
      end

      it "Oystercard#touch_out sets card to 'not in use'" do
        expect(subject.touch_out(tube_stop2)).to eq false
      end

      it "Oystercard#touch_out deduct cost from balance" do
        expect {subject.touch_out(tube_stop2)}.to change {subject.balance}.by(-Oystercard::MIN_CHARGE)
      end

      it "Oystercard#in_journey?" do
        expect(subject.in_journey?).to eq true
      end

      it "Oystercard#touch_out remembers station" do
        subject.touch_out(tube_stop2)
        expect(subject.journey_history).to eq [{entry_station: tube_stop, exit_station: tube_stop2}]
      end

    end

    it "Oystercard#journey_history returns empty array" do
      expect(subject.journey_history).to eq []
    end


  end



end
