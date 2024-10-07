Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84D81CFB440
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Oct 2024 08:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M9UD9Uv2SyqOTx2EFMg4j1WlT+YHrRtigGkwkbYfuDE=; b=PuX0WEkp1YsS8sNIeEb3sI+8ji
	3JnIHxGVtkRfP41vDLgQX6AXOJRs1YmZ3RHe2JJLHXTwbmX0vgknJ55hDv6oXOYHTqLWHHjObYsgq
	57urKsR7BPmBazjKTvTrLYIvENkmS58inYFebre1nfHPG4+mYwUb1HSv6mBkEhVqeV3mmwwwEYrT2
	ppc+N46M9fjRlW55BeJNbHn5PJpq7Y8CeDzl+0vxVRrEDi9JsqZjg3AbkIonVIjoasncHARW4boha
	v9xN5H69SxEd8qozq5llkYdV5uvg5ydLLErSmZ1O1TkJxKvaG6zA7tyhHp3hMH7Iny45j8Pt+sLoa
	OM+Zr+GQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxixv-00000001ikd-3TFF;
	Mon, 07 Oct 2024 08:19:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxhoF-00000001WpR-1ldF
	for linux-nvme@lists.infradead.org;
	Mon, 07 Oct 2024 07:05:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 95DD2227A8E; Mon,  7 Oct 2024 09:05:31 +0200 (CEST)
Date: Mon, 7 Oct 2024 09:05:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvmet-rdma: use sbitmap to replace rsp free list
Message-ID: <20241007070530.GB1477@lst.de>
References: <20240925105100.88797-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925105100.88797-1-kanie@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241007_000535_629946_0DC97BC7 
X-CRM114-Status: GOOD (  17.20  )
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

On Wed, Sep 25, 2024 at 06:51:00PM +0800, Guixin Liu wrote:
> We can use sbitmap to manage all the nvmet_rdma_rsp instead of using
> free lists and spinlock, and we can use an additional tag to
> determine whether the nvmet_rdma_rsp is extra allocated.

Can you explain why?  I guess it's better performance for some definition
of "performance", but it would be great to state that here, preferably
including numbers.

>  static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
> -				struct nvmet_rdma_rsp *r);
> +				struct nvmet_rdma_rsp *r,
> +				int tag);

Nit: take can go on the line above.

> -		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp);
> +		ret = nvmet_rdma_alloc_rsp(queue->dev, rsp, -1);

Please add a symbolic name (NVME_RDMA_RSP_DYNAMIC?) for the magic -1
tag.

> @@ -241,17 +236,13 @@ nvmet_rdma_get_rsp(struct nvmet_rdma_queue *queue)
>  static inline void
>  nvmet_rdma_put_rsp(struct nvmet_rdma_rsp *rsp)
>  {
> -	unsigned long flags;
> -
> -	if (unlikely(rsp->allocated)) {
> +	if (unlikely(rsp->tag < 0)) {

.. and use it here.

Otherwise this looks reasonable to me.

