# Licensed to Elasticsearch B.V. under one or more contributor
# license agreements. See the NOTICE file distributed with
# this work for additional information regarding copyright
# ownership. Elasticsearch B.V. licenses this file to you under
# the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

require "spec_helper"
require "logstash/settings"

describe LogStash::Setting::TimeValue do
  subject { described_class.new("option", "-1") }
  describe "#set" do
    it "should coerce the default correctly" do
      expect(subject.value).to eq(LogStash::Util::TimeValue.new(-1, :nanosecond).to_nanos)
    end

    context "when a value is given outside of possible_values" do
      it "should raise an ArgumentError" do
        expect { subject.set("invalid") }.to raise_error(ArgumentError)
      end
    end
    context "when a value is given as a time value" do
      it "should set the value" do
        subject.set("18m")
        expect(subject.value).to eq(LogStash::Util::TimeValue.new(18, :minute).to_nanos)
      end
    end

    context "when a value is given as a nanosecond" do
      it "should set the value" do
        subject.set(5)
        expect(subject.value).to eq(LogStash::Util::TimeValue.new(5, :nanosecond).to_nanos)
      end
    end
  end
end
