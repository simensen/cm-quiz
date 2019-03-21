module CmQuiz
  module Review
    class DeleteIdeaWithoutAuthentication < BaseReview
      def initialize(project_api:)
        @project_api = project_api
        @verb = :delete
        @path = '/ideas/:idea_id'
      end

      def run
        jwt, _ = Factory::User.new({
          project_api: @project_api
        }).create
        idea_payload = Factory::Idea.new({
          project_api: @project_api,
          jwt: jwt
        }).create
        idea_id = idea_payload['id']

        res = send_delete_idea_request(idea_id: idea_id)
        expect(res.response.code).to eq("401")

        res = send_get_ideas_request(jwt: jwt)
        res_hash = JSON.parse(res.body)
        expect(res_hash.size).to eq(1)
      end

      private

      def send_delete_idea_request(idea_id:)
        @options = {
          headers: {
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
