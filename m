Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A68DCC369C2
	for <linux-nvme@archiver.kernel.org>; Mon,  5 May 2025 06:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ci3H2pyLQmj3VM1Z7xGFayTI23JfWZLsasngR/bRFmg=; b=h14NsQC2ePettQSAZlf/i2Hkte
	Js6daScG2HxS2OpU9mN79A3CXnz7bHs+jgt0CV4bvFgb1FYl9BQ+YLmeJZgqA/7sw++GyFq+J1gCq
	4bE8n1Q7P2Ld5NkBbQttL9gCX1DDYQfZGQLfptkl7U+heNTQiEydEB42pyTyFogT3dHGGZm1Az+fl
	l6s6/ZDxVp4NLPUeFKP39S/BL2eOURuCzCDr9irQfU5Y23iP/4zH4BDd46w8msw3VPYdjOI92O50g
	CY25pSWegjeaF8a/ANxZGCQgTCXI6FfzvP3bR6xxaMdJZ7842lhyjaj+OjcPSe/P9H4nHW6FSEWmf
	PPS3f+IA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBpTx-00000006Xax-3uIe;
	Mon, 05 May 2025 06:39:17 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBpTu-00000006XaP-0dg4
	for linux-nvme@lists.infradead.org;
	Mon, 05 May 2025 06:39:16 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 335881F387;
	Mon,  5 May 2025 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746427152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci3H2pyLQmj3VM1Z7xGFayTI23JfWZLsasngR/bRFmg=;
	b=kKHPPn2+yVh/AsxavBceFlF5yxo/37zTw6YXfJ5AfebQVR1InfLvXZQjknhZBDboKA8aK8
	gpv4Xfyf1rjg/1OKnIGl0yAqbMTkscx9FGm+zO1zDsDKPJ+UcxEWECBtJzUgH8fKJPWksc
	bmHHfCtLuTTcc7GRZr/jUF6Y0ZAfBJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746427152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci3H2pyLQmj3VM1Z7xGFayTI23JfWZLsasngR/bRFmg=;
	b=0RpotALc95JhHVI8ZeFG+IKj0fGaZkEQ4vuLMsPEYC8JgVn82a3lVECME544ugYosWWOGO
	H2ytOgxE6RwDEqCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=kKHPPn2+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0RpotALc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1746427152; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci3H2pyLQmj3VM1Z7xGFayTI23JfWZLsasngR/bRFmg=;
	b=kKHPPn2+yVh/AsxavBceFlF5yxo/37zTw6YXfJ5AfebQVR1InfLvXZQjknhZBDboKA8aK8
	gpv4Xfyf1rjg/1OKnIGl0yAqbMTkscx9FGm+zO1zDsDKPJ+UcxEWECBtJzUgH8fKJPWksc
	bmHHfCtLuTTcc7GRZr/jUF6Y0ZAfBJQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1746427152;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ci3H2pyLQmj3VM1Z7xGFayTI23JfWZLsasngR/bRFmg=;
	b=0RpotALc95JhHVI8ZeFG+IKj0fGaZkEQ4vuLMsPEYC8JgVn82a3lVECME544ugYosWWOGO
	H2ytOgxE6RwDEqCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA4021372E;
	Mon,  5 May 2025 06:39:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WJplLw9dGGjKNwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 05 May 2025 06:39:11 +0000
Message-ID: <dd7330a2-6499-4af7-af3a-489ab86d2b5f@suse.de>
Date: Mon, 5 May 2025 08:39:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCHv3 1/3] nvme-multipath: introduce delayed removal of
 the multipath head node
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, jmeneghi@redhat.com,
 axboe@kernel.dk, martin.petersen@oracle.com, gjoyce@ibm.com
