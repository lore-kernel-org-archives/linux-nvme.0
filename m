Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FA606A32C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=qOFQz447
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9h+1E7N+A3RaIcQ9Eg+VVEuIVPgWxegN8q/Ah2XTidA=; b=qOFQz447wkRNX+gvr0RPznxpt6
	NpeH74vSvwC5eSd/Gvp9ODli4PyA5r+R7P8yYZW4bk4X0lIdxa+B0TDV4Q8azxOrXM9ccsB8igIdN
	bXyBWzaxURNDmfnxs2TxCoPPHomRWu6o36gWxiXRgfX2Q1ZveJc4OUkiqrsIrwbBOaiwUBDWIUEhY
	uxgTmcUcHSuGOaBnrZISAv3Swir/zII8fC5SzVrEt9zOFnBtnIMGOWCnICsNL2vaUyJnD1RDfE14T
	gMR8W2vRywkib2IgT7npLxhli+NsMWXLmeeg29MW5yBnFkMZB4MSri4frkMwotgWo+YSNGQZKMQqs
	kW0lMDGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7jR-00000001CDR-3EUd;
	Tue, 03 Nov 2026 06:10:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7jO-00000001CCm-1UJ1
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:10:52 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0FE6C68AFE; Tue,  3 Nov 2026 07:10:47 +0100 (CET)
Date: Tue, 3 Nov 2026 07:10:46 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	Chris Mason <mason@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 14/19] nvmet-rdma: queue the release work under the
 mutex
Message-ID: <20261103061046.GJ1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-15-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-15-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_221050_572699_1653EFA0 
X-CRM114-Status: GOOD (  27.15  )
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

On Thu, Oct 29, 2026 at 08:52:47AM -0700, Keith Busch wrote:
> From: Chris Mason <mason@kernel.org>
> 
> nvmet_rdma_remove_one() takes the queue mutex, unlists each queue of
> the device and queues its release work, then flushes nvmet-wq. So a
> queue that still holds objects on the device must either be on the
> list or have its release work queued. nvmet_rdma_queue_disconnect()
> breaks that: it unlists the queue under the mutex, drops it, and only
> then calls __nvmet_rdma_queue_disconnect() to queue the work. A device
> removal in that window finds nothing to wait for, and the release work
> then destroys the QP and CQ share on a freed device.
> 
> Queue the work before dropping the mutex, as nvmet_rdma_remove_one()
> itself does. That's safe now that rdma_disconnect() no longer sleeps on
> an iWARP event that needs the same mutex.
> 
> Fixes: f1d4ef7d8883 ("nvmet-rdma: register ib_client to not deadlock in device removal")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/target/rdma.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index fe91df653e5cf..35fd3f3c35dc1 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1744,17 +1744,17 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
>  
>  static void nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
>  {
> -	bool disconnect = false;
> -
> +	/*
> +	 * The release work is queued with the mutex held, so that
> +	 * nvmet_rdma_remove_one() finds the queue on the list or its work on
> +	 * the workqueue.

Odd sentence structure once again:

	/*
	 * Queue the release work is with &nvmet_rdma_queue_mutex held, so that
	 * nvmet_rdma_remove_one() either finds the queue on the list or its
	 * the work has already been queued.
	 */

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

