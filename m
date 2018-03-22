From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Mar 2018 16:02:25 -0600
Subject: [GIT PULL] nvme fix for 4.16-rc6
In-Reply-To: <71eda309-fa4a-7641-9292-fcc6c77d44af@kernel.dk>
References: <20180316160110.GC720@localhost.localdomain>
 <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>
 <20180316161655.GA13293@lst.de>
 <8734416c-cd14-8bfb-8e2c-6eab84e0ce5d@kernel.dk>
 <20180321205958.GH12909@localhost.localdomain>
 <dc2798b4-5654-9fc3-444e-efbce5775ca4@kernel.dk>
 <e8fecf76-08db-154b-fcfb-b15acbc7acac@kernel.dk>
 <20180322210917.GK12909@localhost.localdomain>
 <71eda309-fa4a-7641-9292-fcc6c77d44af@kernel.dk>
Message-ID: <20180322220224.GL12909@localhost.localdomain>

On Thu, Mar 22, 2018@03:32:45PM -0600, Jens Axboe wrote:
> There seems to be some mismatch. nvme6q7 is 244:
> 
> # cat /proc/irq/244/smp_affinity_list 
> 49,51,53,55,57,59,61,63
> 
> and 243 is nvme6q6:
> 
> # cat /proc/irq/243/smp_affinity_list 
> 17,19,21,23,41,43,45,47
> 
> 244 has never triggered, if I do:
> 
> # taskset -c 17 dd if=/dev/nvme6n1 of=/dev/null bs=4k iflag=direct count=1
> 
> then look at interrupts, none of the nvme6 associated interrupts have
> triggered.

Thanks, got it now: blk_mq_pci_map_queues() doesn't take pre_vectors into
account, nor is there a way for it to know even about them. Some queues,
then, get interrupt affinity assigned to "possible" CPUs that aren't
online.

This approach will definitely need some more. Sorry for the trouble.
