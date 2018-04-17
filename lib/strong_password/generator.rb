require 'byebug'

module StrongPassword
  class Generator
    UPPER_CASE_CHARS = ('A'..'Z').to_a
    LOWER_CASE_CHARS = ('a'..'z').to_a
    NUMERIC = ('0'..'9').to_a
    SPECIAL_CHARS = "-_.,;+!*()[]{}|~^<>\"'$=#%/:@&?".split(//)

    DEFAULT_LENGTH = 8

    attr_reader :mixed_case, :numeric, :special_char, :total_chars,
                :pwd_string, :required_chars

    def initialize(mixed_case: 1, numeric: 1, special_char: 1, total_chars: DEFAULT_LENGTH)
      @mixed_case = mixed_case
      @numeric = numeric
      @special_char = special_char
      @total_chars = total_chars
      @pwd_string = ''
    end

    def executed
      raise 'Invalid password combination: insufficient password length' if total_chars < (mixed_case + numeric + special_char)
      while current_chars_count < total_chars do
        char_type = weighted_rand(weights_table)
        @pwd_string << chars_map[char_type].sample
        if [:mixed_case, :numeric, :special_char].include? char_type
          instance_variable_set("@#{char_type.to_s}", send("#{char_type.to_s}") - 1)
        end
      end
      @pwd_string
    end

    private

    def all_chars
      return @chars_array if @chars_array

      @chars_array = LOWER_CASE_CHARS
      @chars_array |= UPPER_CASE_CHARS if mixed_case.positive?
      @chars_array |= NUMERIC if numeric.positive?
      @chars_array |= SPECIAL_CHARS if special_char.positive?
      @chars_array
    end

    def chars_map
      @map ||= {
        all_chars: all_chars,
        mixed_case: UPPER_CASE_CHARS,
        numeric: NUMERIC,
        special_char: SPECIAL_CHARS
      }
    end

    def weights_table
      hash = {
        all_chars: all_chars_weight,
        mixed_case: weight_for(:mixed_case),
        numeric: weight_for(:numeric),
        special_char: weight_for(:special_char)
      }
      hash.reject! { |_k, v| v == 0 }
      hash
    end

    def all_chars_weight
      1 - weight_for(:mixed_case) - weight_for(:special_char) - weight_for(:numeric)
    end

    def remaining_chars_count
      total_chars - current_chars_count
    end

    def weight_for(char_type)
      return 0 unless send(char_type).positive?
      (send(char_type).to_f / remaining_chars_count).round(5)
    end

    def weighted_rand(weights = {})
      raise 'Probabilities must sum up to 1' unless weights.values.inject(&:+) == 1.0

      u = 0.0
      ranges = Hash[weights.map{ |v, p| [u += p, v] }]

      u = rand
      ranges.find{ |p, _| p > u }.last
    end

    def current_chars_count
      pwd_string.size
    end
  end
end
