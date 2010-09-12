# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_autoshka_session',
  :secret      => 'de5578f58a51aa8214fa041c7196ee6d18ed06a85079622e441b57b9f71faa27156f5149c65e03a6b912318c66e902e24410c86781636eef997122bff4fb1880'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
