# Lazy Deejays

This is a spaghetti code bot that we did in [Vienna's first bot hackathon](http://botshackathon.com/) ! 
( [FB Event](https://www.facebook.com/events/706934266114109/?active_tab=posts) )

[Lazy deejays](https://www.facebook.com/lazydeejays/) won first prize and we wanted to share the code that made it all possible. Since we had to hack this up in a single day there's no QA or testing 

## WTF is lazy deejays? 
![Screenshot 3](http://i.imgur.com/RlD5q7Y.png)


You know how parties nowadays always have like a laptop with 6 tabs of youtube open where everybody wants to play his song? 
Don't you just hate it when somebody with his drink comes in and ignores all that, closes the other tabs and plays his stupid song? 

Meet lazy deejays. The DJ just opens up a website with a playlist. People can now request new songs through the bot. The songs are queued to the playlist automatically.
easy cheesy.

## Screenshots

![Screenshot 1](http://i.imgur.com/SBqZ17F.png)

## Installation

1. clone the repo

2. Install redis & libsqlite3-dev: `sudo apt-get install redis-server libsqlite3-dev`

3. Make sure you're running ruby >=2.2. Do a bundle install `bundle install`
 
4. Edit `config/initializers/messenger.rb` and put in your messenger tokens. Use this [tutorial](https://github.com/netguru/messenger-ruby#configuration) to create your page, bot and generate webhooks.

5. Edit `config/initializers/yt.rb` and put in your Google APIs Youtube API **browser** key. Follow this [tutorial](https://github.com/Fullscreen/yt#configuring-your-app) to get a key. Make sure the API Key is a browser one and not a server one.

6. Run `rails s` to start the server

7. visit `http://127.0.0.1:3000/messenger/subscribe` to subscribe the bot. You can now text your bot :)

8. visit `http://127.0.0.1:3000/` and party hard! 

## License

Apache 2.0. Please beware that you are not allowed to use the names "Lazy Deejay", "Lazy Deejays" or "Lazy DJs".

Copyright 2016 Todor Lazov, David Mann, David Peherstorfer, Larisa Stanescu

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
