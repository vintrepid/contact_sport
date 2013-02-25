require 'minitest/autorun'
require 'test_helper'
require 'contact_sport'

class OutlookReaderTest < MiniTest::Unit::TestCase

  def test_iso_8859_1_commas
    contacts = ContactSport.contacts fixture('iso_8859_1_commas.csv')
    assert_equal 3, contacts.length
    
    contact = contacts.shift
    assert_equal 'Bruce',               contact.first_name
    assert_equal 'Wayne',               contact.last_name
    assert_equal 'Bruce Wayne',         contact.name
    assert_equal 'b.wayne@example.com', contact.email
    assert_equal 'http://example.com',  contact.url
    assert_equal '020 7123 4567',       contact.office_phone
    assert_equal '07979 797 979',       contact.mobile_phone
    assert_equal '020 7123 4560',       contact.fax
    assert_equal 'Wayne Enterprises',   contact.company
    assert_equal '1st Floor',           contact.address1
    assert_equal '1 High Street',       contact.address2
    assert_equal 'London',              contact.city
    assert_equal 'Middlesex',           contact.region
    assert_equal 'W1 1AB',              contact.postcode
    assert_equal 'United Kingdom',      contact.country
    
    contact = contacts.shift
    assert_equal 'James Bond',  contact.name
    
    contact = contacts.shift
    assert_equal 'Clarke Kent',  contact.name
  end

  def test_utf_16_le_tabs
    contacts = ContactSport.contacts fixture('utf_16_le_tabs.csv')
    assert_equal 6, contacts.length
    
    contact = contacts.shift
    assert_equal 'Andrew',                contact.first_name
    assert_equal 'Stewart',               contact.last_name
    assert_equal 'Andrew Stewart',        contact.name
    assert_equal 'andrew@home.de',        contact.email
    assert_equal 'http://www.mcdonalds.com/staff/Andrew', contact.url
    assert_equal '4420812345',            contact.office_phone
    assert_equal '49123456789',           contact.mobile_phone
    assert_equal '',                      contact.fax
    assert_equal 'McDonalds Corporation', contact.company
    assert_equal '1 Leicester Square',    contact.address1
    assert_equal '',                      contact.address2
    assert_equal 'London',                contact.city
    assert_equal '',                      contact.region
    assert_equal 'WC1A 1AA',              contact.postcode
    assert_equal '',                      contact.country

    contact = contacts.pop
    assert_equal '',                      contact.first_name
    assert_equal '',                      contact.last_name
    assert_equal '',                      contact.name
    assert_equal 'info@mcdonalds.com',    contact.email
    assert_equal 'http://www.mcdonalds.com', contact.url
    assert_equal '',                      contact.office_phone
    assert_equal '',                      contact.mobile_phone
    assert_equal '800234567',             contact.fax
    assert_equal 'McDonalds Corporation', contact.company
    assert_equal '1 Canary Wharf',        contact.address1
    assert_equal '',                      contact.address2
    assert_equal 'London',                contact.city
    assert_equal 'E1 1AA',                contact.region    # data-entry mistake
    assert_equal '',                      contact.postcode  # data-entry mistake
    assert_equal '',                      contact.country
  end

end
