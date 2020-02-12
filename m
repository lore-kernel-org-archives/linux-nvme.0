Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D35C352A4
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 19:33:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B811021734
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 19:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q/OAKOUR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B811021734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=wynj3lnW1gfueyO8IdjAe1zI8k87UOdmRPpvUfGdFe8=; b=Q/OAKOUR4srVxZ0CPIhPL1H+T
	Ihki6NkE57axvQQ5wGYs5G0OD87mPUcJAmcEYQKS7CDGAYE1sb5OozfwbkNyAzhejTwKwY/QUclGO
	H7rsUdmLr7Bb1LEy8gho17WyDJUY/hSkNummHuOsqg2OLT769c+1/fhXDMNv2zcXAWeKuB3RAKFht
	Pc76iI2EU4FzkoPpMxP50y/25Q0kgy2EUh7hiaFE6vrRP9ylM95zl84lQFpTx+uZr+eT6qDxXgnbK
	4PSF2saA2tTlvi+lFRbkfX2AzT+APHtBvq54r1n1TtWqqqDpZvgdxrUV8nlrDTAR9yogeRlVx4RMW
	bST3VAM1g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1xlH-00044x-6S; Wed, 12 Feb 2020 19:33:27 +0000
Received: from mail-oi1-f193.google.com ([209.85.167.193])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1xlD-00044I-UN
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 19:33:25 +0000
Received: by mail-oi1-f193.google.com with SMTP id z2so3198498oih.6
 for <linux-nvme@lists.infradead.org>; Wed, 12 Feb 2020 11:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IyKs+t8jAGKWTrPnlLeH/dHfTGmw3AkeTThixt6WgnE=;
 b=PyKRfVscj9o3N3RwHbC6lvERxjrDOCCcXkhmCnNrB39g5/SloXNRLKab/5FUxpK2bE
 xHXVGZ0yacS/1wnbLB4ir4ymNkKhlNWpGH7Ki8VuyvbIUWM05g1yNqeOcxR7siExFpf2
 BGw0f8odVimROnMG7tiAeOtT4SC8OWfiWoK5lMeekilDy0oXxctrKPfUtRwyoEBtb0zu
 2XvnUvZcdTHd9OFrkE/ncIwF03vETTgPZtzU6+pmF/ItRgsjpufmTFuXO11IJjfdJ9it
 x8oCKSTBHZTCD5wT1avUKwwNim0sVSsZPOwngaB7mVMuPXZk8HtZB+EI+sNS2ldLOhRX
 YRFw==
X-Gm-Message-State: APjAAAXe8gaP2LfbW1d2MSdHb0VK3gkpdrrbDrKnK4xd/Y3flhqG79Rl
 YdshA5/4/OjG3FuF9Xjus4bpvOGL
X-Google-Smtp-Source: APXvYqzzdc7MFDVXyyu7DzyBy8LlJfqF4xadItZeeJ3vyZI3Nppa4FtRcthqbzh9AKAZdi/qJh/0Jw==
X-Received: by 2002:aca:3805:: with SMTP id f5mr476999oia.6.1581536002372;
 Wed, 12 Feb 2020 11:33:22 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d?
 ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
 by smtp.gmail.com with ESMTPSA id z10sm395297oih.1.2020.02.12.11.33.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Feb 2020 11:33:21 -0800 (PST)
Subject: Re: [PATCH] nvme-multipath: do not reset controller on unknown status
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
References: <20200212134140.105817-1-hare@suse.de>
 <20200212175317.GA5813@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <6d4d18e3-c3a1-7d93-5abf-1ae46e18ca8c@grimberg.me>
