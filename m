Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16926C2BA83
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:53:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEFA21739
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 17:53:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MoXrG4Un"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEFA21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5FXnWH8iui8OFX11NNQfQQLmKlZevTRG5iDkXCNhx9Y=; b=MoXrG4Un/JRgjN
	IceOuzuFQBTwhcz7oRfoRomOY89mGfpfrp2s11J4kFvpzBcdBUXcZ+I5twnz5I4UXPmksL8Mx4tEF
	nthWaysoSwZVUayIODi+gZ+DqUKvziF3lKyzpcMEtbdwwlN7w6UaNnwsAEXGh0w1yl61QQd3/1l3k
	SYJdPLi0tLmmhrqwwaG5SseTo7uNNQ1CRciCi8ZAuYJ7oN3PgUvCgRmT4RxfV9jOH3A8ds1XMgUHT
	rh5P0IzrZmYqN8AqPsT9eugU1GPoaMvfzDN5Aq4gRPfopA++5Zwet5/+ErznJJ4QmzzMn7ETDsNzG
	sZKfXT10dGMom49MTU3g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1wCR-0003YW-P9; Wed, 12 Feb 2020 17:53:23 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1wCO-0003Xe-LA
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 17:53:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id E41DF68BFE; Wed, 12 Feb 2020 18:53:17 +0100 (CET)
Date: Wed, 12 Feb 2020 18:53:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] nvme-multipath: do not reset controller on unknown status
Message-ID: <20200212175317.GA5813@lst.de>
References: <20200212134140.105817-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200212134140.105817-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_095320_992715_DFB1F536 
X-CRM114-Status: GOOD (  31.13  )
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
Cc: Keith Busch <keith.busch@intel.com>,
 John Managhini <john.meneghini@netapp.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Feb 12, 2020 at 02:41:40PM +0100, Hannes Reinecke wrote:
> We're seeing occasional controller resets during straight I/O,
> but only when multipath is active.
> The problem here is the nvme-multipath will reset the controller
> on every unknown status, which really is an odd behaviour, seeing
> that the host already received a perfectly good status; it's just
> that it's not smart enough to understand it.
> And resetting wouldn't help at all; the error status will continue
> to be received.
> So we should rather pass up any unknown error to the generic
> routines and let them deal with this situation.

What unknown status do you see?

> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Cc: John Managhini <john.meneghini@netapp.com>
> ---
>  drivers/nvme/host/core.c      |  4 ++--
>  drivers/nvme/host/multipath.c | 18 ++++++++++--------
>  drivers/nvme/host/nvme.h      |  2 +-
>  3 files changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 5dc32b72e7fa..edb081781ae7 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -293,8 +293,8 @@ void nvme_complete_rq(struct request *req)
>  	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
>  		if ((req->cmd_flags & REQ_NVME_MPATH) &&
>  		    blk_path_error(status)) {
> -			nvme_failover_req(req);
> -			return;
> +			if (nvme_failover_req(req))
> +				return;

This reads weird, why not:

		if ((req->cmd_flags & REQ_NVME_MPATH) &&
		    blk_path_error(status) && nvme_failover_req(req))
			return;

?

But see below, with your updated checks (assuming this makes sense
as we need more explanation) we don't even need the blk_path_error
call.

> -void nvme_failover_req(struct request *req)
> +bool nvme_failover_req(struct request *req)
>  {
>  	struct nvme_ns *ns = req->q->queuedata;
>  	u16 status = nvme_req(req)->status;
>  	unsigned long flags;
> +	bool handled = false;
>  
>  	spin_lock_irqsave(&ns->head->requeue_lock, flags);
>  	blk_steal_bios(&ns->head->requeue_list, req);
>  	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> -	blk_mq_end_request(req, 0);

You can't just steal the bios without completing the request.

>  
>  	switch (status & 0x7ff) {
>  	case NVME_SC_ANA_TRANSITION:
> @@ -88,11 +88,13 @@ void nvme_failover_req(struct request *req)
>  		 * mark the the path as pending and kick of a re-read of the ANA
>  		 * log page ASAP.
>  		 */
> +		blk_mq_end_request(req, 0);
>  		nvme_mpath_clear_current_path(ns);
>  		if (ns->ctrl->ana_log_buf) {
>  			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
>  			queue_work(nvme_wq, &ns->ctrl->ana_work);
>  		}
> +		handled = true;
>  		break;
>  	case NVME_SC_HOST_PATH_ERROR:
>  	case NVME_SC_HOST_ABORTED_CMD:
> @@ -100,18 +102,18 @@ void nvme_failover_req(struct request *req)
>  		 * Temporary transport disruption in talking to the controller.
>  		 * Try to send on a new path.
>  		 */
> +		blk_mq_end_request(req, 0);
>  		nvme_mpath_clear_current_path(ns);
> +		handled = true;
>  		break;
>  	default:
> -		/*
> -		 * Reset the controller for any non-ANA error as we don't know
> -		 * what caused the error.
> -		 */
> -		nvme_reset_ctrl(ns->ctrl);
> +		/* Delegate to common error handling */
>  		break;
>  	}
>  
> -	kblockd_schedule_work(&ns->head->requeue_work);
> +	if (handled)
> +		kblockd_schedule_work(&ns->head->requeue_work);
> +	return handled;

I think you can defer the blk_mq_end_request to here as well.  Then
just return false from the default case and you don't need the handled
variable.

So in the end this should be something like this:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5dc32b72e7fa..68443564b930 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -291,11 +291,8 @@ void nvme_complete_rq(struct request *req)
 		nvme_req(req)->ctrl->comp_seen = true;
 
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) &&
-		    blk_path_error(status)) {
-			nvme_failover_req(req);
+		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
 			return;
-		}
 
 		if (!blk_queue_dying(req->q)) {
 			nvme_retry_req(req);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 797c18337d96..7b62b14985c2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -64,18 +64,12 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-void nvme_failover_req(struct request *req)
+bool nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
-	u16 status = nvme_req(req)->status;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	blk_steal_bios(&ns->head->requeue_list, req);
-	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-	blk_mq_end_request(req, 0);
-
-	switch (status & 0x7ff) {
+	switch (nvme_req(req)->status & 0x7ff) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
 	case NVME_SC_ANA_PERSISTENT_LOSS:
@@ -103,15 +97,16 @@ void nvme_failover_req(struct request *req)
 		nvme_mpath_clear_current_path(ns);
 		break;
 	default:
-		/*
-		 * Reset the controller for any non-ANA error as we don't know
-		 * what caused the error.
-		 */
-		nvme_reset_ctrl(ns->ctrl);
-		break;
+		return false;
 	}
 
+	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	blk_steal_bios(&ns->head->requeue_list, req);
+	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+	blk_mq_end_request(req, 0);
+
 	kblockd_schedule_work(&ns->head->requeue_work);
+	return true;
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1024fec7914c..d800b9a51c2c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -550,7 +550,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
-void nvme_failover_req(struct request *req);
+bool nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -599,8 +599,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 }
 
