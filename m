From: keith.busch@intel.com (Keith Busch)
Date: Tue, 4 Nov 2014 14:55:00 +0000 (UTC)
Subject: [PATCH] NVMe: Re-attach waitqueue following device reset
In-Reply-To: <5453DE85.90407@micron.com>
References: <5453DE85.90407@micron.com>
Message-ID: <alpine.LNX.2.00.1411041452350.4225@localhost.lm.intel.com>

On Fri, 31 Oct 2014, Sam Bradshaw wrote:
> Bios queued to sq_cong prior to and during a device reset may not
> get re-issued or may get issued very slowly following the completion
> of the reset sequence.  The waitqueue was detached as part of the
> sequence and never re-attached, forcing all new make_request() bios
> to be queued and the queue to be flushed out without the help of the
> completion path waking the kthread.

Hi Sam,

Are you using the latest from linux-nvme tree? I could have sworn this
bug was fixed in commit:

http://git.infradead.org/users/willy/linux-nvme.git/commitdiff/3559b4d2159aaae42f0fc0fa22e40312c45d4606

Please let me know if there's still a gap.

> This patch re-attaches the waitqueue as part of the reset process.
>
> Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
> ---
> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> index b85a2a0..8133ee8 100644
> --- a/drivers/block/nvme-core.c
> +++ b/drivers/block/nvme-core.c
> @@ -2329,6 +2329,23 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
> 	nvme_free_queues(dev, nr_io_queues + 1);
> 	nvme_assign_io_queues(dev);
>
> +	/* Re-attach the waitqueue */
> +	for (i = dev->queue_count - 1; i >= 1; i--) {
> +		struct nvme_queue *nvmeq = raw_nvmeq(dev, i);
> +
> +		if (nvmeq) {
> +			spin_lock_irq(&nvmeq->q_lock);
> +			init_waitqueue_head(&nvmeq->sq_full);
> +			init_waitqueue_entry(&nvmeq->sq_cong_wait,
> +								nvme_thread);
> +			if (bio_list_peek(&nvmeq->sq_cong) ||
> +						!list_empty(&nvmeq->iod_bio))
> +				add_wait_queue(&nvmeq->sq_full,
> +							&nvmeq->sq_cong_wait);
> +			spin_unlock_irq(&nvmeq->q_lock);
> +		}
> +	}
> +
> 	return 0;
>
>  free_queues:
