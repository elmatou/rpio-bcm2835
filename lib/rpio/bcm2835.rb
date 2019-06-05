require "rpio/bcm2835/version"

require "rpio"
require "ffi"

module Rpio::Bcm2835::FFI
  extend FFI::Library
  ffi_lib File.join(File.dirname(__FILE__), 'bcm2835/libbcm2835.so')
end

require "rpio/bcm2835/gpio"
require "rpio/bcm2835/pwm"
require "rpio/bcm2835/i2c"
require "rpio/bcm2835/spi"
require "rpio/bcm2835/driver"

module Rpio
  self.driver= Rpio::Bcm2835::Driver

  module Bcm2835
    module FFI
      extend FFI::Library
      ffi_lib File.join(File.dirname(__FILE__), 'libbcm2835.so')
    end
  end
end
