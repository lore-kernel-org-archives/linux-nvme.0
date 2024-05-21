Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5766C25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 06:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=//tTej+aTayCrYxzBUucKq2/q2m6pA14E1kIG6nEVwI=; b=gDtv8U1TiRBEKr1hel+Zobhc2b
	pswCuwgIOMQznZU4EMwkUBuVuXFbWi92ycU+42/tN3yVLHXrJrpEX2kkCB+F6OBSCH4jZRi24zgPt
	Hwzl1vQLtT17Z7/X3EOcAf4TgZ12O1nQzRc2BfiMYHHboLPpViZoNsm5QvR7b8RojGMMRaRx5Mi/9
	Vq0148YB6309mxrB/AwzvngMJKPcZNB/Vw4PIx+S2KZq0oFS5heJ8HWpPGzVSGnZO4RAeEF8GLE9r
	GplVZG4+lhoEQoaE+YJ7ltMpFxibM2ibQQvh1e4j2nL06y5N/A9GMcS1demxDOR8ftItNXYygo/U6
	bOTV7OvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9JGi-0000000GVEW-0VOR;
	Tue, 21 May 2024 06:46:40 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9JGc-0000000GVDF-2LB5
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 06:46:38 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6262120A87;
	Tue, 21 May 2024 06:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716273989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//tTej+aTayCrYxzBUucKq2/q2m6pA14E1kIG6nEVwI=;
	b=KhQ8oypWi64G8hSauIDcEONRqgoOvPGi061TmTRMy4/s+0rFFvMTCvHO+hnZ/R/ydoOLD3
	nqXbY+YlyCsKYWZuJf+xIHrNX0bzjh1Azrv4TX+wh0efbwSUjdED8RtRC07eQuTB3NH6jm
	hpAdD2OLvqig1g2IqpvVTgrhurmh4XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716273989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//tTej+aTayCrYxzBUucKq2/q2m6pA14E1kIG6nEVwI=;
	b=XKOKGJ08H6MbYBXJhazGpg/i7tDS8txqHVyLOgcrfFsFzD9uRnNtGyhCfP2Ou51utxiZLx
	GkG8KjpUDHZ6wAAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1716273989; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//tTej+aTayCrYxzBUucKq2/q2m6pA14E1kIG6nEVwI=;
	b=KhQ8oypWi64G8hSauIDcEONRqgoOvPGi061TmTRMy4/s+0rFFvMTCvHO+hnZ/R/ydoOLD3
	nqXbY+YlyCsKYWZuJf+xIHrNX0bzjh1Azrv4TX+wh0efbwSUjdED8RtRC07eQuTB3NH6jm
	hpAdD2OLvqig1g2IqpvVTgrhurmh4XY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1716273989;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=//tTej+aTayCrYxzBUucKq2/q2m6pA14E1kIG6nEVwI=;
	b=XKOKGJ08H6MbYBXJhazGpg/i7tDS8txqHVyLOgcrfFsFzD9uRnNtGyhCfP2Ou51utxiZLx
	GkG8KjpUDHZ6wAAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01F0913A1E;
	Tue, 21 May 2024 06:46:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zyM1OkRDTGYBawAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 21 May 2024 06:46:28 +0000
Message-ID: <f808fa46-e7c7-48e6-8c80-3d28efd0afec@suse.de>
Date: Tue, 21 May 2024 08:46:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] nvme: multipath: Implemented new iopolicy
 "queue-depth"
Content-Language: en-US
To: John Meneghini <jmeneghi@redhat.com>, kbusch@kernel.org, hch@lst.de,
 sagi@grimberg.me, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240520202045.427110-1-jmeneghi@redhat.com>
 <20240520202045.427110-2-jmeneghi@redhat.com>
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20240520202045.427110-2-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240520_234634_965515_AE981E47 
X-CRM114-Status: GOOD (  36.10  )
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

