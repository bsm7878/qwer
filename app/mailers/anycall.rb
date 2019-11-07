class Anycall < ApplicationMailer
    def welcome_email flyer_content, content_content 
                mail from: flyer_content, 
                       to: 'bsm7878@naver.com', 
                  subject: '피드백 & 대학 추가',
                     body: content_content 
    end
end
