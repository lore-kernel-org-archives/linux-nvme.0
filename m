From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Mon, 8 Jun 2015 14:44:35 +0000
Subject: nvme  single core performance question
In-Reply-To: <alpine.LNX.2.00.1506081330040.15930@localhost.lm.intel.com>
References: <682248939.6745169.1433715437812.JavaMail.yahoo@mail.yahoo.com>
 <alpine.LNX.2.00.1506081330040.15930@localhost.lm.intel.com>
Message-ID: <36F6EBABA23FEF4391AF72944D228901B6BFB06F@BBYEXM01.pmc-sierra.internal>

Keith/Alex

Would you be able to also generate some results with multiple threads? I am wondering if blk-mq had an adverse impact on single thread performance? I also have a system I can use to test a few other vendors' drives and if I can get time in the next couple of days I will do some testing.

BTW Alex was the drive natively formatted to 512B?

Cheers

Stephen

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Monday, June 8, 2015 7:41 AM
To: alex nln
Cc: linux-nvme at lists.infradead.org
Subject: Re: nvme single core performance question

On Sun, 7 Jun 2015, alex nln wrote:
> Hello list,
>
> I am testing Intel P3600 NVMe SSD and I experience performance
>
> degradation of 20% between kernels 3.16.0 and 4.0.5 in random
>
> read test on single core system.
>
> kernel                IOPS    BW         CPU (usr/sys)
>
> -------------------------------------------------------
>
> 4.0.5                 207K    103MB/s    32/68
> 3.16.0-34-generic     250K    124MB/s    39/61
>
> What possibly can cause such performance degradation?
>
> I use fio tool, random read of 512B blocks:
>
> [global]
> filename=/dev/nvme0n1
> ioengine=libaio
> direct=1
> buffered=0
> blocksize=512
> rw=randread
> iodepth=60
> numjobs=1
> time_based
> runtime=120
> norandommap
> refill_buffers
> group_reporting
>
> Kernel boot parameters: "idle=poll nosmp"
> I tested 4.0.5 with use_blk_mq=Y and use_blk_mq=N and receive same results.

As of 3.19, the nvme driver always uses blk-mq. That conversion is the single biggest driver difference between your two kernels. We ran various benchmarks prior to committing this and didn't measure significant performance difference between the two driver modes at the time, but I can't think of anything else right now to explain your observations. Will try your workload with "nosmp" on a few of my platforms and see what's happening.

_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
