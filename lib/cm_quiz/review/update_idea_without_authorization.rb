module CmQuiz
  module Review
    class UpdateIdeaWithoutAuthorization < BaseReview
      def initialize(project_api:)
        @project_api = project_api
        @verb = :put
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
        jwt, _ = Factory::User.new({
          project_api: @project_api
        }).create
        idea_id = idea_payload['id']

        res = send_update_idea_request({
          jwt: jwt,
          idea_id: idea_id,
          content: 'test-new-content',
          impact: 6,
          ease: 7,
          confidence: 8
        })

        expect(res.response.code).to eq("404")
      end

      private

      def send_update_idea_request(jwt:, idea_id:, content: nil, impact: nil,
        ease: nil, confidence: nil)

        @options = {
          headers: {
            'x-access-token' => jwt
          },
          body: {
            content: content,
            impact: impact,
            ease: ease,
            confidence: confidence
          }
        }
        @path = "/ideas/#{idea_id}"

        @project_api.request(:put, @path, @options)
      end

    end
  end
end
