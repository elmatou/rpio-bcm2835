RSpec.describe Rpio::Bcm2835::I2C do

  subject { Rpio::Bcm2835::Driver.new(true) }

  it '#i2c_begin' do
    is_expected.to respond_to(:i2c_begin).with(0).argument
  end

  it '#i2c_end' do
    is_expected.to respond_to(:i2c_end).with(0).argument
  end

  it '#i2c_allowed_clocks' do
    is_expected.to respond_to(:i2c_allowed_clocks).with(0).argument
  end

  it '#i2c_set_clock_divider(divider)' do
    is_expected.to respond_to(:i2c_set_clock_divider).with(1).argument
  end

  it '#i2c_set_clock(clock)' do
    is_expected.to respond_to(:i2c_set_clock).with(1).argument
  end

  it '#i2c_set_address(address)' do
    is_expected.to respond_to(:i2c_set_address).with(1).argument
  end

  it '#i2c_transfer_bytes(data)' do
    is_expected.to respond_to(:i2c_transfer_bytes).with(1).argument
  end

  it '#i2c_read_bytes(bytes)' do
    is_expected.to respond_to(:i2c_read_bytes).with(1).argument
  end

  it '#i2c_write(data_out, bytes)' do
    is_expected.to respond_to(:i2c_write).with(2).arguments
  end

  it '#i2c_read(data_in, bytes)' do
    is_expected.to respond_to(:i2c_read).with(2).arguments
  end
end
