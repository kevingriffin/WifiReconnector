require 'ruby-growl'

class WiFiConnectionStatus
  def initialize
    @online   = true
    @growler  = Growl.new 'localhost', 'wifi', ['offline', 'online']
    @count    = 0

    File.open "#{File.dirname(__FILE__)}/../bin/snarks.txt" do |file|
      @snarks = file.readlines 
    end
  end
  
  def reconnect
    `/usr/sbin/networksetup -setairportpower en0 off`
    sleep(2)      
    `/usr/sbin/networksetup -setairportpower en0 on`
  end

  def snark
    @snarks.shuffle.first.strip
  end
  
  def disconnection_count
    "Disconnection count: #{@count}"
  end
  
  def growl( arguments )
    title = arguments.fetch :title , ""
    body  = arguments.fetch :body  , ""
    body = "#{snark}\n#{body}#{"\n" unless body.empty?}#{disconnection_count}" if @online
    @growler.notify arguments[:name] , title , body
  end
  
  def check_connection
    result = %x(ping -W2 -c3 google.com 2>&1)
    if result["100.0% packet loss"] || result["Unknown"]
      @count += 1 if @online
      growl( :name => 'offline', :title => 'The internet is gone again', :body => "You've lost your Wifi connection again" ) if @online
      reconnect
      @online = false
    else
      growl( :name => 'online', :title => 'The internet is back', :body => 'Enjoy it while it lasts' ) unless @online
      @online = true
    end
  end
end
