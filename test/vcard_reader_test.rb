require 'minitest/autorun'
require 'test_helper'
require 'contact_sport'

class VcardReaderTest < MiniTest::Unit::TestCase

  def test_foo
    contacts = ContactSport.contacts fixture('vcards.vcf')
    assert_equal 2, contacts.length

    contact = contacts.shift
    assert_equal '', contact.first_name
    assert_equal '', contact.last_name
    assert_equal 'Wayne Enterprises',         contact.name
    assert_equal 'info@wayneenterprises.com', contact.email
    assert_equal '', contact.url
    assert_equal '', contact.office_phone
    assert_equal '', contact.mobile_phone
    assert_equal '', contact.fax
    assert_equal 'Wayne Enterprises',         contact.company
    assert_equal '', contact.address1
    assert_equal '', contact.address2
    assert_equal '', contact.city
    assert_equal '', contact.region
    assert_equal '', contact.postcode
    assert_equal '', contact.country

    contact = contacts.shift
    assert_equal 'Bruce',                      contact.first_name
    assert_equal 'Wayne',                      contact.last_name
    assert_equal 'Bruce Wayne',                contact.name
    assert_equal 'bruce@wayneenterprises.com', contact.email
    assert_equal 'www.batman.com',             contact.url
    assert_equal '+44 20 7123 4567',           contact.office_phone
    assert_equal '07777 999 888',              contact.mobile_phone
    assert_equal '+44 20 71234 4560',          contact.fax
    assert_equal 'Wayne Enterprises',          contact.company
    assert_equal 'The Batcave',                contact.address1
    assert_equal '',                           contact.address2
    assert_equal 'Gotham',                     contact.city
    assert_equal 'NY',                         contact.region
    assert_equal '90210',                      contact.postcode
    assert_equal 'USA',                        contact.country
  end
end
