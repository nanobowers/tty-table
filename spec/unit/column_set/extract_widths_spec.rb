# coding: utf-8

require 'spec_helper'

RSpec.describe TTY::Table::ColumnSet, '#extract_widths' do
  it 'extract widths' do
    header = ['h1', 'h2', 'h3']
    rows   = [['a1', 'a2', 'a3'], ['b1', 'b2', 'b3']]
    table = TTY::Table.new header, rows
    column_set = TTY::Table::ColumnSet.new(table)
    expect(column_set.extract_widths).to eql([2,2,2])
  end

  it "extracts widths from utf" do
    header = ['h1', 'うなじ']
    rows   = [['こんにちは', 'a2'], ['b1','選択']]
    table  = TTY::Table.new header, rows
    column_set = TTY::Table::ColumnSet.new(table)
    expect(column_set.extract_widths).to eql([10,6])
  end

  it "extracts widths from multiline text" do
    table = TTY::Table.new
    table << ["Multi\nLine\nContent", "Text\nthat\nwraps"]
    table << ["Some\nother\ntext", 'Simple']
    column_set = TTY::Table::ColumnSet.new(table)
    expect(column_set.extract_widths).to eq([7,6])
  end

  it "extracts widths from multiline text" do
    table = TTY::Table.new
    table << ["Multi\\nLine\\nContent", "Text\\nthat\\nwraps"]
    table << ["Some\\nother\\ntext", 'Simple']
    column_set = TTY::Table::ColumnSet.new(table)
    expect(column_set.extract_widths).to eq([20, 17])
  end
end
