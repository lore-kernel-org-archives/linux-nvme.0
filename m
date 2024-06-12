Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 772BCC27C53
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jun 2024 06:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Kv4XHC9GTpRAkkL1nuyfozm6BHGpzmSviYbo3rNfZW8=; b=ACARMrZq+T7fzAGaYGyNcd/DKv
	zs+zirWVRjNwg72GwVF27Fa1PiQKYijWcOqxSSmiN5Qoqd66Jp2qe7cX3DSzJbZfQ5zE2JdxUFWU5
	/W5OCkXnLH7b1oLTi5UxO/BGcq0PqLMq/dw3kSBBEaGDENZGEd3+xjnzJQDtoUzAKvcMm5kE5BDdI
	aqlJ7rzs7FCz19XtD5EWUWU6i4WacG/OELkwcMHrWEPofoPbPVz0bkRWlmHGmJ68HEsOE+klSPZau
	RBNtS9z69tPApJiN9VRJUDrMN5FRF82L/NKu6LXFY1lsFtoy2H9UdXEroMWcRo5qmjmFnvS6jn1j6
	Fp5fMB1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHHCo-0000000BEKh-2s0c;
	Wed, 12 Jun 2024 06:11:34 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sHHCi-0000000BEJg-1OYF
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jun 2024 06:11:31 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0C35C21079;
	Wed, 12 Jun 2024 06:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718172684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kv4XHC9GTpRAkkL1nuyfozm6BHGpzmSviYbo3rNfZW8=;
	b=q5uaLl4yJUJAEDcOqCHyalHW9VHPYkL9FuOd+WOdFpIbfjmwh/o4Ofifkpzv/ZPcJe51RW
	JryOgpCy683HX4at35ONWXunzSiFO/1TrdrAlKWaM26EzLxpTs2QQaMxwK6yyRlWYx+rJ8
	y4A2Gcd/7F3UklHEveNgX9JiV1vWtKQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718172684;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kv4XHC9GTpRAkkL1nuyfozm6BHGpzmSviYbo3rNfZW8=;
	b=6ROSClDrPwhbB/H6nqJSRsyQGyoTGtNxAagKILHn7e2q9M/EbIEBUTI/F+nXlL8YYPNnFa
	awuY2gaiq1CqcLCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718172683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kv4XHC9GTpRAkkL1nuyfozm6BHGpzmSviYbo3rNfZW8=;
	b=0S0AtOsX0NffzEwNTVEY/6QRw0244voAxV+kxVV4zDJVoJ0TZ31UkERd/9L5MvpjvFhEYO
	uDqOrw5WFpjjeIIiOTE6q1z74y1EDvBNLks7A1iY6kXS15cBgITdojmYEFgH3jcrEyhbfL
	2B68rfX1+le5W7Jab9QGKCB2UOOIMg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718172683;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kv4XHC9GTpRAkkL1nuyfozm6BHGpzmSviYbo3rNfZW8=;
	b=bhdppViTUKO6MMo0SS4Ck+nbNnqEa+5x88Zb93S+jwTcqvJP5wywnr1RP2adkNG9k/quEO
	4wLYPgcIl+TQL2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B4DD1372E;
	Wed, 12 Jun 2024 06:11:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 04pGAAo8aWb1NQAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 12 Jun 2024 06:11:21 +0000
Message-ID: <8a4f965d-91af-4e70-b605-fa5fe2fee43a@suse.de>
Date: Wed, 12 Jun 2024 08:11:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] nvme-multipath: implement "queue-depth" iopolicy
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240612002034.1299922-1-jmeneghi@redhat.com>
 <20240612002034.1299922-2-jmeneghi@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240612002034.1299922-2-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,purestorage.com:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240611_231128_560250_49F03F36 
X-CRM114-Status: GOOD (  27.26  )
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

