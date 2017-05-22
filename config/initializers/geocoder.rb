Geocoder::Configuration.timeout = 30
Geocoder.configure(
  # geocoding service
  lookup: :google,

  # geocoding service request timeout (in seconds)
  timeout: 15,

  # default units
  units: :km
)
