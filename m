From: yaolin@marvell.com (Yao Lin)
Date: Fri, 12 Oct 2018 15:37:49 +0000
Subject: [EXT] Re: bad IOPS when running multiple btest/fio in parallel
In-Reply-To: <20181012143921.GA15177@localhost.localdomain>
References: <1539319463418.78556@marvell.com>
 <20181012143921.GA15177@localhost.localdomain>
Message-ID: <40c7cf992ec34fc988534a60d2c1413b@SC-EXCH03.marvell.com>

I monitor the CPU usage during all these tests. I have a powerful CPU (i9-7940X) and none of its cores ever reach 80% load.

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Friday, October 12, 2018 7:39 AM
To: Yao Lin <yaolin at marvell.com>
Cc: linux-nvme at lists.infradead.org
Subject: [EXT] Re: bad IOPS when running multiple btest/fio in parallel

External Email

----------------------------------------------------------------------
On Fri, Oct 12, 2018@04:44:22AM +0000, Yao Lin wrote:
> Today I changed to a much simpler setup and the same issue persists.
> 
> Directly connect 2 PCs (identical hardware) with a pair of 100G rNICs. Create a null block device on the target PC and configure it as the NVMeOF target. So, there is no switch or SSD in this setup. And this is a single FIO, not the 4 FIO in parallel I mentioned earlier.
> 
> Start fio test against that null block device from the host, the best 
> IOPS is 1550K. That's the best IOPS after I try out many different QD, 
> # of job, and CPU affinity setting. Run the same fio test on the 
> target, I get 2250K IOPS (it jumps to 3650K when I increased the 
> number of threads). ?
> 
> So it seems to me that Linux NVMe stack is quite good and can support 100Gb/s + throughput. But the same can not be said of the NVMeOF stack. Any tuning possible?

You're sure it's the software stack? Need to check your CPU utilization to see if that's a possibility.
