tell application "System Events"
  tell process "SystemUIServer"
    tell (1st menu bar item of menu bar 1 whose value of attribute "AXDescription" is "Airport Menu Extra")
      perform action "AXPress"
      delay 0.2
      if exists menu item "Turn Airport Off" of menu 1
        perform action "AXPress" of menu item "Turn AirPort Off" of menu 1
      -- If the AirPort is already off, just click again to dismiss the menu	
      else
        perform action "AXPress"
      end if
    end tell
  end tell
end tell