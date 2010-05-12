WiFi Reconnector
=================

What is this?
-----------------

The WiFi connection at my university has a tendency to silently cut out; figuring out that the problem with your commit or project is dead internet can be frustrating. I decided to write a small script that would check my connection and, if it was out, would disconnect and re-connect in an attempt to restore the connection.

What does it do?
-----------------

If you have an internet connection, it does nothing. If it detects that the internet is down (or you're dropping a lot of packets), it'll turn off your WiFi and turn it back on, trying to re-establish the connection.

What's needed to use it?
-----------------

This is a script specific to OS X, so you'll need a Mac (with wifi). You'll also need the ruby-growl gem, along with an install of Growl which is set to listen for Network Growls.

Credits
----------------

    ruby-growl -- Library used for Growl               http://segment7.net/projects/ruby/growl/
    
    StefanK    -- Inspiration for the AppleScripts     http://macscripter.net/viewtopic.php?id=29003


