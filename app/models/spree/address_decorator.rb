Spree::Address.class_eval do
    def dhl_formatted(email)
            {
              name:          full_name,
              firtsName:     firstname,
              lastName:      lastname,
              email:         email,
              company:       company,
              phone_number:  phone,
              street:        [address1, address2].compact.join(' '),
              city:          city,
              state:         state,
              postalCode:    zipcode,
              countryCode:   country.iso
            }
    end
end