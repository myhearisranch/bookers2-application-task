class Relationship < ApplicationRecord

  # 中間テーブルを用いることで
  # relationshipとfollowerというテーブルが1対多
  # relationshipとfollowedというテーブルが多対1という関係にする

  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

end
