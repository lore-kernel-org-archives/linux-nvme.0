Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423B1C5B552
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Jun 2025 08:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eEHwbVYDQeH/Pl7svpqVe4/lYpJRoDIZv7/FOJXL2iA=; b=cVD3erz9mztzgbVVA0sGeS89ns
	YeRn3xKw99bJvcUS97ZiDuX0xe4ciRzrVX4V41nebXsefHq+xLfHmwm6ux1pEZ5dbarP8uSoBJZBo
	WZmsA4GVVV5/i+OrvaIYEjcJHr+vg7IC6RYxeVI/l09GN4/I+zXL+VNiTzw2gw/lMaLv6zkdn1PHu
	e1e42RRyaOpLxD3wXH7qSNdQRbDDa4vhIjRCoXEOi2FIrazX5DhCzCPiRiFJKMOY2tQxr2nzb2gjh
	rLLr74JOgunuU7z7Xn6nafYaiWArJgyH4EqWKBfzfALVMi+sDPuOshxYN5YJQKExNoheQSk3n7k57
	hKbQGThQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMjXN-0000000Cu8B-1iLS;
	Wed, 04 Jun 2025 08:31:53 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uMj6q-0000000Cq4c-1g04;
	Wed, 04 Jun 2025 08:04:28 +0000
Date: Wed, 4 Jun 2025 01:04:28 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: typo fix for nvme subsystem
Message-ID: <aD_-DLW_JB6fBLvC@infradead.org>
References: <20250425100107.844298-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425100107.844298-1-yi.zhang@redhat.com>
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

I've added this to nvme-6.16 after writing a proper commit log.
Please do that yourself next time.

> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -221,7 +221,7 @@ static struct nvme_rdma_qe *nvme_rdma_alloc_ring(struct ib_device *ibdev,
>  
>  	/*
>  	 * Bind the CQEs (post recv buffers) DMA mapping to the RDMA queue
> -	 * lifetime. It's safe, since any chage in the underlying RDMA device
> +	 * lifetime. It's safe, since any change in the underlying RDMA device
>  	 * will issue error recovery and queue re-creation.
>  	 */
>  	for (i = 0; i < ib_queue_size; i++) {
> @@ -800,7 +800,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>  
>  	/*
>  	 * Bind the async event SQE DMA mapping to the admin queue lifetime.
> -	 * It's safe, since any chage in the underlying RDMA device will issue
> +	 * It's safe, since any change in the underlying RDMA device will issue
>  	 * error recovery and queue re-creation.
>  	 */
>  	error = nvme_rdma_alloc_qe(ctrl->device->dev, &ctrl->async_event_sqe,
> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index acc138bbf8f2..ff731b5a072e 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -1174,7 +1174,7 @@ static void nvmet_execute_identify(struct nvmet_req *req)
>   * A "minimum viable" abort implementation: the command is mandatory in the
>   * spec, but we are not required to do any useful work.  We couldn't really
>   * do a useful abort, so don't bother even with waiting for the command
> - * to be exectuted and return immediately telling the command to abort
> + * to be executed and return immediately telling the command to abort
>   * wasn't found.
>   */
>  static void nvmet_execute_abort(struct nvmet_req *req)
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 71f8d06998d6..aac398f96c9e 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -648,7 +648,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
>  	 * Now that we removed the namespaces from the lookup list, we
>  	 * can kill the per_cpu ref and wait for any remaining references
>  	 * to be dropped, as well as a RCU grace period for anyone only
> -	 * using the namepace under rcu_read_lock().  Note that we can't
> +	 * using the namespace under rcu_read_lock().  Note that we can't
>  	 * use call_rcu here as we need to ensure the namespaces have
>  	 * been fully destroyed before unloading the module.
>  	 */
> diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> index 7b50130f10f6..297bf2886127 100644
> --- a/drivers/nvme/target/fc.c
> +++ b/drivers/nvme/target/fc.c
> @@ -1328,7 +1328,7 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
>  /**
>   * nvmet_fc_register_targetport - transport entry point called by an
>   *                              LLDD to register the existence of a local
> - *                              NVME subystem FC port.
> + *                              NVME subsystem FC port.
>   * @pinfo:     pointer to information about the port to be registered
>   * @template:  LLDD entrypoints and operational parameters for the port
>   * @dev:       physical hardware device node port corresponds to. Will be
> diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
> index 83be0657e6df..b25af5cbaf05 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -133,7 +133,7 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
>  	 * Right now there exists M : 1 mapping between block layer error
>  	 * to the NVMe status code (see nvme_error_status()). For consistency,
>  	 * when we reverse map we use most appropriate NVMe Status code from
> -	 * the group of the NVMe staus codes used in the nvme_error_status().
> +	 * the group of the NVMe status codes used in the nvme_error_status().
>  	 */
>  	switch (blk_sts) {
>  	case BLK_STS_NOSPC:
> diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
> index 26e2907ce8bb..b7515c53829b 100644
> --- a/drivers/nvme/target/passthru.c
> +++ b/drivers/nvme/target/passthru.c
> @@ -99,7 +99,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
>  
>  	/*
>  	 * The passthru NVMe driver may have a limit on the number of segments
> -	 * which depends on the host's memory fragementation. To solve this,
> +	 * which depends on the host's memory fragmentation. To solve this,
>  	 * ensure mdts is limited to the pages equal to the number of segments.
>  	 */
>  	max_hw_sectors = min_not_zero(pctrl->max_segments << PAGE_SECTORS_SHIFT,
> -- 
> 2.45.1
> 
> 
---end quoted text---

