### 作用

将pcap流根据TCP五元组切分

### 使用方法

将"cut_flow.lua"和pcap文件放到"C:\Wireshark" 文件夹下，运行命令：

tshark -X lua_script:cut_flow.lua -r file_name.pcap

结果以<src, sport, dst, dport>的形式放置在文件夹中。