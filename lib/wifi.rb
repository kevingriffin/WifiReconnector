require 'ruby-growl'

class WiFiConnectionStatus
  def initialize
    @online    = true
    @growler   = Growl.new 'localhost', 'wifi', ['offline', 'online']
    @count     = 0
    @interface = detect_interface

    File.open(File.dirname(__FILE__) + '/snarks.txt') do |file|
      @snarks = file.readlines 
    end
  end
  
  def reconnect
    `/usr/sbin/networksetup -setairportpower #{@interface} off`
    sleep(2)      
    `/usr/sbin/networksetup -setairportpower #{@interface} on`
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
  
  def detect_interface
    active_interface = ""
    `ifconfig -lu`.split.each do |interface|
      status = `ifconfig #{interface}`
      unless status.scan(/status: active$/).empty?
        active_interface = interface
        break
      end
    end
    
    if active_interface.empty?
      puts "WiFi interface not found. Make sure your WiFi is turned on."
      exit
    else
      active_interface
    end
  end
end
