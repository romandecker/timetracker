require 'httparty'

class Toggl
    include HTTParty

    base_uri "https://www.toggl.com"
    format :json
    headers "Content-Type" => "application/json"

    attr_reader :api_token

    def initialize( token )
        @api_token = token
    end

    def workspaces
        response = get "workspaces"
        ret = response.map do |wsdata|
            { :id => wsdata['id'], :name => wsdata['name'] }
        end

        return ret
    end

    def logged_time( workspace_id )
        reports_get( "details", workspace_id, {
                :since => '2014-08-06',
                :until => '2014-08-07',
            }
           )
    end

    private
    def get( resource_name, data={} )
        return self.class.get( "/api/v8/#{resource_name}",
                               :basic_auth => { :username => self.api_token, :password => "api_token" },
                               :query => data )
    end

    def reports_get( resource_name, workspace_id, data={} )
        data.merge!( { :workspace_id => workspace_id,
                       :user_agent => 'api_test' } )

        return self.class.get( "/reports/api/v2/#{resource_name}",
                               :basic_auth => { :username => self.api_token, :password => "api_token" },
                               :query => data )
    end

end
