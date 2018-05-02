require File.join(File.dirname(__FILE__), 'spec_helper')

describe RDF::Digest do
  let(:nt) { RDF::Graph.load(fixture_path('doap.nt')) }
  let(:ttl) { RDF::Graph.load(fixture_path('doap.ttl'), format:  :ttl) }

  it "runs at all" do
    nt_hash = described_class.hash(nt)
    puts "nt_hash: #{nt_hash}"
    expect(nt_hash).to be
    ttl_hash = described_class.hash(ttl)
    puts "ttl_hash: #{ttl_hash}"
    expect(nt_hash).to eql ttl_hash
  end
end