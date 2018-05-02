# frozen_string_literal: true
require 'digest'
require 'rdf'

module RDF::Digest
  A_S = '{'
  W_S = '}'
  A_P = '('
  W_P = ')'
  A_O = '['
  W_O = ']'
  B = :'*'

  # Implement the in-memory graph hashing algorithm described by
  # Höfig/Schieferdecker in "Hashing of RDF Graphs and a Solution to the Blank Node Problem".
  # http://ceur-ws.org/Vol-1259
  def self.hash(graph)
    subject_strings = []
    graph.subjects(unique: true).each do |subject|
      visited_nodes = []
      subject_string = encode_subject(subject, visited_nodes, graph)
      subject_strings << subject_string if subject_string
    end
    string_data = subject_strings.sort.inject(String.new) do |collector, subject_string|
      collector << A_S << subject_string << W_S
    end
    # return a SHA-256 hash of utf-8
    unless string_data.encoding == Encoding::UTF_8
      converter = Encoding::Converter.new(string_data.encoding, "UTF-8")
      string_data = converter.convert(string_data)
    end
    ::Digest::SHA256.hexdigest(string_data)
  end

  def self.encode_subject(subject, visited_nodes, graph)
    result = String.new
    if subject.is_a? RDF::Node
      # blank node handling
      return nil if visited_nodes.include? subject
      visited_nodes << subject
      result << B.to_s
    else
      result << subject.to_s
    end
    result << encode_properties(subject, visited_nodes, graph)
  end

  def self.encode_properties(subject, visited_nodes, graph)
    predicates = predicates(subject, graph).sort
    result = String.new
    predicates.each do |predicate|
      result << A_P << predicate
      object_strings = []
      graph.query([subject, predicate, :o]).each do |statement|
        object_string = encode_object(statement.object, visited_nodes, graph)
        object_strings << object_string if object_string
      end
      object_strings.sort!
      object_strings.each do |object_string|
        result << A_O << object_string << W_O
      end
      result << W_P
    end
    result
  end

  def self.predicates(subject, graph)
    graph.query([subject, :p,:o]).map(&:predicate)
  end

  def self.encode_object(object, visited_nodes, graph)
    if object.node?
      return encode_subject(object, visited_nodes, graph)
    elsif object.literal?
      return object.to_base
    else
      return object.to_s
    end
  end
end
