# ContactSport

Simple importing of contacts from Outlook and vCard.

`ContactSport` provides a simple way to read contacts exported from Outlook or vCard files.  It came about because I needed to enable users of a webapp to import contacts from their existing desktop address books and email clients.

Outlook contacts should be exported as [Comma Separated Values (Windows)][outlook].

vCards can be exported from most other address books or email clients.  Here are [instructions for Apple's Address Book][osx].


## Usage

There is precisely one method in the API:

Assuming `contacts_file` is the name and path of your contacts file:

```ruby
ContactSport.contacts(contacts_file)
```

This returns an array of contacts, where a contact is an object responding to:

```ruby
:first_name
:last_name
:name
:email
:url
:office_phone
:mobile_phone
:fax
:company
:address1
:address2
:city
:region
:postcode
:country
```

All responses are strings.  If a value is not set (e.g. a contact has no fax number) an empty string is returned.

Where there are work and home values, e.g. a work phone and a home phone, `ContactSport` will prefer the work phone.


## Installation

    $ gem install contact_sport

The code requires Ruby 1.9.


## Intellectual Property

Copyright [Andrew Stewart][boss], AirBlade Software Ltd.

Released under the MIT licence.


  [outlook]: http://office.microsoft.com/en-us/outlook-help/export-contacts-HA101870639.aspx
  [osx]: http://support.apple.com/kb/PH4655
  [contact_csv]: https://github.com/mwhuss/contact_csv
  [contactgems]: https://rubygems.org/search?query=contact
  [boss]: mailto:boss@airbladesoftware.com
