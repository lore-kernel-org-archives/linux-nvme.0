Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4807C982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 12:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/N2j+TpzdH5fYChgBVVWU81IYom7qAkVZBKFMILG6e8=; b=YQcyQ9erLc84+udaVVkDsELh3v
	5clASQV7pPppp8tPfeE792hNWcdWMrFlLihMEAkMmr1+enYgM+Lvf6ir8gboDMSzWoysRMuZUJ1sz
	p/680RwuY08AdmzQZl1nqKhx355I2vp8N7JVCrigNAF9xOm7MOychuiD5c/qePoUpvOvCTz9zrSqD
	XRiOjiUHHIadWvVjmofs4u7WfTECLEPl9fg3MAcMTRgwNY0SIxf8WULDIPEf5ninSKvr0xAvPQ3/k
	hX1UFONA+qb2Qz7Vw5+aPr8pFucpo+xbM8+3imznmWCoz5Sv7FeA77LKaeJOduxaZcJwNvGj71Srz
	SZxJjDyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8d1k-000000022jq-1ENx;
	Mon, 21 Sep 2026 12:21:44 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8d1g-000000022ik-1aJS
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 12:21:42 +0000
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0F2401F88D;
	Mon, 21 Sep 2026 12:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789993294; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/N2j+TpzdH5fYChgBVVWU81IYom7qAkVZBKFMILG6e8=;
	b=vMcD5NsrqTImu+Fqgoosse5gO6i+RTvkRV9beOsFtIzOwF7xu5RGhn58gUFtR1a9b7j0Qr
	mvjf4CuIZ2zeGVYHP7tps2AnfZwiinH/r/cXRRKHbHlKXog87cEImdSd7qAa9ItTBUrR6V
	CA9R6XgqnXH1XTI8VjFuKKEUj/moRvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789993294;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/N2j+TpzdH5fYChgBVVWU81IYom7qAkVZBKFMILG6e8=;
	b=FzMpx8b53VFqBtTNqm8R+StpzG3XE38SDhJrlssrV7jcVeyqW80nIXSYInDaivcXy2fanH
	zj5mnR4RuAe5+BAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wbGEu34E;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CphzqfRh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789993290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/N2j+TpzdH5fYChgBVVWU81IYom7qAkVZBKFMILG6e8=;
	b=wbGEu34EThcTu2JOHqQgjzOusC+x0Wg0QKklo2qFk86kFEPiB70CNv1BYdVCIZMPFUBj3m
	yqBS4jRtjMmxUF+g/fPFea0vjipHuH/nSB+gUdckk7Je0DVq7SVOS1d38xwc7Y7RPO2qZY
	EkDQlhHnC9jF2Merg4eN390kpzqfSWY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789993290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/N2j+TpzdH5fYChgBVVWU81IYom7qAkVZBKFMILG6e8=;
	b=CphzqfRhsBZpzu3UsK8btmaGpjW3EQ4MmUxDo3deuccjjwBUfMEWdf6fJmMQlzmUaWmksg
	Bn1zkAgIrREH7pCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E31513793;
	Mon, 21 Sep 2026 12:21:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id YJ42G0khsWp0NwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 21 Sep 2026 12:21:29 +0000
Message-ID: <db8c19f8-d087-4e3c-8424-6a90760cdf16@suse.de>
Date: Mon, 21 Sep 2026 14:21:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] nvme-tcp: allow multiple queues per hctx
To: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk,
 Keith Busch <kbusch@kernel.org>
References: <20260903152623.614951-1-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260903152623.614951-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0F2401F88D
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_052140_736082_45CDEC08 
X-CRM114-Status: GOOD (  42.75  )
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

