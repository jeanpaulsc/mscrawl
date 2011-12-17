# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_mscrawl_session',
  :secret      => 'daded1341c4d70be0779e5baf8a1852ad9aa0848d6de32f64033f1d8fcd3462a0e5b2825f865f4ea24cbc75da28826ee0c9fc0318024b53aecaae49ef54d485e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
