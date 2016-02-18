From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 18 Feb 2016 09:34:37 +0100
Subject: [PATCH 2/3] nvme: don't poll the CQ from the kthread
In-Reply-To: <1455732194-30790-3-git-send-email-hch@lst.de>
References: <1455732194-30790-1-git-send-email-hch@lst.de>
 <1455732194-30790-3-git-send-email-hch@lst.de>
Message-ID: <20160218083437.GO18134@c203.arch.suse.de>

On Wed, Feb 17, 2016@07:03:13PM +0100, Christoph Hellwig wrote:
> There is no reason to do unconditional polling of CQs per the NVMe
> spec.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/pci.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 21b0be4..10839f7 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1156,9 +1156,6 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
>  	nvmeq->qid = qid;
>  	nvmeq->cq_vector = -1;
>  	dev->queues[qid] = nvmeq;
> -
> -	/* make sure queue descriptor is set before queue count, for kthread */
> -	mb();
>  	dev->queue_count++;
>  
>  	return nvmeq;
> @@ -1345,7 +1342,6 @@ static int nvme_kthread(void *data)
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		spin_lock(&dev_list_lock);
>  		list_for_each_entry_safe(dev, next, &dev_list, node) {
> -			int i;
>  			u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
>  			/*
> @@ -1363,14 +1359,6 @@ static int nvme_kthread(void *data)
>  				}
>  				continue;
>  			}
> -			for (i = 0; i < dev->queue_count; i++) {
> -				struct nvme_queue *nvmeq = dev->queues[i];
> -				if (!nvmeq)
> -					continue;
> -				spin_lock_irq(&nvmeq->q_lock);
> -				nvme_process_cq(nvmeq);
> -				spin_unlock_irq(&nvmeq->q_lock);
> -			}
>  		}
>  		spin_unlock(&dev_list_lock);
>  		schedule_timeout(round_jiffies_relative(HZ));
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme

Oh yeah, I was hunting down a lockup in that loop ("fixable" with
touch_nmi_watchdog()). Highly appreciate it's gone.


Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
