From: keith.busch@intel.com (Keith Busch)
Date: Thu, 13 Oct 2016 10:44:34 -0400
Subject: Scalability issue with multiple NVMe Devices with one core
In-Reply-To: <5db865d2-3698-b621-8511-a996499d66bf@mellanox.com>
References: <50e02652-9e54-c314-6551-cd3075ccb005@mellanox.com>
 <20161013141820.GA17823@localhost.localdomain>
 <5db865d2-3698-b621-8511-a996499d66bf@mellanox.com>
Message-ID: <20161013144433.GB17823@localhost.localdomain>

On Thu, Oct 13, 2016@05:11:58PM +0300, Roy Shterman wrote:
> On 10/13/2016 5:18 PM, Keith Busch wrote:
> > On Thu, Oct 13, 2016@08:44:37AM +0300, Roy Shterman wrote:
> > > scenario is when running traffic over 1 NVMe Device with 1 core I'm getting
> > > X IOPS and Y% core utilization.
> > > 
> > > In my perception, when adding more NVMe Devices I should see some linearity
> > > of the above results, but I'm getting only a small improvement in IOPS and
> > > still not getting 100% (or closer ) in CPU utilization.
> > > 
> > > Any suggestions?
> > How are you generating IO?
> 
> fio --group_reporting --rw=randread --bs=4k --numjobs=1 --ramp_time=30
> --iodepth=1 --runtime=300 --direct=1 --time_based --loops=1
> --ioengine=libaio --invalidate=1 --randrepeat=1 --norandommap --exitall
> --name task_nvme0n1 --filename=/dev/nvme0n1

And if you append "--name task_nvme1n1 --filename=/dev/nvme1n1" to this
command, you are not observing a meaningful IOPS improvement?
