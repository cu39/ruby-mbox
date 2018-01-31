# coding: utf-8
require 'mbox'
require 'kconv'

describe Mbox do
	let :base_dir do
		File.dirname(File.expand_path(__FILE__))
	end
	let :fixtures_dir do
		File.join(base_dir, 'fixtures')
	end
	
	context 'with ISO-2022-JP encoded mails' do
		let :box do
			Mbox.open(File.join(fixtures_dir, 'iso-2022-jp.mbox'))
		end

		it 'finds three mails' do
			expect(box.size).to eq(3)
		end

		context 'all mail' do
			it 'has Subject header' do
				box.each do |m|
					expect(m.headers[:subject]).not_to be_nil
					expect(m.headers[:subject].toutf8).to eq(' 我輩は猫である')
				end
			end

			it 'has From header' do
				box.each do |m|
					expect(m.headers[:from]).not_to be_nil
					expect(m.headers[:from].toutf8).to eq('夏目漱石 <daemon@example.com>')
				end
			end
		end
	end
end
