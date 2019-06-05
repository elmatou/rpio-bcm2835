RSpec.describe Rpio::Bcm2835::PWM do

  subject { Rpio::Bcm2835::Driver.new(true) }

  it '#pwn_set_pin(pin)' do
    is_expected.to respond_to(:pwm_set_pin).with(1).argument

    expect(subject).to receive(:gpio_select_function).with(12, 0b100)
    subject.pwm_set_pin(12)

    expect { subject.pwm_set_pin(11) }.to raise_error ArgumentError, 'pin should be one of [12, 13, 18, 19, 40, 41, 45, 52, 53]'
  end

  it'#pwm_set_clock(clock_value)' do
    is_expected.to respond_to(:pwm_set_clock).with(1).argument

    expect(subject).to receive(:bcm2835_pwm_set_clock).with(1)
    subject.pwm_set_clock(1)
  end

  describe '#pwm_set_mode(pin, mode, start = 1)' do
    it '#pwm_set_mode(channel, mode, start = 1)' do
      is_expected.to respond_to(:pwm_set_mode).with(3).arguments
      is_expected.to respond_to(:pwm_set_mode).with(2).arguments
    end

    it 'should set to :balanced' do
      expect(subject).to receive(:bcm2835_pwm_set_mode).with(1, 0, 1)
      subject.pwm_set_mode(53, :balanced)
    end

    it 'should set to :markspace' do
      expect(subject).to receive(:bcm2835_pwm_set_mode).with(1, 1, 1)
      subject.pwm_set_mode(53, :markspace)
    end

    it 'should raise error' do
      expect { subject.pwm_set_mode(4, :balancedmarkspace) }.to raise_error ArgumentError, 'mode should be one of [:balanced, :markspace]'
    end

    it 'should start the signal'
    it 'should stop the signal'
  end

  it '#pwm_set_range(pin, range)' do
    is_expected.to respond_to(:pwm_set_range).with(2).arguments

    expect(subject).to receive(:bcm2835_pwm_set_range).with(1, 100)
    subject.pwm_set_range(53, 100)
  end

  it '#pwm_set_data(pin, data)' do
    is_expected.to respond_to(:pwm_set_data).with(2).arguments

    expect(subject).to receive(:bcm2835_pwm_set_data).with(1, 100)
    subject.pwm_set_data(53, 100)
  end
end
