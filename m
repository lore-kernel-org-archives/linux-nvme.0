From: kenneth.heitke@intel.com (Heitke, Kenneth)
Date: Thu, 16 May 2019 11:49:21 -0600
Subject: Issue with namespace delete
In-Reply-To: <20190516155356.GA26104@infradead.org>
References: <f215cfd2-c0ce-34ff-bc8b-4a577a73372e@intel.com>
 <20190516151130.GB23416@localhost.localdomain>
 <20190516155356.GA26104@infradead.org>
Message-ID: <8745b7bb-e433-a54b-5ecf-b4584038d832@intel.com>

Thanks Christoph. With my limited testing, your patch resolves my issue.

On 5/16/2019 9:53 AM, Christoph Hellwig wrote:
> On Thu, May 16, 2019@09:11:30AM -0600, Keith Busch wrote:
>> You may have avoided this if you send the ioctl through the controller
>> char dev rather than the namespace block dev handle.
>>
>> I'm not sure what the best way to fix this might be right now.
> 
> We could try something like the changes below, although they are
> completely untested for now and will need to be split up into
> a few patches:
> 
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a6644a2c3ef7..537cbef5bc4a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1362,9 +1362,14 @@ static struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
>   {
>   #ifdef CONFIG_NVME_MULTIPATH
>   	if (disk->fops == &nvme_ns_head_ops) {
> +		struct nvme_ns *ns;
> +
>   		*head = disk->private_data;
>   		*srcu_idx = srcu_read_lock(&(*head)->srcu);
> -		return nvme_find_path(*head);
> +		ns = nvme_find_path(*head);
> +		if (!ns)
> +			srcu_read_unlock(&(*head)->srcu, *srcu_idx);
> +		return ns;
>   	}
>   #endif
>   	*head = NULL;
> @@ -1384,8 +1389,6 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned cmd, unsigned long arg)
>   	case NVME_IOCTL_ID:
>   		force_successful_syscall_return();
>   		return ns->head->ns_id;
> -	case NVME_IOCTL_ADMIN_CMD:
> -		return nvme_user_cmd(ns->ctrl, NULL, (void __user *)arg);
>   	case NVME_IOCTL_IO_CMD:
>   		return nvme_user_cmd(ns->ctrl, ns, (void __user *)arg);
>   	case NVME_IOCTL_SUBMIT_IO:
> @@ -1395,9 +1398,6 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned cmd, unsigned long arg)
>   		if (ns->ndev)
>   			return nvme_nvm_ioctl(ns, cmd, arg);
>   #endif
> -		if (is_sed_ioctl(cmd))
> -			return sed_ioctl(ns->ctrl->opal_dev, cmd,
> -					 (void __user *) arg);
>   		return -ENOTTY;
>   	}
>   }
> @@ -1405,16 +1405,30 @@ static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned cmd, unsigned long arg)
>   static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
>   		unsigned int cmd, unsigned long arg)
>   {
> +	void __user *argp = (void __user *)arg;
>   	struct nvme_ns_head *head = NULL;
> +	struct nvme_ctrl *ctrl = NULL;
>   	struct nvme_ns *ns;
> -	int srcu_idx, ret;
> +	int srcu_idx, ret = 0;
>   
>   	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
>   	if (unlikely(!ns))
> -		ret = -EWOULDBLOCK;
> +		return -EWOULDBLOCK;
> +
> +	if (cmd == NVME_IOCTL_ADMIN_CMD || is_sed_ioctl(cmd))
> +		ctrl = nvme_get_ctrl(ns->ctrl);
>   	else
>   		ret = nvme_ns_ioctl(ns, cmd, arg);
>   	nvme_put_ns_from_disk(head, srcu_idx);
> +
> +	if (ctrl) {
> +		if (cmd == NVME_IOCTL_ADMIN_CMD)
> +			return nvme_user_cmd(ctrl, NULL, argp);
> +		if (is_sed_ioctl(cmd))
> +			return sed_ioctl(ctrl->opal_dev, cmd, argp);
> +		nvme_put_ctrl(ctrl);
> +	}
> +
>   	return ret;
>   }
>   
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 5ee75b5ff83f..86625767da8b 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -405,9 +405,10 @@ static inline void nvme_end_request(struct request *req, __le16 status,
>   	blk_mq_complete_request(req);
>   }
>   
> -static inline void nvme_get_ctrl(struct nvme_ctrl *ctrl)
> +static inline struct nvme_ctrl *nvme_get_ctrl(struct nvme_ctrl *ctrl)
>   {
>   	get_device(ctrl->device);
> +	return ctrl;
>   }
>   
>   static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
> 