On 9/3/26 5:26 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We've observed many workloads may burst large amounts of IO from a one
> thread, which has the nvme tcp driver queue all the work onto a single
> socket and serialized by a single CPU. We can hit a CPU bottleneck
> before saturating the link when this happens.
> 
> Provide an option to ask for more queues for each blk-mq hctx. The
> option is provided in the nvme-fabrics connection string by appending
> "queues_per_hctx=N", where N is the number of queues you want to share
> each hctx. The nvme tcp driver will group those queues under that hctx
> and perform a simple round-robin to dispatch the requests and subsequent
> work. The workqueue provided for this is always unbounded, and we
> provide the CPU hint from the original dispatching CPU in order to
> maintain locality for the completion side.
> 
> The default is the pre-existing 1 queue per hctx, so this patch should
> be a no-op if you don't explicitly opt into this feature.
> 
> Testing with a very capable NIC, a high bandwith workload of QD16 1MB
> reads improved from 7GB/s on the default settings to 24GB/s with 4
> queues per hctx.
> 
> For a more IOPs intensive workload, a QD64 4k random read test improved
> from 184k to 252k.
> 
> This also gets a tighter grouping on application observed latency,
> significantly bringing in the P99 outliers.
> 
> On the down side, there is a minor regression on low depth workloads.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
> One potential subtlety here, this relies on the tcp queue connection's
> existing behavior today, which serializes the sequence. There is a
> proposal to parallelize that process and would break this.
> 
>   drivers/nvme/host/core.c    |  13 +-
>   drivers/nvme/host/fabrics.c |  15 ++
>   drivers/nvme/host/fabrics.h |  11 +-
>   drivers/nvme/host/nvme.h    |   2 +
>   drivers/nvme/host/tcp.c     | 267 ++++++++++++++++++++++++++++--------
>   5 files changed, 248 insertions(+), 60 deletions(-)
> 
Interesting.
We have so far refrained from similar attempts as the idea was that
one CPU would be able to saturate the available bandwidth; additionally
nvme_tcp_io_work() would be gobbling up any available data, so 
scheduling between two instances on the same queue would be pointless.

So question would be: where does the speed up come from?
I do seen that using polling for performance testing would explain the
differences, but do we see an improvement without polling?
If we do then it means that we gain performance by adding more 
connections _on the same CPU_, ie that our implementation
is creating a bottleneck (obviously the block layer is able
to drive more I/O, and equally obvious the physical connection
is able to driver more I/O, too).

> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 758245c799a10..e5e8e4609003d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1194,11 +1194,15 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
>   		blk_flags |= BLK_MQ_REQ_NOWAIT;
>   	if (flags & NVME_SUBMIT_RESERVED)
>   		blk_flags |= BLK_MQ_REQ_RESERVED;
> -	if (qid == NVME_QID_ANY)
> +	if (qid == NVME_QID_ANY) {
>   		req = blk_mq_alloc_request(q, nvme_req_op(cmd), blk_flags);
> -	else
> +	} else {
> +		struct nvme_ctrl *ctrl = q->tag_set->driver_data;
> +
> +		/* the command names a transport queue, not a blk-mq hctx */
>   		req = blk_mq_alloc_request_hctx(q, nvme_req_op(cmd), blk_flags,
> -						qid - 1);
> +				(qid - 1) / ctrl->queues_per_hctx);
> +	}
>   
>   	if (IS_ERR(req))
>   		return PTR_ERR(req);
> @@ -5063,7 +5067,7 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
>   		set->flags |= BLK_MQ_F_BLOCKING;
>   	set->cmd_size = cmd_size;
>   	set->driver_data = ctrl;
> -	set->nr_hw_queues = ctrl->queue_count - 1;
> +	set->nr_hw_queues = (ctrl->queue_count - 1) / ctrl->queues_per_hctx;
>   	set->timeout = NVME_IO_TIMEOUT;
>   	set->nr_maps = nr_maps;
>   	ret = blk_mq_alloc_tag_set(set);
> @@ -5232,6 +5236,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
>   	ctrl->ops = ops;
>   	ctrl->quirks = quirks;
>   	ctrl->numa_node = NUMA_NO_NODE;
> +	ctrl->queues_per_hctx = 1;
>   	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
>   	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
>   	INIT_WORK(&ctrl->fw_act_work, nvme_fw_act_work);
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index 59f823dfbbccb..43ad240586ec8 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -694,6 +694,7 @@ static const match_table_t opt_tokens = {
>   	{ NVMF_OPT_DATA_DIGEST,		"data_digest"		},
>   	{ NVMF_OPT_NR_WRITE_QUEUES,	"nr_write_queues=%d"	},
>   	{ NVMF_OPT_NR_POLL_QUEUES,	"nr_poll_queues=%d"	},
> +	{ NVMF_OPT_QUEUES_PER_HCTX,	"queues_per_hctx=%d"	},
>   	{ NVMF_OPT_TOS,			"tos=%d"		},
>   #ifdef CONFIG_NVME_TCP_TLS
>   	{ NVMF_OPT_KEYRING,		"keyring=%d"		},
> @@ -727,6 +728,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   	/* Set defaults */
>   	opts->queue_size = NVMF_DEF_QUEUE_SIZE;
>   	opts->nr_io_queues = num_online_cpus();
> +	opts->queues_per_hctx = 1;
>   	opts->reconnect_delay = NVMF_DEF_RECONNECT_DELAY;
>   	opts->kato = 0;
>   	opts->duplicate_connect = false;
> @@ -975,6 +977,18 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   			}
>   			opts->nr_poll_queues = token;
>   			break;
> +		case NVMF_OPT_QUEUES_PER_HCTX:
> +			if (match_int(args, &token)) {
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			if (token <= 0 || token > NVMF_MAX_QUEUES_PER_HCTX) {
> +				pr_err("Invalid queues_per_hctx %d\n", token);
> +				ret = -EINVAL;
> +				goto out;
> +			}
> +			opts->queues_per_hctx = token;
> +			break;
>   		case NVMF_OPT_TOS:
>   			if (match_int(args, &token)) {
>   				ret = -EINVAL;
> @@ -1078,6 +1092,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
>   		opts->nr_io_queues = 0;
>   		opts->nr_write_queues = 0;
>   		opts->nr_poll_queues = 0;
> +		opts->queues_per_hctx = 1;
>   		opts->duplicate_connect = true;
>   	} else {
>   		if (!opts->kato)
> diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
> index caf5503d08332..69fccecd4901b 100644
> --- a/drivers/nvme/host/fabrics.h
> +++ b/drivers/nvme/host/fabrics.h
> @@ -67,8 +67,12 @@ enum {
>   	NVMF_OPT_KEYRING	= 1 << 26,
>   	NVMF_OPT_TLS_KEY	= 1 << 27,
>   	NVMF_OPT_CONCAT		= 1 << 28,
> +	NVMF_OPT_QUEUES_PER_HCTX = 1 << 29,
>   };
>   
> +/* Upper bound on transport queues backing a single blk-mq hctx. */
> +#define NVMF_MAX_QUEUES_PER_HCTX	16
> +
>   /**
>    * struct nvmf_ctrl_options - Used to hold the options specified
>    *			      with the parsing opts enum.
> @@ -109,6 +113,7 @@ enum {
>    * @nr_write_queues: number of queues for write I/O
>    * @nr_poll_queues: number of queues for polling I/O
>    * @tos: type of service
> + * @queues_per_hctx: transport queues backing each blk-mq hctx
>    * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
>    */
>   struct nvmf_ctrl_options {
> @@ -138,6 +143,7 @@ struct nvmf_ctrl_options {
>   	bool			data_digest;
>   	unsigned int		nr_write_queues;
>   	unsigned int		nr_poll_queues;
> +	unsigned int		queues_per_hctx;
>   	int			tos;
>   	int			fast_io_fail_tmo;
>   };
> @@ -212,9 +218,10 @@ static inline void nvmf_complete_timed_out_request(struct request *rq)
>   
>   static inline unsigned int nvmf_nr_io_queues(struct nvmf_ctrl_options *opts)
>   {
> -	return min(opts->nr_io_queues, num_online_cpus()) +
> +	return (min(opts->nr_io_queues, num_online_cpus()) +
>   		min(opts->nr_write_queues, num_online_cpus()) +
> -		min(opts->nr_poll_queues, num_online_cpus());
> +		min(opts->nr_poll_queues, num_online_cpus())) *
> +		opts->queues_per_hctx;
>   }
>   
>   static inline unsigned long nvmf_get_virt_boundary(struct nvme_ctrl *ctrl,
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 2cff9fcbf7404..5f92dba7aeca9 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -355,6 +355,8 @@ struct nvme_ctrl {
>   	int numa_node;
>   	struct blk_mq_tag_set *tagset;
>   	struct blk_mq_tag_set *admin_tagset;
> +	/* transport queues per hctx; set before nvme_alloc_io_tag_set() */
> +	unsigned int queues_per_hctx;
>   	struct list_head namespaces;
>   	struct mutex namespaces_lock;
>   	struct srcu_struct srcu;
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 921934028e0b2..6b36fe9445466 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -105,7 +105,10 @@ struct nvme_tcp_ctrl;
>   struct nvme_tcp_queue {
>   	struct socket		*sock;
>   	struct work_struct	io_work;
> +	struct workqueue_struct	*wq;
>   	int			io_cpu;
> +	/* queue_work_on() cpu; only a pod hint on the unbound workqueue */
> +	int			wq_cpu;
>   
>   	struct mutex		queue_lock;
>   	struct mutex		send_mutex;
> @@ -151,6 +154,13 @@ struct nvme_tcp_queue {
>   #endif
>   };
>   
> +/* the transport queues backing one blk-mq hctx, and their rotor */
> +struct nvme_tcp_hctx {
> +	struct nvme_tcp_queue	*queues;
> +	unsigned int		nr;
> +	atomic_t		rotor;
> +};
> +
>   static DEFINE_MUTEX(nvme_tcp_ctrl_mutex);
>   static LIST_HEAD_GUARDED(nvme_tcp_ctrl_list, nvme_tcp_ctrl_mutex);
>   
> @@ -167,6 +177,9 @@ struct nvme_tcp_ctrl {
>   	struct sockaddr_storage src_addr;
>   	struct nvme_ctrl	ctrl;
>   
> +	/* connection being established; relies on connects being serialized */
> +	struct nvme_tcp_queue	*connect_queue;
> +
>   	struct work_struct	err_work;
>   	struct delayed_work	connect_work;
>   	struct nvme_tcp_request async_req;
> @@ -174,6 +187,12 @@ struct nvme_tcp_ctrl {
>   };
>   
>   static struct workqueue_struct *nvme_tcp_wq;
> +/*
> + * Grouped queues must run concurrently, so they go on an unbound workqueue and
> + * let the scheduler place them within the pod.  Retunable via sysfs
> + * affinity_scope.
> + */
> +static struct workqueue_struct *nvme_tcp_unbound_wq;
>   static const struct blk_mq_ops nvme_tcp_mq_ops;
>   static const struct blk_mq_ops nvme_tcp_admin_mq_ops;
>   static int nvme_tcp_try_send(struct nvme_tcp_queue *queue);
> @@ -256,13 +275,15 @@ static inline bool nvme_tcp_tls_configured(struct nvme_ctrl *ctrl)
>   	return ctrl->opts->tls || ctrl->opts->concat;
>   }
>   
> +/* A group shares one tag set, so a command id is unique across its queues. */
>   static inline struct blk_mq_tags *nvme_tcp_tagset(struct nvme_tcp_queue *queue)
>   {
>   	u32 queue_idx = nvme_tcp_queue_id(queue);
>   
>   	if (queue_idx == 0)
>   		return queue->ctrl->admin_tag_set.tags[queue_idx];
> -	return queue->ctrl->tag_set.tags[queue_idx - 1];
> +	return queue->ctrl->tag_set.tags[(queue_idx - 1) /
> +					 queue->ctrl->ctrl.queues_per_hctx];
>   }
>   
>   static inline u8 nvme_tcp_hdgst_len(struct nvme_tcp_queue *queue)
> @@ -400,6 +421,17 @@ static inline bool nvme_tcp_queue_more(struct nvme_tcp_queue *queue)
>   		nvme_tcp_queue_has_pending(queue);
>   }
>   
> +/*
> + * A grouped queue never sends inline: contending for send_mutex and the socket
> + * lock against every sibling io_work costs more than the handoff it saves.
> + */
> +static inline bool nvme_tcp_send_from_submitter(struct nvme_tcp_queue *queue)
> +{
> +	if (nvme_tcp_queue_id(queue) && queue->ctrl->ctrl.queues_per_hctx > 1)
> +		return false;
> +	return queue->io_cpu == raw_smp_processor_id();
> +}
> +
>   static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   		bool last)
>   {
> @@ -411,14 +443,14 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   
>   	/*
>   	 * if we're the first on the send_list and we can try to send
> -	 * directly, otherwise queue io_work. Also, only do that if we
> -	 * are on the same cpu, so we don't introduce contention.
> +	 * directly, otherwise queue io_work. Also, only do that if this
> +	 * context may send, so we don't introduce contention.
>   	 *
>   	 * TLS kTLS send takes ctx->tx_lock while blk_mq holds set->srcu.
>   	 * lockdep reports circular locking via elevator_lock.  Defer TLS
>   	 * sends to the io workqueue instead of inline from this path.
>   	 */
> -	if (queue->io_cpu == raw_smp_processor_id() &&
> +	if (nvme_tcp_send_from_submitter(queue) &&
>   	    !nvme_tcp_queue_tls(queue) &&
>   	    empty && mutex_trylock(&queue->send_mutex)) {
>   		nvme_tcp_send_all(queue);\
We already have indication from TLS that this check really doesn't buy 
us anything. Can't we just drop it completely?

> @@ -426,7 +458,7 @@ static inline void nvme_tcp_queue_request(struct nvme_tcp_request *req,
>   	}
>   
>   	if (last && nvme_tcp_queue_has_pending(queue))
> -		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +		queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
>   }
>   
>   static void nvme_tcp_process_req_list(struct nvme_tcp_queue *queue)
> @@ -555,7 +587,8 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(set->driver_data);
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   	struct nvme_tcp_cmd_pdu *pdu;
> -	int queue_idx = (set == &ctrl->tag_set) ? hctx_idx + 1 : 0;
> +	int queue_idx = (set == &ctrl->tag_set) ?
> +		hctx_idx * ctrl->ctrl.queues_per_hctx + 1 : 0;
>   	struct nvme_tcp_queue *queue = &ctrl->queues[queue_idx];
>   	u8 hdgst = nvme_tcp_hdgst_len(queue);
>   
> @@ -577,24 +610,87 @@ static int nvme_tcp_init_request(struct blk_mq_tag_set *set,
>   	return 0;
>   }
>   
> +static int nvme_tcp_alloc_hctx(struct blk_mq_hw_ctx *hctx,
> +		struct nvme_tcp_queue *queues, unsigned int nr)
> +{
> +	struct nvme_tcp_hctx *qg;
> +
> +	qg = kzalloc_obj(*qg);
> +	if (!qg)
> +		return -ENOMEM;
> +
> +	qg->queues = queues;
> +	qg->nr = nr;
> +	hctx->driver_data = qg;
> +	return 0;
> +}
> +
> +/* The queues of a group are contiguous, starting at hctx_idx * nr + 1. */
>   static int nvme_tcp_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>   		unsigned int hctx_idx)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(data);
> -	struct nvme_tcp_queue *queue = &ctrl->queues[hctx_idx + 1];
> +	unsigned int nr = ctrl->ctrl.queues_per_hctx;
>   
> -	hctx->driver_data = queue;
> -	return 0;
> +	return nvme_tcp_alloc_hctx(hctx, &ctrl->queues[hctx_idx * nr + 1], nr);
>   }
>   
> +/* Only the I/O tag set groups queues; the admin queue is always alone. */
>   static int nvme_tcp_init_admin_hctx(struct blk_mq_hw_ctx *hctx, void *data,
>   		unsigned int hctx_idx)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(data);
> -	struct nvme_tcp_queue *queue = &ctrl->queues[0];
>   
> -	hctx->driver_data = queue;
> -	return 0;
> +	return nvme_tcp_alloc_hctx(hctx, &ctrl->queues[0], 1);
> +}
> +
> +static void nvme_tcp_exit_hctx(struct blk_mq_hw_ctx *hctx, unsigned int hctx_idx)
> +{
> +	kfree(hctx->driver_data);
> +	hctx->driver_data = NULL;
> +}
> +
> +/* Pick the queue of this hctx that the next request goes to. */
> +static struct nvme_tcp_queue *nvme_tcp_hctx_queue(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct nvme_tcp_hctx *qg = hctx->driver_data;
> +	struct nvme_tcp_queue *queue;
> +	unsigned int slot;
> +
> +	if (qg->nr == 1)
> +		return qg->queues;
> +
> +	/* connect_q fabrics commands belong to the connection coming up */
> +	if (unlikely(!hctx->queue->queuedata)) {
> +		struct nvme_tcp_queue *connect =
> +			READ_ONCE(qg->queues->ctrl->connect_queue);
> +
> +		if (connect)
> +			return connect;
> +	}
> +
> +	slot = (unsigned int)atomic_inc_return_relaxed(&qg->rotor) % qg->nr;
> +	queue = &qg->queues[slot];
> +	queue->wq_cpu = raw_smp_processor_id();
> +
> +	return queue;
> +}
> +
> +/*
> + * Kick every queue of the group with work pending: a batch is spread across all
> + * of them, so kicking only the last request's queue leaves the others sitting.
> + */
> +static void nvme_tcp_kick_hctx_queues(struct blk_mq_hw_ctx *hctx)
> +{
> +	struct nvme_tcp_hctx *qg = hctx->driver_data;
> +	struct nvme_tcp_queue *queue = qg->queues;
> +	unsigned int i;
> +
> +	for (i = 0; i < qg->nr; i++, queue++) {
> +		if (nvme_tcp_queue_has_pending(queue))
> +			queue_work_on(queue->wq_cpu, queue->wq,
> +				      &queue->io_work);
> +	}
>   }
>   
>   static enum nvme_tcp_recv_state
> @@ -835,7 +931,7 @@ static int nvme_tcp_handle_r2t(struct nvme_tcp_queue *queue,
>   	nvme_tcp_setup_h2c_data_pdu(req);
>   
>   	llist_add(&req->lentry, &queue->req_list);
> -	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +	queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
>   
>   	return 0;
>   }
> @@ -1122,7 +1218,7 @@ static void nvme_tcp_data_ready(struct sock *sk)
>   	queue = sk->sk_user_data;
>   	if (likely(queue && queue->rd_enabled) &&
>   	    !test_bit(NVME_TCP_Q_POLLING, &queue->flags))
> -		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +		queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
>   
> @@ -1137,7 +1233,7 @@ static void nvme_tcp_write_space(struct sock *sk)
>   		/* Ensure pending TLS partial records are retried */
>   		if (nvme_tcp_queue_tls(queue))
>   			queue->write_space(sk);
> -		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +		queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
>   	}
>   	read_unlock_bh(&sk->sk_callback_lock);
>   }
> @@ -1460,7 +1556,7 @@ static void nvme_tcp_io_work(struct work_struct *w)
>   
>   	} while (!time_after(jiffies, deadline)); /* quota is exhausted */
>   
> -	queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +	queue_work_on(queue->wq_cpu, queue->wq, &queue->io_work);
>   }
>   
>   static void nvme_tcp_free_async_req(struct nvme_tcp_ctrl *ctrl)
> @@ -1712,9 +1808,11 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   {
>   	struct nvme_tcp_ctrl *ctrl = queue->ctrl;
>   	struct blk_mq_tag_set *set = &ctrl->tag_set;
> +	unsigned int qph = ctrl->ctrl.queues_per_hctx;
>   	int qid = nvme_tcp_queue_id(queue) - 1;
>   	unsigned int *mq_map = NULL;
>   	int cpu, min_queues = INT_MAX, io_cpu;
> +	int hctx_idx;
>   
>   	if (wq_unbound)
>   		goto out;
> @@ -1729,20 +1827,34 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
>   	if (WARN_ON(!mq_map))
>   		goto out;
>   
> -	/* Search for the least used cpu from the mq_map */
> +	hctx_idx = qid / qph;
>   	io_cpu = WORK_CPU_UNBOUND;
> -	for_each_online_cpu(cpu) {
> -		int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
>   
> -		if (mq_map[cpu] != qid)
> -			continue;
> -		if (num_queues < min_queues) {
> -			io_cpu = cpu;
> -			min_queues = num_queues;
> +	if (qph > 1) {
> +		/* the group names the hctx's cpu, only a pod hint */
> +		for_each_online_cpu(cpu) {
> +			if (mq_map[cpu] == hctx_idx) {
> +				io_cpu = cpu;
> +				break;
> +			}
> +		}
> +	} else {
> +		/* Search for the least used cpu from the mq_map */
> +		for_each_online_cpu(cpu) {
> +			int num_queues = atomic_read(&nvme_tcp_cpu_queues[cpu]);
> +
> +			if (mq_map[cpu] != hctx_idx)
> +				continue;
> +			if (num_queues < min_queues) {
> +				io_cpu = cpu;
> +				min_queues = num_queues;
> +			}
>   		}
>   	}
> +
>   	if (io_cpu != WORK_CPU_UNBOUND) {
>   		queue->io_cpu = io_cpu;
> +		queue->wq_cpu = io_cpu;
>   		atomic_inc(&nvme_tcp_cpu_queues[io_cpu]);
>   		set_bit(NVME_TCP_Q_IO_CPU_SET, &queue->flags);
>   	}
> @@ -1850,6 +1962,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   	INIT_LIST_HEAD(&queue->send_list);
>   	mutex_init(&queue->send_mutex);
>   	INIT_WORK(&queue->io_work, nvme_tcp_io_work);
> +	queue->wq = (qid && nctrl->queues_per_hctx > 1) ? nvme_tcp_unbound_wq :
> +							  nvme_tcp_wq;
>   	mutex_init(&queue->pf_cache_lock);
>   
>   	if (qid > 0)
> @@ -1907,6 +2021,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
>   	queue->sock->sk->sk_allocation = GFP_ATOMIC;
>   	queue->sock->sk->sk_use_task_frag = false;
>   	queue->io_cpu = WORK_CPU_UNBOUND;
> +	queue->wq_cpu = WORK_CPU_UNBOUND;
>   	queue->request = NULL;
>   	queue->data_remaining = 0;
>   	queue->ddgst_remaining = 0;
> @@ -2086,7 +2201,9 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
>   
>   	if (idx) {
>   		nvme_tcp_set_queue_io_cpu(queue);
> +		WRITE_ONCE(ctrl->connect_queue, queue);
>   		ret = nvmf_connect_io_queue(nctrl, idx);
> +		WRITE_ONCE(ctrl->connect_queue, NULL);
>   	} else
>   		ret = nvmf_connect_admin_queue(nctrl);
>   
> @@ -2226,8 +2343,9 @@ static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   
>   static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   {
> -	unsigned int nr_io_queues;
> -	int ret;
> +	u32 hctxs[HCTX_MAX_TYPES] = { };
> +	unsigned int nr_io_queues, qph;
> +	int ret, i;
>   
>   	nr_io_queues = nvmf_nr_io_queues(ctrl->opts);
>   	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
> @@ -2240,12 +2358,21 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>   		return -ENOMEM;
>   	}
>   
> +	/* the controller may grant fewer, so keep whole groups only */
> +	qph = ctrl->opts->queues_per_hctx;
> +	if (nr_io_queues < qph)
> +		qph = 1;
> +	nr_io_queues -= nr_io_queues % qph;
> +	ctrl->queues_per_hctx = qph;
> +
>   	ctrl->queue_count = nr_io_queues + 1;
> -	dev_info(ctrl->device,
> -		"creating %d I/O queues.\n", nr_io_queues);
> +	dev_info(ctrl->device, "creating %d I/O queues, %u per hctx.\n",
> +		nr_io_queues, qph);
> +
> +	nvmf_set_io_queues(ctrl->opts, nr_io_queues / qph, hctxs);
> +	for (i = 0; i < HCTX_MAX_TYPES; i++)
> +		to_tcp_ctrl(ctrl)->io_queues[i] = hctxs[i] * qph;
>   
> -	nvmf_set_io_queues(ctrl->opts, nr_io_queues,
> -			   to_tcp_ctrl(ctrl)->io_queues);
>   	return __nvme_tcp_alloc_io_queues(ctrl);
>   }
>   
> @@ -2271,7 +2398,8 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   	 * and limited it to the available queues. On reconnects, the
>   	 * queue number might have changed.
>   	 */
> -	nr_queues = min(ctrl->tagset->nr_hw_queues + 1, ctrl->queue_count);
> +	nr_queues = min(ctrl->tagset->nr_hw_queues * ctrl->queues_per_hctx + 1,
> +			ctrl->queue_count);
>   	ret = nvme_tcp_start_io_queues(ctrl, 1, nr_queues);
>   	if (ret)
>   		goto out_cleanup_connect_q;
> @@ -2290,7 +2418,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   			goto out_wait_freeze_timed_out;
>   		}
>   		blk_mq_update_nr_hw_queues(ctrl->tagset,
> -			ctrl->queue_count - 1);
> +			(ctrl->queue_count - 1) / ctrl->queues_per_hctx);
>   		nvme_unfreeze(ctrl);
>   	}
>   
> @@ -2299,7 +2427,7 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
>   	 * start all new queues now.
>   	 */
>   	ret = nvme_tcp_start_io_queues(ctrl, nr_queues,
> -				       ctrl->tagset->nr_hw_queues + 1);
> +			ctrl->tagset->nr_hw_queues * ctrl->queues_per_hctx + 1);
>   	if (ret)
>   		goto out_wait_freeze_timed_out;
>   
> @@ -2840,17 +2968,14 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
>   
>   static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
>   {
> -	struct nvme_tcp_queue *queue = hctx->driver_data;
> -
> -	if (!llist_empty(&queue->req_list))
> -		queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
> +	nvme_tcp_kick_hctx_queues(hctx);
>   }
>   
>   static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   		const struct blk_mq_queue_data *bd)
>   {
>   	struct nvme_ns *ns = hctx->queue->queuedata;
> -	struct nvme_tcp_queue *queue = hctx->driver_data;
> +	struct nvme_tcp_queue *queue = nvme_tcp_hctx_queue(hctx);
>   	struct request *rq = bd->rq;
>   	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
>   	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
> @@ -2859,13 +2984,18 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
>   		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
>   
> +	/* the queue is chosen per dispatch, everything below follows it */
> +	req->queue = queue;
> +
>   	ret = nvme_tcp_setup_cmd_pdu(ns, rq);
>   	if (unlikely(ret))
>   		return ret;
>   
>   	nvme_start_request(rq);
>   
> -	nvme_tcp_queue_request(req, bd->last);
> +	nvme_tcp_queue_request(req, false);
> +	if (bd->last)
> +		nvme_tcp_kick_hctx_queues(hctx);
>   
>   	return BLK_STS_OK;
>   }
> @@ -2873,25 +3003,42 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
>   static void nvme_tcp_map_queues(struct blk_mq_tag_set *set)
>   {
>   	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(set->driver_data);
> +	unsigned int qph = ctrl->ctrl.queues_per_hctx;
> +	u32 hctxs[HCTX_MAX_TYPES];
> +	int i;
> +
> +	/* ctrl->io_queues counts transport queues, the maps count hctxs */
> +	for (i = 0; i < HCTX_MAX_TYPES; i++)
> +		hctxs[i] = ctrl->io_queues[i] / qph;
>   
> -	nvmf_map_queues(set, &ctrl->ctrl, ctrl->io_queues);
> +	nvmf_map_queues(set, &ctrl->ctrl, hctxs);
>   }
>   
>   static int nvme_tcp_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
>   {
> -	struct nvme_tcp_queue *queue = hctx->driver_data;
> -	struct sock *sk = queue->sock->sk;
> -	int ret;
> +	struct nvme_tcp_hctx *qg = hctx->driver_data;
> +	struct nvme_tcp_queue *queue = qg->queues;
> +	unsigned int i;
> +	int ret, nr_cqe = 0;
>   
> -	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> -		return 0;
> +	for (i = 0; i < qg->nr; i++, queue++) {
> +		struct sock *sk = queue->sock->sk;
>   
> -	set_bit(NVME_TCP_Q_POLLING, &queue->flags);
> -	if (sk_can_busy_loop(sk) && skb_queue_empty_lockless(&sk->sk_receive_queue))
> -		sk_busy_loop(sk, true);
> -	ret = nvme_tcp_try_recv(queue);
> -	clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
> -	return ret < 0 ? ret : queue->nr_cqe;
> +		if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
> +			continue;
> +
> +		set_bit(NVME_TCP_Q_POLLING, &queue->flags);
> +		if (sk_can_busy_loop(sk) &&
> +		    skb_queue_empty_lockless(&sk->sk_receive_queue))
> +			sk_busy_loop(sk, true);
> +		ret = nvme_tcp_try_recv(queue);
> +		clear_bit(NVME_TCP_Q_POLLING, &queue->flags);
> +		if (ret < 0)
> +			return ret;
> +		nr_cqe += queue->nr_cqe;
> +	}
> +
> +	return nr_cqe;
>   }
>   
>   static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
> @@ -2927,6 +3074,7 @@ static const struct blk_mq_ops nvme_tcp_mq_ops = {
>   	.init_request	= nvme_tcp_init_request,
>   	.exit_request	= nvme_tcp_exit_request,
>   	.init_hctx	= nvme_tcp_init_hctx,
> +	.exit_hctx	= nvme_tcp_exit_hctx,
>   	.timeout	= nvme_tcp_timeout,
>   	.map_queues	= nvme_tcp_map_queues,
>   	.poll		= nvme_tcp_poll,
> @@ -2938,6 +3086,7 @@ static const struct blk_mq_ops nvme_tcp_admin_mq_ops = {
>   	.init_request	= nvme_tcp_init_request,
>   	.exit_request	= nvme_tcp_exit_request,
>   	.init_hctx	= nvme_tcp_init_admin_hctx,
> +	.exit_hctx	= nvme_tcp_exit_hctx,
>   	.timeout	= nvme_tcp_timeout,
>   };
>   
> @@ -2989,8 +3138,9 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
>   	 */
>   	context_unsafe(INIT_LIST_HEAD(&ctrl->list));
>   	ctrl->ctrl.opts = opts;
> -	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
> -				opts->nr_poll_queues + 1;
> +	ctrl->ctrl.queue_count = (opts->nr_io_queues + opts->nr_write_queues +
> +				  opts->nr_poll_queues) *
> +				 opts->queues_per_hctx + 1;
>   	ctrl->ctrl.sqsize = opts->queue_size - 1;
>   	ctrl->ctrl.kato = opts->kato;
>   
> @@ -3111,7 +3261,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
>   			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
>   			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
>   			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE | NVMF_OPT_TLS |
> -			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT,
> +			  NVMF_OPT_KEYRING | NVMF_OPT_TLS_KEY | NVMF_OPT_CONCAT |
> +			  NVMF_OPT_QUEUES_PER_HCTX,
>   	.create_ctrl	= nvme_tcp_create_ctrl,
>   };
>   
> @@ -3138,6 +3289,13 @@ static int __init nvme_tcp_init_module(void)
>   	if (!nvme_tcp_wq)
>   		return -ENOMEM;
>   
> +	nvme_tcp_unbound_wq = alloc_workqueue("nvme_tcp_unbound_wq",
> +			WQ_MEM_RECLAIM | WQ_HIGHPRI | WQ_SYSFS | WQ_UNBOUND, 0);
> +	if (!nvme_tcp_unbound_wq) {
> +		destroy_workqueue(nvme_tcp_wq);
> +		return -ENOMEM;
> +	}
> +
>   	for_each_possible_cpu(cpu)
>   		atomic_set(&nvme_tcp_cpu_queues[cpu], 0);
>   
> @@ -3157,6 +3315,7 @@ static void __exit nvme_tcp_cleanup_module(void)
>   	mutex_unlock(&nvme_tcp_ctrl_mutex);
>   	flush_workqueue(nvme_delete_wq);
>   
> +	destroy_workqueue(nvme_tcp_unbound_wq);
>   	destroy_workqueue(nvme_tcp_wq);
>   }
>   

In general not a bad idea. Especially if it helps to up our performance.
But this really points to the same problem we're having with HW RAID
HBAs: we have an issue if the per-queue I/O performance is below what
the cpu can drive. Then it _does_ make sense to have more queues than\ 
CPUs, but the layout of which is beyond what blk-mq can handle.
Ideally we should be able to handle that via blk-mq, too.

Nice topic for ALPSS ...

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

