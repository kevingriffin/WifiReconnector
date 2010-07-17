require 'ruby-growl'

class WiFiConnectionStatus
  def initialize
    @online   = true
    @growler  = Growl.new 'localhost', 'wifi', ['offline']
  end

  def is_down
    @growler.notify 'offline', 'The internet is gone again', 'The Wifi has left the building' if @online
    %x[osascript airport_off.scpt]
    sleep(3)      
    %x[osascript airport_on.scpt] 
  end

  def check_connection
    result = %x(ping -W2 -c3 google.com 2>&1)
    if result["100.0% packet loss"] || result["Unknown"]
      is_down
      @online = false
    else
      @growler.notify 'offline', 'The internet is back', 'Enjoy it while it lasts' unless @online
      @online = true
    end
  end
end

wifi = WiFiConnectionStatus.new
loop do
  wifi.check_connection
  sleep(5)
end