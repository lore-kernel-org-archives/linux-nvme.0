From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Apr 2019 09:42:30 -0700
Subject: [PATCH RFC] nvme: fix race condition between remove and scan_work
In-Reply-To: <20190424162659.GA15412@localhost.localdomain>
References: <20190411133227.28435-1-yuyufen@huawei.com>
 <a9d6bf42-e01a-4e56-acc7-5d87ac9179f9@grimberg.me>
 <20190424162659.GA15412@localhost.localdomain>
Message-ID: <55a37c3e-5732-5162-37ff-80151363cbc4@grimberg.me>


>> Is it just DELETING state that is acceptable here? or can we meet other
>> states that fail transition to RESETTING (CONNECTING/DEAD)?
> 
> It could be connecting or already scheduled resetting, in which case we
> wouldn't want to unquiesce.
> 
> When we do want to unquiesce, though, we also want to do that to the
> IO queues, not just the admin queue. Untested below, but this might be
> in the right direction:

This looks good Keith, Yufen, does that address your race?

> 
> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index a90cf5d63aac..acfb34c945b2 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -1315,6 +1315,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>   		nvme_dev_disable(dev, false);
>   		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
>   		return BLK_EH_DONE;
> +	case NVME_CTRL_DELETING:
> +		nvme_dev_disable(dev, true);
> +		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
> +		return BLK_EH_DONE;
>   	default:
>   		break;
>   	}
> @@ -2438,8 +2442,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>   	 * must flush all entered requests to their failed completion to avoid
>   	 * deadlocking blk-mq hot-cpu notifier.
>   	 */
> -	if (shutdown)
> +	if (shutdown) {
>   		nvme_start_queues(&dev->ctrl);
> +		if (dev->ctrl.admin_q)
> +			blk_mq_unquiesce_queue(dev->ctrl.admin_q);
> +	}
>   	mutex_unlock(&dev->shutdown_lock);
>   }
>   
> --
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