On 5/20/24 22:20, John Meneghini wrote:
> From: "Ewan D. Milne" <emilne@redhat.com>
> 
> The round-robin path selector is inefficient in cases where there is a
> difference in latency between multiple active optimized paths.  In the
> presence of one or more high latency paths the round-robin selector
> continues to the high latency path equally. This results in a bias
> towards the highest latency path and can cause is significant decrease
> in overall performance as IOs pile on the lowest latency path. This
> problem is particularly accute with NVMe-oF controllers.
> 
> The queue-depth policy instead sends I/O requests down the path with the
> least amount of requests in its request queue. Paths with lower latency
> will clear requests more quickly and have less requests in their queues
> compared to higher latency paths. The goal of this path selector is to
> make more use of lower latency paths, which will bring down overall IO
> latency.
> 
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> [tsong: patch developed by Thomas Song @ Pure Storage, fixed whitespace
>        and compilation warnings, updated MODULE_PARM description, and
>        fixed potential issue with ->current_path[] being used]
> Signed-off-by: Thomas Song <tsong@purestorage.com>
> [jmeneghi: vairious changes and improvements, addressed review comments]
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
> Tested-by: Marco Patalano <mpatalan@redhat.com>
> Reviewed-by: Randy Jennings <randyj@redhat.com>
> Tested-by: Jyoti Rani <jani@purestorage.com>
> ---
>   drivers/nvme/host/core.c      |  2 +-
>   drivers/nvme/host/multipath.c | 86 +++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      |  9 ++++
>   3 files changed, 92 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a066429b790d..1dd7c52293ff 100644
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
> index 5397fb428b24..0e2b6e720e95 100644
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
> +	"Default multipath I/O policy; 'numa' (default) , 'round-robin' or 'queue-depth'");
>   
>   void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
>   {
> @@ -127,6 +130,11 @@ void nvme_mpath_start_request(struct request *rq)
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
> @@ -140,8 +148,12 @@ void nvme_mpath_end_request(struct request *rq)
>   {
>   	struct nvme_ns *ns = rq->q->queuedata;
>   
> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> +		atomic_dec_if_positive(&ns->ctrl->nr_active);
> +
>   	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>   		return;
> +

Pointless newline.

>   	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
>   			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
>   			 nvme_req(rq)->start_time);
> @@ -330,6 +342,40 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
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
> +
> +		case NVME_ANA_NONOPTIMIZED:
> +			if (depth < min_depth_nonopt) {
> +				min_depth_nonopt = depth;
> +				best_nonopt = ns;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return best_opt ? best_opt : best_nonopt;
> +}
> +
>   static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
>   {
>   	return nvme_ctrl_state(ns->ctrl) == NVME_CTRL_LIVE &&
> @@ -338,15 +384,27 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
>   
>   inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
>   {
> -	int node = numa_node_id();
> +	int iopolicy = READ_ONCE(head->subsys->iopolicy);
> +	int node;
>   	struct nvme_ns *ns;
>   
> +	/*
> +	 * queue-depth iopolicy does not need to reference ->current_path
> +	 * but round-robin needs the last path used to advance to the
> +	 * next one, and numa will continue to use the last path unless
> +	 * it is or has become not optimized
> +	 */
> +	if (iopolicy == NVME_IOPOLICY_QD)
> +		return nvme_queue_depth_path(head);
> +
> +	node = numa_node_id();
>   	ns = srcu_dereference(head->current_path[node], &head->srcu);
>   	if (unlikely(!ns))
>   		return __nvme_find_path(head, node);
>   
> -	if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_RR)
> +	if (iopolicy == NVME_IOPOLICY_RR)
>   		return nvme_round_robin_path(head, node, ns);
> +
>   	if (unlikely(!nvme_path_is_optimized(ns)))
>   		return __nvme_find_path(head, node);
>   	return ns;
> @@ -798,6 +856,25 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
>   			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
>   }
>   
> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		atomic_set(&ctrl->nr_active, 0);
> +		nvme_mpath_clear_ctrl_paths(ctrl);

You always reset the variables here, even if specified iopolicy is
the same than the currently active one.
I'd rather check if the iopolicy is different before changing the settings.

> +	}
> +	mutex_unlock(&nvme_subsystems_lock);
> +
> +	pr_notice("%s: changed from %s to %s for subsysnqn %s\n", __func__,
> +			nvme_iopolicy_names[old_iopolicy], nvme_iopolicy_names[iopolicy],
> +			subsys->subnqn);
> +}
> +
>   static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>   		struct device_attribute *attr, const char *buf, size_t count)
>   {
> @@ -807,7 +884,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>   
>   	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
>   		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
> -			WRITE_ONCE(subsys->iopolicy, i);
> +			nvme_subsys_iopolicy_update(subsys, i);
>   			return count;
>   		}
>   	}
> @@ -905,6 +982,7 @@ void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
>   	mutex_init(&ctrl->ana_lock);
>   	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
>   	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
> +	atomic_set(&ctrl->nr_active, 0);
>   }
>   
>   int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index f243a5822c2b..f5557889b244 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -50,6 +50,8 @@ extern struct workqueue_struct *nvme_wq;
>   extern struct workqueue_struct *nvme_reset_wq;
>   extern struct workqueue_struct *nvme_delete_wq;
>   
> +extern struct mutex nvme_subsystems_lock;
> +
>   /*
>    * List of workarounds for devices that required behavior not specified in
>    * the standard.
> @@ -190,6 +192,7 @@ enum {
>   	NVME_REQ_CANCELLED		= (1 << 0),
>   	NVME_REQ_USERCMD		= (1 << 1),
>   	NVME_MPATH_IO_STATS		= (1 << 2),
> +	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
>   };
>   
>   static inline struct nvme_request *nvme_req(struct request *req)
> @@ -354,6 +357,7 @@ struct nvme_ctrl {
>   	size_t ana_log_size;
>   	struct timer_list anatt_timer;
>   	struct work_struct ana_work;
> +	atomic_t nr_active;
>   #endif
>   
>   #ifdef CONFIG_NVME_HOST_AUTH
> @@ -402,6 +406,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
>   enum nvme_iopolicy {
>   	NVME_IOPOLICY_NUMA,
>   	NVME_IOPOLICY_RR,
> +	NVME_IOPOLICY_QD,
>   };
>   
>   struct nvme_subsystem {
> @@ -935,6 +940,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
>   void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
>   void nvme_mpath_start_request(struct request *rq);
>   void nvme_mpath_end_request(struct request *rq);
> +void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy);
>   
>   static inline void nvme_trace_bio_complete(struct request *req)
>   {
> @@ -1034,6 +1040,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
>   {
>   	return false;
>   }
> +static inline void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +}
>   #endif /* CONFIG_NVME_MULTIPATH */
>   
>   int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich


