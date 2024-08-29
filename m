Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866FEC83F2E
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Aug 2024 14:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JeuC29PncgUK5EsEeJTSC0ml+erkehiCpYxGNdZv1Og=; b=Wa1PybHwqHcN774MeVwYn355Oz
	UrZNMnaP04roRm78g1+oQQndgK9hBTbw4Z4KryGIiYkpk8STLhTZ+cAnr4P7ygxy9vmih4n/z32ML
	KGldrjLOr3K8ZGwC7xXXol1l7wIiyiePCSP/ghxx1WJFB/8/wbiN76/kwudd0rxE0JQagQyOJKJhn
	Z/RqO38BrPK1OEdDdxfLFNbZAa5mcH9yxsFyDntMrbcIrqvGNveHaOeiIhRiq/2Vgf9c1QxfKxd0l
	DvzbRyc5ZL42DExvGRYoIqNsNuU9uwzo8g8qkZ/pksCCXG+THu6r77Qi60HGuLf/0QWe6lqSO6zLa
	ootMMYag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgEZ-00000002QZF-3bEl;
	Thu, 29 Aug 2024 14:34:47 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjgEU-00000002QY6-1BtC
	for linux-nvme@lists.infradead.org;
	Thu, 29 Aug 2024 14:34:45 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F2A622191F
	for <linux-nvme@lists.infradead.org>; Thu, 29 Aug 2024 14:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724942080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeuC29PncgUK5EsEeJTSC0ml+erkehiCpYxGNdZv1Og=;
	b=bew7AAwb5QGKWSj4C4HvXFdbuSVCOKIuuRuGVywNxlfzBflpNQpzCpYyIEPYw/AXmokAAO
	HFf8g4wjIB+p6RYOGbu9IWTRlVJYxlGeWvduhLmx7VPyRVEgAKsWFU26BQzURf6iB6HjZ/
	NaLK7IwyLRYnJb1pIY+U/ftvDQGK6mU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724942080;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeuC29PncgUK5EsEeJTSC0ml+erkehiCpYxGNdZv1Og=;
	b=kiwks/ZYw7tdz179iK8J1y+dzE2NS9VolagZnMXt4FkWe8YCjcRJxRXRLidjMgTZXkpzBY
	ieGxLJFo0OTg+sDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1724942079; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeuC29PncgUK5EsEeJTSC0ml+erkehiCpYxGNdZv1Og=;
	b=ym8JVKngOEuF3Py/3x+0hEEACL9288ljaPQTcf9Ne8DDGE6GAQjelw6SxJz2gzyM8wNAcf
	vwxoybNi3w+zP5t/n1rpgLSbks41OTv0Er1bLSj5o/dnXcCpLmyaqsmqg34x+baNcPAxsg
	wSf3luxRfMws1pCNj+y1R6uYrOpHBc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724942079;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JeuC29PncgUK5EsEeJTSC0ml+erkehiCpYxGNdZv1Og=;
	b=QWlNC1sCO8UwYOgnp7V6f1nsbaTbLrJFDaiQZgR4UHzQWXLvy/I/06MTDnCkOnWRUMZHYx
	MeHvMnJDom4FfZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D97E9139B0
	for <linux-nvme@lists.infradead.org>; Thu, 29 Aug 2024 14:34:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id di8cM/+G0GbIVwAAD6G6ig
	(envelope-from <hare@suse.de>)
	for <linux-nvme@lists.infradead.org>; Thu, 29 Aug 2024 14:34:39 +0000
Message-ID: <69bb27d4-1ea6-4554-9a1d-e19e4e9079c1@suse.de>
Date: Thu, 29 Aug 2024 16:34:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] nvme: freeze both the ns and multipath queues whe
 updating queue limits
To: linux-nvme@lists.infradead.org
References: <20240829063142.2048109-1-hch@lst.de>
 <20240829063142.2048109-4-hch@lst.de>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240829063142.2048109-4-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	PREVIOUSLY_DELIVERED(0.00)[linux-nvme@lists.infradead.org];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240829_073442_885920_D039221B 
X-CRM114-Status: GOOD (  23.49  )
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

On 8/29/24 08:31, Christoph Hellwig wrote:
> We really should not have any I/O outstanding while updating the queue
> limits, as that could introduce inconsistencies between the multipath
> and underlying nodes.  So always freeze the multipath node first and then
> the underlying one, matching the order in nvme_passthru_start.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   drivers/nvme/host/core.c | 41 ++++++++++++++++++++++++++++------------
>   1 file changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 81d2a09dd00f30..0f01a0bf976fd3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2095,6 +2095,24 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id,
>   	lim->chunk_sectors = iob;
>   }
>   
> +/*
> + * Freeze all I/O for a namespace, including clearing out anything on the
> + * multipath node.
> + */
> +static void nvme_ns_freeze(struct nvme_ns *ns)
> +{
> +	if (nvme_ns_head_multipath(ns->head))
> +		blk_mq_freeze_queue(ns->head->disk->queue);
> +	blk_mq_freeze_queue(ns->disk->queue);
> +}
> +
> +static void nvme_ns_unfreeze(struct nvme_ns *ns)
> +{
> +	blk_mq_unfreeze_queue(ns->disk->queue);
> +	if (nvme_ns_head_multipath(ns->head))
> +		blk_mq_unfreeze_queue(ns->head->disk->queue);
> +}
> +
>   /*
>    * The queue_limits structure mixes values that are the hardware limitations for
>    * bio splitting with what is the device configuration.
> @@ -2116,7 +2134,8 @@ static int nvme_update_ns_info_mpath(struct nvme_ns *ns,
>   	struct queue_limits lim;
>   	int ret;
>   
> -	blk_mq_freeze_queue(disk->queue);
> +	WARN_ON_ONCE(disk->queue->mq_freeze_depth < 1);
> +
>   	lim = queue_limits_start_update(disk->queue);
>   	lim.logical_block_size = ns_lim->logical_block_size;
>   	lim.physical_block_size = ns_lim->physical_block_size;
> @@ -2132,7 +2151,6 @@ static int nvme_update_ns_info_mpath(struct nvme_ns *ns,
>   	set_capacity_and_notify(disk, get_capacity(ns->disk));
>   	set_disk_ro(disk, nvme_ns_is_readonly(ns, info));
>   	nvme_mpath_revalidate_paths(ns);
> -	blk_mq_unfreeze_queue(disk->queue);
>   
>   	return ret;
>   }
> @@ -2143,7 +2161,7 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
>   	struct queue_limits lim;
>   	int ret;
>   
> -	blk_mq_freeze_queue(ns->disk->queue);
> +	nvme_ns_freeze(ns);
>   	lim = queue_limits_start_update(ns->disk->queue);
>   	nvme_set_ctrl_limits(ns->ctrl, &lim);
>   	ret = queue_limits_commit_update(ns->disk->queue, &lim);
> @@ -2154,11 +2172,11 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
>   	ns->disk->flags |= GENHD_FL_HIDDEN;
>   	set_bit(NVME_NS_READY, &ns->flags);
>   	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
> +	if (nvme_ns_head_multipath(ns->head))
> +		ret = nvme_update_ns_info_mpath(ns, info, true);
>   
>   out_unfreeze:
> -	blk_mq_unfreeze_queue(ns->disk->queue);
> -	if (nvme_ns_head_multipath(ns->head) && !ret)
> -		ret = nvme_update_ns_info_mpath(ns, info, true);
> +	nvme_ns_unfreeze(ns);
>   	return ret;
>   }
>   
> @@ -2204,7 +2222,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   			goto out;
>   	}
>   
> -	blk_mq_freeze_queue(ns->disk->queue);
> +	nvme_ns_freeze(ns);
>   	ns->head->lba_shift = id->lbaf[lbaf].ds;
>   	ns->head->nuse = le64_to_cpu(id->nuse);
>   	capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
> @@ -2236,7 +2254,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   
>   	ret = queue_limits_commit_update(ns->disk->queue, &lim);
>   	if (ret) {
> -		blk_mq_unfreeze_queue(ns->disk->queue);
> +		nvme_ns_unfreeze(ns);
>   		goto out;
>   	}
>   
> @@ -2254,7 +2272,9 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
>   done:
>   	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
>   	set_bit(NVME_NS_READY, &ns->flags);
> -	blk_mq_unfreeze_queue(ns->disk->queue);
> +	if (nvme_ns_head_multipath(ns->head))
> +		ret = nvme_update_ns_info_mpath(ns, info, unsupported);
> +	nvme_ns_unfreeze(ns);
>   
>   	if (blk_queue_is_zoned(ns->queue)) {
>   		ret = blk_revalidate_disk_zones(ns->disk);

While we're shuffling things around; doesn't the mean that we unfreeze 
the queue (and allow I/O) before we've validated all zones?
Wouldn't it be better if we validate zoned before unfreezing queues?

Otherwise it looks good; I'll give it a spin on my map/unmap testcases.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


