module Rpio
  module Bcm2835
    module PWM
      extend Rpio::Bcm2835::FFI

      GPIO_FSEL_ALT0 = 0b100
      GPIO_FSEL_ALT1 = 0b101
      GPIO_FSEL_ALT2 = 0b110
      GPIO_FSEL_ALT3 = 0b111
      GPIO_FSEL_ALT4 = 0b011
      GPIO_FSEL_ALT5 = 0b010
      GPIO_FSEL_MASK = 0b111

      PWM_PIN = {
          12 => {:channel => 0, :alt_fun => GPIO_FSEL_ALT0},
          13 => {:channel => 1, :alt_fun => GPIO_FSEL_ALT0},
          18 => {:channel => 0, :alt_fun => GPIO_FSEL_ALT5},
          19 => {:channel => 1, :alt_fun => GPIO_FSEL_ALT5},
          40 => {:channel => 0, :alt_fun => GPIO_FSEL_ALT0},
          41 => {:channel => 1, :alt_fun => GPIO_FSEL_ALT0},
          45 => {:channel => 1, :alt_fun => GPIO_FSEL_ALT0},
          52 => {:channel => 0, :alt_fun => GPIO_FSEL_ALT1},
          53 => {:channel => 1, :alt_fun => GPIO_FSEL_ALT1}
      }

      PWM_MODE = [:balanced, :markspace]

      def self.included(mod)
        attach_function :bcm2835_pwm_set_clock,  :bcm2835_pwm_set_clock,  [:uint32], :void
        attach_function :bcm2835_pwm_set_mode,   :bcm2835_pwm_set_mode,   [:uint8, :uint8, :uint8], :void
        attach_function :bcm2835_pwm_set_range,  :bcm2835_pwm_set_range,  [:uint8, :uint32], :void
        attach_function :bcm2835_pwm_set_data,   :bcm2835_pwm_set_data,   [:uint8, :uint32], :void
      end

      def pwm_set_pin(pin)
        raise ArgumentError, "pin should be one of #{PWM_PIN.keys}" unless PWM_PIN[pin]
        gpio_select_function(pin, PWM_PIN[pin][:alt_fun])
      end

  # TODO: update Rpio::Pwm to set the clock and the driver should handle the clock_divider
      def pwm_set_clock(clock_divider)
        # (19.2.megahertz.to_f / clock).to_i
        bcm2835_pwm_set_clock(clock_divider)
      end

      def pwm_set_mode(pin, mode, start = 1)
        raise ArgumentError, "mode should be one of #{PWM_MODE}" unless PWM_MODE.include? mode
        bcm2835_pwm_set_mode(PWM_PIN[pin][:channel], PWM_MODE.index(mode), start)
      end

      def pwm_set_range(pin, range)
        bcm2835_pwm_set_range(PWM_PIN[pin][:channel], range)
      end

      def pwm_set_data(pin, data)
        bcm2835_pwm_set_data(PWM_PIN[pin][:channel], data)
      end

    end
  end
end
