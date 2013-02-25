module ContactSport
  module Encoding
    
    # https://github.com/Manfred/Ensure-encoding/blob/master/lib/ensure/encoding.rb
    # https://github.com/oleander/rchardet/blob/master/lib/rchardet/universaldetector.rb
    BYTE_ORDER_MARKS = {
      ::Encoding::UTF_32BE => [0x00, 0x00, 0xfe, 0xff],
      ::Encoding::UTF_32LE => [0xff, 0xfe, 0x00, 0x00],
      ::Encoding::UTF_8    => [0xef, 0xbb, 0xbf],
      ::Encoding::UTF_16BE => [0xfe, 0xff],
      ::Encoding::UTF_16LE => [0xff, 0xfe],
    }

    FALLBACK_ENCODING = ::Encoding::ISO_8859_1

    # Guesses the encoding of the given file.
    def self.guess_encoding(file)
      # First look for a byte order mark (BOM).
      first_bytes = IO.read(file, 4).bytes.to_a
      bom = BYTE_ORDER_MARKS.detect { |encoding, bytes| first_bytes[0...bytes.length] == bytes }
      bom ? bom.first : FALLBACK_ENCODING
    end

  end
end
