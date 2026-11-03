Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A29606A32C
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cWReULNB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bHQoiKS1610TvtJ6yqZjL26GVVEFqRazdkk6nglUbNM=; b=cWReULNBYeSY7A/BNgd0GVbpJr
	dESwJWS2phIiSKqSG9eNmFYgDMygUqSfqowatFFEhfUXvN10Q0pOoPglIYRxKZERzHFynwqB10+ty
	Q/68rScZUMdgq1bRZHdzp8aMk/+3W6CVQblSXsjBk1fmzAPOYqOmDTI/am4Q8uTTpkvlzHl3A/XLg
	N2tet93BEua3As2CRI97pGk5QFlpGRNl+7e2aXfqkON66v2E1yX0HwZRms46121UFSTERekgQVGQK
	A1r6xu+y273wgHa0jjwY/pWf4k5tLAO2b4sU3zOCGXBJmz+IUeIHN9h6nPuSW2At8iCVA4U821Y8+
	/gjiZoQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7hz-00000001C8a-2Rf8;
	Tue, 03 Nov 2026 06:09:23 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7hx-00000001C8E-01Mn
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:09:22 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E264B68AFE; Tue,  3 Nov 2026 07:09:16 +0100 (CET)
Date: Tue, 3 Nov 2026 07:09:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Chris Mason <mason@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 13/19] nvmet-rdma: take a device off the list last
Message-ID: <20261103060916.GI1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-14-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-14-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_220921_193959_EFFD8FE0 
X-CRM114-Status: GOOD (  13.86  )
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

> @@ -1197,13 +1197,17 @@ static void nvmet_rdma_free_dev(struct kref *ref)
>  	struct nvmet_rdma_device *ndev =
>  		container_of(ref, struct nvmet_rdma_device, ref);
>  
> +	nvmet_rdma_destroy_srqs(ndev);
> +	ib_dealloc_pd(ndev->pd);
> +
> +	/*
> +	 * Not earlier: nvmet_rdma_remove_one() waits for the release work that
> +	 * got here only if it finds the device on the list.
> +	 */

Very odd wording.  This should be something like:

	/*
	 * Only delete from the device list once all RDMA resources are torn
	 * down because nvmet_rdma_remove_one waits for the release work only
	 * if the device still is on the list.
	 */

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

