require "rpio/bcm2835/version"

require 'rpio'
require 'ffi'

require "rpio/bcm2835/gpio"
require "rpio/bcm2835/pwm"
require "rpio/bcm2835/i2c"
require "rpio/bcm2835/spi"

require "rpio/bcm2835/driver"

module Rpio
  self.driver= Rpio::Bcm2835::Driver
end
