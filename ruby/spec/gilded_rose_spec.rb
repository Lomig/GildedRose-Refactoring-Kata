require_relative "../gilded_rose.rb"

describe GildedRose do
  before(:all) { `ruby spec/texttest_fixture.rb 100 > test.txt` }
  after(:all)  { `rm test.txt` }

  describe "#update_quality" do
    xit "has no regression" do
      expected = "spec/100_updates_expected_results.txt"
      actual = "test.txt"

      expect(IO.read(actual)).to eq IO.read(expected)
    end

    context "with a common object" do
      let(:sell_in_date) { 14 }
      let(:quality) { 10 }
      let(:item) { Item.new("foo", sell_in_date, quality) }

      context "when the sell by date has not passed" do
        it "ages 1 day" do
          GildedRose.new([item]).update_quality
          expect(item.sell_in).to eq 13
        end

        it "loses 1 quality" do
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 9
        end
      end

      context "when the sell by date has passed" do
        let(:sell_in_date) { 0 }

        it "ages 1 day" do
          GildedRose.new([item]).update_quality
          expect(item.sell_in).to eq -1
        end

        it "loses 2 quality" do
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 8
        end
      end

      context "when quality is 0" do
        let(:quality) { 0 }

        it "ages 1 day" do
          GildedRose.new([item]).update_quality()
          expect(item.sell_in).to eq 13
        end

        it "doest not lose quality anymore" do
          GildedRose.new([item]).update_quality()
          expect(item.quality).to eq 0
        end
      end
    end

    context "with Aged Brie" do
      let(:item) { Item.new("Aged Brie", sell_in_date, quality) }

      context "when before or at the sell by date" do
        let(:sell_in_date) { 8 }

        context "and quality is below 50" do
          let(:quality) { 10 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 7
          end

          it "gains 1 quality" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 11
          end
        end

        context "and quality is at 50" do
          let(:quality) { 50 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 7
          end

          it "does not gain any quality anymore" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 50
          end
        end
      end

      context "when after the sell by date" do
        let(:sell_in_date) { 0 }

        context "and quality is below 50" do
          let(:quality) { 10 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq -1
          end

          it "gains 2 quality" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 12
          end
        end

        context "and quality is at 49" do
          let(:quality) { 49 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq -1
          end

          it "does not gain any quality anymore" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 50
          end
        end

        context "and quality is at 50" do
          let(:quality) { 50 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq -1
          end

          it "does not gain any quality anymore" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 50
          end
        end
      end
    end

    context "with Sulfuras" do
      let(:item) { Item.new("Sulfuras, Hand of Ragnaros", 8, 40) }

      it "is not to be sold" do
        GildedRose.new([item]).update_quality
        expect(item.sell_in).to eq 8
      end

      it "does not decay in quality" do
        GildedRose.new([item]).update_quality
        expect(item.quality).to eq 40
      end
    end

    context "with Backstage passes" do
      let(:sell_in_date) { 11 }
      let(:quality) { 30 }
      let(:item) { Item.new("Backstage passes to a TAFKAL80ETC concert", sell_in_date, quality) }

      context "when > 10 days before the sell by date" do
        context "and quality < 50" do
          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 10
          end

          it "gains 1 quality" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 31
          end
        end

        context "and quality is at 50" do
          let(:quality) { 50 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 10
          end

          it "does not gain any quality anymore" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 50
          end
        end
      end
      context "when > 5 and <= 10 days before the sell by date" do
        let(:sell_in_date) { 6 }

        context "and quality < 50" do
          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 5
          end

          it "gains 2 quality" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 32
          end
        end

        context "and quality is at 49" do
          let(:quality) { 49 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 5
          end

          it "does not gain any quality anymore" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 50
          end
        end

        context "and quality is at 50" do
          let(:quality) { 50 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 5
          end

          it "does not gain any quality anymore" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 50
          end
        end
      end
      context "when <= 5 days before the sell by date" do
        let(:sell_in_date) { 3 }

        context "and quality < 50" do
          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 2
          end

          it "gains 3 quality" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 33
          end
        end

        context "and quality is at 48" do
          let(:quality) { 48 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 2
          end

          it "does not gain any quality anymore" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 50
          end
        end

        context "and quality is at 49" do
          let(:quality) { 49 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 2
          end

          it "does not gain any quality anymore" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 50
          end
        end

        context "and quality is at 50" do
          let(:quality) { 50 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 2
          end

          it "does not gain any quality anymore" do
            GildedRose.new([item]).update_quality
            expect(item.quality).to eq 50
          end
        end
      end
      context "when after the sell by date" do
        let(:sell_in_date) { 0 }

        it "ages 1 day" do
          GildedRose.new([item]).update_quality
          expect(item.sell_in).to eq -1
        end

        it "has a quality of 0" do
          GildedRose.new([item]).update_quality
          expect(item.quality).to eq 0
        end
      end
    end

    xcontext "with a Conjured item" do
      let(:sell_in_date) { 25 }
      let(:item) { Item.new("Conjured mana bottle", sell_in_date, quality) }

      context "when the sell by date has not passed" do
        context "and quality >= 2" do
          let(:quality) { 30 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 24
          end

          it "loses 2 quality" do
            GildedRose.new([item]).update_quality()
            expect(item.quality).to eq 28
          end
        end

        context "and quality = 1" do
          let(:quality) { 1 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 24
          end

          it "cannot go below 0 quality" do
            GildedRose.new([item]).update_quality()
            expect(item.quality).to eq 0
          end
        end

        context "and quality = 0" do
          let(:quality) { 0 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality
            expect(item.sell_in).to eq 24
          end

          it "cannot go below 0 quality" do
            GildedRose.new([item]).update_quality()
            expect(item.quality).to eq 0
          end
        end
      end

      context "when the sell by date has passed" do
        let(:sell_in_date) { 0 }

        context "and quality >= 4" do
          let(:quality) { 30 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality()
            expect(item.sell_in).to eq -1
          end

          it "loses 4 quality" do
            GildedRose.new([item]).update_quality()
            expect(item.quality).to eq 26
          end
        end

        context "and quality = 3" do
          let(:quality) { 3 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality()
            expect(item.sell_in).to eq -1
          end

          it "cannot go below 0 quality" do
            GildedRose.new([item]).update_quality()
            expect(item.quality).to eq 0
          end
        end

        context "and quality = 2" do
          let(:quality) { 2 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality()
            expect(item.sell_in).to eq -1
          end

          it "cannot go below 0 quality" do
            GildedRose.new([item]).update_quality()
            expect(item.quality).to eq 0
          end
        end

        context "and quality = 1" do
          let(:quality) { 1 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality()
            expect(item.sell_in).to eq -1
          end

          it "cannot go below 0 quality" do
            GildedRose.new([item]).update_quality()
            expect(item.quality).to eq 0
          end
        end

        context "and quality = 0" do
          let(:quality) { 0 }

          it "ages 1 day" do
            GildedRose.new([item]).update_quality()
            expect(item.sell_in).to eq -1
          end

          it "cannot go below 0 quality" do
            GildedRose.new([item]).update_quality()
            expect(item.quality).to eq 0
          end
        end
      end
    end
  end

end
