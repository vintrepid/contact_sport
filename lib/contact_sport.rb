require "contact_sport/version"
require 'contact_sport/vcard_reader'
require 'contact_sport/outlook_reader'

module ContactSport

  # Raised when a contacts file doesn't appear to be Outlook CSV or vCard.
  UnknownProviderError = Class.new RuntimeError

  # Raised when a contacts file cannot be parsed.
  FormatError = Class.new RuntimeError

  # Raised when a contacts file is in an unknown encoding.
  EncodingError = Class.new RuntimeError

  EMPTY_FIELD = ''
  
  def self.contacts(file)
    reader(file).contacts
  end

  private

  def self.reader(file)
    case File.extname(file)
    when /[.]vcf$/i; VcardReader.new(file)
    when /[.]csv$/i; OutlookReader.new(file)
    else raise UnknownProviderError
    end
  end

end
