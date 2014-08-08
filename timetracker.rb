require_relative './toggl.rb'

API_TOKEN=''

t = Toggl.new( API_TOKEN )

workspace_id = t.workspaces.find{ |ws| ws[:name] == 'CardEmotion' }[:id]

if workspace_id.nil? then
    puts "No workspace named 'CardEmotion'!"
    exit 1
end

puts t.logged_time( workspace_id )
