Return-Path: <SRS0=Ayoq=4V=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC54C3F2D7
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 19:19:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1639D21739
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Mar 2020 19:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KnmJoSiV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1639D21739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=chelsio.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=D93B1CGfDT6Fw2DCmG1c4m74lDp/WnDkDHoEuZHebcc=; b=KnmJoSiVDlbJjg
	r4/v6FYYHqQbXX71Dt+Ctsuyq0BLoBpCRubJ53RxhxSubFZ3ko/dgWxKaHtWY/j2RhzHAq0263Mvw
	ZPfqyF2blnFG+p0nkgc5yIEstSxAcIuf3VEtzzihpPgsKLzT4mf1UOHNfqmkN9Q4IMoy7rURM4/5o
	PxBiJSHZ9qnqQLAq1fUUkjf64SgTv46MHdTBe/n2wUSjwd+uMZnKpjsoG4uDxBMP5jkcCOeyiwNoj
	IQHWwanyjBlgiuX5b5xOGxXKhdib6m6bq4PAJ8ZHJyNigb+bW/fZEA8Wz/0ejFlJ6PTbMaNfGfFdg
	GcvCp0MxRD1dWXP4uJUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j9ZY1-0000Sa-V3; Wed, 04 Mar 2020 19:19:13 +0000
Received: from stargate.chelsio.com ([12.32.117.8])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j9ZXy-0000Pz-RQ
 for linux-nvme@lists.infradead.org; Wed, 04 Mar 2020 19:19:12 +0000
Received: from localhost (pvp1.blr.asicdesigners.com [10.193.80.26])
 by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id 024JIoIE021675;
 Wed, 4 Mar 2020 11:18:51 -0800
Date: Thu, 5 Mar 2020 00:48:49 +0530
From: Krishnamraju Eraparaju <krishna2@chelsio.com>
To: Max Gurtovoy <maxg@mellanox.com>
Subject: Re: [PATCH 3/3] nvmet-rdma: allocate RW ctxs according to mdts
Message-ID: <20200304191848.GA30485@chelsio.com>
References: <20200304153935.101063-1-maxg@mellanox.com>
 <20200304153935.101063-3-maxg@mellanox.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200304153935.101063-3-maxg@mellanox.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200304_111910_901730_F41A5486 
X-CRM114-Status: GOOD (  17.69  )
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
Cc: sagi@grimberg.me, Chaitanya.Kulkarni@wdc.com, bharat@chelsio.com,
 nirranjan@chelsio.com, linux-nvme@lists.infradead.org, jgg@mellanox.com,
 kbusch@kernel.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Max Gurtovoy,

I just tested this patch series, the issue is not occuring with these
patches.

Have couple of questons:
- Say both host & target has max_fr_pages size of 128 pages, then
the number of MRs allocated at target will be twice the size of
send_queue_size, as NVMET_RDMA_MAX_MDTS is set to 256 pages.

so, in this case, as host can never request an IO of size greater
than 128 pages, half of the MRs allocated at target will always
left unused.

If this is true, will this be a concern in future when
NVMET_RDMA_MAX_MDTS limit is increased, but max_fr_pages
size of few devices remained at 128 pages?


- Also, will just passing the optimal mdts(derived based on
max_fr_pages) to host during ctrl identification fixes this issue
properly(instead of increasing the max_rdma_ctxs with factor)? I think
the target doesn't require multiple MRs in this case as host's blk
max_segments got tuned with target's mdts.

Please correct me if I'm wrong.

Thanks,
Krishna.
On Wednesday, March 03/04/20, 2020 at 17:39:35 +0200, Max Gurtovoy wrote:
> Current nvmet-rdma code allocates MR pool budget based on queue size,
> assuming both host and target use the same "max_pages_per_mr" count.
> After limiting the mdts value for RDMA controllers, we know the factor
> of maximum MR's per IO operation. Thus, make sure MR pool will be
> sufficient for the required IO depth and IO size.
> 
> That is, say host's SQ size is 100, then the MR pool budget allocated
> currently at target will also be 100 MRs. But 100 IO WRITE Requests
> with 256 sg_count(IO size above 1MB) require 200 MRs when target's
> "max_pages_per_mr" is 128.
> 
> Reported-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
> Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
> ---
>  drivers/nvme/target/rdma.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 5ba76d2..a6c9d11 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -976,7 +976,7 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>  {
>  	struct ib_qp_init_attr qp_attr;
>  	struct nvmet_rdma_device *ndev = queue->dev;
> -	int comp_vector, nr_cqe, ret, i;
> +	int comp_vector, nr_cqe, ret, i, factor;
>  
>  	/*
>  	 * Spread the io queues across completion vectors,
> @@ -1009,7 +1009,9 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
>  	qp_attr.qp_type = IB_QPT_RC;
>  	/* +1 for drain */
>  	qp_attr.cap.max_send_wr = queue->send_queue_size + 1;
> -	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size;
> +	factor = rdma_rw_mr_factor(ndev->device, queue->cm_id->port_num,
> +				   1 << NVMET_RDMA_MAX_MDTS);
> +	qp_attr.cap.max_rdma_ctxs = queue->send_queue_size * factor;
>  	qp_attr.cap.max_send_sge = max(ndev->device->attrs.max_sge_rd,
>  					ndev->device->attrs.max_send_sge);
>  
> -- 
> 1.8.3.1
> 

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
