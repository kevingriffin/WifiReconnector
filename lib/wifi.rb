require 'ruby-growl'

class WiFiConnectionStatus
  def initialize
    @online   = true
    @growler  = Growl.new 'localhost', 'wifi', ['offline', 'online']
    @count    = 0

    File.open "snarks.txt" do |file|
      @snarks = file.readlines 
    end
  end
  
  def reconnect
    %x[osascript #{File.dirname(__FILE__)}/wifi/airport_off.scpt]
    sleep(3)      
    %x[osascript #{File.dirname(__FILE__)}/wifi/airport_on.scpt] 
  end

  def snark
    @online ? @snarks.shuffle.first.strip + "\n" : ''
  end
  
  def disconnection_count
    @online ? "\nDisconnection count: #{@count}" : ''
  end
  
  def growl( arguments )
    @growler.notify arguments[:name] , arguments[:title] || '' , snark + (arguments[:body] || '') + disconnection_count
  end
  
  def check_connection
    result = %x(ping -W2 -c3 google.com 2>&1)
    if result["100.0% packet loss"] || result["Unknown"]
      @count += 1 if @online
      growl( :name => 'offline', :title => 'The internet is gone again', :body => "You've lost your Wifi connection again." ) if @online
      reconnect
      @online = false
    else
      growl( :name => 'online', :title => 'The internet is back', :body => 'Enjoy it while it lasts' ) unless @online
      @online = true
    end
  end
end
