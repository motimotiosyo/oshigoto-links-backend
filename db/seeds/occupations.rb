require "digest"

def slugify(str)
  s = I18n.transliterate(str.to_s).to_s.parameterize
  s.presence || "x#{Digest::SHA1.hexdigest(str.to_s)[0,8]}"
end

# 職種一覧
occupations = {
  "サービス系" => %w[接客 教育 観光・宿泊 飲食・小売],
  "営業・販売系" => %w[法人営業 個人営業 店舗営業 バイヤー カスタマーサクセス],
  "企画・管理系" => %w[経営企画 商品企画 マーケティング 人事 経理・財務 法務・知財 広報・IR 総務 秘書],
  "事務・オフィス系" => %w[一般事務 営業事務 受付 カスタマーサポート],
  "クリエイティブ系" => %w[デザイナー ライター・編集 映像・音響 広告・ディレクション],
  "IT専門職" => %w[システムエンジニア インフラエンジニア 組込エンジニア データサイエンティスト セキュリティエンジニア QA・テストエンジニア サポートエンジニア ヘルプデスク],
  "技術系" => %w[研究開発 建築・土木・設備],
  "医療系専門職" => %w[医師 看護師 薬剤師 臨床検査士],
  "士業" => %w[弁護士 司法書士 行政書士 公認会計士・税理士 社労士 その他士業],
  "物流・運輸" => %w[運転士 ドライバー 倉庫作業 物流管理 購買・調達],
  "公務・団体職" => %w[公務員・行政 公務員・技術 団体職員・NPO 団体職員・国際協力],
  "家庭人" => %w[家事 育児 介護 地域活動 自営業補助]
}

# 職種（Occupation = 大分類）と、その配下の中分類（OccupationCategory）をまとめて作る処理
occupations.each.with_index(1) do |(parent, children), i|
  occ = Occupation.find_or_create_by!(code: slugify(parent)) { |r| r.name = parent; r.position = i }
  children.each.with_index(1) do |child, j|
    OccupationCategory.find_or_create_by!(occupation: occ, code: slugify(child)) { |c| c.name = child; c.position = j }
  end
end
