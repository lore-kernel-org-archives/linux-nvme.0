Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D08FA606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IMaWbp6h
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=DzWnGbBHK0NIV2t8ZgCJUie5kLKxOSDXL3LFwI8oyQI=; b=IMaWbp6hhQnuPX8Kcw9iFbXPer
	M66+Ras16qF2MTRgcwuAiUrksL3PkDsLWAZpVZO9hPSinxIWtzuJasDtD5cSFPn02ioEjR9WGQrmR
	ftyvnYJtKh/6RCUPu7KCP1O+AszqszqBMS/v5xTwhpC1S8NT5RG7pWiAqqvbCKMKm6WrGb/7m7Ou8
	eYTLePRqmxWQtPvFOUs94s2CYZv2ZSUSDgupEnds5i9bD5P3rlfYBNO8as9zK9d/KA3/aqtu/o949
	Dk3x9+x0txjVr/nRzSSFBOVlYG6mVOAwKhirx+N2r55V1G6Q+VjPv0n92gVktz+JRKKjEWS+VY6oQ
	Yu4B3UXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7n1-00000001Ccy-2qXG;
	Tue, 03 Nov 2026 06:14:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7mx-00000001Ccd-2x8K
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:14:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 79DF068AFE; Tue,  3 Nov 2026 07:14:27 +0100 (CET)
Date: Tue, 3 Nov 2026 07:14:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Chris Mason <mason@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 16/19] nvmet-rdma: reject queues larger than max_cqe
Message-ID: <20261103061427.GL1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-17-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-17-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_221431_913860_B9C5050E 
X-CRM114-Status: GOOD (  14.19  )
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
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 29, 2026 at 08:52:49AM -0700, Keith Busch wrote:
>  	 */
>  	nr_cqe = queue->recv_queue_size + 2 * queue->send_queue_size;
>  
> -	queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
> -				   queue->comp_vector, IB_POLL_WORKQUEUE);
> +	/*
> +	 * The host picks both sizes. Never ask ib_cq_pool_get() for more
> +	 * entries than one CQ of the device can have: no CQ would ever fit,
> +	 * and it would allocate new CQs until an allocation fails.
> +	 */

"The host picks both sizes" read really weird, but doesn't actually
add any information.  In fact none of this comment seems overly
useful.

> +	if (nr_cqe + 1 > ndev->device->attrs.max_cqe)
> +		queue->cq = ERR_PTR(-EINVAL);
> +	else
> +		queue->cq = ib_cq_pool_get(ndev->device, nr_cqe + 1,
> +					   queue->comp_vector,
> +					   IB_POLL_WORKQUEUE);
>  	if (IS_ERR(queue->cq)) {
>  		ret = PTR_ERR(queue->cq);
>  		pr_err("failed to create CQ cqe= %d ret= %d\n",

The out of bounds case should have it's own error message instead of
falling through to this miseading error.


