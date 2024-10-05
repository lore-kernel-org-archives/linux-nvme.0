Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97CDCF887F
	for <linux-nvme@archiver.kernel.org>; Sat,  5 Oct 2024 14:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6LkeLFBEZwIvwaWdvviOdBIHs7YdJmbBfJBQqJ5TAtI=; b=RpSkSrnk70kXJpaipiftoGu1+3
	qZxR8gykycBhT8MLl31oDds29QGv25GzJhUCKqjfR7lqwO/hdkeyFDptYMOO2waRHVYStqxNr2Siv
	4eCnnJxwdK7cLstUgAk7sy+v4yELs3PLan8392GJeuE+Pq25BAH6X3zzrIaJxt+WHq1F68jEIRg3+
	h/XHzDNj5lBypcjZ/ct7RMwqGp+018XPP0Aoqo+os0ldj4WoDDAuTmSx6GX4VdrX9eZBpkL2O9+lv
	QL3C91JHTMaoemlP4YLhr/RNGw4fcDU7rrJxIAZU4htB2H3okPKehKBJ8MUvIHrsvDLN/XL5p7EAT
	jtxmrC/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sx5QZ-0000000FRHu-3RfT;
	Sat, 05 Oct 2024 14:06:35 +0000
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sx5QU-0000000FRH5-3kh1
	for linux-nvme@lists.infradead.org;
	Sat, 05 Oct 2024 14:06:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1728137184; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=6LkeLFBEZwIvwaWdvviOdBIHs7YdJmbBfJBQqJ5TAtI=;
	b=WHxlVZvkVJotICm3gdkbCPs6uc4Iglm54GaSPdjRUhF3Jbp9KMcBmAdaBv8R4eY92TPTAO4OK+ajmUvAeQtsx6c5A09bGXucrg+EvDRWD7PcqlLOzPh5Hyi34ftRJaDcv1eZ+z22GHHIi/PcwsiCphcWGO6KlxaPinbreoC8CWU=
Received: from 30.170.72.251(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WGHgC1N_1728137181)
          by smtp.aliyun-inc.com;
          Sat, 05 Oct 2024 22:06:22 +0800
Message-ID: <fafa4e58-96c7-4e13-a81c-2ac2f516df3d@linux.alibaba.com>
Date: Sat, 5 Oct 2024 22:06:21 +0800
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [PATCH] nvmet-rdma: use sbitmap to replace rsp free list
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de, sagi@grimberg.me, kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
References: <20240925105100.88797-1-kanie@linux.alibaba.com>
In-Reply-To: <20240925105100.88797-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241005_070631_452067_2F36EEAE 
X-CRM114-Status: GOOD (  18.45  )
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

gentle ping...

