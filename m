From: keith.busch@intel.com (Keith Busch)
Date: Wed, 4 Apr 2018 20:48:51 -0600
Subject: NVMe and IRQ Affinity, another problem
In-Reply-To: <18F290A8-40B0-4680-985D-5005D0892192@northwestern.edu>
References: <388F2D0B-537F-4884-91F0-CD562F33C639@northwestern.edu>
 <20180405010037.GA10098@localhost.localdomain>
 <18F290A8-40B0-4680-985D-5005D0892192@northwestern.edu>
Message-ID: <20180405024851.GE10098@localhost.localdomain>

On Thu, Apr 05, 2018@02:31:21AM +0000, Young Yu wrote:
> Thank you for the quick reply Keith,
> 
> nr_cpus=24 kernel parameter definitely has limited the present CPU and
> helped spread the queues to the interrupt.
> 
> If you could forgive me asking another question, the admin queue, and 
> half of the I/O queues of all NVMe devices are allocated to cores in a 
> NUMA nodes ( in my case it is NUMA 0 as admin queue wants to stay
> in the CPU0), and the other half of the I/O queues are allocated with 
> the other, even if they are attached to either one of them. This is 
> regardless of whether they are attached to NUMA 0 or 1.
> 
> I?m trying to read from the NVMe devices and send them to the NIC, 
> and they both are attached to the same NUMA node (1). Is it possible 
> to manually bind the first half of nvme8 so they all belongs to the cores 
> in the same NUMA node so I can avoid accessing them using slow QPI 
> between NUMA nodes? (or maybe exclude ones with admin queue 
> because there will be a patch to separate the admin queue and the I/O 
> queue soon) 

If you are getting interrupts on NUMA node 0, that means your request
originated from a thread running on a CPU in NUMA node 0. If you want
interrupts to wake up a CPU in NUMA node 1, you'll need to pin your IO
submission processes to the CPUs in that node.
