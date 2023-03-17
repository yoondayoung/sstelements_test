import sst

# Define SST core options
sst.setProgramOption("timebase", "1ps")
sst.setProgramOption("stopAtCycle", "0 ns")

# Tell SST what statistics handling we want
sst.setStatisticLoadLevel(4)

memory_mb = 128

# Define the simulation components
comp_cpu = sst.Component("cpu", "miranda.BaseCPU")
comp_cpu.addParams({
	"verbose" : 0,
	"generator" : "miranda.GUPSGenerator",
	"generatorParams.verbose" : 0,
	"generatorParams.count" : 10000,
	"generatorParams.max_address" : ((memory_mb) / 2) * 1024 * 1024,
})

# Enable statistics outputs
comp_cpu.enableAllStatistics({"type":"sst.AccumulatorStatistic"})

comp_l1cache = sst.Component("l1cache", "memHierarchy.Cache")
comp_l1cache.addParams({
      "access_latency_cycles" : "2",
      "cache_frequency" : "2 Ghz",
      "replacement_policy" : "lru",
      "coherence_protocol" : "MESI",
      "associativity" : "4",
      "cache_line_size" : "64",
      "prefetcher" : "cassini.StridePrefetcher",
      "L1" : "1",
      "cache_size" : "8KB",
      "do_not_back" : 1
})

# Enable statistics outputs
comp_l1cache.enableAllStatistics({"type":"sst.AccumulatorStatistic"})

nvm_memory = sst.Component("memory", "memHierarchy.MemController")

nvm_mem_params = {
    "clock" : "1024 MHz",
   "network_bw" : "80GiB/s",
   "max_requests_per_cycle" : 1,
    "backend.mem_size" : "1024MB", 
    "do_not_back" : 1,
    "backend" : "memHierarchy.Messier",
    "backendConvertor.backend" : "memHierarchy.Messier",
    "backend.clock" : "1024 MHz",
    "backendConvertor.backend.clock" : "1024 MHz",
    "backendConvertor" : "memHierarchy.MemBackendConvertor", 
   "backend.device_count" : 1,
   "backend.link_count" : 4,
   "backend.vault_count" : 16,
   "backend.queue_depth" : 64,
   "backend.bank_count" : 16,
   "backend.dram_count" : 20,
   "backend.capacity_per_device" : 4, # Min is now 4 but we'll just use 1 of it
   "backend.xbar_depth" : 128,
   "backend.max_req_size" : 64,
   "backend.tag_count" : 512,
}

nvm_memory.addParams(nvm_mem_params)

messier_inst = sst.Component("NVMmemory", "Messier")

messier_params = {
	"clock" : "1 GHz",

}
messier_inst.addParams(messier_params)

messier_inst.addParams({
      "tCL" : "30",
      "tRCD" : "300",
      "clock" : "1GHz",
      "tCL_W" : "1000",
      "write_buffer_size" : "32",
      "flush_th" : "90",
      "num_banks" : "32",
      "max_outstanding" : "32",
      "max_current_weight" : "160",
      "read_weight" : "5",
      "write_weight" : "50",
      "max_writes" : 4
})


nvm_memory.addParams({
     "coherence_protocol" : "MESI",
     "backend.access_time" : "1000 ns",
     "backend.mem_size" : str(memory_mb * 1024 * 1024) + "B",
     "clock" : "1GHz"
})

nvm_memory.addParams(nvm_mem_params)

link_nvm_bus_link = sst.Link("link_nvm_bus_link")
link_nvm_bus_link.connect( (messier_inst, "bus", "50ps"), (nvm_memory, "cube_link", "50ps") )

# Define the simulation links
link_cpu_cache_link = sst.Link("link_cpu_cache_link")
link_cpu_cache_link.connect( (comp_cpu, "cache_link", "1000ps"), (comp_l1cache, "high_network_0", "1000ps") )
link_cpu_cache_link.setNoCut()

link_mem_bus_link = sst.Link("link_mem_bus_link")
link_mem_bus_link.connect( (comp_l1cache, "low_network_0", "50ps"), (nvm_memory, "direct_link", "50ps") )

opalParams = {
 "clock"				: "2GHz",
 "max_inst" 				: 32,
 "num_nodes"				: 1,
 "shared_mempools" 			: 1,
 "node0.cores"				: 8,
 "node0.clock" 				: "2GHz",
 "node0.allocation_policy"		: 1,
 "node0.latency"			: 2000,
 "node0.memory.start"			: 0,
 "node0.memory.size"			: 16384,
 "node0.memory.frame_size"		: 4,
 "node0.memory.mem_tech"		: 0,
#  "node1.cores"				: 8,
#  "node1.clock" 				: "2GHz",
#  "node1.allocation_policy"		: 1,
#  "node1.latency"			: 2000,
#  "node1.memory.start"			: 0,
#  "node1.memory.size"			: 16384,
#  "node1.memory.frame_size"		: 4,
#  "node1.memory.mem_tech"		: 0,
#  "node2.cores"				: 8,
#  "node2.clock" 				: "2GHz",
#  "node2.allocation_policy"		: 1,
#  "node2.latency"			: 2000,
#  "node2.memory.start"			: 0,
#  "node2.memory.size"			: 16384,
#  "node2.memory.frame_size"		: 4,
#  "node2.memory.mem_tech"		: 0,
#  "node3.cores"				: 8,
#  "node3.clock" 				: "2GHz",
#  "node3.allocation_policy"		: 1,
#  "node3.latency"			: 2000,
#  "node3.memory.start"			: 0,
#  "node3.memory.size"			: 16384,
#  "node3.memory.frame_size"		: 4,
#  "node3.memory.mem_tech"		: 0, 
 "shared_mem.mempool0.start"		: 1000000,
 "shared_mem.mempool0.size"		: 4194304,
 "shared_mem.mempool0.frame_size"	: 4,
 "shared_mem.mempool0.mem_type" 	: 1,
#  "shared_mem.mempool1.start"		: 101000000,
#  "shared_mem.mempool1.size"		: 4194304,
#  "shared_mem.mempool1.frame_size"	: 4,
#  "shared_mem.mempool1.mem_type" 	: 1,
#  "shared_mem.mempool2.start"		: 201000000,
#  "shared_mem.mempool2.size"		: 4194304,
#  "shared_mem.mempool2.frame_size"	: 4,
#  "shared_mem.mempool2.mem_type" 	: 1,
#  "shared_mem.mempool3.start"		: 301000000,
#  "shared_mem.mempool3.size"		: 4194304,
#  "shared_mem.mempool3.frame_size"	: 4,
#  "shared_mem.mempool3.mem_type" 	: 1,
}