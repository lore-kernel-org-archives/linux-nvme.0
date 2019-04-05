From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 5 Apr 2019 09:10:00 -0600
Subject: [GIT PULL] early nvme updates for 5.2
In-Reply-To: <20190405062043.GA26688@infradead.org>
References: <20190405062043.GA26688@infradead.org>
Message-ID: <96592ce3-88d6-ac9a-1f10-6175ccae89b7@kernel.dk>

On 4/5/19 12:20 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> below is the first batch of nvme updates for 5.2.  This includes the
> performance improvements for single segment I/O on PCIe, which introduce
> new block helpers, so it might be a good idea to get them in early.
> 
>  - various performance optimizations in the PCIe code (Keith and me)
>  - new block helpers to support the above (me)
>  - nvmet error conversion cleanup (me)
>  - nvmet-fc variable sized array cleanup (Gustavo)
>  - passthrough ioctl error printk cleanup (Kenneth)
>  - small nvmet fixes (Max)
>  - endianess conversion cleanup (Max)
>  - nvmet-tcp faspath completion optimization (Sagi)

Pulled, thanks.

-- 
Jens Axboe
