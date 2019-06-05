module Rpio
  module Bcm2835
    module Gpio
      GPIO_FSEL_INPT = 0b000
      GPIO_FSEL_OUTP = 0b001

      GPIO_PUD_OFF = 0
      GPIO_PUD_DOWN = 1
      GPIO_PUD_UP = 2

      GPIO_HIGH = 1
      GPIO_LOW  = 0

      def self.included(mod)
        # Sets the Function Select register for the given pin, which configures the pin as Input, Output or one of the 6 alternate functions.
        attach_function :gpio_select_function, :bcm2835_gpio_fsel,    [:uint8, :uint8], :void
        attach_function :gpio_set,             :bcm2835_gpio_set,     [:uint8], :void
        attach_function :gpio_clear,           :bcm2835_gpio_clr,     [:uint8], :void
        attach_function :gpio_level,           :bcm2835_gpio_lev,     [:uint8], :uint8
        attach_function :gpio_set_pud,         :bcm2835_gpio_set_pud, [:uint8, :uint8], :void

        # Sets the Function Event register for the given pin.
        attach_function :gpio_event_low,       :bcm2835_gpio_len,    [:uint8], :void
        attach_function :gpio_event_high,      :bcm2835_gpio_hen,    [:uint8], :void
        attach_function :gpio_event_rising,    :bcm2835_gpio_ren,    [:uint8], :void
        attach_function :gpio_event_falling,   :bcm2835_gpio_fen,    [:uint8], :void
        # attach_function :gpio_event_async_rising,   :bcm2835_gpio_aren,    [:uint8], :void
        # attach_function :gpio_event_async_falling,  :bcm2835_gpio_afen,    [:uint8], :void

        attach_function :gpio_event_status,    :bcm2835_gpio_eds,    [:uint8], :uint8
        attach_function :gpio_event_set_status,:bcm2835_gpio_set_eds,[:uint8], :void

        attach_function :gpio_event_clear_low,          :bcm2835_gpio_clr_len, [:uint8], :void
        attach_function :gpio_event_clear_high,         :bcm2835_gpio_clr_hen, [:uint8], :void
        attach_function :gpio_event_clear_rising,       :bcm2835_gpio_clr_ren, [:uint8], :void
        attach_function :gpio_event_clear_falling,      :bcm2835_gpio_clr_fen, [:uint8], :void

        # attach_function :gpio_event_clear_async_rising, :bcm2835_gpio_clr_aren, [:uint8], :void
        # attach_function :gpio_event_clear_async_falling,:bcm2835_gpio_clr_afen, [:uint8], :void
      end

      def gpio_direction(pin, direction)
        value = case direction
        when :in then GPIO_FSEL_INPT
        when :out then GPIO_FSEL_OUTP
        else raise ArgumentError, 'direction should be :in or :out'
        end

        gpio_select_function(pin, value)
      end

      def gpio_read(pin)
        gpio_level(pin)# == PinValues::GPIO_HIGH
      end

      def gpio_write(pin, value)
        case value
          when GPIO_LOW then gpio_clear(pin)
          when GPIO_HIGH then gpio_set(pin)
          else raise ArgumentError, 'value should be GPIO_LOW (0) or GPIO_HIGH (1)'
        end
        value
      end

      def gpio_set_pud(pin, value)
        case value
        when :up   then super(pin, GPIO_PUD_UP)
          when :down then super(pin, GPIO_PUD_DOWN)
          when :off, :float then super(pin, GPIO_PUD_OFF)
          else raise ArgumentError, 'pull should be :up, :down, :float or :off'
        end
      end

      def gpio_set_trigger(pin, trigger)
        gpio_clear_trigger(pin)

        case trigger
          when :rising  then gpio_event_rising(pin)
          when :falling then gpio_event_falling(pin)
          when :high    then gpio_event_high(pin)
          when :low     then gpio_event_low(pin)

          when :both
            gpio_event_rising(pin)
            gpio_event_falling(pin)
          when :none    then return nil
          else raise ArgumentError, 'trigger should be :none, :rising, :falling, :both, :high or :low'
        end

        @triggered_pins.add pin
      end

      def gpio_wait_for(pin)
        loop do
          if gpio_event_status(pin) == GPIO_HIGH
            gpio_event_set_status(pin)
            break
          end
          sleep 0.1
        end
      end

      def gpio_clear_trigger(pin)
        gpio_event_rising(pin)
        gpio_event_falling(pin)
        gpio_event_high(pin)
        gpio_event_low(pin)
        # gpio_event_clear_async_falling(pin)
        # gpio_event_clear_async_rising(pin)

        @triggered_pins.delete pin
      end

      def gpio_clear_trigger_all
        @triggered_pins.dup.each { |pin| gpio_clear_trigger(pin) }
      end

    end
  end
end
