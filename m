From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 24 Jul 2012 15:55:32 -0400
Subject: [PATCH] NVMe: Set request queue logical block size
In-Reply-To: <B58D82457FDA0744A320A2FC5AC253B90D438980@FMSMSX105.amr.corp.intel.com>
References: <B58D82457FDA0744A320A2FC5AC253B90D438980@FMSMSX105.amr.corp.intel.com>
Message-ID: <20120724195532.GA22985@linux.intel.com>

On Tue, Jul 24, 2012@07:26:14PM +0000, Busch, Keith wrote:
> Sets the request queue logical block size with the block size of the namespace.

No objection to the patch itself, but it looks like you used Outlook to
send it.  Outlook has a nasty habit of corrupting patches, even if you
attach them.  Can you resend with a different MUA?

> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
> drivers/block/nvme.c |    1 +
> 1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
> index f4996b0..38b9c73 100644
> --- a/drivers/block/nvme.c
> +++ b/drivers/block/nvme.c
> @@ -1344,6 +1344,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
>      ns->disk = disk;
>      lbaf = id->flbas & 0xf;
>      ns->lba_shift = id->lbaf[lbaf].ds;
> +     blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
>       disk->major = nvme_major;
>      disk->minors = NVME_MINORS;
> --
> 1.7.0.4
> 

> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://merlin.infradead.org/mailman/listinfo/linux-nvme
