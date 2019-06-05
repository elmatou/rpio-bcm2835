module Rpio
  module Bcm2835
    class Driver < Rpio::Driver

    def initialize(dev = false)
      bcm2835_set_debug(1) if dev
      @triggered_pins = Set.new
      bcm2835_init
    end

    def close
      gpio_clear_trigger_all
      bcm2835_close == 1 && @triggered_pins.empty?
    end

    extend FFI::Library

    ffi_lib File.join(File.dirname(__FILE__), 'libbcm2835.so')

    attach_function :bcm2835_set_debug, :bcm2835_set_debug, [:uint8], :void
    attach_function :bcm2835_init, :bcm2835_init, [], :uint8
    attach_function :bcm2835_close, :bcm2835_close, [], :uint8

    include Rpio::Bcm2835::Gpio
    include Rpio::Bcm2835::PWM
    include Rpio::Bcm2835::I2C
    include Rpio::Bcm2835::SPI

    end
  end
end