-static inline void nvme_failover_req(struct request *req)
+static inline bool nvme_failover_req(struct request *req)
 {
+	return false;
 }
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1b8014ab0b25..85b7e080c20b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1071,7 +1071,7 @@ static void dwc3_prepare_one_trb_sg(struct dwc3_ep *dep,
 		unsigned int rem = length % maxp;
 		unsigned chain = true;
 
-		if (sg_is_last(s))
+		if (req->num_queued_sgs + 1 == req->request.num_mapped_sgs)
 			chain = false;
 
 		if (rem && usb_endpoint_dir_out(dep->endpoint.desc) && !chain) {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 9cfc668f91f4..047c9864c3c7 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -152,6 +152,35 @@ const struct btrfs_raid_attr btrfs_raid_array[BTRFS_NR_RAID_TYPES] = {
 	},
 };
 
+static void btrfs_scratch_superblocks(struct block_device *bdev,
+		const char *device_path)
+{
+	struct buffer_head *bh;
+	struct btrfs_super_block *disk_super;
+	int copy_num;
+
+	if (!bdev)
+		return;
+
+	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX; copy_num++) {
+		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
+			continue;
+
+		disk_super = (struct btrfs_super_block *)bh->b_data;
+
+		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
+		set_buffer_dirty(bh);
+		sync_dirty_buffer(bh);
+		brelse(bh);
+	}
+
+	/* Notify udev that device has changed */
+	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
+
+	/* Update ctime/mtime for device path for libblkid */
+	update_dev_time(device_path);
+}
+
 const char *btrfs_bg_type_to_raid_name(u64 flags)
 {
 	const int index = btrfs_bg_flags_to_raid_index(flags);
@@ -7317,36 +7346,6 @@ int btrfs_get_dev_stats(struct btrfs_fs_info *fs_info,
 	return 0;
 }
 
-void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path)
-{
-	struct buffer_head *bh;
-	struct btrfs_super_block *disk_super;
-	int copy_num;
-
-	if (!bdev)
-		return;
-
-	for (copy_num = 0; copy_num < BTRFS_SUPER_MIRROR_MAX;
-		copy_num++) {
-
-		if (btrfs_read_dev_one_super(bdev, copy_num, &bh))
-			continue;
-
-		disk_super = (struct btrfs_super_block *)bh->b_data;
-
-		memset(&disk_super->magic, 0, sizeof(disk_super->magic));
-		set_buffer_dirty(bh);
-		sync_dirty_buffer(bh);
-		brelse(bh);
-	}
-
-	/* Notify udev that device has changed */
-	btrfs_kobject_uevent(bdev, KOBJ_CHANGE);
-
-	/* Update ctime/mtime for device path for libblkid */
-	update_dev_time(device_path);
-}
-
 /*
  * Update the size and bytes used for each device where it changed.  This is
  * delayed since we would otherwise get errors while writing out the
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 409f4816fb89..9394cfde7ace 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -473,7 +473,6 @@ int btrfs_run_dev_stats(struct btrfs_trans_handle *trans);
 void btrfs_rm_dev_replace_remove_srcdev(struct btrfs_device *srcdev);
 void btrfs_rm_dev_replace_free_srcdev(struct btrfs_device *srcdev);
 void btrfs_destroy_dev_replace_tgtdev(struct btrfs_device *tgtdev);
-void btrfs_scratch_superblocks(struct block_device *bdev, const char *device_path);
 int btrfs_is_parity_mirror(struct btrfs_fs_info *fs_info,
 			   u64 logical, u64 len);
 unsigned long btrfs_full_stripe_len(struct btrfs_fs_info *fs_info,

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
