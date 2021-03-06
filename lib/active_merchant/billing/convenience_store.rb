module ActiveMerchant
  module Billing
    class ConvenienceStore < Model
      module Code
        SEVEN_ELEVEN = 11
        FAMILY_MART  = 21
        LAWSON       = 31
        SEICO_MART   = 32
        MINI_STOP    = 33
        CIRCLE_K     = 35
        SUNKUS       = 36
      end

      def initialize(code:, full_name_kana:, phone_number:)
        @code           = code
        @full_name_kana = full_name_kana
        @phone_number   = phone_number
      end

      def code
        @code
      end

      def name
        @full_name_kana
      end

      def phone_number
        @phone_number
      end

      def validate
        errors_hash(validate_essential_attributes)
      end

      private

      def validate_essential_attributes
        errors = []

        if code.blank?
          errors << [:code, "is required"]
        elsif !valid_code?(code)
          errors << [:code, "is invalid"]
        end

        errors << [:full_name_kana, "is required"] if name.blank?
        errors << [:phone_number, "is required"] if phone_number.blank?
        errors << [:phone_number, "is not number"] if phone_number.present? && /\D+/.match(phone_number)

        errors
      end

      def valid_code?(code)
        [Code::SEVEN_ELEVEN, Code::FAMILY_MART, Code::LAWSON, Code::SEICO_MART, Code::MINI_STOP, Code::CIRCLE_K, Code::SUNKUS].include?(code.to_i)
      end
    end
  end
end
