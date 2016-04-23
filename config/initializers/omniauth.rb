Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, "871840776271547", "82e3b9bacccdf00e114a6ff1acc67a9d", :info_fields => 'name, email'
  provider :google_oauth2, '612487703388-dqh9cbeafb2tvt9itfu1b4vtisq91vhm.apps.googleusercontent.com', 'hJ_Cb9u3Y-oYBjb4Z7tx50lx',{client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end