class Twofish
  module Mode

    ECB = :ecb
    RCBC = :rcbc
    ALL = [RCBC, ECB]

    DEFAULT = ECB

    def self.validate(mode)
      check_mode = mode.nil? ? DEFAULT : mode.to_s.downcase.to_sym
      raise ArgumentError, "Неизвестный формат #{mode.inspect}" unless ALL.include? check_mode
      check_mode
    end

  end

end
