require_relative '../../spec_helper'

RSpec.describe Degenerate::Generators::Integer do

  describe "#initialize" do
    generative do
      data(:generator) { described_class.new.to_data }

      it "returns an integer" do
        expect(generator.call).to be_a(Fixnum)
      end

      it "will never be greater than an imposed limit" do
        expect(generator.call).to be < described_class::INTEGER_MAX
      end

      it "will never be less than an imposed minimum" do
        expect(generator.call).to be > described_class::INTEGER_MIN
      end
    end

    describe "#initialize with a limit" do
      generative do
        let(:limit) { described_class.new.random_number(0).call }
        data(:generator) { described_class.new(limit).to_data }

        it "should never be greater than the limit" do
          expect(generator.call).to be < limit
        end

        it "should never be less than the opposite of the limit" do
          expect(generator.call).to be > -limit
        end
      end
    end

    describe "#to_data" do
      generative do
        data(:integer) { described_class.new }

        it "should return a proc" do
          expect(integer.to_data).to be_a(Proc)
        end
      end
    end

    describe "#random_number" do
      generative do
        let(:limit) { described_class.new.random_number(0).call }
        data(:int) { described_class.new }

        it "should be between INTEGER_MIN and INTEGER_MAX" do
          expect(int.random_number.call)
            .to be < described_class::INTEGER_MAX
          expect(int.random_number.call)
            .to be > described_class::INTEGER_MIN
        end

        data(:n_with_min) { int.random_number(limit).call }

        it "should be greater than the minimum" do
          expect(n_with_min).to be > limit
        end

        data(:n_with_max) { int.random_number(nil, limit).call }

        it "should be less than the maximum" do
          expect(n_with_max).to be < limit
        end
      end
    end
  end
end