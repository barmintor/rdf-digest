require File.join(File.dirname(__FILE__), 'spec_helper')

describe RDF::Digest do
  let(:nt) { RDF::Graph.load(fixture_path('doap.nt')) }
  let(:ttl) { RDF::Graph.load(fixture_path('doap.ttl'), format:  :ttl) }
  let(:simplettl) { RDF::Graph.load(fixture_path('supersimple.ttl'), format: :ttl) }
  let(:simpletxt) { File.read(fixture_path('supersimple.txt')) }

  it "runs at all" do
    nt_hash = described_class.hash(nt)
    puts "nt_hash: #{nt_hash}"
    expect(nt_hash).to be
    ttl_hash = described_class.hash(ttl)
    puts "ttl_hash: #{ttl_hash}"
    expect(nt_hash).to eql ttl_hash
    simple_string = described_class.get_graph_string(simplettl)
    puts "simple_string: #{simple_string}"
    expect(simple_string).to eql simpletxt
    simple_hash = described_class.hash(simplettl)
    puts "simple hash #{simple_hash}"
  end
end