RSpec.describe Rpio::Bcm2835::Driver do

  it 'inherits from Rpio::Driver' do
    expect(Rpio::Bcm2835::Driver).to be < Rpio::Driver
  end

  subject { Rpio::Bcm2835::Driver.new(true) }

  context 'init & close' do
    it '#new method exist' do
      expect(Rpio::Bcm2835::Driver).to respond_to(:new).with(0).argument
    end
    it '#new' do
      expect { Rpio::Bcm2835.new }.not_to raise_error
      expect(Rpio::Bcm2835.new).to be_an_instance_of Rpio::Bcm2835
      # bcm2835_init
    end

    it '#close method exist' do
      is_expected.to respond_to(:close).with(0).argument
    end

    it 'should remove triggers and close the lib on close' do
      expect(subject).to receive(:pin_clear_trigger_all)
      expect(subject).to receive(:bcm2835_close)
      subject.close
    end
  end

end
