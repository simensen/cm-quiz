module CmQuiz
  module Review
    class CreateIdeaWithInvalidContentTooLong < BaseReview
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
          content: 'MTAL7AsJtzP21iUWXPadvFUIqRPNQkaNwWjajXsSUNd9yHos7Ij0pyYP4OjuKhXecb76QscqKFa0Txr3pYRBmUuxVWAUjqTK6BgstrwQpuQLVA9DFGBtogtzokq8uqQKxoykI4IjBGtixggGuUDtR8IIDhWUNIgvFIKQ9Lf3HpXAlBlSnwua4GV6MSDjOrlbkSMaSC7Cx8YsxTQ8SdrZkGJdbubsrtpeE2mtw4FmY6huR9cSukhnUT6Y1roC3NQ4',
          impact: 7,
          ease: 8,
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
