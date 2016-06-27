class ReplyService

  replies = Hash.new
  replies["todor"] = ["Todor!", "Todor.", "Todoooor", "Todooor!", "Todor.", "Todor todor todor, todor!"]
  replies["whatsup"] = ["Todorrr.", "Todor, todor, todor todor, todor! But then todor.", "First there was Todor. Now there's Todor everywhere.", "In case of emergency, Todor.", "'To Dor Or Not To Dor. That is the todor.", "Todor todor todor, todor!", "Winter is coming. And so is Todor.", "Everyday I'm todoring."]
  replies["name"] = ["A bot has no name. lol jk. It's Todor. Nah it's actually Lazydeejays.", "Toooooo --- Doooooor! Meow. Lazy deejays.", "A bot has many names. Todor. Lazy Deejays.", "I am named after my creator - a stupid, cynical -- oh look! It's a Todor. ", "It's actually Wylis. Nah, just messing with you. I'm the real todor.", "!"]
  replies["hello"] = ["Meow Meow! Let’s get this party started! Do you have the next big hit in your head? Go ahead, what should we play? Just type the artist & song name like for example *Survivor - Eye of the tiger*"]
  replies["help"] = ["Purrr! Just type an artist & song name like for example *Survivor - Eye of the tiger*", "Purr-meow. No stress - just type a song that you like, e.g. depeche mode enjoy the silence", "Do you want to listen to your favorite band? just type in your bands name and i'm going do a cat search for it and send it to the playlist. "]
  replies["meow"] = ["Purrr! Meow.", "Purr-meow.", "Mrrr?", "Meow."]
  replies["thanks"] = ["Purrr! You're welcome.", "Purr-meow. You're welcome", "Mrrr! You're welcome ", "Meow. You're welcome!"]

  DICT = {"todor": replies["todor"],
          "whatsup": replies["whatsup"],
          "whats up": replies["whatsup"],
          "whats going on": replies["whatsup"],
          "sup": replies["whatsup"],
          "how you doin": replies["whatsup"],
          "how you doing": replies["whatsup"],
          "hows it going": replies["whatsup"],
          "whats your name": replies["name"],
          'whats ur name': replies["name"],
          "hello": replies["hello"],
          "hi": replies["hello"],
          "help": replies["help"],
          "meow": replies["meow"],
          "thanks": replies["thanks"],
          "thank you": replies["thanks"],
          "10x": replies["thanks"]

  }

  # Searches through predefined phrases, such as Todor, help, whatsup, etc.
  def self.get_predefined_reply(facebook_id, user_name, message)

    begin
      message = message.downcase.gsub(/[^0-9a-z ]/i, '').to_sym

      if DICT.has_key? message
        return DICT[message].sample
      else
        return ''
      end
    rescue
      # hackathon spaghetti code error handling
      ''
    end
  end

  # perform a simple youtube API search
  def self.get_youtube_search(facebook_id, user_name, message)

    begin
      result = RestClient.get 'https://www.googleapis.com/youtube/v3/search', {:params => {:key => YOUTUBE_API_TOKEN, :maxResults => 1, :order => 'viewCount', :q => message, :part => "snippet"}}
      result_json = JSON.parse result.body
      #video_id = result_json[:items][:id][:videoId]

      video_id = result_json["items"][0]['id']['videoId']
      video_name = result_json["items"][0]['snippet']['title']
      video_thumb = result_json["items"][0]['snippet']['thumbnails']['medium']['url']
      video_description = result_json["items"][0]['snippet']['description']

      # save everything
      TRACKS.insert(:video_id => video_id, :name => video_name, :description => video_description, :thumb => video_thumb, :username => user_name)

      VIDEO_TITLE.set(video_id, video_name)
      VIDEO_DESCRIPTION.set(video_id, video_description)

      Rails.logger.debug("result: #{video_id}")

      # return a video link
      "https://www.youtube.com/watch?v=#{video_id}"
    rescue
      # hackathon spaghetti code error handling
      "Oops I couldn't find anything :("
    end


    # THE YT PLUGIN DOESN'T WORK AND AT THIS POINT WE HAVE NO TIME TO FIGURE OUT WHY

    #  videos = Yt::Collections::Videos.new
    #  videos.where(order: 'viewCount').first.title #=>  "PSY - GANGNAM STYLE"
    # "?key=&maxResults=1&order=viewCount&part=snippet&q=depeche+mode&safeSearch=none&type=video"
    #search_results =  videos.where(order: 'viewCount').first.title
    # search_results = videos.where(order: 'viewCount', q: "#{message}", safe_search: 'none') #=> 324
    #   Rails.logger.debug "yt results + #{search_results.inspect}"

    #    search_results.first.title
    #  videos.where(chart: 'mostPopular', video_category_id: 44).first.title #=> "SINISTER - Trailer"
    #  videos.where(id: 'MESycYJytkU,invalid').map(&:title) #=> ["Fullscreen Creator Platform"]

  end

end