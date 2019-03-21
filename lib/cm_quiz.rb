require 'cm_quiz/cli'
require 'cm_quiz/project_api'
require 'cm_quiz/review/base_review'
require 'cm_quiz/review/sign_up_user'
require 'cm_quiz/review/login_user'
require 'cm_quiz/review/get_user_info'
require 'cm_quiz/review/create_idea'
require 'cm_quiz/review/get_ideas'
require 'cm_quiz/review/update_idea'
require 'cm_quiz/review/delete_idea'
require 'cm_quiz/factory/user'
require 'cm_quiz/factory/idea'
require 'cm_quiz/review_quiz'

# 1 
require 'cm_quiz/review/create_idea_with_invalid_content_empty'
require 'cm_quiz/review/create_idea_with_invalid_content_too_long'
require 'cm_quiz/review/create_idea_with_invalid_ease_too_low'
require 'cm_quiz/review/create_idea_with_invalid_ease_not_numeric'
require 'cm_quiz/review/create_idea_with_invalid_ease_too_high'

# 2
require 'cm_quiz/review/get_user_info_invalid_jwt'

# 3
require 'cm_quiz/review/update_idea_without_authentication'

# 4
require 'cm_quiz/review/update_idea_without_authorization'

# 6
require 'cm_quiz/review/delete_idea_without_authentication'

# 7
require 'cm_quiz/review/delete_idea_without_authorization'

require 'cm_quiz/version'

module CmQuiz
end
