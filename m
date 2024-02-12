Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9603C48297
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Feb 2024 07:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W9F4Vr8hUZh5xtHdT1b8CJ3EgNU0fJ+F1cuzoNRnPxQ=; b=L4/phrVwJpi2Wyj48fMRxxKJ0u
	wtRWD9s3YNQrJArBNFBUY6YPuQ9XgD0eZc+BrcnvTVpsZPtqtEXZMeDiwgrc36EU7/uU5HmUwjxY/
	E1BXiB1I4+ah/CnsHa8rF7AzA2USQC6F0S13Vbdj6fsAxAE1WYlJQuEF01gyKtPoQ+TKHCIeld471
	RkyrKe6hX4/l3ze1XR4uZsXXJtDtAVwIN0MeQuhWV3tqfVajz7J2yOEYw+qnnW7G3ADhmyGp0F9ck
	+BQ9qxQBTzHT/arp5pX5YwBfy3uJw7j0/xjxjmuCCwRsMehVH4W0kBV7MpLQDbgOon6W3lfRsYbJS
	9RLvafBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQoG-00000004WXz-1jaF;
	Mon, 12 Feb 2024 07:33:00 +0000
Received: from smtp-out1.suse.de ([195.135.223.130])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZQoB-00000004WWY-2jND
	for linux-nvme@lists.infradead.org;
	Mon, 12 Feb 2024 07:32:58 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3369221C5F;
	Mon, 12 Feb 2024 07:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707723174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9F4Vr8hUZh5xtHdT1b8CJ3EgNU0fJ+F1cuzoNRnPxQ=;
	b=fnzV5ckdxtpDC810M+7exLzu4a5lKVT0hkHEl3VLgiIvZR++W+Xxuh0Rs9qTK0fDe9NObA
	TBDPOjrQcr1W7G1RlwL99+MjLc5K9tXrCanGNhFlCuEB3yM6SPxVpynEnph2uTI8ccw6UW
	JwCpNJj1s2iwni2LNFKQac62nUoKdbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707723174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9F4Vr8hUZh5xtHdT1b8CJ3EgNU0fJ+F1cuzoNRnPxQ=;
	b=Ih9+DjBCIzYYnxtWt8tKqGdK0KNzgEG4OiSOaMPO8wsPiW5qw7rS8TVcnOIWPtxdPCMdIv
	bpM9IH3hFGz451BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707723174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9F4Vr8hUZh5xtHdT1b8CJ3EgNU0fJ+F1cuzoNRnPxQ=;
	b=fnzV5ckdxtpDC810M+7exLzu4a5lKVT0hkHEl3VLgiIvZR++W+Xxuh0Rs9qTK0fDe9NObA
	TBDPOjrQcr1W7G1RlwL99+MjLc5K9tXrCanGNhFlCuEB3yM6SPxVpynEnph2uTI8ccw6UW
	JwCpNJj1s2iwni2LNFKQac62nUoKdbU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707723174;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9F4Vr8hUZh5xtHdT1b8CJ3EgNU0fJ+F1cuzoNRnPxQ=;
	b=Ih9+DjBCIzYYnxtWt8tKqGdK0KNzgEG4OiSOaMPO8wsPiW5qw7rS8TVcnOIWPtxdPCMdIv
	bpM9IH3hFGz451BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 018D713985;
	Mon, 12 Feb 2024 07:32:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YB7MN6TJyWWoZAAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 12 Feb 2024 07:32:52 +0000
Message-ID: <eded0bd7-ef9e-4cd3-96fb-cd7d312b677e@suse.de>
Date: Mon, 12 Feb 2024 08:32:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] block: pass a queue_limits argument to
 blk_alloc_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240212064609.1327143-1-hch@lst.de>
 <20240212064609.1327143-9-hch@lst.de>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240212064609.1327143-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[14];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240211_233255_866855_6757418D 
X-CRM114-Status: GOOD (  24.04  )
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

On 2/12/24 14:46, Christoph Hellwig wrote:
> Pass a queue_limits to blk_alloc_queue and apply it after validating and
> capping the values using blk_validate_limits.  This will allow allocating
> queues with valid queue limits instead of setting the values one at a
> time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c | 26 ++++++++++++++++++--------
>   block/blk-mq.c   |  7 ++++---
>   block/genhd.c    |  5 +++--
>   3 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index cb56724a8dfb25..a16b5abdbbf56f 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -394,24 +394,34 @@ static void blk_timeout_work(struct work_struct *work)
>   {
>   }
>   
> -struct request_queue *blk_alloc_queue(int node_id)
> +struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>   {
>   	struct request_queue *q;
> +	int error;
>   
>   	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | __GFP_ZERO,
>   				  node_id);
>   	if (!q)
> -		return NULL;
> +		return ERR_PTR(-ENOMEM);
>   
>   	q->last_merge = NULL;
>   
>   	q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
> -	if (q->id < 0)
> +	if (q->id < 0) {
> +		error = q->id;
>   		goto fail_q;
> +	}
>   
>   	q->stats = blk_alloc_queue_stats();
> -	if (!q->stats)
> +	if (!q->stats) {
> +		error = -ENOMEM;
>   		goto fail_id;
> +	}
> +
> +	error = blk_set_default_limits(lim);
> +	if (error)
> +		goto fail_stats;
> +	q->limits = *lim;
>   
>   	q->node = node_id;
>   
> @@ -436,12 +446,12 @@ struct request_queue *blk_alloc_queue(int node_id)
>   	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
>   	 * See blk_register_queue() for details.
>   	 */
> -	if (percpu_ref_init(&q->q_usage_counter,
> +	error = percpu_ref_init(&q->q_usage_counter,
>   				blk_queue_usage_counter_release,
> -				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
> +				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
> +	if (error)
>   		goto fail_stats;
>   
> -	blk_set_default_limits(&q->limits);
>   	q->nr_requests = BLKDEV_DEFAULT_RQ;
>   
>   	return q;
> @@ -452,7 +462,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>   	ida_free(&blk_queue_ida, q->id);
>   fail_q:
>   	kmem_cache_free(blk_requestq_cachep, q);
> -	return NULL;
> +	return ERR_PTR(error);
>   }
>   
>   /**
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 6d2f7b5caa01d8..9dd8055cc5246d 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4086,12 +4086,13 @@ void blk_mq_release(struct request_queue *q)
>   static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
>   		void *queuedata)
>   {
> +	struct queue_limits lim = { };
>   	struct request_queue *q;
>   	int ret;
>   
> -	q = blk_alloc_queue(set->numa_node);
> -	if (!q)
> -		return ERR_PTR(-ENOMEM);
> +	q = blk_alloc_queue(&lim, set->numa_node);
> +	if (IS_ERR(q))
> +		return q;
>   	q->queuedata = queuedata;
>   	ret = blk_mq_init_allocated_queue(set, q);
>   	if (ret) {
> diff --git a/block/genhd.c b/block/genhd.c
> index d74fb5b4ae6818..7a8fd57c51f73c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1393,11 +1393,12 @@ struct gendisk *__alloc_disk_node(struct request_queue *q, int node_id,
>   
>   struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
>   {
> +	struct queue_limits lim = { };
>   	struct request_queue *q;
>   	struct gendisk *disk;
>   
> -	q = blk_alloc_queue(node);
> -	if (!q)
> +	q = blk_alloc_queue(&lim, node);
> +	if (IS_ERR(q))
>   		return NULL;
>   
>   	disk = __alloc_disk_node(q, node, lkclass);
Ah, here it is.

Please move the declaration from patch #4 to this one.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), GF: Ivo Totev, Andrew McDonald,
Werner Knoblich


