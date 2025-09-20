# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# 開発環境用テストデータ
# NOTE: user_id, industry_id, occupation_idは仮のIDを使用（関連テーブル作成後に修正予定）

# db/seeds.rb

# 1) マスタ系（業界/職種）
load Rails.root.join("db/seeds/industries.rb")
load Rails.root.join("db/seeds/occupations.rb")

puts "== Seeding users =="

# 2) ユーザー作成
user1 = User.find_or_create_by!(account_name: "user1") do |u|
  u.email    = "user1@example.com"
  u.password = "password"
end

user2 = User.find_or_create_by!(account_name: "user2") do |u|
  u.email    = "user2@example.com"
  u.password = "password"
end

# 3) 参照用ヘルパ（名前からIDを取得）
def industry_id_by_name(name)
  Industry.find_by!(name: name).id
end

def occupation_id_by_name(name)
  Occupation.find_by!(name: name).id
end

# 4) 開発環境では投稿を入れ替えたい場合があるので、既存データを削除
puts "== Seeding experience_posts =="
ExperiencePost.destroy_all if Rails.env.development?

posts = [
  {
    title: "在宅ワークでの集中力向上方法",
    body:  "在宅ワークを始めてから集中力を保つのに…",
    user:  user1,
    industry_name:   "IT・ソフトウェア",  # ←「業界 大分類」名に合わせる
    occupation_name: "IT系",             # ←「職種 大分類」名に合わせる
    status: "published"
  },
  {
    title: "リモート会議でのコミュニケーション改善",
    body:  "リモート会議でうまく発言できずに…",
    user:  user1,
    industry_name:   "広告・マスコミ",
    occupation_name: "企画・管理系",
    status: "published"
  },
  {
    title: "家事と仕事の両立で学んだタイムマネジメント",
    body:  "育児をしながらフリーランスで働く中で…",
    user:  user2,
    industry_name:   "家庭・生活",
    occupation_name: "家庭人",
    status: "published"
  }
]

created = 0
posts.each do |p|
  rec = ExperiencePost.find_or_create_by!(title: p[:title]) do |x|
    x.body          = p[:body]
    x.user_id       = p[:user].id
    x.industry_id   = industry_id_by_name(p[:industry_name])
    x.occupation_id = occupation_id_by_name(p[:occupation_name])
    x.status        = p[:status]
    x.published_at  = Time.current
  end
  created += 1 if rec.previously_new_record?
end

puts "Created #{created} experience_posts (total: #{ExperiencePost.count})"
