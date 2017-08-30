From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 30 Aug 2017 09:12:06 -0600
Subject: [GIT PULL] last minute NVMe fixes for 4.13
In-Reply-To: <20170830150755.r64wwfrawsb4i34w@infradead.org>
References: <20170830150755.r64wwfrawsb4i34w@infradead.org>
Message-ID: <407852e1-c5fe-7822-04b1-b8e572586e84@kernel.dk>

On 08/30/2017 09:07 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> three more fixes for 4.13 below:
> 
>  - fix the incorrect bit for the doorbell buffer features (Changpeng Liu)
>  - always use a 4k MR page size for RDMA, to not get in trouble with
>    offset in non-4k page size systems (no-op for x86) (Max Gurtovoy)
>  - and a fix for the new nvme host memory buffer support to keep the
>    descriptor list DMA mapped when the buffer is enabled (me)

Pulled, thanks.

-- 
Jens Axboe
