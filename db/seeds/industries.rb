require "digest"

def slugify(str)
  s = I18n.transliterate(str.to_s).to_s.parameterize
  s.presence || "x#{Digest::SHA1.hexdigest(str.to_s)[0, 8]}"
end

# 業界一覧（大分類 => 中分類配列）
industries = {
  "製造業" => %w[自動車 電機・精密 機械 化学・素材 食品・飲料 その他・不明],
  "商社・卸売" => %w[総合商社 専門商社 その他・不明],
  "小売・流通" => %w[百貨店・スーパー コンビニ 専門店 EC その他・不明],
  "金融" => %w[都市銀行 地方銀行 信託銀行 信用金庫・組合 農協(金融・保険) 証券 保険 クレジット・カード ファイナンス その他・不明],
  "IT・ソフトウェア" => %w[SIer 受託開発 Webサービス ゲーム インフラ・クラウド AI・データ その他・不明],
  "建設・不動産" => %w[建設 不動産開発 不動産仲介 設計事務所 その他・不明],
  "医療・福祉" => %w[病院 介護施設 保育施設 製薬 医療機器 その他・不明],
  "サービス・インフラ" => %w[交通・運輸 旅行・観光 ホテル・宿泊 飲食 人材 エネルギー・通信 その他・不明],
  "広告・マスコミ" => %w[広告代理店 出版 テレビ・ラジオ Webメディア その他・不明],
  "官公庁・教育・団体" => %w[官公庁 公共団体 教育機関 NPO・NGO その他・不明],
  "農林水産" => %w[農業 林業 漁業 その他・不明],
  "家庭・生活" => %w[家庭生活 地域コミュニティ 家事・育児・介護 その他・不明],
  "その他・不明" => %w[その他・不明]
}

industries.each.with_index(1) do |(parent, children), i|
  ind = Industry.find_or_create_by!(code: slugify(parent)) { |r| r.name = parent; r.position = i }
  children.each.with_index(1) do |child, j|
    IndustryCategory.find_or_create_by!(industry: ind, code: slugify(child)) { |c| c.name = child; c.position = j }
  end
end
