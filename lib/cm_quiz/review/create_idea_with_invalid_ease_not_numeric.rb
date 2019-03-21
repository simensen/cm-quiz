module CmQuiz
  module Review
    class CreateIdeaWithInvalidEaseNotNumeric < BaseReview
      def initialize(project_api:)
        @project_api = project_api
        @verb = :post
        @path = '/ideas'
      end

      def run
        jwt, _ = Factory::User.new({
          project_api: @project_api
        }).create

        res = send_create_idea_request({
          jwt: jwt,
          content: 'test-content',
          impact: 7,
          ease: 'foo',
          confidence: 9
        })
        expect(res.response.code).to eq("403")
      end

      private

      def send_create_idea_request(jwt:, content:, impact:, ease:, confidence:)
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

        @project_api.request(@verb, @path, @options)
      end
    end
  end
end
