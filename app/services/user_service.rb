class UserService

  # Returns the name of the user. First the cache is searched through.
  # If there's no match, a query to the Graph API is made.
  # If all of the above fails, the user is assigned a name "No name"
  def self.get_name(facebook_id)
    cached_name = NAMES.get(facebook_id)

    if cached_name.nil?
      user_profile = Messenger::Client.get_user_profile(facebook_id)
      if user_profile.has_key?('first_name')
        NAMES.set(facebook_id, user_profile['first_name'])
        return user_profile['first_name']
      else
        return "No name"
      end

    else
      return cached_name
    end

    return "No name"

  end

end