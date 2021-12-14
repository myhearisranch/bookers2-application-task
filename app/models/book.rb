class Book < ApplicationRecord
 belongs_to :user

  validates :title, presence: true

  #バリデーション、複数指定する時ルールをカンマで区切る
  validates :body,  length: {maximum: 200}, presence: true


end
