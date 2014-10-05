From: Indranil.Bhattacharya@netapp.com (Bhattacharya, Indranil)
Date: Sun, 5 Oct 2014 14:23:53 +0000
Subject: 4K writes on nvme device vs that on ext4 running on nvme block
 device
In-Reply-To: <542BB9FC.5090507@bjorling.me>
References: <eedf708ac5b545a2b26ee81b60dd49d3@hioexcmbx06-prd.hq.netapp.com>
 <542BB9FC.5090507@bjorling.me>
Message-ID: <fc4485778d044a1cafdcc94538456580@hioexcmbx06-prd.hq.netapp.com>

Thanks Matias. I don't see much difference in your tests between the two. I used 16 threads in FIO. If you increase the number of threads, do you get a larger difference?

-Indranil

> -----Original Message-----
> From: Matias Bj?rling [mailto:m at bjorling.me]
> Sent: 01 October 2014 13:53
> To: linux-nvme at lists.infradead.org; Bhattacharya, Indranil
> Subject: Re: 4K writes on nvme device vs that on ext4 running on nvme block device
> 
> On 10/01/2014 08:41 AM, Bhattacharya, Indranil wrote:
> > Hi,
> >
> > I was recently doing some experiments using the nvme emulator (nvmeqemu) and I observed a curious thing. There was a
> marked degradation in write-throughput when I run FIO (multithreaded, O_DIRECT writes) on an ext4 filesystem that has been
> created on top of a nvme block device; as compared to the same tests which run directly on the nvme block device (i.e. without the
> filesystem in between).
> >
> > I plan to repeat this test on a real nvme device as soon as I get one, but some insight from others on the following questions will
> be helpful:
> >
> > 	1) Have others seen the same on a real nvme device?
> 
> Here's my results from an Intel DC P3700. 4k Random Writes, libaio, qdepth 16 and two jobs.
> 
> Plain
> 
> 112.556 IOPS
> ~140us completion time
> 
> With ext4
> 
> 112.267 IOPS
> ~140us completion time
> 
> > 	2) If yes, any possible explanation for the same?
> 
> ext4 does some background work in the beginning if lazy inode table init and lazy journal init have been enabled during mkfs. This
> might be what influence your results.
