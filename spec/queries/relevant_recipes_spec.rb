RSpec.describe RelevantRecipes do
  subject(:query) { described_class.new().call()}

  let!(:sausage_receipt) { create(:receipt, title: 'Sausage') }
  let!(:sausage_ingredient_meat) { create(:ingredient, name: 'Meat', receipt: sausage_receipt) }

  let!(:pizza_receipt) { create(:receipt, title: 'Pizza') }
  let!(:pizza_ingredient_flour) { create(:ingredient, name: 'White Flour', receipt: pizza_receipt) }
  let!(:pizza_ingredient_egg) { create(:ingredient, name: 'egg', receipt: pizza_receipt) }
  let!(:pizza_ingredient_yeast) { create(:ingredient, name: 'yeast', receipt: pizza_receipt) }
  let!(:pizza_ingredient_tomato) { create(:ingredient, name: ' sweet tomato from countryside', receipt: pizza_receipt) }

  let!(:home_ingredient_flour) { create(:home_ingredient, name: 'flour') }
  let!(:home_ingredient_egg) { create(:home_ingredient, name: 'egg') }
  let!(:home_ingredient_tomato) { create(:home_ingredient, name: 'tomato') }

  context 'when one of the ingredients of the recipe is not found at home' do
    it 'returns 0 recipes' do
      expect(query.length).to equal(0)
    end
  end

  context 'when all of the ingredients of the recipe are found at home' do
    let!(:home_ingredient_yiest) { create(:home_ingredient, name: 'Yeast') }

    it 'returns the matching recipes using case insensitive search' do
      expect(query.length).to equal(1)
    end

    context 'when there are 2 receipts with all the ingredients having at home' do
      let!(:home_made_bread_receipt) { create(:receipt, title: 'Bread') }
      let!(:home_made_bread_ingredient_flour) { create(:ingredient, name: 'Flour', receipt: home_made_bread_receipt) }
      let!(:home_made_bread_ingredient_egg) { create(:ingredient, name: 'egg', receipt: home_made_bread_receipt) }
      let!(:home_made_bread_ingredient_yeast) { create(:ingredient, name: 'yeast', receipt: home_made_bread_receipt) }

      it 'returns the 2 matching recipes using case insensitive search' do
        expect(query.length).to equal(2)
        expect(query).to include(home_made_bread_receipt)
        expect(query).to include(pizza_receipt)
        expect(query).to_not include(sausage_receipt)
      end

      context 'the other kind of bread required brown flour' do
        let!(:home_made_brown_bread_receipt) { create(:receipt, title: 'Brown Bread') }
        let!(:home_made_brown_bread_ingredient_flour) { create(:ingredient, name: 'Brown Flour', receipt: home_made_brown_bread_receipt) }
        let!(:home_made_brown_bread_ingredient_egg) { create(:ingredient, name: 'egg', receipt: home_made_brown_bread_receipt) }
        let!(:home_made_brown_bread_ingredient_yeast) { create(:ingredient, name: 'yeast', receipt: home_made_brown_bread_receipt) }

        it 'returns the 2 matching recipes using case insensitive search' do
          expect(query.length).to equal(3)
          expect(query).to include(home_made_bread_receipt)
          expect(query).to include(home_made_brown_bread_receipt)
          expect(query).to include(pizza_receipt)
        end
      end

      context 'relevancy' do
        let!(:country_bread_receipt) { create(:receipt, title: 'Brown Bread') }
        let!(:country_bread_ingredient_flour) { create(:ingredient, name: 'Brown Flour', receipt: country_bread_receipt) }
        let!(:country_bread_ingredient_egg) { create(:ingredient, name: 'egg', receipt: country_bread_receipt) }

        it 'orders the recipes by their ingredient number ascending' do
          expect(query.first.ingredient_number).to eq(2)
          expect(query.last.ingredient_number).to eq(4)
        end

        context 'querying for the most complex recipes' do
          subject(:query) { described_class.new().call( {most_relevant: { most_ingredients: :desc} } ) }

          it 'orders the recipes by their ingredient number descending' do
            expect(query.first.ingredient_number).to eq(4)
            expect(query.last.ingredient_number).to eq(2)
          end
        end
      end
    end
  end
end