References: <20250504175051.2208162-1-nilay@linux.ibm.com>
 <20250504175051.2208162-2-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250504175051.2208162-2-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 335881F387
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250504_233914_512526_7E01942D 
X-CRM114-Status: GOOD (  43.49  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 5/4/25 19:50, Nilay Shroff wrote:
> Currently, the multipath head node of a PCIe NVMe disk is removed
> immediately as soon as all paths of the disk are removed. However,
> this can cause issues in scenarios where:
> 
> - The disk hot-removal followed by re-addition.
> - Transient PCIe link failures that trigger re-enumeration,
>    temporarily removing and then restoring the disk.
> 
> In these cases, removing the head node prematurely may lead to a head
> disk node name change upon re-addition, requiring applications to
> reopen their handles if they were performing I/O during the failure.
> 
> To address this, introduce a delayed removal mechanism of head disk
> node. During transient failure, instead of immediate removal of head
> disk node, the system waits for a configurable timeout, allowing the
> disk to recover.
> 
> During transient disk failure, if application sends any IO then we
> queue it instead of failing such IO immediately. If the disk comes back
> online within the timeout, the queued IOs are resubmitted to the disk
> ensuring seamless operation. In case disk couldn't recover from the
> failure then queued IOs are failed to its completion and application
> receives the error.
> 
> So this way, if disk comes back online within the configured period,
> the head node remains unchanged, ensuring uninterrupted workloads
> without requiring applications to reopen device handles.
> 
> A new sysfs attribute, named "delayed_removal_secs" is added under head
> disk blkdev for user who wish to configure time for the delayed removal
> of head disk node. The default value of this attribute is set to zero
> second ensuring no behavior change unless explicitly configured.
> 
> Link: https://lore.kernel.org/linux-nvme/Y9oGTKCFlOscbPc2@infradead.org/
> Link: https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/
> Suggested-by: Keith Busch <kbusch@kernel.org>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> [nilay: reworked based on the original idea/POC from Christoph and Keith]
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  10 ++-
>   drivers/nvme/host/multipath.c | 137 +++++++++++++++++++++++++++++++---
>   drivers/nvme/host/nvme.h      |  25 ++++++-
>   drivers/nvme/host/sysfs.c     |  13 ++++
>   4 files changed, 171 insertions(+), 14 deletions(-)
> 

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index eb6ea8acb3cc..0f6b01f10c70 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -3560,7 +3560,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
>   		 */
>   		if (h->ns_id != nsid || !nvme_is_unique_nsid(ctrl, h))
>   			continue;
> -		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
> +		if (nvme_tryget_ns_head(h))
>   			return h;
>   	}
>   
> @@ -3688,6 +3688,8 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
>   	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
>   	ratelimit_set_flags(&head->rs_nuse, RATELIMIT_MSG_ON_RELEASE);
>   	kref_init(&head->ref);
> +	if (ctrl->ops->flags & NVME_F_FABRICS)
> +		nvme_mpath_set_fabrics(head);
>   

Please make this a separate patch.

