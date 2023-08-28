## アプリケーションの概要
ユーザーを登録すると商品を出品できるようになります。自身が出品した商品は、編集と削除をすることができます。他のユーザーが出品した商品は、クレジットカードを用いて購入することができます。


## Basic認証
ID:admin
Pass:2222


## テスト用アカウント
# 購入者用
メールアドレス:kido@mail.com
パスワード:kusaka913


# 購入用カード情報
番号：4242424242424242
期限：12/24	
セキュリティコード：123

# 出品者用
メールアドレス名:kanzaki@mail.com
パスワード:inui555


## 実装機能

1.ユーザー登録機能
ユーザー登録することで出品・購入できるようになります。
（ユーザー登録していない人でも出品している商品を見ることは可能です。）


2.商品出品機能
商品画像を選択し、商品情報や販売したい金額を入力すると、出品することができます。
（JavaScriptで販売手数料が表示されるようになっています。）


3.商品の編集機能
出品した商品について、編集することができます。
その際に、ユーザーの手間を省くため出品時の情報が表示されるようになっています。


4.商品の削除機能
出品中であった商品について、削除ボタンを押すことで商品を削除することができます。


5.商品の購入機能
出品者以外であれば、商品を購入することができます。
カード情報と配送先を入力すると購入できます。
（JavaScriptとフォームオブジェクトを使用し、トークン化したカード情報をPAY.JPに送付しつつ、
カード情報がアプリケーションのデータベースに保存されないように設計しています。）


## テーブル設計

# users テーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana     | string | null: false               |
| first_name_kana    | string | null: false               |
| birthday           | date   | null: false               |

# Association
has_many :items
has_many :orders
has_many :comments


# items テーブル
| Column                | Type       | Options                        |
| --------------------- | ---------- | ------------------------------ |
| user                  | references | null: false, foreign_key: true |
| name                  | string     | null: false                    |
| description           | text       | null: false                    |
| category_id           | integer    | null: false                    |
| item_status_id        | integer    | null: false                    |
| prefecture_id         | integer    | null: false                    |
| scheduled_delivery_id | integer    | null: false                    |
| shipping_cost_id      | integer    | null: false                    |
| price                 | integer    | null: false                    |

# Association
belongs_to :user
has_one :order
has_many :comments


# orders テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

# Association
belongs_to :user
belongs_to :item
has_one :payment


# payments テーブル
| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| order         | references | null: false, foreign_key: true |
| postcode      | string     | null: false                    |
| prefecture_id | integer    | null: false                    |
| city          | string     | null: false                    |
| block         | string     | null: false                    |
| building      | string     |                                |
| phone_number  | string     | null: false                    |

# Association
belongs_to :order


# comments テーブル
| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |
| text   | text       | null: false                    |

# Association
belongs_to :user
belongs_to :item
