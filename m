Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36256C433E0
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 08:12:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E2222A84
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 08:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E2222A84
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PdLspOkhqqtcVkyq2XShSp9MHPyqTNHoM/6veKW3EmQ=; b=2Pdr7/Ymu6vi0Wddu1XTOhORV
	EAjj8Gm1cPbckshQkkFfabKZuvTkH9mnbyW5A5P6D4Z6lc7v9RDp4wrhr2wFq8mPDzemDomsDIZSR
	tRlp1IvZD3FJNYSoJUuS7Jox22CnxkYulD923SNLoYatpznNllcLaXYNPjyhnuCI63TRM2U9cJ5g/
	FTswAKAAlZNGzCNfISTSmVmprs2Yttx0j1ijoE4dBwv3y3d8EvP+0s0QArYxdH4zbNQlipAjG20EF
	srvstJS2YOd/0bUIMwJKZCKmqUxQW40G8suN6ljm+XMSMTSzMvfJPH7QFbGGsB20oN+iQX1wiiswd
	YcwxOgJTw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kysIx-0003gT-4k; Mon, 11 Jan 2021 08:11:59 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kysIs-0003ek-Ur
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 08:11:56 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BE95667373; Mon, 11 Jan 2021 09:11:46 +0100 (CET)
Date: Mon, 11 Jan 2021 09:11:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: leonid.ravich@dell.com
Subject: Re: [PATCH v2] nvmet-fc: associations list protected by rcu,
 instead of spinlock_irq where possible.
Message-ID: <20210111081146.GA27116@lst.de>
References: <20201224110542.22219-1-leonid.ravich@dell.com>
 <1609697575-103348-1-git-send-email-leonid.ravich@dell.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1609697575-103348-1-git-send-email-leonid.ravich@dell.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_031155_238980_523D3833 
