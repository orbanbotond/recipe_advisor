class RelevantRecipes
  def call(params = {})
    # The original query:
    # sql = <<-SQL
    #   WITH tif AS(
    #     SELECT r.id, count(1) as totalIngrFound
    #     FROM receipts r
    #     INNER JOIN ingredients i ON i.receipt_id = r.id
    #     INNER JOIN home_ingredients hi ON i.name ILIKE concat('%',hi.name,'%')
    #     GROUP BY r.id
    #   ), tin AS(
    #     SELECT r.id, count(1) as totalIngr
    #     FROM receipts r
    #     INNER JOIN ingredients i ON i.receipt_id = r.id
    #     GROUP BY r.id
    #   )
    #   SELECT r.*, tif.totalIngrFound*1.00/tin.totalIngr AS relevancy
    #   FROM receipts r
    #   INNER JOIN tif ON tif.id = r.id
    #   INNER JOIN tin ON tin.id = r.id
    #   ORDER BY relevancy DESC
    # SQL
    # array_of_receipts = Receipt.find_by_sql(sql)

    receipts = Receipt.with(total_ingredients_found: Receipt.joins(:ingredients)
                                                 .joins("INNER JOIN home_ingredients hi ON ingredients.name ILIKE concat('%',hi.name,'%')")
                                                 .select("receipts.id, count(1) as total_ingredients_found")
                                                 .group(:id))
           .with(total_ingredients_needed: Receipt.joins(:ingredients)
                                                  .select("receipts.id, count(1) as total_ingredients_needed")
                                                  .group(:id))
           .joins('INNER JOIN total_ingredients_found ON total_ingredients_found.id = receipts.id')
           .joins('INNER JOIN total_ingredients_needed ON total_ingredients_needed.id = receipts.id')
           .select('receipts.* , total_ingredients_found.total_ingredients_found*1.00/total_ingredients_needed.total_ingredients_needed AS relevancy')
           .order(relevancy: :desc)

    receipts = receipts.order(params[:second_relevant]) if params[:second_relevant].present?
    receipts
  end
end