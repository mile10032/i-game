# このアプリについて
## i-game
出題者に対して全員で質問を繰り返しながら、制限時間内に答えにたどり着く「i-game」
1人だけ答えを知っているインサイダーは、自分がインサイダーだとバレてはいけません。

親と犯人を配られたプレイヤーが答えとなるワードを確認したらゲーム開始です。子と犯人を配られたプレイヤーは、答えを当てるために「それは生き物ですか」「コンビニで買えますか」と言ったような質問をとにかく繰り返し、答えにたどりつくことが目的です。正解しなかった場合は全員負けとなります。
正解した場合は、誰が犯人かを当てるフェイズに移ります。見事犯人を当てることができれば子の勝利となります。

犯人は正解を知っているので、他のプレイヤーを正解へどうやって導いていくのか、いつ正解を言うのかなど、難しい立ち回りを必要とされます。そのため、犯人で勝てた時は大きな達成感を得ることができます。推理と正体隠匿が合わさったゲームです。

@startでゲームスタート
@answer xxx で回答
@wolf xxx で犯人の名前を指名
xxxに任意の文字を入れる

## 概要
アプリ名：i-game

使用言語：Ruby on Rails、JavaScript

主な機能ユーザー登録 、ルーム、チャット

作業人数：1人

作業日数：1４日間

## 作った経緯
TECH::EXPERTのカリキュラムが終わり今まで習ったことで何か実装しようと考えた際に、チャット機能を用いた誰も作っていなそうなアプリを作ろうと思い制作した。
## 機能
### ユーザー登録
deviseを用いて、ユーザー登録機能の実装を行った。 ログインしていないユーザーはログインページに自動で飛ばされる。
### トップページ
ユーザーネームが表示される。
ルーム作成ボタンとユーザー編集ボタンが有る。
一人のユーザーが対戦ルームの作成を行い、ルーム一覧がトップページに表示される。
### 対戦ページ
チャット機能がある。
誰かが@startと入力したらゲームが始まる。（４人以下だと人数が足りませんと通知が出て始まらない）
ゲームが始まると、親と犯人にだけ自分の役割がメッセージで届き、答えも教えられる。
ゲームが進み答えがわかったら
@answer　xxxx
と入力答えがあってると正解の通知が、間違えると違うと通知が出る。
犯人を当てるフェーズも同様
ユーザー好きなルームに入る。
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|email|string|null: false|
|password|string|null: false|
|username|string|null: false|
### Association
- has_many :messages
- has_many :rooms, through: :group_users
- has_many :room_users

## room_usersテーブル

|Column|Type|Options|
|------|----|-------|
|user_id|integer|null: false, foreign_key: true|
|room_id|integer|null: false, foreign_key: true|

### Association
- belongs_to :room
- belongs_to :user

## roomsテーブル
|Column|Type|Options|
|------|----|-------|
|title|string|null: false|
### Association
- has_many :user,  through:  :room_users
- has_many  :messages
-has_many :room_users
## messagesテーブル
|Column|Type|Options|
|------|----|-------|
|text|text|
|show_user_id|string|
|user_id|integer|null: false, foreign_key: true|
|room_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :room