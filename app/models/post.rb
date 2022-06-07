class Post < ApplicationRecord
    validates :title, presence: true
    validates :content, length: {minimum: 250}
    validates :summary, length: {maximum: 250}
    validates :category, inclusion: {in: %w(Fiction Non-Fiction)}
    validate :must_have_clickbait
    
    def must_have_clickbait
        clickbaits = [/won't believe/i, /secret/i, /top \d+/i, /guess/i]
        clickbaits.each do |c|
            if title
                if title.match(c)
                    return true
                end
            end
        end
        errors.add(:title, "Title not clickbaity.")
    end
end