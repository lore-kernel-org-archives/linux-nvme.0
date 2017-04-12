From: keith.busch@intel.com (Keith Busch)
Date: Wed, 12 Apr 2017 11:02:28 -0400
Subject: [lkp-robot] [irq/affinity]  13c024422c:  fsmark.files_per_sec
 -4.3% regression
In-Reply-To: <20170412013328.GC31394@yexl-desktop>
References: <20170330171255.GF20181@localhost.localdomain>
 <20170412013328.GC31394@yexl-desktop>
Message-ID: <20170412150227.GD623@localhost.localdomain>

On Wed, Apr 12, 2017@09:33:28AM +0800, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed a -4.3% regression of fsmark.files_per_sec due to commit:
> 
> 
> commit: 13c024422cbb6dcc513667be9a2613b0f0de781a ("irq/affinity: Assign all CPUs a vector")
> url: https://github.com/0day-ci/linux/commits/Keith-Busch/irq-affinity-Assign-all-CPUs-a-vector/20170401-035036
> 
> 
> in testcase: fsmark
> on test machine: 72 threads Intel(R) Xeon(R) CPU E5-2699 v3 @ 2.30GHz with 128G memory
> with following parameters:
> 
> 	iterations: 8
> 	disk: 1SSD
> 	nr_threads: 4
> 	fs: btrfs
> 	filesize: 9B
> 	test_size: 16G
> 	sync_method: fsyncBeforeClose
> 	nr_directories: 16d
> 	nr_files_per_directory: 256fpd
> 	cpufreq_governor: performance
> 
> test-description: The fsmark is a file system benchmark to test synchronous write workloads, for example, mail servers workload.
> test-url: https://sourceforge.net/projects/fsmark/
> 
> 
> Details are as below:
> -------------------------------------------------------------------------------------------------->

This wasn't supposed to change anything if all the nodes have the same
number of CPU's. I've reached out to the 0-day team to get a little more
information on the before/after smp affinity settings to see how this
algorithm messed up the spread on this system.
