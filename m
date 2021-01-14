Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2FCC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:30:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 738D3235FA
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 02:30:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 738D3235FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sP79Ja8ov6/bPh40fmRXbtriBONB1F+Al4e+ih34e7Y=; b=NlePlRj6ex6Gr49MNXQAeV0JL
	2T/2xjf2yAJBNPC52b4vrFQHp/bZwJazHBIdzpCjjlxS8S18Vu7hTaSxYnF8I6fUABIHOD7eM8B7j
	DhlPsHzcL19tAjFQfAi4a2QHoZ7woVIqT+SYdZFJUt1b/6RAecDC1JeAwnzDqbrdAW+V7nt0O7otO
	QVU0saJWZQK6B/AKfMcnWW4XuINhFc4SX1/8vm+38WA3Qal08pSLSdU6iPUh/wVZTjj9ULXtkZF0o
	l0NqYPRhnquQORzD+6HV/ImG/+18V9WEx/uI5QK5Ei5xl6QYGfpRhnOTzDHyvDaZAVB1oMeO41b40
	p0OXV38/A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzsOW-0006sL-QG; Thu, 14 Jan 2021 02:29:52 +0000
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzsOU-0006rn-9K
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 02:29:51 +0000
Received: by mail-wr1-f42.google.com with SMTP id d26so4176328wrb.12
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 18:29:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VrlFugT0A4MwX/4X8Z67yhcTtUJ+zVHZbK90zoOHCSc=;
 b=JoKlGUXw59Grlvo/dLASGOqyfaRvYX/i2Ugc+ZllyTdcHozI3DTy7WkNbfWjMW7ruz
 wqvPXnx5LCpeROY0ldxABHnl6P5Qrg0DOZD7jfG9FPXZy3tBfy02IDnZuULz5BNT5qok
 ojcu0dvl6rJuJxA0SPXgA8IDy+lgHEFBX/ByqQJa+67QXf83cL0O8UDY/l/kShnLABIR
 DkwJPtOr391Bx9lLpjs20L/vDBBu7AtGqu9Dcn4Uxk6+3lAuGUu9H7GD0eVV4uaUfpJk
 6IlEDgqTfJy6EQeyX5rUxdi8kPq7tRPo6HRtlXfTn/Rgkd5ENdFybcWCICANkcjWxaN8
 zMjg==
X-Gm-Message-State: AOAM532nahVbStP3QY4qd+s6mnN1Sv9JRbFhxGBf25eN6jAeFiwODRB9
 1SBJLaNW6kvOd/m6ZkBpUbI=
X-Google-Smtp-Source: ABdhPJwNaGLiBa0E0trZrusu1Kdb9dMlXj0qM6Ee5LRn5T/leTpRlR6SOSUQW6TGt9S+esP1pHoHRA==
X-Received: by 2002:adf:fb49:: with SMTP id c9mr5483493wrs.72.1610591389003;
 Wed, 13 Jan 2021 18:29:49 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:e70c:620a:4d8a:b988?
 ([2601:647:4802:9070:e70c:620a:4d8a:b988])
 by smtp.gmail.com with ESMTPSA id s13sm6955631wra.53.2021.01.13.18.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jan 2021 18:29:48 -0800 (PST)
Subject: Re: [RFC PATCH 2/2] nvmet_tcp: enable polling nvme for completions
To: "Wunderlich, Mark" <mark.wunderlich@intel.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <BYAPR11MB28696A3E9DB98DE8AC271EFDE5C60@BYAPR11MB2869.namprd11.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <65f7e710-a9fd-8ebb-70ad-5a6cfde4cc9e@grimberg.me>
Date: Wed, 13 Jan 2021 18:29:45 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <BYAPR11MB28696A3E9DB98DE8AC271EFDE5C60@BYAPR11MB2869.namprd11.prod.outlook.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_212950_384891_4FBCF377 
X-CRM114-Status: GOOD (  33.79  )
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
Cc: "Vasudevan, Anil" <anil.vasudevan@intel.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


> nvmet_tcp: enable polling nvme for completions
> 
> NVMe device queue interrupt activity can conflict with CPUs
> processing NVMe/TCP network queues.  This patch adds the ability
> to poll an NVMe device for completions, when NVMe device poll
> queues are configured.
> 
> A new non-blocking blk_poll_once() function is introduced to
> provide a one shot option to poll an individual NVMe device
> queue.
> 
> Per-queue tracking of outstanding requests to specific NVMe
> devices established to facilitate directed use of the new
> blk_poll_once() function.
> 
> These changes are viable after adding the previous patch
> that added the idle_poll_period option to io_work(). If this
> option is not enabled then use of NVMe device polling is
> bypassed.
> 
> Signed-off-by: Mark Wunderlich <mark.wunderlich@intel.com>
> ---
>   block/blk-mq.c                    |   22 +++++++++
>   drivers/nvme/target/io-cmd-bdev.c |    6 ++
>   drivers/nvme/target/nvmet.h       |    4 ++
>   drivers/nvme/target/tcp.c         |   90 ++++++++++++++++++++++++++++++++++++-
>   include/linux/blkdev.h            |    1
>   5 files changed, 120 insertions(+), 3 deletions(-)

Patches for block, nvmet core and nvmet-tcp should be split into
sub-patches.

> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 55bcee5dc032..ceacf327f65e 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3832,6 +3832,28 @@ static bool blk_mq_poll_hybrid(struct request_queue *q,
>   	return blk_mq_poll_hybrid_sleep(q, rq);
>   }
>   
> +int blk_poll_once(struct request_queue *q)
> +{
> +	struct blk_mq_hw_ctx *hctx;
> +	int ret;
> +
> +	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
> +		return 0;
> +
> +	hctx = blk_mq_map_queue_type(q, HCTX_TYPE_POLL, smp_processor_id());

This should probably be __smp_processor_id() in a preemptible context.

> +	if (!hctx) {
> +		pr_err("%s: hctx not resolved\n", __func__);
> +		return 0;
> +	}
> +
> +	hctx->poll_invoked++;
> +	ret = q->mq_ops->poll(hctx);
> +	if (ret > 0)
> +		hctx->poll_success++;
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(blk_poll_once);
> +
>   /**
>    * blk_poll - poll for IO completions
>    * @q:  the queue
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 125dde3f410e..1d9ee8546ae1 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -269,6 +269,12 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>   	bio->bi_iter.bi_sector = sector;
>   	bio->bi_private = req;
>   	bio->bi_end_io = nvmet_bio_done;
> +	/* Set hipri flag to trigger use of poll queues */
> +	if ((req->op & REQ_HIPRI) &&
> +	    test_bit(QUEUE_FLAG_POLL, &bio->bi_disk->queue->queue_flags)) {
> +		op |= REQ_HIPRI;
> +		req->queue = bio->bi_disk->queue;
> +	}
>   	bio->bi_opf = op;
>   
>   	blk_start_plug(&plug);
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 559a15ccc322..65900df2b45d 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -341,6 +341,10 @@ struct nvmet_req {
>   	size_t			transfer_len;
>   	size_t			metadata_len;
>   
> +	/* details to support polling */
> +	struct request_queue	*queue;
> +	int			op;
> +
>   	struct nvmet_port	*port;
>   
>   	void (*execute)(struct nvmet_req *req);
> diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
> index 739d67985d93..43a0cc630bc7 100644
> --- a/drivers/nvme/target/tcp.c
> +++ b/drivers/nvme/target/tcp.c
> @@ -62,6 +62,12 @@ enum {
>   	NVMET_TCP_F_INIT_FAILED = (1 << 0),
>   };
>   
> +struct nvmet_tcp_devq {
> +	u32				pend_cnt;
> +	struct request_queue		*queue;
> +	struct list_head		entry;
> +};
> +
>   struct nvmet_tcp_cmd {
>   	struct nvmet_tcp_queue		*queue;
>   	struct nvmet_req		req;
> @@ -82,6 +88,7 @@ struct nvmet_tcp_cmd {
>   	struct kvec			*iov;
>   	u32				flags;
>   
> +	struct nvmet_tcp_devq		*devq;
>   	struct list_head		entry;
>   	struct llist_node		lentry;
>   
> @@ -142,6 +149,9 @@ struct nvmet_tcp_queue {
>   	int			idx;
>   	struct list_head	queue_list;
>   
> +	/* ref to group subsys devq entry */
> +	struct list_head	devq_list;
> +
>   	struct nvmet_tcp_cmd	connect;
>   
>   	struct page_frag_cache	pf_cache;
> @@ -237,6 +247,42 @@ static inline int queue_cpu(struct nvmet_tcp_queue *queue)
>   	return queue->sock->sk->sk_incoming_cpu;
>   }
>   
> +static int nvmet_tcp_track_queue(struct nvmet_tcp_queue *queue)
> +{
> +	struct nvmet_tcp_devq *devq;
> +	struct nvmet_req *req = &queue->cmd->req;
> +
> +	/* track only requests issued as poll requests */
> +	if (req->queue == NULL)
> +		return 0;
> +
> +	list_for_each_entry(devq, &queue->devq_list, entry) {
> +		if (devq->queue == req->queue)
> +			goto update;
> +	}
> +
> +	devq = kzalloc(sizeof(*devq), GFP_KERNEL);
> +	if (!devq)
> +		return -ENOMEM;
> +	list_add_tail(&devq->entry, &queue->devq_list);
> +	devq->queue = req->queue;
> +update:
> +	devq->pend_cnt++;
> +	queue->cmd->devq = devq;
> +	return 0;
> +}
> +
> +static void nvmet_tcp_free_dev_tracking(struct nvmet_tcp_queue *queue)
> +{
> +	struct nvmet_tcp_devq *devq;
> +
> +	while ((devq = list_first_entry_or_null(
> +			&queue->devq_list, struct nvmet_tcp_devq, entry))) {
> +		list_del_init(&devq->entry);
> +		kfree(devq);
> +	}
> +}
> +
>   static inline u8 nvmet_tcp_hdgst_len(struct nvmet_tcp_queue *queue)
>   {
>   	return queue->hdr_digest ? NVME_TCP_DIGEST_LENGTH : 0;
> @@ -479,6 +525,25 @@ static void nvmet_setup_response_pdu(struct nvmet_tcp_cmd *cmd)
>   	}
>   }
>   
> +static inline void nvmet_tcp_poll_init(struct nvmet_req *req)
> +{
> +	req->queue = NULL;
> +	if (idle_poll_period)
> +		req->op |= REQ_HIPRI;
> +	else
> +		req->op = 0;
> +}

All of this patch really exemplifies why none of this should live
in nvme-tcp.

All of this management, tracking, and decisions should live in
nvmet core. But as I said, I'm not convinced that this is an easy
change because it fundamentally changes the target architecture (not
saying we shouldn't do this, but it is a rather intrusive change).

Would be good to hear what others think on this. I do think that all
transports would benefit from backend device polling (despite
demonstrated on nvme-tcp).

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
