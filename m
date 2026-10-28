Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4F0606A31C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=QW3A4Kyw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9q11DNs176bYYMFUR11AeQaBpGiT4ivxtJoclTadRk4=; b=QW3A4Kyww8PGlyqDJLydqa7X+3
	Wdd9q8fqNWp1WI5xgKITNLpBYoAQnAdUl/03Nrxcdy+5rN2bLaL4bCwD4aEDfDY3Ghb+ZqKK6LEJE
	gOxxkk853tPqOIgBMjyjxJCsA5AFYPptSrbC0Ps1Hg2qkJBQ3KaohfH+WwFyREWSBaNuu/Wg2AYu8
	x/ZWkWS1PDm2zDLXAIVagPRc2kRi4FCN7EUoXbj4W4pLtjW3SVqI7P4vs01xT9p8uQDiiSfgPmrXx
	QJUsI45Wgnp3Iig9gStgDw7/9mFgqs3taFDJ3cj40rE8EG3mM2+W9SGLYHoISZIc/HqhLx0pWDhMu
	5mewAN5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4yd-00000007Fsn-3rdH;
	Wed, 28 Oct 2026 14:50:07 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM4ya-00000007FrT-3dqo
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 14:50:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 75A2468DDD; Wed, 28 Oct 2026 15:49:53 +0100 (CET)
Date: Wed, 28 Oct 2026 15:49:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrei-Alexandru Bleortu <me@andrei-z.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-rdma: post the command capsule inline when it
 fits
Message-ID: <20261028144951.GA14583@lst.de>
References: <20261015124823.2962700-1-me@andrei-z.com> <20261015124823.2962700-2-me@andrei-z.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015124823.2962700-2-me@andrei-z.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261028_075005_212777_F55DA35B 
X-CRM114-Status: GOOD (  38.15  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Can you reworkd the commit log to be concise?  Also I find it really
annoying that a ULP would have to decide this.  Doing inline submission
should really be something the core/LLDD takes care of.

On Thu, Oct 15, 2026 at 03:48:23PM +0300, Andrei-Alexandru Bleortu wrote:
> nvme_rdma_post_send() posts the 64-byte command capsule by reference,
> so the HCA has to DMA-read the capsule from host memory before it can
> send the command. That read is on the latency path of every I/O.
> 
> Ask for sizeof(struct nvme_command) bytes of inline data when creating
> the queue pair, and create it without inline data if the device refuses.
> Post a capsule that has no in-capsule data with IB_SEND_INLINE when it
> fits in the granted inline size. The CPU then copies the capsule into
> the send WQE and the HCA no longer reads it.
> 
> Providers copy inline data from sg_list[].addr as a kernel virtual
> address, but nvme-rdma keeps the capsule's DMA address there. On the
> inline path the SGE therefore points at qe->data. The capsule stays
> DMA-mapped for the by-reference path.
> 
> An earlier version of this patch was measured with fio doing 4 KiB
> random reads at queue depth 1 against a null_blk namespace exported by
> nvmet-rdma. Both host pairs ran a 6.8 kernel over RoCEv2 at 100 Gb/s.
> The mean completion latency fell by 0.998 us (95% CI 0.943-1.049)
> between two AMD EPYC 7452 hosts with ConnectX-5 Ex, and by 0.589 us
> (0.558-0.618) between two Xeon Platinum 8360Y hosts with ConnectX-6 Dx.
> IOPS rose by 3.3% on the EPYC pair. A run there that asked for inline
> data but kept posting by reference showed no change. That version asked
> for 220 bytes and had no fallback, but it inlined the same capsules.
> 
> Assisted-by: LLM
> Signed-off-by: Andrei-Alexandru Bleortu <me@andrei-z.com>
> ---
>  drivers/nvme/host/rdma.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 5b9b540693b5..517098ebffb1 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -106,6 +106,7 @@ struct nvme_rdma_queue {
>  	bool			pi_support;
>  	int			cq_size;
>  	struct mutex		queue_lock;
> +	u32			max_inline_data;
>  };
>  
>  struct nvme_rdma_setup_ctx {
> @@ -265,7 +266,7 @@ static int nvme_rdma_wait_for_cm(struct nvme_rdma_queue *queue)
>  static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
>  {
>  	struct nvme_rdma_device *dev = queue->device;
> -	struct ib_qp_init_attr init_attr;
> +	struct ib_qp_init_attr init_attr, attr;
>  	int ret;
>  
>  	memset(&init_attr, 0, sizeof(init_attr));
> @@ -284,9 +285,21 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
>  		init_attr.create_flags |= IB_QP_CREATE_INTEGRITY_EN;
>  	init_attr.qp_context = queue;
>  
> -	ret = rdma_create_qp(queue->cm_id, dev->pd, &init_attr);
> +	/*
> +	 * Ask for enough inline data to carry the command capsule in the send
> +	 * WQE (see nvme_rdma_post_send()).  If the device cannot provide it,
> +	 * create the QP without inline data and post the capsule by reference.
> +	 */
> +	attr = init_attr;
> +	attr.cap.max_inline_data = sizeof(struct nvme_command);
> +	ret = rdma_create_qp(queue->cm_id, dev->pd, &attr);
> +	if (ret) {
> +		attr = init_attr;
> +		ret = rdma_create_qp(queue->cm_id, dev->pd, &attr);
> +	}
>  
>  	queue->qp = queue->cm_id->qp;
> +	queue->max_inline_data = ret ? 0 : attr.cap.max_inline_data;
>  	return ret;
>  }
>  
> @@ -1641,6 +1654,17 @@ static int nvme_rdma_post_send(struct nvme_rdma_queue *queue,
>  	wr.opcode     = IB_WR_SEND;
>  	wr.send_flags = IB_SEND_SIGNALED;
>  
> +	/*
> +	 * Post a capsule without in-capsule data inline if it fits in the
> +	 * granted inline size, so the HCA does not have to DMA-read it from
> +	 * host memory.  The CPU copies inline data from a kernel virtual
> +	 * address, so point the SGE at qe->data.
> +	 */
> +	if (num_sge == 1 && sge->length <= queue->max_inline_data) {
> +		sge->addr = (uintptr_t)qe->data;
> +		wr.send_flags |= IB_SEND_INLINE;
> +	}
> +
>  	if (first)
>  		first->next = &wr;
>  	else
> -- 
> 2.56.0
> 
---end quoted text---

