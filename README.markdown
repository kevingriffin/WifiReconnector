WiFi Reconnector
=================

What is this?
-----------------

The WiFi connection at my university has a tendency to silently cut out, requiring me to turn off my wifi and turn it back on. This tool detects when your internet drops and does that automatically.

What does it do?
-----------------

If you have an internet connection, it does nothing. If it detects that the internet is down (or you're dropping a lot of packets), it'll turn off your WiFi and turn it back on, trying to re-establish the connection.

What's needed to use it?
-----------------

This is a script specific to OS X, so you'll need a Mac (with wifi). 

You'll need Growl, which is a popular notification system for the Mac. You can find it at [growl.info](http://growl.info).

You'll also need the ruby-growl gem. If you don't have RubyGems, get it [here](http://rubygems.org/pages/download).

Finally, you'll need to open up System Preferences, and turn on network support for Growl:

![The Growl preference pane](http://img.skitch.com/20100717-deu4p3xgiiat89jnrwqdixicuf.png)

Credits
----------------

    ruby-growl -- Library used for Growl               http://segment7.net/projects/ruby/growl/
    
    StefanK    -- Inspiration for the AppleScripts     http://macscripter.net/viewtopic.php?id=29003


