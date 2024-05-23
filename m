Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D914DC25B78
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 03:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vdd3r6K35KSLHu+6qWhITEHymjHF8Is7l7B37+TsM4k=; b=LEeylYyp1djLKXpV1HUlFpzNHz
	ibCtu7zOeAygnkBa/4Oly33vJnx23AkLHV85PD4oLiKujHCJJ8Q3bxlcV9MGx++8EmvS0FVAJ/1Ag
	lzyHEARZvo7KHt/VuwnxaxooWxGH2D/mMJSFGdGuRmF++uh/UDQDO5H8umR6d8ciFjkiXINejuKEZ
	8MgSl3A0UOf6nbYv+XNr9Zvrq5iUV0eVvLW0Z4cPhDnF0GBM0v0hdn8PIzGx9x6trCH0p2a+ZHWGO
	l6pSj2+ApLDQvbCY6Cr5p2awY+jHMlShjNOrWgO8D1OuItRYYQTU7OvZICcLbQvutptkQ1dM1jdyR
	P7setvYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9yh6-00000004q9L-0GdA;
	Thu, 23 May 2024 03:00:40 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9yh1-00000004q82-3RbD
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 03:00:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716433233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vdd3r6K35KSLHu+6qWhITEHymjHF8Is7l7B37+TsM4k=;
	b=VEW9moz+iBoR1aFckv8+2j0GONA7af8irkTSJKhh3ZJSNVpulOC0T7wckm9Dc4jINFSLmR
	aJG1Rh/NwuX452RHfJ30kQC7F04vGWrfCcFv/1zru4gTRlD+tSO+bUFCUjUI3Zyxq2D7FS
	gZVf+e5D31FlZFyvsd74m8mWGw1/w5o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-663I8Ty4NFiT-HTfCj_2YQ-1; Wed,
 22 May 2024 23:00:30 -0400
X-MC-Unique: 663I8Ty4NFiT-HTfCj_2YQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 93C381C02145;
	Thu, 23 May 2024 03:00:29 +0000 (UTC)
Received: from [10.22.8.193] (unknown [10.22.8.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0E7082026D68;
	Thu, 23 May 2024 03:00:29 +0000 (UTC)
Message-ID: <5254a3a5-82b3-4b26-8620-6bd0bbeca4f1@redhat.com>
Date: Wed, 22 May 2024 23:00:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] nvme: multipath: Implemented new iopolicy
 "queue-depth"
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, emilne@redhat.com
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 jrani@purestorage.com, randyj@purestorage.com, hare@kernel.org
References: <20240522165406.702362-1-jmeneghi@redhat.com>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20240522165406.702362-1-jmeneghi@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240522_200036_108144_29A1445F 
X-CRM114-Status: GOOD (  38.31  )
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

OK, I've retested this patch and verified the queue-depth policy is working as expected.

Running the same workload using queue-depth policy instead of round-robin provides a more even distribution of IO across all 
controllers.

https://github.com/johnmeneghini/iopolicy?tab=readme-ov-file#compare-outstanding-ios-per-controller

And it increases the overall throughput per-namespace:

https://github.com/johnmeneghini/iopolicy?tab=readme-ov-file#compare-outstanding-ios-per-namespace

Tested-by: John Meneghini <jmeneghi@redhat.com>


On 5/22/24 12:54, John Meneghini wrote:
> From: "Ewan D. Milne" <emilne@redhat.com>
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
> Signed-off-by: Ewan D. Milne <emilne@redhat.com>
> [jmeneghi: vairious changes and improvements, addressed review comments]
> Signed-off-by: John Meneghini <jmeneghi@redhat.com>
> Link: https://lore.kernel.org/linux-nvme/20240509202929.831680-1-jmeneghi@redhat.com/
> Tested-by: Marco Patalano <mpatalan@redhat.com>
> Reviewed-by: Randy Jennings <randyj@purestorage.com>
> Tested-by: Jyoti Rani <jrani@purestorage.com>
> ---
>   drivers/nvme/host/core.c      |  2 +-
>   drivers/nvme/host/multipath.c | 94 +++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      |  5 ++
>   3 files changed, 96 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 7706df237349..66dc676677d4 100644
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
> index 1bee176fd850..96264c5c979f 100644
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
> @@ -141,6 +149,9 @@ void nvme_mpath_end_request(struct request *rq)
>   {
>   	struct nvme_ns *ns = rq->q->queuedata;
>   
> +	if ((nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE))
> +		atomic_dec_if_positive(&ns->ctrl->nr_active);
> +
>   	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
>   		return;
>   	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
> @@ -332,6 +343,43 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
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
> @@ -340,15 +388,27 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
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
> @@ -800,6 +860,29 @@ static ssize_t nvme_subsys_iopolicy_show(struct device *dev,
>   			  nvme_iopolicy_names[READ_ONCE(subsys->iopolicy)]);
>   }
>   
> +static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys, int iopolicy)
> +{
> +	struct nvme_ctrl *ctrl;
> +	int old_iopolicy = READ_ONCE(subsys->iopolicy);
> +
> +	if (old_iopolicy == iopolicy)
> +		return;
> +
> +	WRITE_ONCE(subsys->iopolicy, iopolicy);
> +
> +	/* iopolicy changes reset the counters and clear the mpath by design */
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		atomic_set(&ctrl->nr_active, 0);
> +		nvme_mpath_clear_ctrl_paths(ctrl);
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
> @@ -809,7 +892,7 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
>   
>   	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++) {
>   		if (sysfs_streq(buf, nvme_iopolicy_names[i])) {
> -			WRITE_ONCE(subsys->iopolicy, i);
> +			nvme_subsys_iopolicy_update(subsys, i);
>   			return count;
>   		}
>   	}
> @@ -920,6 +1003,9 @@ int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>   	    !(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA))
>   		return 0;
>   
> +	/* initialize this in the identify path to cover controller resets */
> +	atomic_set(&ctrl->nr_active, 0);
> +
>   	if (!ctrl->max_namespaces ||
>   	    ctrl->max_namespaces > le32_to_cpu(id->nn)) {
>   		dev_err(ctrl->device,
> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index fc31bd340a63..fa3833d88a85 100644
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
> @@ -195,6 +197,7 @@ enum {
>   	NVME_REQ_CANCELLED		= (1 << 0),
>   	NVME_REQ_USERCMD		= (1 << 1),
>   	NVME_MPATH_IO_STATS		= (1 << 2),
> +	NVME_MPATH_CNT_ACTIVE	= (1 << 3),
>   };
>   
>   static inline struct nvme_request *nvme_req(struct request *req)
> @@ -359,6 +362,7 @@ struct nvme_ctrl {
>   	size_t ana_log_size;
>   	struct timer_list anatt_timer;
>   	struct work_struct ana_work;
> +	atomic_t nr_active;
>   #endif
>   
>   #ifdef CONFIG_NVME_HOST_AUTH
> @@ -407,6 +411,7 @@ static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
>   enum nvme_iopolicy {
>   	NVME_IOPOLICY_NUMA,
>   	NVME_IOPOLICY_RR,
> +	NVME_IOPOLICY_QD,
>   };
>   
>   struct nvme_subsystem {