On 6/12/24 02:20, John Meneghini wrote:
> From: Thomas Song <tsong@purestorage.com>
> 
> The round-robin path selector is inefficient in cases where there is a
> difference in latency between paths.  In the presence of one or more
> high latency paths the round-robin selector continues to use the high
> latency path equally. This results in a bias towards the highest latency
> path and can cause a significant decrease in overall performance as IOs
> pile on the highest latency path. This problem is acute with NVMe-oF
> controllers.
> 
> The queue-depth policy instead sends I/O requests down the path with the
> least amount of requests in its request queue. Paths with lower latency
> will clear requests more quickly and have less requests in their queues
> compared to higher latency paths. The goal of this path selector is to
> make more use of lower latency paths which will bring down overall IO
> latency and increase throughput and performance.
> 
> Signed-off-by: Thomas Song <tsong@purestorage.com>
> [emilne: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>        and compilation warnings, updated MODULE_PARM description, and
>        fixed potential issue with ->current_path[] being used]
> Co-developed-by: Ewan D. Milne <emilne@redhat.com>
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> [jmeneghi: vairious changes and improvements, addressed review comments]
> Co-developed-by: John Meneghini <jmeneghi@redhat.com>
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
> Tested-by: Marco Patalano <mpatalan@redhat.com>
> Reviewed-by: Randy Jennings <randyj@purestorage.com>
> Tested-by: Jyoti Rani <jrani@purestorage.com>
> ---
>   drivers/nvme/host/core.c      |   2 +-
>   drivers/nvme/host/multipath.c | 108 +++++++++++++++++++++++++++++++---
>   drivers/nvme/host/nvme.h      |   5 ++
>   3 files changed, 106 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7c9f91314d36..c10ff8815d82 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -110,7 +110,7 @@ struct workqueue_struct *nvme_delete_wq;
>   EXPORT_SYMBOL_GPL(nvme_delete_wq);
>   
>   static LIST_HEAD(nvme_subsystems);
> -static DEFINE_MUTEX(nvme_subsystems_lock);
> +DEFINE_MUTEX(nvme_subsystems_lock);
>   
>   static DEFINE_IDA(nvme_instance_ida);
>   static dev_t nvme_ctrl_base_chr_devt;
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 03a6868f4dbc..fe10e0cebcf0 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -17,6 +17,7 @@ MODULE_PARM_DESC(multipath,
>   static const char *nvme_iopolicy_names[] = {
>   	[NVME_IOPOLICY_NUMA]	= "numa",
>   	[NVME_IOPOLICY_RR]	= "round-robin",
> +	[NVME_IOPOLICY_QD]      = "queue-depth",
>   };
>   
>   static int iopolicy = NVME_IOPOLICY_NUMA;
> @@ -29,6 +30,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>   		iopolicy = NVME_IOPOLICY_NUMA;
>   	else if (!strncmp(val, "round-robin", 11))
>   		iopolicy = NVME_IOPOLICY_RR;
> +	else if (!strncmp(val, "queue-depth", 11))
> +		iopolicy = NVME_IOPOLICY_QD;
>   	else
>   		return -EINVAL;
>   
> @@ -43,7 +46,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
>   module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
>   	&iopolicy, 0644);
>   MODULE_PARM_DESC(iopolicy,
> -	"Default multipath I/O policy; 'numa' (default) or 'round-robin'");
> +	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
>   
>   void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>   {
> @@ -128,6 +131,11 @@ void nvme_mpath_start_request(struct request *rq)
>   	struct nvme_ns *ns = rq->q->queuedata;
>   	struct gendisk *disk = ns->head->disk;
>   
> +	if (READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) {
> +		atomic_inc(&ns->ctrl->nr_active);
> +		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
> +	}
> +
>   	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
>   		return;
>   
> @@ -140,6 +148,12 @@ EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
>   void nvme_mpath_end_request(struct request *rq)
>   {
>   	struct nvme_ns *ns = rq->q->queuedata;
> +	int result;
> +
> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
> +		result = atomic_dec_if_positive(&ns->ctrl->nr_active);
> +		WARN_ON_ONCE(result < 0);
> +	}
>   
>   	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>   		return;
> @@ -291,10 +305,15 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
>   	return list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
>   }
>   
> -static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
> -		int node, struct nvme_ns *old)
> +static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
>   {
> -	struct nvme_ns *ns, *found = NULL;
> +	struct nvme_ns *ns, *old, *found = NULL;
> +	int node = numa_node_id();
> +
> +	old = srcu_dereference(head->current_path[node], &head->srcu);
> +
> +	if (unlikely(!old))
> +		return __nvme_find_path(head, node);
>   
>   	if (list_is_singular(&head->list)) {
>   		if (nvme_path_is_disabled(old))
> @@ -334,13 +353,49 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
>   	return found;
>   }
>   
> +static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
> +{
> +	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
> +	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
> +	unsigned int depth;
> +
> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (nvme_path_is_disabled(ns))
> +			continue;
> +
> +		depth = atomic_read(&ns->ctrl->nr_active);
> +
> +		switch (ns->ana_state) {
> +		case NVME_ANA_OPTIMIZED:
> +			if (depth < min_depth_opt) {
> +				min_depth_opt = depth;
> +				best_opt = ns;
> +			}
> +			break;
> +		case NVME_ANA_NONOPTIMIZED:
> +			if (depth < min_depth_nonopt) {
> +				min_depth_nonopt = depth;
> +				best_nonopt = ns;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +
> +		if (min_depth_opt == 0)
> +			return best_opt;
> +	}
> +
> +	return best_opt ? best_opt : best_nonopt;
> +}
> +
>   static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
>   {
>   	return nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE &&
>   		ns->ana_state == NVME_ANA_OPTIMIZED;
>   }
>   
> -inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
> +static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
>   {
>   	int node = numa_node_id();
>   	struct nvme_ns *ns;
> @@ -349,13 +404,25 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   	if (unlikely(!ns))
>   		return __nvme_find_path(head, node);
>   
> -	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
> -		return nvme_round_robin_path(head, node, ns);
>   	if (unlikely(!nvme_path_is_optimized(ns)))
>   		return __nvme_find_path(head, node);
> +

Pointless newline.

But other than that:

Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


