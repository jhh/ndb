require_relative 'test_helper'

class TestPivot < Test::Unit::TestCase

  REF_QUERY = <<-SQL
    select nd.nutr_val
    from FOOD_DES f inner join NUT_DATA nd on f.ndb_no = nd.ndb_no
    inner join NUTR_DEF n on nd.nutr_no = n.nutr_no
    where n.tagname = ? and f.ndb_no like ?
    SQL

  def setup
    @db = SQLite3::Database.new(ENV["NDB_DB"])
  end

  must "have correct calories in FOOD table" do
    run_nutrient_value_test('ENERC_KCAL', 'calories')
  end

  must "have correct protein values in FOOD table" do
    run_nutrient_value_test('PROCNT', 'protein')
  end

  must "have correct fat values in FOOD table" do
    run_nutrient_value_test('FAT', 'fat')
  end

  must "have correct saturated_fat values in FOOD table" do
    run_nutrient_value_test('FASAT', 'saturated_fat')
  end

  must "have correct polyunsaturated_fat values in FOOD table" do
    run_nutrient_value_test('FAPU', 'polyunsaturated_fat')
  end

  must "have correct monounsaturated_fat values in FOOD table" do
    run_nutrient_value_test('FAMS', 'monounsaturated_fat')
  end

  must "have correct trans_fat values in FOOD table" do
    run_nutrient_value_test('FATRN', 'trans_fat')
  end

  must "have correct cholesterol values in FOOD table" do
    run_nutrient_value_test('CHOLE', 'cholesterol')
  end

  must "have correct sodium values in FOOD table" do
    run_nutrient_value_test('NA', 'sodium')
  end

  must "have correct potassium values in FOOD table" do
    run_nutrient_value_test('K', 'potassium')
  end

  must "have correct carbohydrate values in FOOD table" do
    run_nutrient_value_test('CHOCDF', 'carbohydrate')
  end

  must "have correct fiber values in FOOD table" do
    run_nutrient_value_test('FIBTG', 'fiber')
  end

  must "have correct sugars values in FOOD table" do
    run_nutrient_value_test('SUGAR', 'sugars')
  end

  must "have correct vitamin_a values in FOOD table" do
    run_nutrient_value_test('VITA_IU', 'vitamin_a')
  end

  must "have correct vitamin_c values in FOOD table" do
    run_nutrient_value_test('VITC', 'vitamin_c')
  end

  must "have correct calcium values in FOOD table" do
    run_nutrient_value_test('CA', 'calcium')
  end

  must "have correct iron values in FOOD table" do
    run_nutrient_value_test('FE', 'iron')
  end

  must "have correct vitamin_e values in FOOD table" do
    run_nutrient_value_test('TOCPHA', 'vitamin_e')
  end

  must "have correct vitamin_k values in FOOD table" do
    run_nutrient_value_test('VITK1', 'vitamin_k')
  end

  must "have correct thiamin values in FOOD table" do
    run_nutrient_value_test('THIA', 'thiamin')
  end

  must "have correct riboflavin values in FOOD table" do
    run_nutrient_value_test('RIBF', 'riboflavin')
  end

  must "have correct niacin values in FOOD table" do
    run_nutrient_value_test('NIA', 'niacin')
  end

  must "have correct vitamin_b6 values in FOOD table" do
    run_nutrient_value_test('VITB6A', 'vitamin_b6')
  end

  must "have correct folic_acid values in FOOD table" do
    run_nutrient_value_test('FOLAC', 'folic_acid')
  end

  must "have correct vitamin_b12 values in FOOD table" do
    run_nutrient_value_test('VITB12', 'vitamin_b12')
  end

  must "have correct pantothenic_acid values in FOOD table" do
    run_nutrient_value_test('PANTAC', 'pantothenic_acid')
  end

  must "have correct phosphorus values in FOOD table" do
    run_nutrient_value_test('P', 'phosphorus')
  end

  must "have correct magnesium values in FOOD table" do
    run_nutrient_value_test('MG', 'magnesium')
  end

  must "have correct zinc values in FOOD table" do
    run_nutrient_value_test('ZN', 'zinc')
  end

  must "have correct selenium values in FOOD table" do
    run_nutrient_value_test('SE', 'selenium')
  end

  must "have correct copper values in FOOD table" do
    run_nutrient_value_test('CU', 'copper')
  end

  must "have correct manganese values in FOOD table" do
    run_nutrient_value_test('MN', 'manganese')
  end

  def run_nutrient_value_test(tagname, column)
    ndb_numbers = random_ndb_numbers(10)
    ndb_numbers.each do |ndb_no|
      result = @db.get_first_row(REF_QUERY, [tagname, ndb_no])
      ref_val = result ? result[0] : nil
      result = @db.get_first_row("select #{column} from FOOD where ndb_number = ?", [ndb_no])
      test_val = result ? result[0] : nil
      assert_equal(ref_val, test_val, "Expected #{column} wrong")
    end
  end


  def random_ndb_numbers(count)
    all_ndb_numbers.sort_by{ rand }.slice(0..count)
  end

  def all_ndb_numbers
    @all_ndb_numbers ||= @db.execute('select ndb_no from FOOD_DES')
  end


end