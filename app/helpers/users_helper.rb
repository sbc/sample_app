module UsersHelper
  def gravatar_for(user, options = { :size => 50 })
    gravatar_image_tag user.email.downcase, :alt => user.name,
                                            :class => 'gravatar',
                                            :gravatar => options
  end

  def gravatar_for_current_user(options)
    gravatar_for(current_user, options)
  end
end
