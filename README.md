# このアプリについて
## i-game
親に対して質問を繰り返して答えにたどり着く「i-game」
1人だけ答えを知っている犯人は、自分が犯人だとバレてはいけません。

親と犯人を配られたプレイヤーが答えとなるワードを確認したらゲーム開始です。
子と犯人は、答えを当てるために「それは生き物ですか」「コンビニで買えますか」と言ったような質問を繰り返し、答えにたどりつくことが目的です。正解しなかった場合は全員負けとなります。

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

https://i-game.herokuapp.com/
テストアカウント
name: test
adress: test@test
password: a12345678

## 作った経緯
プログラミングスクールのTECH::EXPERTのカリキュラムの復習でチャット機能を用いた誰も作っていなそうなアプリを作ろうと思い制作した。
チャットするアプリは人狼が有名でそれに近いアプリを探していた所ボードゲーム好きの友人がインサイダーゲームのアプリが欲しいといっていたのでそれだ！！と思い作成した。
## 機能
### ユーザー登録
deviseを用いて、ユーザー登録機能の実装を行った。 ログインしていないユーザーはログインページに自動で飛ばされる。
### トップページ
![top](https://user-images.githubusercontent.com/57488122/72398247-c005b900-3785-11ea-9a86-efbef61896cc.png)
ユーザーネームが表示される。
ルーム作成ボタンとユーザー編集ボタンが有る。
一人のユーザーが対戦ルームの作成を行い、ルーム一覧がトップページに表示される。
### 対戦ページ
チャット機能がある。
<img width="1437" alt="start" src="https://user-images.githubusercontent.com/57488122/72398895-dc0a5a00-3787-11ea-8778-5e0a6a0807a9.png">
誰かが@startと入力したらゲームが始まる。（４人以下だと人数が足りませんと通知が出て始まらない）
<img width="1437" alt="ChatSpace" src="https://user-images.githubusercontent.com/57488122/72399118-84202300-3788-11ea-8e05-7ecf4cb37c8e.png">

ゲームが始まると、親と犯人にだけ自分の役割がメッセージで届き、答えも教えられる。
ゲームが進み答えがわかったら
@answer xxxx
と入力答えがあってると正解の通知が、間違えると違うと通知が出る。
犯人を当てるフェーズも同様
ユーザー好きなルームに入る。
![wolf](https://user-images.githubusercontent.com/57488122/72398301-e62b5900-3785-11ea-86ff-4bd0a8264434.png)

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
- has_many :room_users
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

## ER図
![名称未設定ファイル_drawio_-_draw_io-3](https://user-images.githubusercontent.com/57488122/72533028-c72ce400-38b7-11ea-9871-a32dc5e66bb7.png)
