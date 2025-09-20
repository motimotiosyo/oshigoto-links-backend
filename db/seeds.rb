# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 業界・職種データの読み込み
require 'digest'
require 'bcrypt'

def slugify(str)
  s = I18n.transliterate(str.to_s).to_s.parameterize
  s.presence || "x#{Digest::SHA1.hexdigest(str.to_s)[0, 8]}"
end

puts "Loading industries and occupations data..."
load Rails.root.join('db', 'seeds', 'industries.rb')
load Rails.root.join('db', 'seeds', 'occupations.rb')

# 開発環境用テストデータ
puts "Creating development test data..."

# 既存データをクリア（開発環境のみ）
if Rails.env.development?
  ExperiencePost.destroy_all
  puts "Cleared existing experience posts"
end

# テストユーザー作成
test_users = [
  { account_name: "test_user", email: "test@example.com", password_digest: BCrypt::Password.create("password") },
  { account_name: "user2", email: "user2@example.com", password_digest: BCrypt::Password.create("password") },
  { account_name: "user3", email: "user3@example.com", password_digest: BCrypt::Password.create("password") }
]

test_users.each do |user_data|
  User.find_or_create_by!(account_name: user_data[:account_name]) do |user|
    user.email = user_data[:email]
    user.password_digest = user_data[:password_digest]
  end
end

puts "Created #{User.count} test users"

# テストデータ作成
test_posts = [
  {
    title: "在宅ワークでの集中力向上方法",
    body: "在宅ワークを始めてから集中力を保つのに苦労していましたが、ポモドーロテクニックを導入することで劇的に改善しました。25分集中→5分休憩のサイクルで作業効率が向上し、疲労感も軽減されました。",
    user_id: 1,
    industry_id: 5, industry_category_id: 19,  # IT・ソフトウェア > Webサービス
    occupation_id: 6, occupation_category_id: 27, # IT専門職 > システムエンジニア
    status: "published"
  },
  {
    title: "リモート会議でのコミュニケーション改善",
    body: "リモート会議でうまく発言できずにいましたが、事前にアジェンダを確認し、話すポイントをメモしておくことで自信を持って参加できるようになりました。",
    user_id: 1,
    industry_id: 4, industry_category_id: 12,  # 金融 > 銀行
    occupation_id: 2, occupation_category_id: 5, # 営業・販売系 > 法人営業
    status: "published"
  },
  {
    title: "家事と仕事の両立で学んだタイムマネジメント",
    body: "育児をしながらフリーランスで働く中で、タスクの優先順位付けと時間の使い方を見直しました。朝の時間を有効活用することで、無理なく両立できています。",
    user_id: 2,
    industry_id: 12, industry_category_id: 49,  # 家庭・生活 > 家庭生活
    occupation_id: 12, occupation_category_id: 56, # 家庭人 > 家事
    status: "published"
  },
  {
    title: "副業での経験が本業に活かされた話",
    body: "週末にWebライティングの副業をしていたところ、文章力や情報整理能力が向上し、本業での資料作成やメール対応が格段に改善されました。",
    user_id: 2,
    industry_id: 9, industry_category_id: 39,  # 広告・マスコミ > 出版
    occupation_id: 5, occupation_category_id: 24, # クリエイティブ系 > ライター・編集
    status: "published"
  },
  {
    title: "未経験からプログラミングを学んだ体験",
    body: "全くの未経験からプログラミングを始めて半年。オンライン学習と実際にコードを書く練習を繰り返すことで、基本的なWebサイトが作れるようになりました。",
    user_id: 3,
    industry_id: 5, industry_category_id: 19,  # IT・ソフトウェア > Webサービス
    occupation_id: 6, occupation_category_id: 27, # IT専門職 > システムエンジニア
    status: "published"
  }
]

created_count = 0
test_posts.each do |post_data|
  post = ExperiencePost.find_or_create_by!(
    title: post_data[:title]
  ) do |experience_post|
    experience_post.body = post_data[:body]
    experience_post.user_id = post_data[:user_id]
    experience_post.industry_id = post_data[:industry_id]
    experience_post.occupation_id = post_data[:occupation_id]
    experience_post.industry_category_id = post_data[:industry_category_id]
    experience_post.occupation_category_id = post_data[:occupation_category_id]
    experience_post.status = post_data[:status]
    experience_post.published_at = Time.current
  end
  created_count += 1 if post.previously_new_record?
end

puts "Created #{created_count} experience posts"
puts "Total experience posts: #{ExperiencePost.count}"
