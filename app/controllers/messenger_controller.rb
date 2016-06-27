class MessengerController < Messenger::MessengerController

  # This is the main entry point for messenger.
  def webhook

    begin
      #
      # if the human sent a a message:
      #
      if fb_params.first_entry.callback.message?

        # get the id of the sender (facebook id)
        sender_id = fb_params.first_entry.sender_id

        # look up if we have an entry about that sender in our keystore
        if NAMES.get(sender_id) == nil
          reply_text = "Let’s get this party started! Do you have the next big hit in your head? Go ahead, what should we play? Just type the artist & song name like for example *Survivor - Eye of the tiger*"
          user_name = "no name"
          user_name = UserService.get_name(sender_id)
        else
          # get the name of the person messaging
          user_name = "no name"
          user_name = UserService.get_name(sender_id)

          message = fb_params.first_entry.callback.text

          logger.debug "new message from: #{user_name.inspect} - #{message}" if message

          # set an initial text for the reply
          reply_text = ''

          # 1. Check for predefined phrases
          if (predefined_reply = ReplyService.get_predefined_reply(sender_id, user_name, message)) != ''
            reply_text = predefined_reply
          else
          # if none of the phrases are matching, do a simple youtube search
            # analyze text
            # reply_text = "I'm still learning, #{user_name}! Come by later, maybe the actual Todor has done something with the bot :) "
            reply_text = ReplyService.get_youtube_search(sender_id, user_name, message)
          end


          # if a video has been found, append a "ok i found this" message
          if reply_text.include? ("youtube")
            #  video_id = reply_text.slice! "https://www.youtube.com/watch?v="
            replies = ["Mrrr! I found the following:", "OK my cat search found this:", "Purrr! I found this:", "Purr-meow. I caught this:"]
            found_reply = Messenger::Elements::Text.new(text: replies.sample)
            Messenger::Client.send(
                Messenger::Request.new(found_reply, sender_id)
            )
          end

        end

        # create the reply message from the text
        reply = Messenger::Elements::Text.new(text: reply_text)


        # log the reply message to be sent
        logger.debug "replying to: #{user_name.inspect} with: #{reply_text}"

        # send the actual reply.
        Messenger::Client.send(
            Messenger::Request.new(reply, sender_id)
        )

      end
    rescue
      # spaghetti code error handling
      logger.debug "something wrong happened"

    end

    # make sure to send 200 at the end
    render nothing: true, status: 200


  end
end