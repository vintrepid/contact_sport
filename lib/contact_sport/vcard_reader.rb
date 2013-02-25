require 'vcard'
require 'contact_sport/contact'

module ContactSport

  class VcardReader
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def contacts
      begin
        @contacts ||= Vcard::Vcard.decode(contents).map do |card|
          Contact.new(
            first_name:    card.name.given,
            last_name:     card.name.family,
            name:          card.name.fullname,

            email:         email(card),
            url:           url(card),

            company:       company(card),
            office_phone:  work_phone(card),
            mobile_phone:  mobile_phone(card),
            fax:           fax(card),

            address1:      address_first_line(card),
            address2:      address_second_line(card),
            city:          address(:locality, card),
            region:        address(:region, card),
            postcode:      address(:postalcode, card),
            country:       address(:country, card)
          )
        end
      rescue Vcard::InvalidEncodingError, Vcard::UnsupportedError, Vcard::Unencodeable => e
        raise ContactSport::FormatError, e.message
      end
    end

    private

    def contents
      File.read file
    end

    def company(card)
      card.org ? card.org.first : EMPTY_FIELD
    end

    def address(field, card)
      card.address ? card.address.send(field) : EMPTY_FIELD
    end

    def address_first_line(card)
      if card.address && card.address.street
        card.address.street.split("\n").first
      else
        EMPTY_FIELD
      end
    end

    def address_second_line(card)
      if card.address && card.address.street
        card.address.street.split("\n")[1..-1].join "\n"
      else
        EMPTY_FIELD
      end
    end

    def email(card)
      card.email ? card.email.to_s : EMPTY_FIELD
    end

    def url(card)
      card.url ? card.url.uri.sub('http\\','http') : EMPTY_FIELD
    end

    def work_phone(card)
      tel = card.telephones.detect { |t| t.location.any? { |l| l =~ /work/i } } || card.telephone
      tel ? tel.to_s : EMPTY_FIELD
    end

    def mobile_phone(card)
      tel = card.telephones.detect { |t| t.location.any? { |l| l =~ /cell/i } }
      tel ? tel.to_s : EMPTY_FIELD
    end

    def fax(card)
      fax = card.telephones.detect { |t| t.capability.any? { |c| c =~ /fax/i } }
      fax ? fax.to_s : EMPTY_FIELD
    end

  end

end
