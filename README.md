# README
@startでゲームスタート
@answer xxx で回答
@wolf xxx で犯人の名前を指名
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|username|string|null: false|
|image|string||
### Association
- has_many :messages
- has_many :groupes, through: :group_users
- has_many :group_users

## room_usersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|group_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :group
- belongs_to :user

## roomsテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
### Association
- has_many :user,  through:  :group_users
- has_many  :messages
-has_many :group_users
## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|
|user_id|integer|null: false, foreign_key: true|
|room_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :room