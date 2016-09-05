# Load the rails application
require File.expand_path('../application', __FILE__)

ENV['SSL_CERT_FILE'] = 'C:/cacert.pem'
# Initialize the rails application
Blog::Application.initialize!
