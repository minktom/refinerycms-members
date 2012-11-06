# encoding: utf-8
require "spec_helper"

describe Refinery do
  describe "MemberGroups" do
    describe "Admin" do
      describe "member_groups" do
        login_refinery_user

        describe "member_groups list" do
          before do
            FactoryGirl.create(:member_group, :name => "UniqueTitleOne")
            FactoryGirl.create(:member_group, :name => "UniqueTitleTwo")
          end

          it "shows two items" do
            visit refinery.member_groups_admin_member_groups_path
            page.should have_content("UniqueTitleOne")
            page.should have_content("UniqueTitleTwo")
          end
        end

        describe "create" do
          before do
            visit refinery.member_groups_admin_member_groups_path

            click_link "Add New Member Group"
          end

          context "valid data" do
            it "should succeed" do
              fill_in "Name", :with => "This is a test of the first string field"
              click_button "Save"

              page.should have_content("'This is a test of the first string field' was successfully added.")
              Refinery::MemberGroups::MemberGroup.count.should == 1
            end
          end

          context "invalid data" do
            it "should fail" do
              click_button "Save"

              page.should have_content("Name can't be blank")
              Refinery::MemberGroups::MemberGroup.count.should == 0
            end
          end

          context "duplicate" do
            before { FactoryGirl.create(:member_group, :name => "UniqueTitle") }

            it "should fail" do
              visit refinery.member_groups_admin_member_groups_path

              click_link "Add New Member Group"

              fill_in "Name", :with => "UniqueTitle"
              click_button "Save"

              page.should have_content("There were problems")
              Refinery::MemberGroups::MemberGroup.count.should == 1
            end
          end

        end

        describe "edit" do
          before { FactoryGirl.create(:member_group, :name => "A name") }

          it "should succeed" do
            visit refinery.member_groups_admin_member_groups_path

            within ".actions" do
              click_link "Edit this member group"
            end

            fill_in "Name", :with => "A different name"
            click_button "Save"

            page.should have_content("'A different name' was successfully updated.")
            page.should have_no_content("A name")
          end
        end

        describe "destroy" do
          before { FactoryGirl.create(:member_group, :name => "UniqueTitleOne") }

          it "should succeed" do
            visit refinery.member_groups_admin_member_groups_path

            click_link "Remove this member group forever"

            page.should have_content("'UniqueTitleOne' was successfully removed.")
            Refinery::MemberGroups::MemberGroup.count.should == 0
          end
        end

      end
    end
  end
end
