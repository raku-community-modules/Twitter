unit role Twitter::API::AccountSettings;

method account-settings {
    # Returns settings (including current trend, geo and sleep time information) for the authenticating user.
    self!ua.request: 'GET', 'account/settings', %();
}
