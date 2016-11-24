function on_msg_receive (msg)
  if msg.out then
      return
  end
  if (msg.text=='ping') then
     send_msg (msg.from.print_name, 'pong', ok_cb, false)
  end
  if (msg.text=='temp') then
         local line = io.popen("cat /sys/devices/virtual/thermal/thermal_zone0/temp")
         local result = line:read("*a")
         line:close()
         result = result/1000
         send_msg (msg.from.print_name, 'My temperature is: '..result..' ºC', ok_cb, false)
  end
end

function on_our_id (id)
end

function on_secret_chat_created (peer)
end

function on_user_update (user)
end

function on_chat_update (user)
end

function on_get_difference_end ()
end

function on_binlog_replay_end ()
end
