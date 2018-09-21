RSpec.describe ApplicationHelper, type: :helper do
  describe "#render_flash_messages" do
    it "should return div tag with flash value" do
      flash[:error] = Faker::Lorem.sentence
      expect(helper.render_flash_messages).to include("div", "error", flash[:error])
    end
  end
end
