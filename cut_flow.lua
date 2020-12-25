local getTcpStream =Field.new("tcp.stream")
local getSrcIp =Field.new("ip.src")
local getDstIp =Field.new("ip.dst")
local getSrcPort =Field.new("tcp.srcport")
local getDstPort =Field.new("tcp.dstport")
local getIpVersion =Field.new("ip.version")
 
local tcpStreamTable = {}--每一条流的索引哈希表
local dataWriterTable = {}--每一条流的dumper
 
do
    local function packet_listener()
        --local tap =Listener.new("frame", "tcp.port == 10004")
        --local tap =Listener.new("frame")
        local tap =Listener.new()
        --frame是监听器的名称，tcp是wireshark过滤器规则
             
        function tap.reset()
            print("tap reset")
        end
             
        function tap.packet(pinfo,tvb)
            --回调函数，每收到一个包执行一次。
                     local tcpStream = getTcpStream()
                     local srcIp = getSrcIp()
                     local dstIp = getDstIp()
                     local srcPort = getSrcPort()
                     local dstPort = getDstPort()
                     local ipVersion = getIpVersion()
                     local tcpStreamNumber =tonumber(tostring(tcpStream))
                    
                     if(tcpStreamTable[tcpStreamNumber])
                     then
                            dataWriterTable[tcpStreamNumber]:dump_current()
                            --print("hhhh")
                            --print("hhhh")
                     else
                            local packetTuple4 =tostring(tcpStream).."_"..tostring(srcIp).."_"..tostring(srcPort).."_"..tostring(dstIp).."_"..tostring(dstPort).."_"..tostring(ipVersion)..".pcap"
                            --print(packetTuple4)
                            tcpStreamTable[tcpStreamNumber] =tcpStream
                            dataWriterTable[tcpStreamNumber] =Dumper.new("test2/"..packetTuple4)
                            dataWriterTable[tcpStreamNumber]:dump_current()
                            --dumper:flush()
                     --print(type(tcpStreamTable[tcpStreamNumber]),type(tcpStreamNumber),type(dataWriterTable[tcpStreamNumber]),type(tcpStreamTable))
                     end
        end
             
        function tap.draw()
            --结束执行
            print("tap.draw")
        end
    end
       --监听报文
    packet_listener()
       --tcpStreamTable =nil
end