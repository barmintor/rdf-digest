# RDF::Digest

An implementation of the graph hashing algorithm described by Höfig/Schieferdecker in "Hashing of RDF Graphs and a Solution to the Blank Node Problem".

http://ceur-ws.org/Vol-1259

## Example Usage

```ruby
graph = RDF::Graph.load("spec/data/doap.nt")
graph_digest = RDF::Digest.hash(graph)
```

## Known Issues

Chaos ensues when you name a module `Hash`, so we're abusing the term "Digest"