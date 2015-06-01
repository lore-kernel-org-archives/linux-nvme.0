From: mlin@kernel.org (Ming Lin)
Date: Mon, 01 Jun 2015 15:52:51 -0700
Subject: NVMe scalability issue
Message-ID: <1433199171.7699.22.camel@ssi>

Hi list,

I'm playing with 8 high performance NVMe devices on a 4 sockets server.
Each device can get 730K 4k read IOPS.

Kernel: 4.1-rc3
fio test shows it doesn't scale well with 4 or more devices.
I wonder any possible direction to improve it.

devices		theory		actual
		IOPS(K)		IOPS(K)
-------		-------		-------
1		733		733
2		1466		1446.8
3		2199		2174.5
4		2932		2354.9
5		3665		3024.5
6		4398		3818.9
7		5131		4526.3
8		5864		4621.2

And a graph here:
http://minggr.net/pub/20150601/nvme-scalability.jpg


With 8 devices, CPU is still 43% idle, so CPU is not the bottleneck.

"top" data

Tasks: 565 total,  30 running, 535 sleeping,   0 stopped,   0 zombie
%Cpu(s): 17.5 us, 39.2 sy,  0.0 ni, 43.3 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
KiB Mem:  52833033+total,  3103032 used, 52522732+free,    18472 buffers
KiB Swap:  7999484 total,        0 used,  7999484 free.  1506732 cached Mem

"perf top" data

   PerfTop:  124581 irqs/sec  kernel:78.6%  exact:  0.0% [4000Hz cycles],  (all, 48 CPUs)
-----------------------------------------------------------------------------------------

     3.30%  [kernel]       [k] do_blockdev_direct_IO      
     2.99%  fio            [.] get_io_u                   
     2.79%  fio            [.] axmap_isset                
     2.40%  [kernel]       [k] irq_entries_start          
     1.91%  [kernel]       [k] _raw_spin_lock             
     1.77%  [kernel]       [k] nvme_process_cq            
     1.73%  [kernel]       [k] _raw_spin_lock_irqsave     
     1.71%  fio            [.] fio_gettime                
     1.33%  [kernel]       [k] blk_account_io_start       
     1.24%  [kernel]       [k] blk_account_io_done        
     1.23%  [kernel]       [k] kmem_cache_alloc           
     1.23%  [kernel]       [k] nvme_queue_rq              
     1.22%  fio            [.] io_u_queued_complete       
     1.14%  [kernel]       [k] native_read_tsc            
     1.11%  [kernel]       [k] kmem_cache_free            
     1.05%  [kernel]       [k] __acct_update_integrals    
     1.01%  [kernel]       [k] context_tracking_exit      
     0.94%  [kernel]       [k] _raw_spin_unlock_irqrestore
     0.91%  [kernel]       [k] rcu_eqs_enter_common       
     0.86%  [kernel]       [k] cpuacct_account_field      
     0.84%  fio            [.] td_io_queue  

fio script

[global]
rw=randread
bs=4k
direct=1
ioengine=libaio
iodepth=64
time_based
runtime=60
group_reporting
numjobs=4

[job0]
filename=/dev/nvme0n1

[job1]
filename=/dev/nvme1n1

[job2]
filename=/dev/nvme2n1

[job3]
filename=/dev/nvme3n1

[job4]
filename=/dev/nvme4n1

[job5]
filename=/dev/nvme5n1

[job6]
filename=/dev/nvme6n1

[job7]
filename=/dev/nvme7n1
