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

	context 'with mails having multi-line headers' do
		let :box do
			Mbox.open(File.join(fixtures_dir, 'multiline-header.mbox'))
		end

		it 'finds one mail' do
			expect(box.size).to eq(1)
		end

		context 'in the first mail' do
			context 'header' do
				let :headers do
					box[0].headers
				end

				it 'has Subject' do
					expect(headers[:subject]).not_to be_nil
					expect(headers[:subject].toutf8).to eq('This mail has multi-line Subject header since it\'s very very long')
				end

				it 'has From' do
					expect(headers[:from]).to eq('Deep Meaning Quotes <deep-meaning-quotes@example.com>')
				end
			end

			context 'body' do
				let :body do
					box[0].content[0].content
				end

				it 'has body text' do
					expect(body).to eq('Penguins do not live in the North Pole.')
				end
			end
		end
	end
end
