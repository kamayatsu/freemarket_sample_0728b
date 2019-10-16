# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Name
メルカリクローン TECH::EXPERT最終課題_0728b

* Overview
フリマサイト「メルカリ」のクローン。
物品を簡単に売買できるフリーマーケットアプリです。
It is a free market app that allows you to easily buy, sell and trade.

* Ruby version
Ruby 2.5.1

* Authors
Hiroki_Katsuyama, Masatomo_Sugai, Yuichi_Motmomura, Kenta_Uneme, Hirokuni_Takgai

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

* ER
  https://cacoo.com/diagrams/bWLWHZyk5HVNBOGA/B8EB9

## deliveraddressesテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_pseudonym|string|null: false|
|first_name_pseudonym|string|null: false|
|post_number|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building|string||
|phone_number|integer||
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user, optional: true

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|post_number|integer||
|prefecture|string|null: false|
|city|string|null: false|
|street|string|null: false|
|building|string||
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user, optional: true

## evaluationsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|string|null: false|
|evaluation|integer|null: false|
|seller|references|null: false, foreign_key: true|
|buyer|references|null: false, foreign_key: true|

### Association
- belongs_to  :buyer, class_name: 'User', foreign_key: 'buyer_id'
- belongs_to  :seller, class_name: 'User', foreign_key: 'seller_id'

## pointsテーブル
|Column|Type|Options|
|------|----|-------|
|point|integer|null: false|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user

## credit_cardsテーブル
|Column|Type|Options|
|------|----|-------|
|customer_id|integer|null: false|
|card_id|integer|null: false|
|user|references|null: false, foreign_key: true|

### Association
- belongs_to :user, optional: true

## purchasesテーブル
|Column|Type|Options|
|------|----|-------|
|seller|references|null: false, foreign_key: true|
|buyer|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|

### Association
- belongs_to  :product
- belongs_to  :buyer, class_name: 'User', foreign_key: 'buyer_id'
- belongs_to  :seller, class_name: 'User', foreign_key: 'seller_id'

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|family_name|string|null: false|
|first_name|string|null: false|
|family_name_pseudonym|string|null: false|
|first_name_pseudonym|string|null: false|
|birthday|date|null: false|
|nickname|string|null: false|
|photo|string|null: false|
|email|string|null: false, unique: true|
|password|string|null: false|
|phone_number|integer|null: false|
|provider|string||
|uid|string||
|profile|text||
|line_token|string||

### Association
- has_many :evaluations
- has_one :deliver_address
- has_one :address
- has_one :point
- has_many :points
- has_one :credit_card
- has_many :products, through: :purchases
- has_many :comments
- has_many :purchases
- has_many :likes, dependent: :destroy
- has_many :like_products, through: :likes, source: :product

## purchasesテーブル
|Column|Type|Options|
|------|----|-------|
|seller|string|null: false|
|buyer|string|null: false|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|
|status|string|null: false|

### Association
- belongs_to  :product
- belongs_to  :buyer, class_name: 'User', foreign_key: 'buyer_id'
- belongs_to  :seller, class_name: 'User', foreign_key: 'seller_id'


## likesテーブル
|Column|Type|Options|
|------|----|-------|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product, counter_cache: :likes_count

## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|comment|string|null: false|
|user|references|null: false, foreign_key: true|
|product|references|null: false, foreign_key: true|

### Association
- belongs_to :user
- belongs_to :product

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|category|string|null: false|
|parent_id|integer||
|size_type|references|foreign_key: true|

### Association
- belongs_to :size_type, optional: true
- belongs_to :parent, class_name: :Category, optional: true
- has_many :children, class_name: :Category, foreign_key: :parent_id
- has_many :products

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|brand|string|null: false|

### Association
- has_one :product

## size_typesテーブル
|Column|Type|Options|
|------|----|-------|
|size_type|string|null: false|

### Association
- has_many :categories
- has_many :sizes

## sizesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|size|string|null: false|
|size_type_id|reference|null: false, foreign_key: true|

### Association
- belongs_to :size_type
- has_many :products

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|integer|null: false|
|detail|string|null: false|
|category|references|null: false, foreign_key: true|
|status|references|null: false, foreign_key: true|
|condition|references|null: false, foreign_key: true|
|brand|references|null: false, foreign_key: true|
|seller|references|null: false, foreign_key: true|
|likes_count|integer|null: false|

### Association
- has_many :users, through: :likes
- has_many :product_images, dependent: :destroy
- belongs_to :category
- belongs_to :brand, optional: true
- belongs_to :size, optional: true
- belongs_to :status
- belongs_to :condition
- has_one :delivery, dependent: :destroy
- has_many :users, through: :purchases
- has_many :comments
- has_many :purchases
- has_many :likes, dependent: :destroy
- has_many :liking_users, through: :likes, source: :user

## product_imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image|string|null: false|
|product|integer|null: false, foreign_key: true|

### Association
- belongs_to :product

## statusesテーブル
|Column|Type|Options|
|------|----|-------|
|status|string|null: false|

### Association
- has_one :product

## conditionsテーブル
|Column|Type|Options|
|------|----|-------|
|condition|string|null: false|

### Association
- has_one :product

## deliveriesテーブル
|Column|Type|Options|
|------|----|-------|
|product|integer|null: false, foreign_key: true|
|deliver_region|references|null: false, foreign_key: true|
|deliver_method|references|null: false, foreign_key: true|
|estimated_date|references|null: false, foreign_key: true|
|shipping_fee|string|null: false|

### Association
- belongs_to :product
- belongs_to :deliver_method
- belongs_to :deliver_region
- belongs_to :estimated_date

## deliver_methodsテーブル
|Column|Type|Options|
|------|----|-------|
|method|string|null: false|

### Association
- has_one :delivery

## deliver_regionsテーブル
|Column|Type|Options|
|------|----|-------|
|region|string|null: false|

### Association
- has_one :delivery

## estimated_datesテーブル
|Column|Type|Options|
|------|----|-------|
|date|integer|null: false|

### Association
- has_one :delivery

uneme_kenta