Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61E07CAC592
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Sep 2025 07:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BreBo8ENL2uUzZlZ79Bcrw0bMZIau2nyyV4M8wByjq4=; b=i74fo+SHUrW3zWDETL+pK7M7PJ
	r8A7kEJ/mhCXHfOif/RsedOp83LB0YQqwpigDVDYIdeH5n7+uC64jMrFPQ2f305CYzBEuPRACzTjG
	qcNSTzMkEn8ekNzYpYUzczlA4oD8vRg0ILmxC7p/SYmP3yzS9I8wOBb/Y/K6RA3IOyPEZfFVRyBjZ
	WzS3tSVOI+q+6EtOoNuqh0VIh4aL8/P2nM0+kTlwnudiTuU1VHvwy2K6cOlaWxgto+cRH/wu0Vl14
	Qk4MN3lDlDugFg1udE0yxPceSi+F4d+B6xEP+YC+Ve3Ypkm43DAvJ16nFqOFVSKtbrDkl1bfyKJ4y
	L+B64iJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0b0o-00000009KPQ-1dWV;
	Mon, 22 Sep 2025 07:31:02 +0000
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v0b0g-00000009KKq-3N1k
	for linux-nvme@lists.infradead.org;
	Mon, 22 Sep 2025 07:30:58 +0000
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2CEF1226B4;
	Mon, 22 Sep 2025 07:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758526251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BreBo8ENL2uUzZlZ79Bcrw0bMZIau2nyyV4M8wByjq4=;
	b=u9lWVnbs4Zc9Ce0CUaLDdLJACFIVJCefum/hQQVq1DDegZBVyXFz/uRqRknjZpDuA/3T66
	hF5ifKIoOJHLgbtDu7JOA6LuEJsvJngq2XlqOwAyidxcwxW2AhKiJoIYqWaAa4eIP8N6yO
	YHfFg58se8DrzdCYreuIXtsGpTJUI3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758526251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BreBo8ENL2uUzZlZ79Bcrw0bMZIau2nyyV4M8wByjq4=;
	b=eohtJKtV36C+qpnP6nsjWI5bnrzaFQgye4BrPRt7Wts3q3x1PArMjlwAoxdSpGm64E15mC
	YLpLZSe0asvfpwCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1758526251; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BreBo8ENL2uUzZlZ79Bcrw0bMZIau2nyyV4M8wByjq4=;
	b=u9lWVnbs4Zc9Ce0CUaLDdLJACFIVJCefum/hQQVq1DDegZBVyXFz/uRqRknjZpDuA/3T66
	hF5ifKIoOJHLgbtDu7JOA6LuEJsvJngq2XlqOwAyidxcwxW2AhKiJoIYqWaAa4eIP8N6yO
	YHfFg58se8DrzdCYreuIXtsGpTJUI3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1758526251;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BreBo8ENL2uUzZlZ79Bcrw0bMZIau2nyyV4M8wByjq4=;
	b=eohtJKtV36C+qpnP6nsjWI5bnrzaFQgye4BrPRt7Wts3q3x1PArMjlwAoxdSpGm64E15mC
	YLpLZSe0asvfpwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C98E61388C;
	Mon, 22 Sep 2025 07:30:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Fu8fLyr70GhdfgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 22 Sep 2025 07:30:50 +0000
Message-ID: <70beea89-0ba2-4300-a109-b8d2103fe4d6@suse.de>
Date: Mon, 22 Sep 2025 09:30:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 2/5] nvme-multipath: add support for adaptive I/O
 policy
To: Nilay Shroff <nilay@linux.ibm.com>, linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@kernel.dk,
 dwagner@suse.de, gjoyce@ibm.com
References: <20250921111234.863853-1-nilay@linux.ibm.com>
 <20250921111234.863853-3-nilay@linux.ibm.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20250921111234.863853-3-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250922_003055_243229_17D97715 
X-CRM114-Status: GOOD (  42.81  )
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

