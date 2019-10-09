require 'graphite-api'

module Ring
class SQA

  class Graphite
    #ROOT = "nlnog.ring_sqa.#{CFG.afi}"
    ROOT = "#{CFG.graphite.root}.#{CFG.afi}"

    def add records
      host = @hostname.split(".").first
      node =  @nodes.all
      records.each do |record|
        nodename = noderec = node[record.peer][:name].split(".").first
        nodecc = noderec = node[record.peer][:cc].downcase
        hash = {
        }
        if record.result != 'no response'
          hash["#{ROOT}.#{host}.#{nodecc}.#{nodename}.latency"] = record.latency
          hash["#{ROOT}.#{host}.#{nodecc}.#{nodename}.state"] = 1.0
        else
          hash["#{ROOT}.#{host}.#{nodecc}.#{nodename}.state"] = 0.0
        end
        @client.metrics hash, record.time
      end
    end

    private
    
    def initialize nodes, server=CFG.graphite.server
      @client = GraphiteAPI.new graphite: server
      @hostname = Ring::SQA::CFG.host.name
      @nodes = nodes
    end
  end

end
end