在 2024/9/25 18:51, Guixin Liu 写道:
> We can use sbitmap to manage all the nvmet_rdma_rsp instead of using
> free lists and spinlock, and we can use an additional tag to
> determine whether the nvmet_rdma_rsp is extra allocated.
>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
>   drivers/nvme/target/rdma.c | 53 +++++++++++++++++---------------------
>   1 file changed, 24 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 689bb5d3cfdc..4fa1aa0f46a7 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -75,7 +75,7 @@ struct nvmet_rdma_rsp {
>   	u32			invalidate_rkey;
>   
>   	struct list_head	wait_list;
> -	struct list_head	free_list;
> +	int			tag;
>   };
>   
>   enum nvmet_rdma_queue_state {
> @@ -98,8 +98,7 @@ struct nvmet_rdma_queue {
>   	struct nvmet_sq		nvme_sq;
>   
>   	struct nvmet_rdma_rsp	*rsps;
> -	struct list_head	free_rsps;
> -	spinlock_t		rsps_lock;
> +	struct sbitmap		rsp_tags;
>   	struct nvmet_rdma_cmd	*cmds;
>   
>   	struct work_struct	release_work;
> @@ -172,7 +171,8 @@ static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue);
>   static void nvmet_rdma_free_rsp(struct nvmet_rdma_device *ndev,
>   				struct nvmet_rdma_rsp *r);
>   static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
> -				struct nvmet_rdma_rsp *r);
> +				struct nvmet_rdma_rsp *r,
> +				int tag);
>   
>   static const struct nvmet_fabrics_ops nvmet_rdma_ops;
>   
> @@ -210,15 +210,12 @@ static inline bool nvmet_rdma_need_data_out(struct nvmet_rdma_rsp *rsp)
>   static inline struct nvmet_rdma_rsp *
>   nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
>   {
> -	struct nvmet_rdma_rsp *rsp;
> -	unsigned long flags;
> +	struct nvmet_rdma_rsp *rsp = NULL;
> +	int tag;
>   
> -	spin_lock_irqsave(&queue->rsps_lock, flags);
> -	rsp = list_first_entry_or_null(&queue->free_rsps,
> -				struct nvmet_rdma_rsp, free_list);
> -	if (likely(rsp))
> -		list_del(&rsp->free_list);
> -	spin_unlock_irqrestore(&queue->rsps_lock, flags);
> +	tag = sbitmap_get(&queue->rsp_tags);
> +	if (tag >= 0)
> +		rsp = &queue->rsps[tag];
>   
>   	if (unlikely(!rsp)) {
>   		int ret;
> @@ -226,13 +223,11 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
>   		rsp = kzalloc(sizeof(*rsp), GFP_KERNEL);
>   		if (unlikely(!rsp))
>   			return NULL;
> -		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp);
> +		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp, -1);
>   		if (unlikely(ret)) {
>   			kfree(rsp);
>   			return NULL;
>   		}
> -
> -		rsp->allocated = true;
>   	}
>   
>   	return rsp;
> @@ -241,17 +236,13 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
>   static inline void
>   nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
>   {
> -	unsigned long flags;
> -
> -	if (unlikely(rsp->allocated)) {
> +	if (unlikely(rsp->tag < 0)) {
>   		nvmet_rdma_free_rsp(rsp->queue->dev, rsp);
>   		kfree(rsp);
>   		return;
>   	}
>   
> -	spin_lock_irqsave(&rsp->queue->rsps_lock, flags);
> -	list_add_tail(&rsp->free_list, &rsp->queue->free_rsps);
> -	spin_unlock_irqrestore(&rsp->queue->rsps_lock, flags);
> +	sbitmap_clear_bit(&rsp->queue->rsp_tags, rsp->tag);
>   }
>   
>   static void nvmet_rdma_free_inline_pages(struct nvmet_rdma_device *ndev,
> @@ -404,7 +395,7 @@ static void nvmet_rdma_free_cmds(struct nvmet_rdma_device *ndev,
>   }
>   
>   static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
> -		struct nvmet_rdma_rsp *r)
> +		struct nvmet_rdma_rsp *r, int tag)
>   {
>   	/* NVMe CQE / RDMA SEND */
>   	r->req.cqe = kmalloc(sizeof(*r->req.cqe), GFP_KERNEL);
> @@ -432,6 +423,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
>   	r->read_cqe.done = nvmet_rdma_read_data_done;
>   	/* Data Out / RDMA WRITE */
>   	r->write_cqe.done = nvmet_rdma_write_data_done;
> +	r->tag = tag;
>   
>   	return 0;
>   
> @@ -454,21 +446,23 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
>   {
>   	struct nvmet_rdma_device *ndev = queue->dev;
>   	int nr_rsps = queue->recv_queue_size * 2;
> -	int ret = -EINVAL, i;
> +	int ret = -ENOMEM, i;
> +
> +	if (sbitmap_init_node(&queue->rsp_tags, nr_rsps, -1, GFP_KERNEL,
> +			NUMA_NO_NODE, false, true))
> +		goto out;
>   
>   	queue->rsps = kcalloc(nr_rsps, sizeof(struct nvmet_rdma_rsp),
>   			GFP_KERNEL);
>   	if (!queue->rsps)
> -		goto out;
> +		goto out_free_sbitmap;
>   
>   	for (i = 0; i < nr_rsps; i++) {
>   		struct nvmet_rdma_rsp *rsp = &queue->rsps[i];
>   
> -		ret = nvmet_rdma_alloc_rsp(ndev, rsp);
> +		ret = nvmet_rdma_alloc_rsp(ndev, rsp, i);
>   		if (ret)
>   			goto out_free;
> -
> -		list_add_tail(&rsp->free_list, &queue->free_rsps);
>   	}
>   
>   	return 0;
> @@ -477,6 +471,8 @@ nvmet_rdma_alloc_rsps(struct nvmet_rdma_queue *queue)
>   	while (--i >= 0)
>   		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
>   	kfree(queue->rsps);
> +out_free_sbitmap:
> +	sbitmap_free(&queue->rsp_tags);
>   out:
>   	return ret;
>   }
> @@ -489,6 +485,7 @@ static void nvmet_rdma_free_rsps(struct nvmet_rdma_queue *queue)
>   	for (i = 0; i < nr_rsps; i++)
>   		nvmet_rdma_free_rsp(ndev, &queue->rsps[i]);
>   	kfree(queue->rsps);
> +	sbitmap_free(&queue->rsp_tags);
>   }
>   
>   static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
> @@ -1447,8 +1444,6 @@ nvmet_rdma_alloc_queue(struct nvmet_rdma_device *ndev,
>   	INIT_LIST_HEAD(&queue->rsp_wait_list);
>   	INIT_LIST_HEAD(&queue->rsp_wr_wait_list);
>   	spin_lock_init(&queue->rsp_wr_wait_lock);
> -	INIT_LIST_HEAD(&queue->free_rsps);
> -	spin_lock_init(&queue->rsps_lock);
>   	INIT_LIST_HEAD(&queue->queue_list);
>   
>   	queue->idx = ida_alloc(&nvmet_rdma_queue_ida, GFP_KERNEL);

