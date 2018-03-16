# Set principals configuration to SpreeDhlShippingLabeler
dhl_config = YAML.load_file("config/dhl_api_conection.yml")[Rails.env]

SpreeDhlShippingLabeler::DhlConection.config({
  userId:   dhl_config["userId"],
  key:      dhl_config["key"],
  account:  dhl_config["accountId"]
})


