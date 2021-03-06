require 'oystercard'

describe Oystercard do
  
  let(:station) {double :station}

  describe '@balance' do
    it 'initializes a new card with a default balance of 0' do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'adds the specified credit to the balance' do
      subject.top_up(9)
      expect(subject.balance).to eq(9)
    end
    it 'will raise an exception when a topup will exceed the maximum value of 90' do #starting with 90 but could be removed to make test better
      expect {subject.top_up(100)}.to raise_error("Topup will exceed maximum balance of 90, Topup not processed")
    end
  end

  xdescribe '#deduct' do
    it 'deducts the fare from the balance' do
      subject.top_up(10)
      subject.deduct(2.40)
      expect(subject.balance).to eq(7.60)
    end
  end

  describe '#in_journey?' do
    it 'returns default value of not in_journey (false) after initialization' do
      expect(subject).not_to be_in_journey
    end
  end

  describe '#touch_in' do
    it 'changes in_journey status to true when touch_in' do
      subject.top_up(1)
      expect {subject.touch_in(station)}.to change(subject, :in_journey?).from(false).to(true)
    end
    it 'raises an error when there is insufficient funds (at least £1)' do
      expect {subject.touch_in(station)}.to raise_error("Insufficient funds :(")
    end
    it 'will store the entry station name after touch in' do
      subject.top_up(1)
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#touch_out' do
    before do
      subject.top_up(1)
      subject.touch_in(station)
    end

    it 'changes in_journey status to true when touch_out' do
      expect {subject.touch_out}.to change(subject, :in_journey?).from(true).to(false)
    end
    it 'deducts the amount by the minimum charge' do
      expect {subject.touch_out}.to change{ subject.balance }.by(-1)
    end
    it 'expects entry_station to be nil after touch out' do
      expect {subject.touch_out}.to change{ subject.entry_station }.from(station).to(nil)
    end
  end
  
end