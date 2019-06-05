RSpec.describe Rpio::Bcm2835::Gpio do

  subject { Rpio::Bcm2835::Driver.new(true) }

  describe '#gpio_direction(pin, direction)' do
    it '#gpio_direction(pin, direction)' do
      is_expected.to respond_to(:gpio_direction).with(2).arguments
    end

    it 'should set to :in' do
      expect(subject).to receive(:gpio_select_function).with(4, 0b000)
      subject.gpio_direction(4, :in)
    end

    it 'should set to :out' do
      expect(subject).to receive(:gpio_select_function).with(4, 0b001)
      subject.gpio_direction(4, :out)
    end

    it 'should raise error' do
      expect { subject.gpio_direction(4, :inout) }.to raise_error ArgumentError, "direction should be :in or :out"
    end
  end


  it '#gpio_write(pin, value)' do
    is_expected.to respond_to(:gpio_write).with(2).arguments

    expect(subject).to receive(:gpio_set).with(4)
    subject.gpio_write(4, 1)

    expect(subject).to receive(:gpio_clear).with(5)
    subject.gpio_write(5, 0)

    expect { subject.gpio_write(4, 2) }.to raise_error ArgumentError, 'value should be GPIO_LOW (0) or GPIO_HIGH (1)'
  end


  it '#gpio_read(pin)' do
    is_expected.to respond_to(:gpio_read).with(1).argument
    expect(subject).to receive(:gpio_level).with(4)
    subject.gpio_read(4)
  end

  describe '#gpio_set_pud(pin, value)' do
    it '#gpio_set_pud(pin, value)' do
      is_expected.to respond_to(:gpio_set_pud).with(2).arguments
    end

    it 'should set to :off or :float' do
      expect(subject).to receive(:gpio_set_pud).twice.with(4, 0)
      subject.gpio_set_pud(4, :off)
      subject.gpio_set_pud(4, :float)
    end

    it 'should set to :down' do
      expect(subject).to receive(:gpio_set_pud).with(4, 1)
      subject.gpio_set_pud(4, :down)
    end

    it 'should set to :up' do
      expect(subject).to receive(:gpio_set_pud).with(4, 2)
      subject.gpio_set_pud(4, :up)
    end

    it 'should raise error' do
      expect { subject.gpio_set_pud(4, :updown) }.to raise_error ArgumentError, 'pull should be :up, :down, :float or :off'
    end
  end

  describe '#gpio_set_trigger(pin, trigger)' do
    it '#gpio_set_trigger(pin, trigger)' do
      is_expected.to respond_to(:gpio_set_trigger).with(2).arguments
    end

    it 'should set to :low' do
      expect(subject).to receive(:gpio_event_low).with(4)
      expect(subject).to receive(:gpio_clear_trigger).with(4)
      subject.gpio_set_trigger(4, :low)
      expect(subject.instance_variable_get('@triggered_pins')).to include(4)
    end

    it 'should set to :high' do
      expect(subject).to receive(:gpio_clear_trigger).with(5)
      expect(subject).to receive(:gpio_event_high).with(5)
      subject.gpio_set_trigger(5, :high)
      expect(subject.instance_variable_get('@triggered_pins')).to include(5)
    end

    it 'should set to :rising' do
      expect(subject).to receive(:gpio_clear_trigger).with(6)
      expect(subject).to receive(:gpio_event_rising).with(6)
      subject.gpio_set_trigger(6, :rising)
      expect(subject.instance_variable_get('@triggered_pins')).to include(6)
    end

    it 'should set to :falling' do
      expect(subject).to receive(:gpio_clear_trigger).with(7)
      expect(subject).to receive(:gpio_event_falling).with(7)
      subject.gpio_set_trigger(7, :falling)
      expect(subject.instance_variable_get('@triggered_pins')).to include(7)
    end

    it 'should set to :both' do
      expect(subject).to receive(:gpio_clear_trigger).with(8)
      expect(subject).to receive(:gpio_event_rising).with(8)
      expect(subject).to receive(:gpio_event_falling).with(8)
      subject.gpio_set_trigger(8, :both)
      expect(subject.instance_variable_get('@triggered_pins')).to include(8)
    end

    it 'should set to :none' do
      expect(subject).to receive(:gpio_clear_trigger).with(4)
      subject.gpio_set_trigger(4, :none)
      expect(subject.instance_variable_get('@triggered_pins')).not_to include(4)
    end

    it 'should raise error' do
      expect { subject.gpio_set_trigger(4, :risingfalling) }.to raise_error ArgumentError, 'trigger should be :none, :rising, :falling, :both, :high or :low'
    end
  end

  it '#gpio_wait_for(pin)' do
    is_expected.to respond_to(:gpio_wait_for).with(1).arguments
  end




















end