Date: Wed, 12 Feb 2020 11:33:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200212175317.GA5813@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_113323_987620_89F2BCBC 
X-CRM114-Status: GOOD (  38.99  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <keith.busch@intel.com>, linux-nvme@lists.infradead.org,
 John Managhini <john.meneghini@netapp.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 2/12/20 9:53 AM, Christoph Hellwig wrote:
> On Wed, Feb 12, 2020 at 02:41:40PM +0100, Hannes Reinecke wrote:
>> We're seeing occasional controller resets during straight I/O,
>> but only when multipath is active.
>> The problem here is the nvme-multipath will reset the controller
>> on every unknown status, which really is an odd behaviour, seeing
>> that the host already received a perfectly good status; it's just
>> that it's not smart enough to understand it.
>> And resetting wouldn't help at all; the error status will continue
>> to be received.
>> So we should rather pass up any unknown error to the generic
>> routines and let them deal with this situation.
> 
> What unknown status do you see?

My question exactly, I don't understand what is the good status that
the host is not smart enough to understand?

I have a vague recollection that John sent some questions in that area
in the past...

> 
>>
>> Signed-off-by: Hannes Reinecke <hare@suse.de>
>> Cc: John Managhini <john.meneghini@netapp.com>
>> ---
>>   drivers/nvme/host/core.c      |  4 ++--
>>   drivers/nvme/host/multipath.c | 18 ++++++++++--------
>>   drivers/nvme/host/nvme.h      |  2 +-
>>   3 files changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 5dc32b72e7fa..edb081781ae7 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -293,8 +293,8 @@ void nvme_complete_rq(struct request *req)
>>   	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
>>   		if ((req->cmd_flags & REQ_NVME_MPATH) &&
>>   		    blk_path_error(status)) {
>> -			nvme_failover_req(req);
>> -			return;
>> +			if (nvme_failover_req(req))
>> +				return;
> 
> This reads weird, why not:
> 
> 		if ((req->cmd_flags & REQ_NVME_MPATH) &&
> 		    blk_path_error(status) && nvme_failover_req(req))
> 			return;
> 
> ?
> 
> But see below, with your updated checks (assuming this makes sense
> as we need more explanation) we don't even need the blk_path_error
> call.

I think it reads better that we call nvme_failover_req only for actual
path errors.

> 
>> -void nvme_failover_req(struct request *req)
>> +bool nvme_failover_req(struct request *req)
>>   {
>>   	struct nvme_ns *ns = req->q->queuedata;
>>   	u16 status = nvme_req(req)->status;
>>   	unsigned long flags;
>> +	bool handled = false;
>>   
>>   	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>>   	blk_steal_bios(&ns->head->requeue_list, req);
>>   	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
>> -	blk_mq_end_request(req, 0);
> 
> You can't just steal the bios without completing the request.
> 
>>   
>>   	switch (status & 0x7ff) {
>>   	case NVME_SC_ANA_TRANSITION:
>> @@ -88,11 +88,13 @@ void nvme_failover_req(struct request *req)
>>   		 * mark the the path as pending and kick of a re-read of the ANA
>>   		 * log page ASAP.
>>   		 */
>> +		blk_mq_end_request(req, 0);
>>   		nvme_mpath_clear_current_path(ns);
>>   		if (ns->ctrl->ana_log_buf) {
>>   			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
>>   			queue_work(nvme_wq, &ns->ctrl->ana_work);
>>   		}
>> +		handled = true;
>>   		break;
>>   	case NVME_SC_HOST_PATH_ERROR:
>>   	case NVME_SC_HOST_ABORTED_CMD:
>> @@ -100,18 +102,18 @@ void nvme_failover_req(struct request *req)
>>   		 * Temporary transport disruption in talking to the controller.
>>   		 * Try to send on a new path.
>>   		 */
>> +		blk_mq_end_request(req, 0);
>>   		nvme_mpath_clear_current_path(ns);
>> +		handled = true;
>>   		break;
>>   	default:
>> -		/*
>> -		 * Reset the controller for any non-ANA error as we don't know
>> -		 * what caused the error.
>> -		 */
>> -		nvme_reset_ctrl(ns->ctrl);
>> +		/* Delegate to common error handling */
>>   		break;

What will happen in the common case? right now it will just retry
it on the same path, is that the desired behavior?

I guess we need to understand the phenomenon better.

Right now the code says, we don't know what went wrong here, so we
are going to reset the controller because it acts weird, which can
make some sense, given that the host doesn't understand what is going
on...

>>   	}
>>   
>> -	kblockd_schedule_work(&ns->head->requeue_work);
>> +	if (handled)
>> +		kblockd_schedule_work(&ns->head->requeue_work);
>> +	return handled;
> 
> I think you can defer the blk_mq_end_request to here as well.  Then
> just return false from the default case and you don't need the handled
> variable.
> 
> So in the end this should be something like this:
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5dc32b72e7fa..68443564b930 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -291,11 +291,8 @@ void nvme_complete_rq(struct request *req)
>   		nvme_req(req)->ctrl->comp_seen = true;
>   
>   	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
> -		if ((req->cmd_flags & REQ_NVME_MPATH) &&
> -		    blk_path_error(status)) {
> -			nvme_failover_req(req);
> +		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
>   			return;
> -		}
>   
>   		if (!blk_queue_dying(req->q)) {
>   			nvme_retry_req(req);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 797c18337d96..7b62b14985c2 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -64,18 +64,12 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>   	}
>   }
>   
> -void nvme_failover_req(struct request *req)
> +bool nvme_failover_req(struct request *req)
>   {
>   	struct nvme_ns *ns = req->q->queuedata;
> -	u16 status = nvme_req(req)->status;
>   	unsigned long flags;
>   
> -	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> -	blk_steal_bios(&ns->head->requeue_list, req);
> -	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> -	blk_mq_end_request(req, 0);
> -
> -	switch (status & 0x7ff) {
> +	switch (nvme_req(req)->status & 0x7ff) {
>   	case NVME_SC_ANA_TRANSITION:
>   	case NVME_SC_ANA_INACCESSIBLE:
>   	case NVME_SC_ANA_PERSISTENT_LOSS:
> @@ -103,15 +97,16 @@ void nvme_failover_req(struct request *req)
>   		nvme_mpath_clear_current_path(ns);
>   		break;
>   	default:
> -		/*
> -		 * Reset the controller for any non-ANA error as we don't know
> -		 * what caused the error.
> -		 */
> -		nvme_reset_ctrl(ns->ctrl);
> -		break;
> +		return false;
>   	}
>   
> +	spin_lock_irqsave(&ns->head->requeue_lock, flags);
> +	blk_steal_bios(&ns->head->requeue_list, req);
> +	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> +	blk_mq_end_request(req, 0);
> +
>   	kblockd_schedule_work(&ns->head->requeue_work);
> +	return true;
>   }
>   
>   void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 1024fec7914c..d800b9a51c2c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -550,7 +550,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
>   void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
>   void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>   			struct nvme_ctrl *ctrl, int *flags);
> -void nvme_failover_req(struct request *req);
> +bool nvme_failover_req(struct request *req);
>   void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
>   int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
>   void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
> @@ -599,8 +599,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
>   	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
>   }
>   
> -static inline void nvme_failover_req(struct request *req)
> +static inline bool nvme_failover_req(struct request *req)
>   {
> +	return false;
>   }
>   static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
>   {

I'm assuming the below doesn't belong..

> diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
> index 1b8014ab0b25..85b7e080c20b 100644
> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -1071,7 +1071,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
>   		unsigned int rem = length % maxp;
>   		unsigned chain = true;
>   
> -		if (sg_is_last(s))
> +		if (req->num_queued_sgs + 1 == req->request.num_mapped_sgs)
>   			chain = false;
>   
>   		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 9cfc668f91f4..047c9864c3c7 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -152,6 +152,35 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
>   	},
>   };
>   
> +static void btrfs_scratch_superblocks(struct block_device *bdev,
> +		const char *device_path)
> +{
> +	struct buffer_head *bh;
> +	struct btrfs_super_block *disk_super;
> +	int copy_num;
> +
> +	if (!bdev)
> +		return;
> +
> +	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX; copy_num++) {
> +		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
> +			continue;
> +
> +		disk_super = (struct btrfs_super_block *)bh->b_data;
> +
> +		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
> +		set_buffer_dirty(bh);
> +		sync_dirty_buffer(bh);
> +		brelse(bh);
> +	}
> +
> +	/* Notify udev that device has changed */
> +	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
> +
> +	/* Update ctime/mtime for device path for libblkid */
> +	update_dev_time(device_path);
> +}
> +
>   const char *btrfs_bg_type_to_raid_name(u64 flags)
>   {
>   	const int index = btrfs_bg_flags_to_raid_index(flags);
> @@ -7317,36 +7346,6 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
>   	return 0;
>   }
>   
> -void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path)
> -{
> -	struct buffer_head *bh;
> -	struct btrfs_super_block *disk_super;
> -	int copy_num;
> -
> -	if (!bdev)
> -		return;
> -
> -	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
> -		copy_num++) {
> -
> -		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
> -			continue;
> -
> -		disk_super = (struct btrfs_super_block *)bh->b_data;
> -
> -		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
> -		set_buffer_dirty(bh);
> -		sync_dirty_buffer(bh);
> -		brelse(bh);
> -	}
> -
> -	/* Notify udev that device has changed */
> -	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
> -
> -	/* Update ctime/mtime for device path for libblkid */
> -	update_dev_time(device_path);
> -}
> -
>   /*
>    * Update the size and bytes used for each device where it changed.  This is
>    * delayed since we would otherwise get errors while writing out the
> diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
> index 409f4816fb89..9394cfde7ace 100644
> --- a/fs/btrfs/volumes.h
> +++ b/fs/btrfs/volumes.h
> @@ -473,7 +473,6 @@ int btrfs_run_dev_stats(struct btrfs_trans_handle *trans);
>   void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev);
>   void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev);
>   void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev);
> -void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path);
>   int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info,
>   			   u64 logical, u64 len);
>   unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
