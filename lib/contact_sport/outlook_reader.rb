require 'csv'
require 'contact_sport/contact'
require 'contact_sport/encoding'

module ContactSport

  # To read an Outlook "Comma Separated Values (Windows)" file we need to guess:
  #
  # * the file's encoding
  # * the column separator
  # * the column headings
  #
  # These all vary by Outlook version, platform, and phase of the moon.
  #
  # Some example contact headings are given here:
  #
  # * http://stackoverflow.com/questions/4847596/what-are-the-csv-headers-in-outlook-contact-export
  # * http://lists.lrug.org/pipermail/chat-lrug.org/2013-February/008474.html
  class OutlookReader
    attr_reader :file, :file_encoding, :column_separator

    def initialize(file)
      @file = file
      @file_encoding = ContactSport::Encoding.guess_encoding file
      @column_separator = guess_column_separator
    end

    def contacts
      begin
        @contacts ||= begin
          results = []
          CSV.foreach(file, headers: true,
                            col_sep: column_separator,
                            encoding: "#{file_encoding.to_s}:UTF-8") do |row|
            # Headers:
            results << Contact.new(
              first_name:    first_name(row),
              last_name:     last_name(row),
              name:          name(row),

              email:         email(row),
              url:           web_page(row),

              company:       company(row),
              office_phone:  office_phone(row),
              mobile_phone:  mobile_phone(row),
              fax:           fax(row),

              address1:      street(row),
              address2:      street2(row),
              city:          city(row),
              region:        state(row),
              postcode:      postcode(row),
              country:       country(row)
            )
          end
          results
        end
      rescue EncodingError => e
        raise ContactSport::EncodingError, e.message
      rescue StandardError => e
        raise ContactSport::FormatError, e.message
      end
    end

    private

    def guess_column_separator
      first_line  = File.open file, encoding: "#{file_encoding.to_s}:UTF-8", &:readline
      comma_count = first_line.count ','
      tab_count   = first_line.count '\t'
      comma_count > tab_count ? ',' : "\t"
    end

    def find_first(row, *fields)
      fields.each do |field|
        if result = row[field]
          return result
        end
      end
      EMPTY_FIELD
    end

    def first_name(row)
      find_first row, 'First Name'
    end

    def last_name(row)
      find_first row, 'Last Name'
    end

    def street(row)
      find_first row, 'Business Street', 'Home Street', 'Work Street Address', 'Home Street Address'
    end

    def street2(row)
      find_first row, 'Business Street 2', 'Home Street 2', 'Work Street Address 2', 'Home Street Address 2'
    end

    def city(row)
      find_first row, 'Business City', 'Home City', 'Work City'
    end

    def state(row)
      find_first row, 'Business State', 'Home State', 'Work State'
    end

    def postcode(row)
      find_first row, 'Business Postal Code', 'Home Postal Code', 'Work Zip', 'Home Zip'
    end

    def country(row)
      find_first row, 'Business Country', 'Home Country', 'Business Country/Region', 'Work Country/Region', 'Home Country/Region'
    end

    def fax(row)
      find_first row, 'Business Fax', 'Work Fax', 'Home Fax'
    end

    def web_page(row)
      find_first row, 'Web Page'
    end

    def email(row)
      find_first row, 'E-mail Address', 'Email Address 1'
    end

    def office_phone(row)
      find_first row, 'Work Phone 1', 'Home Phone 1', 'Business Phone', 'Home Phone'
    end

    def mobile_phone(row)
      find_first row, 'Mobile Phone'
    end

    def company(row)
      find_first row, 'Company'
    end

    def name(row)
      [ row['First Name'], row['Last Name'] ].compact.join(' ') || EMPTY_FIELD
    end
  end

end
