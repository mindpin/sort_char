require 'spec_helper'

=begin 
  我们用17个字母构成的字符串来表示一个列表项的顺序位置
  A B C D E F G H I J K L M N O P Q
=end


describe SortChar::Generator do
  specify '补齐端点长度' do
    s = SortChar::Generator.new(nil, nil)
    expect(s.left).to eq('A') 
    expect(s.right).to eq('Q')

    s = SortChar::Generator.new(nil, 'I')
    expect(s.left).to eq('A')
    expect(s.right).to eq('I')

    s = SortChar::Generator.new('I', nil)
    expect(s.left).to eq('I')
    expect(s.right).to eq('Q')

    s = SortChar::Generator.new(nil, 'CI')
    expect(s.left).to eq('AA')
    expect(s.right).to eq('CI')

    s = SortChar::Generator.new('CI', 'D')
    expect(s.left).to eq('CI')
    expect(s.right).to eq('DQ')
  end

  specify '可以在空列表新增一项' do
    expect(SortChar::Generator.g(nil, nil)).to eq(SortChar::Generator.g('A', 'Q'))
    expect(SortChar::Generator.g(nil, nil)).to eq('I')
  end

  specify '可以在最前新增一项' do
    expect(SortChar::Generator.g(nil, 'I')).to eq(SortChar::Generator.g('A', 'I'))
    expect(SortChar::Generator.g(nil, 'I')).to eq('E')

    expect(SortChar::Generator.g(nil, 'E')).to eq(SortChar::Generator.g('A', 'E'))
    expect(SortChar::Generator.g(nil, 'E')).to eq('C')

    expect(SortChar::Generator.g(nil, 'C')).to eq(SortChar::Generator.g('A', 'C'))
    expect(SortChar::Generator.g(nil, 'C')).to eq('B')

    expect(SortChar::Generator.g(nil, 'B')).to eq(SortChar::Generator.g('A', 'B'))
    expect(SortChar::Generator.g(nil, 'B')).to eq('AI')

    expect(SortChar::Generator.g(nil, 'D')).to eq(SortChar::Generator.g('A',  'D'))
    expect(SortChar::Generator.g(nil, 'D')).to eq(SortChar::Generator.g('AA', 'DQ'))
    expect(SortChar::Generator.g(nil, 'D')).to eq('BI')
  end

  specify '可以在中间插入一项' do
    cases = [
      ['E', 'G', 'I'],
      ['E', 'F', 'G'],
      ['E', 'EI', 'F'],
      ['E', 'FI', 'H'],
      ['E', 'EE', 'FI'],
      ['E', 'EC', 'EE'],
      [nil, 'CB', 'EC']
    ]

    cases.each do |arr|
      l = arr[0]
      r = arr[2]

      expect(SortChar::Generator.g(l, r)).to eq(arr[1])
    end

  end
end