>   	if (head->ids.csi) {
>   		ret = nvme_get_effects_log(ctrl, head->ids.csi, &head->effects);
> @@ -3804,7 +3806,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
>   		}
>   	} else {
>   		ret = -EINVAL;
> -		if (!info->is_shared || !head->shared) {
> +		if ((!info->is_shared || !head->shared) &&
> +		    !list_empty(&head->list)) {
>   			dev_err(ctrl->device,
>   				"Duplicate unshared namespace %d\n",
>   				info->nsid);
> @@ -4008,7 +4011,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>   	mutex_lock(&ns->ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
>   	if (list_empty(&ns->head->list)) {
> -		list_del_init(&ns->head->entry);
> +		if (!nvme_mpath_queue_if_no_path(ns->head))
> +			list_del_init(&ns->head->entry);
>   		last_path = true;
>   	}
>   	mutex_unlock(&ns->ctrl->subsys->lock);
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 250f3da67cc9..f3f981c9f3ec 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -442,7 +442,24 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>   			break;
>   		}
>   	}
> -	return false;
> +
> +	/*
> +	 * If "head->delayed_removal_secs" is configured (i.e., non-zero), do
> +	 * not immediately fail I/O. Instead, requeue the I/O for the configured
> +	 * duration, anticipating that if there's a transient link failure then
> +	 * it may recover within this time window. This parameter is exported to
> +	 * userspace via sysfs, and its default value is zero. It is internally
> +	 * mapped to NVME_NSHEAD_QUEUE_IF_NO_PATH. When delayed_removal_secs is
> +	 * non-zero, this flag is set to true. When zero, the flag is cleared.
> +	 *
> +	 * Note: This option is not exposed to the users for NVMeoF connections.
> +	 * In fabric-based setups, fabric link failure is managed through other
> +	 * parameters such as "reconnect_delay" and "max_reconnects" which is
> +	 * handled at respective fabric driver layer. Therefor, head->delayed_
> +	 * removal_secs" is intended exclusively for non-fabric (e.g., PCIe)
> +	 * multipath configurations.
> +	 */
> +	return nvme_mpath_queue_if_no_path(head);
>   }
>   
>   static void nvme_ns_head_submit_bio(struct bio *bio)
> @@ -617,6 +634,40 @@ static void nvme_requeue_work(struct work_struct *work)
>   	}
>   }
>   
> +static void nvme_remove_head(struct nvme_ns_head *head)
> +{
> +	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +		/*
> +		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> +		 * to allow multipath to fail all I/O.
> +		 */
> +		kblockd_schedule_work(&head->requeue_work);
> +
> +		nvme_cdev_del(&head->cdev, &head->cdev_device);
> +		synchronize_srcu(&head->srcu);
> +		del_gendisk(head->disk);
> +		nvme_put_ns_head(head);
> +	}
> +}
> +
> +static void nvme_remove_head_work(struct work_struct *work)
> +{
> +	struct nvme_ns_head *head = container_of(to_delayed_work(work),
> +			struct nvme_ns_head, remove_work);
> +	bool shutdown = false;
> +

Don't you need to check here if the 'QUEUE_IF_NO_PATH' bit is still
cleared?

> +	mutex_lock(&head->subsys->lock);
> +	if (list_empty(&head->list)) {
> +		list_del_init(&head->entry);
> +		shutdown = true;
> +	}
> +	mutex_unlock(&head->subsys->lock);
> +	if (shutdown)
> +		nvme_remove_head(head);
> +
> +	module_put(THIS_MODULE);
> +}
> +
>   int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   {
>   	struct queue_limits lim;
> @@ -626,6 +677,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	spin_lock_init(&head->requeue_lock);
>   	INIT_WORK(&head->requeue_work, nvme_requeue_work);
>   	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
> +	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
> +	head->delayed_removal_secs = 0;
>   
>   	/*
>   	 * Add a multipath node if the subsystems supports multiple controllers.
> @@ -659,6 +712,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
>   	set_bit(GD_SUPPRESS_PART_SCAN, &head->disk->state);
>   	sprintf(head->disk->disk_name, "nvme%dn%d",
>   			ctrl->subsys->instance, head->instance);
> +	nvme_tryget_ns_head(head);

What is that doing here?
Why do you tak an additional reference?

>   	return 0;
>   }
>   
> @@ -1015,6 +1069,49 @@ static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr
>   }
>   DEVICE_ATTR_RO(numa_nodes);
>   
> +static ssize_t delayed_removal_secs_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +	int ret;
> +
> +	mutex_lock(&head->subsys->lock);
> +	ret = sysfs_emit(buf, "%u\n", head->delayed_removal_secs);
> +	mutex_unlock(&head->subsys->lock);
> +	return ret;
> +}
> +
> +static ssize_t delayed_removal_secs_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct gendisk *disk = dev_to_disk(dev);
> +	struct nvme_ns_head *head = disk->private_data;
> +	unsigned int sec;
> +	int ret;
> +
> +	ret = kstrtouint(buf, 0, &sec);
> +	if (ret < 0)
> +		return ret;
> +
> +	mutex_lock(&head->subsys->lock);
> +	head->delayed_removal_secs = sec;
> +	if (sec)
> +		set_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
> +	else
> +		clear_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
> +	mutex_unlock(&head->subsys->lock);
> +	/*
> +	 * Ensure that update to NVME_NSHEAD_QUEUE_IF_NO_PATH is seen
> +	 * by its reader.
> +	 */
> +	synchronize_srcu(&head->srcu);
> +
> +	return count;
> +}
> +
> +DEVICE_ATTR_RW(delayed_removal_secs);
> +
>   static int nvme_lookup_ana_group_desc(struct nvme_ctrl *ctrl,
>   		struct nvme_ana_group_desc *desc, void *data)
>   {
> @@ -1138,18 +1235,38 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
>   
>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
>   {
> -	if (!head->disk)
> -		return;
> -	if (test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> -		nvme_cdev_del(&head->cdev, &head->cdev_device);
> +	bool shutdown = false;
> +
> +	mutex_lock(&head->subsys->lock);
> +	/*
> +	 * We are called when all paths have been removed, and at that point
> +	 * head->list is expected to be empty. However, nvme_remove_ns() and
> +	 * nvme_init_ns_head() can run concurrently and so if head->delayed_
> +	 * removal_secs is configured, it is possible that by the time we reach
> +	 * this point, head->list may no longer be empty. Therefore, we recheck
> +	 * head->list here. If it is no longer empty then we skip enqueuing the
> +	 * delayed head removal work.
> +	 */
> +	if (!list_empty(&head->list))
> +		goto out;
> +
> +	if (head->delayed_removal_secs) {
>   		/*
> -		 * requeue I/O after NVME_NSHEAD_DISK_LIVE has been cleared
> -		 * to allow multipath to fail all I/O.
> +		 * Ensure that no one could remove this module while the head
> +		 * remove work is pending.
>   		 */
> -		synchronize_srcu(&head->srcu);
> -		kblockd_schedule_work(&head->requeue_work);
> -		del_gendisk(head->disk);
> +		if (!try_module_get(THIS_MODULE))
> +			goto out;
> +		queue_delayed_work(nvme_wq, &head->remove_work,
> +				head->delayed_removal_secs * HZ);
> +	} else {
> +		list_del_init(&head->entry);
> +		shutdown = true;
>   	}
> +out:
> +	mutex_unlock(&head->subsys->lock);
> +	if (shutdown)
> +		nvme_remove_head(head);
>   }
>   
>   void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 51e078642127..b2d02425dc3c 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -503,7 +503,11 @@ struct nvme_ns_head {
>   	struct work_struct	partition_scan_work;
>   	struct mutex		lock;
>   	unsigned long		flags;
> -#define NVME_NSHEAD_DISK_LIVE	0
> +	struct delayed_work	remove_work;
> +	unsigned int		delayed_removal_secs;
> +#define NVME_NSHEAD_DISK_LIVE		0
> +#define NVME_NSHEAD_FABRICS		1
> +#define NVME_NSHEAD_QUEUE_IF_NO_PATH	2
>   	struct nvme_ns __rcu	*current_path[];
>   #endif
>   };
> @@ -986,12 +990,23 @@ extern struct device_attribute dev_attr_ana_grpid;
>   extern struct device_attribute dev_attr_ana_state;
>   extern struct device_attribute dev_attr_queue_depth;
>   extern struct device_attribute dev_attr_numa_nodes;
> +extern struct device_attribute dev_attr_delayed_removal_secs;
>   extern struct device_attribute subsys_attr_iopolicy;
>   
>   static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>   {
>   	return disk->fops == &nvme_ns_head_ops;
>   }
> +static inline void nvme_mpath_set_fabrics(struct nvme_ns_head *head)
> +{
> +	set_bit(NVME_NSHEAD_FABRICS, &head->flags);
> +}
> +static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
> +{
> +	if (test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags))
> +		return true;
> +	return false;
> +}
>   #else
>   #define multipath false
>   static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
> @@ -1079,6 +1094,14 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>   {
>   	return false;
>   }
> +static inline void nvme_mpath_set_fabrics(struct nvme_ns_head *head)
> +{
> +
> +}
> +static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
> +{
> +	return false;
> +}
>   #endif /* CONFIG_NVME_MULTIPATH */
>   
>   int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
> diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
> index 6d31226f7a4f..51633670d177 100644
> --- a/drivers/nvme/host/sysfs.c
> +++ b/drivers/nvme/host/sysfs.c
> @@ -260,6 +260,7 @@ static struct attribute *nvme_ns_attrs[] = {
>   	&dev_attr_ana_state.attr,
>   	&dev_attr_queue_depth.attr,
>   	&dev_attr_numa_nodes.attr,
> +	&dev_attr_delayed_removal_secs.attr,
>   #endif
>   	&dev_attr_io_passthru_err_log_enabled.attr,
>   	NULL,
> @@ -296,6 +297,18 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
>   		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
>   			return 0;
>   	}
> +	if (a == &dev_attr_delayed_removal_secs.attr) {
> +		struct nvme_ns_head *head = dev_to_ns_head(dev);
> +		struct gendisk *disk = dev_to_disk(dev);
> +
> +		/*
> +		 * This attribute is only valid for head node and non-fabric
> +		 * setup.
> +		 */
> +		if (!nvme_disk_is_ns_head(disk) ||
> +				test_bit(NVME_NSHEAD_FABRICS, &head->flags))
> +			return 0;
> +	}
>   #endif
>   	return a->mode;
>   }

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