On 9/21/25 13:12, Nilay Shroff wrote:
> This commit introduces a new I/O policy named "adaptive". Users can
> configure it by writing "adaptive" to "/sys/class/nvme-subsystem/nvme-
> subsystemX/iopolicy"
> 
> The adaptive policy dynamically distributes I/O based on measured
> completion latency. The main idea is to calculate latency for each path,
> derive a weight, and then proportionally forward I/O according to those
> weights.
> 
> To ensure scalability, path latency is measured per-CPU. Each CPU
> maintains its own statistics, and I/O forwarding uses these per-CPU
> values. Every ~15 seconds, a simple average latency of per-CPU batched
> samples are computed and fed into an Exponentially Weighted Moving
> Average (EWMA):
> 
> avg_latency = div_u64(batch, batch_count);
> new_ewma_latency = (prev_ewma_latency * (WEIGHT-1) + avg_latency)/WEIGHT
> 
> With WEIGHT = 8, this assigns 7/8 (~87.5%) weight to the previous
> latency value and 1/8 (~12.5%) to the most recent latency. This
> smoothing reduces jitter, adapts quickly to changing conditions,
> avoids storing historical samples, and works well for both low and
> high I/O rates. Path weights are then derived from the smoothed (EWMA)
> latency as follows (example with two paths A and B):
> 
>      path_A_score = NSEC_PER_SEC / path_A_ewma_latency
>      path_B_score = NSEC_PER_SEC / path_B_ewma_latency
>      total_score  = path_A_score + path_B_score
> 
>      path_A_weight = (path_A_score * 100) / total_score
>      path_B_weight = (path_B_score * 100) / total_score
> 
> where:
>    - path_X_ewma_latency is the smoothed latency of a path in ns
>    - NSEC_PER_SEC is used as a scaling factor since valid latencies
>      are < 1 second
>    - weights are normalized to a 0–100 scale across all paths.
> 
> Path credits are refilled based on this weight, with one credit
> consumed per I/O. When all credits are consumed, the credits are
> refilled again based on the current weight. This ensures that I/O is
> distributed across paths proportionally to their calculated weight.
> 
> Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
> ---
>   drivers/nvme/host/core.c      |  10 +-
>   drivers/nvme/host/ioctl.c     |   7 +-
>   drivers/nvme/host/multipath.c | 353 ++++++++++++++++++++++++++++++++--
>   drivers/nvme/host/nvme.h      |  33 +++-
>   drivers/nvme/host/pr.c        |   6 +-
>   drivers/nvme/host/sysfs.c     |   2 +-
>   6 files changed, 389 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6b7493934535..6cd1d2c3e6ee 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -689,6 +689,7 @@ static void nvme_free_ns(struct kref *kref)
>   {
>   	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
>   
> +	nvme_mpath_free_stat(ns);
>   	put_disk(ns->disk);
>   	nvme_put_ns_head(ns->head);
>   	nvme_put_ctrl(ns->ctrl);
> @@ -4132,6 +4133,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   	if (nvme_init_ns_head(ns, info))
>   		goto out_cleanup_disk;
>   
> +	if (nvme_mpath_alloc_stat(ns))
> +		goto out_unlink_ns;
> +
>   	/*
>   	 * If multipathing is enabled, the device name for all disks and not
>   	 * just those that represent shared namespaces needs to be based on the
> @@ -4156,7 +4160,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   	}
>   
>   	if (nvme_update_ns_info(ns, info))
> -		goto out_unlink_ns;
> +		goto out_free_ns_stat;
>   
>   	mutex_lock(&ctrl->namespaces_lock);
>   	/*
> @@ -4165,7 +4169,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   	 */
>   	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
>   		mutex_unlock(&ctrl->namespaces_lock);
> -		goto out_unlink_ns;
> +		goto out_free_ns_stat;
>   	}
>   	nvme_ns_add_to_ctrl_list(ns);
>   	mutex_unlock(&ctrl->namespaces_lock);
> @@ -4196,6 +4200,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
>   	list_del_rcu(&ns->list);
>   	mutex_unlock(&ctrl->namespaces_lock);
>   	synchronize_srcu(&ctrl->srcu);
> +out_free_ns_stat:
> +	nvme_mpath_free_stat(ns);
>    out_unlink_ns:
>   	mutex_lock(&ctrl->subsys->lock);
>   	list_del_rcu(&ns->siblings);
> diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
> index 6b3ac8ae3f34..aab7b795a168 100644
> --- a/drivers/nvme/host/ioctl.c
> +++ b/drivers/nvme/host/ioctl.c
> @@ -716,7 +716,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
>   		flags |= NVME_IOCTL_PARTITION;
>   
>   	srcu_idx = srcu_read_lock(&head->srcu);
> -	ns = nvme_find_path(head);
> +	ns = nvme_find_path(head, open_for_write ? WRITE : READ);
>   	if (!ns)
>   		goto out_unlock;
>   
> @@ -747,7 +747,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
>   	int srcu_idx, ret = -EWOULDBLOCK;
>   
>   	srcu_idx = srcu_read_lock(&head->srcu);
> -	ns = nvme_find_path(head);
> +	ns = nvme_find_path(head, open_for_write ? WRITE : READ);
>   	if (!ns)
>   		goto out_unlock;
>   
> @@ -767,7 +767,8 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
>   	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
>   	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
>   	int srcu_idx = srcu_read_lock(&head->srcu);
> -	struct nvme_ns *ns = nvme_find_path(head);
> +	struct nvme_ns *ns = nvme_find_path(head,
> +			ioucmd->file->f_mode & FMODE_WRITE ? WRITE : READ);
>   	int ret = -EINVAL;
>   
>   	if (ns)
> diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
> index 3da980dc60d9..4f56a2bf7ea3 100644
> --- a/drivers/nvme/host/multipath.c
> +++ b/drivers/nvme/host/multipath.c
> @@ -6,6 +6,8 @@
>   #include <linux/backing-dev.h>
>   #include <linux/moduleparam.h>
>   #include <linux/vmalloc.h>
> +#include <linux/blk-mq.h>
> +#include <linux/math64.h>
>   #include <trace/events/block.h>
>   #include "nvme.h"
>   
> @@ -66,9 +68,10 @@ MODULE_PARM_DESC(multipath_always_on,
>   	"create multipath node always except for private namespace with non-unique nsid; note that this also implicitly enables native multipath support");
>   
>   static const char *nvme_iopolicy_names[] = {
> -	[NVME_IOPOLICY_NUMA]	= "numa",
> -	[NVME_IOPOLICY_RR]	= "round-robin",
> -	[NVME_IOPOLICY_QD]      = "queue-depth",
> +	[NVME_IOPOLICY_NUMA]	 = "numa",
> +	[NVME_IOPOLICY_RR]	 = "round-robin",
> +	[NVME_IOPOLICY_QD]       = "queue-depth",
> +	[NVME_IOPOLICY_ADAPTIVE] = "adaptive",
>   };
>   
>   static int iopolicy = NVME_IOPOLICY_NUMA;
> @@ -83,6 +86,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
>   		iopolicy = NVME_IOPOLICY_RR;
>   	else if (!strncmp(val, "queue-depth", 11))
>   		iopolicy = NVME_IOPOLICY_QD;
> +	else if (!strncmp(val, "adaptive", 8))
> +		iopolicy = NVME_IOPOLICY_ADAPTIVE;
>   	else
>   		return -EINVAL;
>   
> @@ -196,6 +201,190 @@ void nvme_mpath_start_request(struct request *rq)
>   }
>   EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
>   
> +int nvme_mpath_alloc_stat(struct nvme_ns *ns)
> +{
> +	gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
> +
> +	if (!ns->head->disk)
> +		return 0;
> +
> +	ns->cpu_stat = __alloc_percpu_gfp(
> +			2 * sizeof(struct nvme_path_stat),
> +			__alignof__(struct nvme_path_stat),
> +			gfp);
> +	if (!ns->cpu_stat)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +#define NVME_EWMA_SHIFT	3
> +static inline u64 ewma_update(u64 old, u64 new)
> +{
> +	return (old * ((1 << NVME_EWMA_SHIFT) - 1) + new) >> NVME_EWMA_SHIFT;
> +}
> +
> +static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
> +{
> +	int cpu, srcu_idx;
> +	unsigned int rw;
> +	struct nvme_path_stat *stat;
> +	struct nvme_ns *cur_ns;
> +	u32 weight;
> +	u64 now, latency, avg_lat_ns;
> +	u64 total_score = 0;
> +	struct nvme_ns_head *head = ns->head;
> +
> +	if (list_is_singular(&head->list))
> +		return;
> +
> +	now = ktime_get_ns();
> +	latency = now >= rq->io_start_time_ns ? now - rq->io_start_time_ns : 0;
> +	if (!latency)
> +		return;
> +
> +	/*
> +	 * As completion code path is serialized(i.e. no same completion queue
> +	 * update code could run simultaneously on multiple cpu) we can safely
> +	 * access per cpu nvme path stat here from another cpu (in case the
> +	 * completion cpu is different from submission cpu).
> +	 * The only field which could be accessed simultaneously here is the
> +	 * path ->weight which may be accessed by this function as well as I/O
> +	 * submission path during path selection logic and we protect ->weight
> +	 * using READ_ONCE/WRITE_ONCE. Yes this may not be 100% accurate but
> +	 * we also don't need to be so accurate here as the path credit would
> +	 * be anyways refilled, based on path weight, once path consumes all
> +	 * its credits. And we limit path weight/credit max up to 100. Please
> +	 * also refer nvme_adaptive_path().
> +	 */
> +	cpu = blk_mq_rq_cpu(rq);
> +	rw = rq_data_dir(rq);
> +	stat = &per_cpu_ptr(ns->cpu_stat, cpu)[rw];
> +

This is tad awkward for setups where #CPUs > #paths.
> +	/*
> +	 * If latency > ~1s then ignore this sample to prevent EWMA from being
> +	 * skewed by pathological outliers (multi-second waits, controller
> +	 * timeouts etc.). This keeps path scores representative of normal
> +	 * performance and avoids instability from rare spikes. If such high
> +	 * latency is real, ANA state reporting or keep-alive error counters
> +	 * will mark the path unhealthy and remove it from the head node list,
> +	 * so we safely skip such sample here.
> +	 */
> +	if (unlikely(latency > NSEC_PER_SEC)) {
> +		stat->nr_ignored++;
> +		return;
> +	}
> +
> +	/*
> +	 * Accumulate latency samples and increment the batch count for each
> +	 * ~15 second interval. When the interval expires, compute the simple
> +	 * average latency over that window, then update the smoothed (EWMA)
> +	 * latency. The path weight is recalculated based on this smoothed
> +	 * latency.
> +	 */
> +	stat->batch += latency;
> +	stat->batch_count++;
> +	stat->nr_samples++;
> +
> +	if (now > stat->last_weight_ts &&
> +			(now - stat->last_weight_ts) >= 15 * NSEC_PER_SEC) {
> +
> +		stat->last_weight_ts = now;
> +
> +		/*
> +		 * Find simple average latency for the last epoch (~15 sec
> +		 * interval).
> +		 */
> +		avg_lat_ns = div_u64(stat->batch, stat->batch_count);
> +
> +		/*
> +		 * Calculate smooth/EWMA (Exponentially Weighted Moving Average)
> +		 * latency. EWMA is preferred over simple average latency
> +		 * because it smooths naturally, reduces jitter from sudden
> +		 * spikes, and adapts faster to changing conditions. It also
> +		 * avoids storing historical samples, and works well for both
> +		 * slow and fast I/O rates.
> +		 * Formula:
> +		 * slat_ns = (prev_slat_ns * (WEIGHT - 1) + (latency)) / WEIGHT
> +		 * With WEIGHT = 8, this assigns 7/8 (~87.5 %) weight to the
> +		 * existing latency and 1/8 (~12.5%) weight to the new latency.
> +		 */
> +		if (unlikely(!stat->slat_ns))
> +			stat->slat_ns = avg_lat_ns;
> +		else
> +			stat->slat_ns = ewma_update(stat->slat_ns, avg_lat_ns);
> +
> +		stat->batch = stat->batch_count = 0;
> +
> +		srcu_idx = srcu_read_lock(&head->srcu);
> +		list_for_each_entry_srcu(cur_ns, &head->list, siblings,
> +				srcu_read_lock_held(&head->srcu)) {

And this is even more awkward as we need to iterate over all paths
(during completion!).

Do we really need to do this?
What would happen if we just measure the latency on the local CPU
and do away with this loop?
We would have less samples, true, but we would even be able to
not only differentiate between distinct path latency but also between
different CPU latencies; I would think this being a bonus for
multi-socket machines.

_And_ we wouldn't need to worry about path failures, which is bound
to expose some race conditions if we need to iterate paths at the
same time than path failures are being handled.

But nevertheless: great job!

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