X-CRM114-Status: GOOD (  21.93  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, james.smart@broadcom.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, lravich@gmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

James, can you review this patch?

On Sun, Jan 03, 2021 at 08:12:53PM +0200, leonid.ravich@dell.com wrote:
> From: Leonid Ravich <Leonid.Ravich@emc.com>
> 
> searching assoc_list protected by rcu_read_lock if list not changed inline.
> and according to the rcu list rules.
> 
> queue array embedded into nvmet_fc_tgt_assoc protected by rcu_read_lock
> according to rcu dereference/assign rules.
> 
> queue and assoc object freed after grace period by call_rcu.
> 
> tgtport lock taken for changing assoc_list.
> 
> Reviewed-by: Eldad Zinger <Eldad.Zinger@dell.com>
> Reviewed-by: Elad Grupi <Elad.Grupi@dell.com>
> Signed-off-by: Leonid Ravich <Leonid.Ravich@emc.com>
> ---
> 1) fixed sytle issus 
> 2) queues array protects by rcu as well
> 
>  drivers/nvme/target/fc.c | 81 +++++++++++++++++++++++-------------------------
>  1 file changed, 38 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index cd4e73a..c14c60b 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -145,6 +145,7 @@ struct nvmet_fc_tgt_queue {
>  	struct list_head		avail_defer_list;
>  	struct workqueue_struct		*work_q;
>  	struct kref			ref;
> +	struct rcu_head			rcu;
>  	struct nvmet_fc_fcp_iod		fod[];		/* array of fcp_iods */
>  } __aligned(sizeof(unsigned long long));
>  
> @@ -167,6 +168,7 @@ struct nvmet_fc_tgt_assoc {
>  	struct nvmet_fc_tgt_queue	*queues[NVMET_NR_QUEUES + 1];
>  	struct kref			ref;
>  	struct work_struct		del_work;
> +	struct rcu_head			rcu;
>  };
>  
>  
> @@ -790,7 +792,6 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  			u16 qid, u16 sqsize)
>  {
>  	struct nvmet_fc_tgt_queue *queue;
> -	unsigned long flags;
>  	int ret;
>  
>  	if (qid > NVMET_NR_QUEUES)
> @@ -829,9 +830,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  		goto out_fail_iodlist;
>  
>  	WARN_ON(assoc->queues[qid]);
> -	spin_lock_irqsave(&assoc->tgtport->lock, flags);
> -	assoc->queues[qid] = queue;
> -	spin_unlock_irqrestore(&assoc->tgtport->lock, flags);
> +	rcu_assign_pointer(assoc->queues[qid], queue);
>  
>  	return queue;
>  
> @@ -851,11 +850,8 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  {
>  	struct nvmet_fc_tgt_queue *queue =
>  		container_of(ref, struct nvmet_fc_tgt_queue, ref);
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&queue->assoc->tgtport->lock, flags);
> -	queue->assoc->queues[queue->qid] = NULL;
> -	spin_unlock_irqrestore(&queue->assoc->tgtport->lock, flags);
> +	rcu_assign_pointer(queue->assoc->queues[queue->qid], NULL);
>  
>  	nvmet_fc_destroy_fcp_iodlist(queue->assoc->tgtport, queue);
>  
> @@ -863,7 +859,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  
>  	destroy_workqueue(queue->work_q);
>  
> -	kfree(queue);
> +	kfree_rcu(queue, rcu);
>  }
>  
>  static void
> @@ -965,24 +961,23 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  	struct nvmet_fc_tgt_queue *queue;
>  	u64 association_id = nvmet_fc_getassociationid(connection_id);
>  	u16 qid = nvmet_fc_getqueueid(connection_id);
> -	unsigned long flags;
>  
>  	if (qid > NVMET_NR_QUEUES)
>  		return NULL;
>  
> -	spin_lock_irqsave(&tgtport->lock, flags);
> -	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
>  		if (association_id == assoc->association_id) {
> -			queue = assoc->queues[qid];
> +			queue = rcu_dereference(assoc->queues[qid]);
>  			if (queue &&
>  			    (!atomic_read(&queue->connected) ||
>  			     !nvmet_fc_tgt_q_get(queue)))
>  				queue = NULL;
> -			spin_unlock_irqrestore(&tgtport->lock, flags);
> +			rcu_read_unlock();
>  			return queue;
>  		}
>  	}
> -	spin_unlock_irqrestore(&tgtport->lock, flags);
> +	rcu_read_unlock();
>  	return NULL;
>  }
>  
> @@ -1137,7 +1132,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  		}
>  		if (!needrandom) {
>  			assoc->association_id = ran;
> -			list_add_tail(&assoc->a_list, &tgtport->assoc_list);
> +			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
>  		}
>  		spin_unlock_irqrestore(&tgtport->lock, flags);
>  	}
> @@ -1167,7 +1162,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  
>  	nvmet_fc_free_hostport(assoc->hostport);
>  	spin_lock_irqsave(&tgtport->lock, flags);
> -	list_del(&assoc->a_list);
> +	list_del_rcu(&assoc->a_list);
>  	oldls = assoc->rcv_disconn;
>  	spin_unlock_irqrestore(&tgtport->lock, flags);
>  	/* if pending Rcv Disconnect Association LS, send rsp now */
> @@ -1177,7 +1172,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  	dev_info(tgtport->dev,
>  		"{%d:%d} Association freed\n",
>  		tgtport->fc_target_port.port_num, assoc->a_id);
> -	kfree(assoc);
> +	kfree_rcu(assoc, rcu);
>  	nvmet_fc_tgtport_put(tgtport);
>  }
>  
> @@ -1198,7 +1193,6 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  {
>  	struct nvmet_fc_tgtport *tgtport = assoc->tgtport;
>  	struct nvmet_fc_tgt_queue *queue;
> -	unsigned long flags;
>  	int i, terminating;
>  
>  	terminating = atomic_xchg(&assoc->terminating, 1);
> @@ -1207,19 +1201,23 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  	if (terminating)
>  		return;
>  
> -	spin_lock_irqsave(&tgtport->lock, flags);
> +
>  	for (i = NVMET_NR_QUEUES; i >= 0; i--) {
> -		queue = assoc->queues[i];
> -		if (queue) {
> -			if (!nvmet_fc_tgt_q_get(queue))
> -				continue;
> -			spin_unlock_irqrestore(&tgtport->lock, flags);
> -			nvmet_fc_delete_target_queue(queue);
> -			nvmet_fc_tgt_q_put(queue);
> -			spin_lock_irqsave(&tgtport->lock, flags);
> +		rcu_read_lock();
> +		queue = rcu_dereference(assoc->queues[i]);
> +		if (!queue) {
> +			rcu_read_unlock();
> +			continue;
> +		}
> +
> +		if (!nvmet_fc_tgt_q_get(queue)) {
> +			rcu_read_unlock();
> +			continue;
>  		}
> +		rcu_read_unlock();
> +		nvmet_fc_delete_target_queue(queue);
> +		nvmet_fc_tgt_q_put(queue);
>  	}
> -	spin_unlock_irqrestore(&tgtport->lock, flags);
>  
>  	dev_info(tgtport->dev,
>  		"{%d:%d} Association deleted\n",
> @@ -1234,10 +1232,9 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  {
>  	struct nvmet_fc_tgt_assoc *assoc;
>  	struct nvmet_fc_tgt_assoc *ret = NULL;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&tgtport->lock, flags);
> -	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
>  		if (association_id == assoc->association_id) {
>  			ret = assoc;
>  			if (!nvmet_fc_tgt_a_get(assoc))
> @@ -1245,7 +1242,7 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  			break;
>  		}
>  	}
> -	spin_unlock_irqrestore(&tgtport->lock, flags);
> +	rcu_read_unlock();
>  
>  	return ret;
>  }
> @@ -1473,19 +1470,17 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  static void
>  __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
>  {
> -	struct nvmet_fc_tgt_assoc *assoc, *next;
> -	unsigned long flags;
> +	struct nvmet_fc_tgt_assoc *assoc;
>  
> -	spin_lock_irqsave(&tgtport->lock, flags);
> -	list_for_each_entry_safe(assoc, next,
> -				&tgtport->assoc_list, a_list) {
> +	rcu_read_lock();
> +	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
>  		if (!nvmet_fc_tgt_a_get(assoc))
>  			continue;
>  		if (!schedule_work(&assoc->del_work))
>  			/* already deleting - release local reference */
>  			nvmet_fc_tgt_a_put(assoc);
>  	}
> -	spin_unlock_irqrestore(&tgtport->lock, flags);
> +	rcu_read_unlock();
>  }
>  
>  /**
> @@ -1568,16 +1563,16 @@ static void nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
>  			continue;
>  		spin_unlock_irqrestore(&nvmet_fc_tgtlock, flags);
>  
> -		spin_lock_irqsave(&tgtport->lock, flags);
> -		list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
> -			queue = assoc->queues[0];
> +		rcu_read_lock();
> +		list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
> +			queue = rcu_dereference(assoc->queues[0]);
>  			if (queue && queue->nvme_sq.ctrl == ctrl) {
>  				if (nvmet_fc_tgt_a_get(assoc))
>  					found_ctrl = true;
>  				break;
>  			}
>  		}
> -		spin_unlock_irqrestore(&tgtport->lock, flags);
> +		rcu_read_unlock();
>  
>  		nvmet_fc_tgtport_put(tgtport);
>  
> -- 
> 1.9.3
---end quoted text---

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
