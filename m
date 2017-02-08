From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 8 Feb 2017 11:58:59 +0200
Subject: [PATCHv1] nvmet-rdma: Support 16K worth of inline data for write
 commands
In-Reply-To: <1486507882-23688-1-git-send-email-parav@mellanox.com>
References: <1486507882-23688-1-git-send-email-parav@mellanox.com>
Message-ID: <87f64c8b-efe1-9d74-a582-28c4184525f9@grimberg.me>

> This patch allows supporting 16Kbytes of inline data for write commands.
>
> With null target below are the performance improvements achieved.
> Workload: random write, 70-30 mixed IOs
> null target: 250GB, 64 core CPU, single controller.
> Queue depth: 256 commands
>
>            cpu idle %        iops (K)            latency (usec)
>            (higher better)   (higher better)     (lower better)
>
> Inline     16K       4K      16K       4K        16K       4K
> size
> io_size    random write      random write        random write
> 512        78        79      2349      2343      5.45      5.45
> 1K         78        78      2438      2417      5.78      5.29
> 2K         78        78      2437      2387      5.78      5.35
> 4K         78        79      2332      2274      5.75      5.62
> 8K         78        87      1308      711       11        21.65
> 16K        79        90      680       538       22        28.64
> 32K        80        95      337       333       47        47.41
>
>            mix RW-30/70      mix RW-30/70        mix RW-30/70
> 512        78        78      2389      2349      5.43      5.45
> 1K         78        78      2250      2354      5.61      5.42
> 2K         79        78      2261      2294      5.62      5.60
> 4K         77        78      2180      2131      5.8       6.28
> 8K         78        79      1746      797       8.5       18.42
> 16K        78        86      943       628       15.90     23.76
> 32K        92        92      440       440       32        33.39
>
> This is tested with modified Linux initiator that can support
> 16K worth of inline data.
> Applications which has typical 8K or 16K block size will benefit most
> out of this performance improvement.
>
> Additionally when IOPs are throttled to 700K IOPs, cpu utilization and
> latency numbers are same for both the inline size;
> confirming that higher inline size is not consuming any extra CPU
> for serving same number of IOPs.
>
>            cpu idle %        iops (K)            latency (usec)
>            (higher better)   (higher better)     (lower better)
>
> Inline     16K       4K      16K       4K       16K        4K
> size
> io_size    random write      random write        random write
> 4K         93        93      700       700       5.75      5.62
> 8K         86        87      700       700       11        21.65
> 16K        83        88      680       538       22        28.64
> 32K        94        94      337       333       47        47.41

Parav,

I think the value is evident in this, however, I share Christoph's
concern of memory usage, moreover, I think we should avoid higher
order allocations and be more friendly to slub/slab.

I think this can impacts the scalability of the target, however,
I think that if we use SRQ (per-core) where we can, can ease the
limitation. I have code that makes nvme-rdma use SRQ per-core, but I
was kind of hoping we can get a generic interface for it so other ULPs
can enjoy it as well. I thought about some hook into the CQ pool API
but didn't follow up on it.
