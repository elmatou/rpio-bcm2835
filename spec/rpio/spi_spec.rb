RSpec.describe Rpio::Bcm2835::SPI do

  subject { Rpio::Bcm2835::Driver.new(true) }

  it '#spi_set_data_mode(mode)' do
    is_expected.to respond_to(:spi_set_data_mode).with(1).argument
  end

  it '#spi_begin' do
    is_expected.to respond_to(:spi_begin).with(0).argument
  end

  it '#spi_end' do
    is_expected.to respond_to(:spi_end).with(0).argument
  end

  it '#spidev_out(array)' do
    is_expected.to respond_to(:spidev_out).with(1).argument
  end

  it '#spi_clock(clock_divider)' do
    is_expected.to respond_to(:spi_clock).with(1).argument
  end

  it '#spi_bit_order(order)' do
    is_expected.to respond_to(:spi_bit_order).with(1).argument
  end

  it '#spi_chip_select(cs)' do
    is_expected.to respond_to(:spi_chip_select).with(1).argument
  end

  it '#spi_chip_select_polarity(cs, active)' do
    is_expected.to respond_to(:spi_chip_select_polarity).with(2).arguments
  end

  it '#spi_transfer(byte)' do
    is_expected.to respond_to(:spi_transfer).with(1).argument
  end

  it '#spi_transfer_bytes(data)' do
    is_expected.to respond_to(:spi_transfer_bytes).with(1).arguments
  end

end
