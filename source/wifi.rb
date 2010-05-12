require 'rubygems'
require 'ruby-growl'

growler  = Growl.new 'localhost', 'wifi', ['offline']
online   = true
switched = false

loop do
 result = %x(ping -W2 -c3 google.com 2>&1)
 
 if result["100.0% packet loss"] || result["Unknown"]
   if online
     switched = true
     online   = false
   else
     switched = false
   end
   
   if switched
     growler.notify 'offline', 'The internet is gone again', 'The Wifi has left the building'
     `osascript airport_off.scpt`
     sleep(3)
     `osascript airport_on.scpt` 
     sleep(5)
   end
   
 else
   if !online
     switched = true
     online   = true
   else
     switched = false
   end
   growler.notify 'offline', 'The internet is back', 'Enjoy it while it lasts' if switched
 end
 sleep(5)
end
