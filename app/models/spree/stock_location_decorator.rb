Spree::StockLocation.class_eval do
  def dhl_formatted
    {
      firstName:     name,
      lastName:      Spree.t(:company_lastname),
      companyName:   admin_name,
      countryCode:   country.iso,
      postalCode:    zipcode,
      city:          city,
      street:        [address1, address2, state].compact.join(' '),
      email:         Spree::Store.first.mail_from_address || '',
      phoneNumber:   phone,
      vatNumber:     Spree.t(:company_cif)
    }
  end                                       
end