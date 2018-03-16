Spree::Address.class_eval do
    def dhl_formatted(email)
            {
              name:          full_name,
              email:         email,
              company:       company,
              phone_number:  phone,
              address:       [address1, address2].compact.join(' '),
              city:          city,
              state:         state,
              zip_code:      zipcode,
              country_iso:   country.iso
            }
    end
end