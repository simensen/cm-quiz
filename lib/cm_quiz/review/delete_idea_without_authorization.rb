module CmQuiz
  module Review
    class DeleteIdeaWithoutAuthorization < BaseReview
      def initialize(project_api:)
        @project_api = project_api
        @verb = :delete
        @path = '/ideas/:idea_id'
      end

      def run
        jwt_first, _ = Factory::User.new({
          project_api: @project_api
        }).create
        idea_payload = Factory::Idea.new({
          project_api: @project_api,
          jwt: jwt_first
        }).create
        idea_id = idea_payload['id']
        jwt, _ = Factory::User.new({
          project_api: @project_api
        }).create

        res = send_delete_idea_request(jwt: jwt, idea_id: idea_id)
        expect(res.response.code).to eq("404")

        #res = send_get_ideas_request(jwt: jwt_first)
        #res_hash = JSON.parse(res.body)
        #expect(res_hash.size).to eq(1)
      end

      private

      def send_delete_idea_request(jwt:, idea_id:)
        @options = {
          headers: {
            'x-access-token' => jwt
          }
        }

        @path = "/ideas/#{idea_id}"
        @project_api.request(:delete, @path, @options)
      end

      def send_get_ideas_request(jwt:)
        options = {
          headers: {
            'x-access-token' => jwt
          }
        }

        @project_api.request(:get, "/ideas", options)
      end
    end
  end
end
