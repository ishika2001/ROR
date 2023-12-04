# Rails.configuration.stripe = {
#   :publishable_key => Rails.application.secrets.publishable_key,
#   :secret_key      => Rails.application.secrets.secret_key
# }

# Stripe.api_key = Rails.configuration.stripe[:secret_key]

Rails.configuration.stripe = {
  :publishable_key => "pk_test_51OI5jfSJkMldkug8QvH3aV04MNQ96BClKieVx9skHXraJMSQ7T72bRkVEF6R23ruXzBQ1u5ECr2xq6y9Sz7Vr2xE00wt4f387R",
  :secret_key      => "sk_test_51OI5jfSJkMldkug8hFkhF0CyFEUweIVIEu5UBk1mBRAXWdaJfOEiPExhkny5RLSFE1aFqeHzaPCTQQZWpjUYBsyq00ZEZarJrQ"
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]