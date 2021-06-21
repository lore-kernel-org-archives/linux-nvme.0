Return-Path: <SRS0=I4H8=LP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3491C48BE5
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 06:38:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF4AB61003
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jun 2021 06:38:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4AB61003
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=2yAgR0878qoccy+paQnhScnABlx5QS73WPETN53WISY=; b=p80BRbeRwCXrEF
	Rl/QTfGp8k4Z98nBScYwmjMk/Ep0hQ3zsFkKRu9hBbkoemakzgnmGGgl8F6pRGqvw8e4QUDts9Qcf
	03sVFZUSTpseqpmpi6XO58s92et4CrUyEFQ1yCNwMjYZCHEwLjW6GQLLvB1JTS1KaalyFkQORdpcH
	e29QTfpE5oU8kZUsLqExM4a3ptfuxnoUyQiUFpt3CnRoXDK+PZxm5/Op+AWlS2bsO9zA7eIQxW6Dz
	9YlzFWhOb1AuqV5ppRSgwMh2Ur2wQK2bVdbrqax7LHTTRh2DqL4lDIKrH6/r20Z+yqlyPxEYjZmG8
	58eQ+arQ7Y54Yl3cfecg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lvDZl-002LAQ-9z; Mon, 21 Jun 2021 06:38:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lvDZh-002L9Y-IK
 for linux-nvme@lists.infradead.org; Mon, 21 Jun 2021 06:38:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 23D1768BEB; Mon, 21 Jun 2021 08:38:21 +0200 (CEST)
Date: Mon, 21 Jun 2021 08:38:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCHv6] nvme: allow to re-attach namespaces after all paths
 are down
Message-ID: <20210621063820.GA5618@lst.de>
References: <20210609150118.130650-1-hare@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210609150118.130650-1-hare@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210620_233825_947974_9C7195D2 
X-CRM114-Status: GOOD (  21.14  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Jun 09, 2021 at 05:01:18PM +0200, Hannes Reinecke wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 177cae44b612..6d7c2958b3e2 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -566,6 +566,9 @@ static void nvme_free_ns_head(struct kref *ref)
>  	struct nvme_ns_head *head =
>  		container_of(ref, struct nvme_ns_head, ref);
>  
> +	mutex_lock(&head->subsys->lock);
> +	list_del_init(&head->entry);
> +	mutex_unlock(&head->subsys->lock);
>  	nvme_mpath_remove_disk(head);
>  	ida_simple_remove(&head->subsys->ns_ida, head->instance);
>  	cleanup_srcu_struct(&head->srcu);
> @@ -3806,8 +3809,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
>   out_unlink_ns:
>  	mutex_lock(&ctrl->subsys->lock);
>  	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> -		list_del_init(&ns->head->entry);
>  	mutex_unlock(&ctrl->subsys->lock);
>  	nvme_put_ns_head(ns->head);
>   out_free_queue:
> @@ -3828,8 +3829,6 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  
>  	mutex_lock(&ns->ctrl->subsys->lock);
>  	list_del_rcu(&ns->siblings);
> -	if (list_empty(&ns->head->list))
> -		list_del_init(&ns->head->entry);
>  	mutex_unlock(&ns->ctrl->subsys->lock);
>  
>  	synchronize_rcu(); /* guarantee not available in head->list */
> @@ -3849,7 +3848,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
>  	list_del_init(&ns->list);
>  	up_write(&ns->ctrl->namespaces_rwsem);
>  
> -	nvme_mpath_check_last_path(ns);
> +	nvme_mpath_check_last_path(ns->head);
>  	nvme_put_ns(ns);
>  }
>  
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 23573fe3fc7d..31153f6ec582 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -266,6 +266,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>  	int node = numa_node_id();
>  	struct nvme_ns *ns;
>  
> +	if (!(head->disk->flags & GENHD_FL_UP))
> +		return NULL;
>  	ns = srcu_dereference(head->current_path[node], &head->srcu);
>  	if (unlikely(!ns))
>  		return __nvme_find_path(head, node);
> @@ -281,6 +283,8 @@ static bool nvme_available_path(struct nvme_ns_head *head)
>  {
>  	struct nvme_ns *ns;
>  
> +	if (!(head->disk->flags & GENHD_FL_UP))
> +		return false;
>  	list_for_each_entry_rcu(ns, &head->list, siblings) {
>  		if (test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ns->ctrl->flags))
>  			continue;
> @@ -771,20 +775,36 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
>  #endif
>  }
>  
> -void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> +void nvme_mpath_check_last_path(struct nvme_ns_head *head)
>  {
> +	bool last_path = false;
>  	if (!head->disk)
>  		return;
> +
> +	/* Synchronize with nvme_init_ns_head() */
> +	mutex_lock(&head->subsys->lock);
> +	if (list_empty(&head->list))
> +		last_path = true;
> +	mutex_unlock(&head->subsys->lock);
> +	if (last_path) {
> +		kblockd_schedule_work(&head->requeue_work);
> +		if (head->disk->flags & GENHD_FL_UP) {
> +			nvme_cdev_del(&head->cdev, &head->cdev_device);
> +			del_gendisk(head->disk);
> +		}
>  	}
> +}
> +
> +void nvme_mpath_remove_disk(struct nvme_ns_head *head)
> +{
> +	if (!head->disk)
> +		return;
>  	blk_set_queue_dying(head->disk->queue);
>  	/* make sure all pending bios are cleaned up */
>  	kblockd_schedule_work(&head->requeue_work);
>  	flush_work(&head->requeue_work);
>  	blk_cleanup_queue(head->disk->queue);
> -	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
> +	if (!test_and_clear_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
>  		/*
>  		 * if device_add_disk wasn't called, prevent
>  		 * disk release to put a bogus reference on the

So if a nvme_mpath_set_live comes in between nvme_mpath_check_last_path
and nvme_mpath_remove_disk we'll end up without a gendisk still, don't we?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
