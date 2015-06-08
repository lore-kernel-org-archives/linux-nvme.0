From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Jun 2015 13:41:28 +0000 (UTC)
Subject: nvme  single core performance question
In-Reply-To: <682248939.6745169.1433715437812.JavaMail.yahoo@mail.yahoo.com>
References: <682248939.6745169.1433715437812.JavaMail.yahoo@mail.yahoo.com>
Message-ID: <alpine.LNX.2.00.1506081330040.15930@localhost.lm.intel.com>

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

As of 3.19, the nvme driver always uses blk-mq. That conversion is
the single biggest driver difference between your two kernels. We ran
various benchmarks prior to committing this and didn't measure significant
performance difference between the two driver modes at the time, but I
can't think of anything else right now to explain your observations. Will
try your workload with "nosmp" on a few of my platforms and see what's
happening.
