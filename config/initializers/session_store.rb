# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_eminem_session',
  :secret      => '3f5e5a107a8de493b4fb91b2b9099ace4024dcaf3c73b250a6a03faa6196cb0d50180c4af28ab17a9cb18a6e884478dd09155e052c052769bb70f5b47b053386'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
