Stripe.api_key = Rails.application.credentials.dig(:stripe, :secret_key)

# aws: access_key_id: 123 secret_access_key: 345

# # Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
# secret_key_base: 90a5f8cc81633777234499a5cc7b589cb80feaed6bd45180a78a899e1ff88967c187308e03603abd35d3fcd426682539a581d460edec6821deb479444988f7dd