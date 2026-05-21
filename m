Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38A86CD4F5E
	for <linux-nvme@archiver.kernel.org>; Thu, 21 May 2026 08:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dU55X8o1Azkb3DIcGgYk52nZUm9U0qNMc4ubxAUwT9E=; b=pms4wdu9D2uWMK+lcbuxVSy+Tz
	59Kwr7xYycSsrPubU5EWMFRGrHsdquh8nuSFN6ejzz4PT9Z1/aZV2GpMpsKk2I1v4ZGYIQftl09OI
	jMH8sNE6hdidJRPkP+q47c933EiRBMmvN02j92BSM/lhhSwCauSXNb/DJBmtboUuOSBsAlmFFVsr9
	3DFqLjPpssmrPUX24wu48HViO8aMyjbUPmYJeOLeQgdfggOkIOjrbi7DvA5Ha69piD/rW+Uyy+I/C
	i956C66lAr1YuxWYo/FUGsu9H6H00/QicFkWc/qYafGtwzISZL9tytaN6xB3Q1aaZ5OLRQ79dWBgX
	qwTvnEmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPyfL-000000076kx-2diW;
	Thu, 21 May 2026 08:22:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPyfI-000000076jj-3UN5
	for linux-nvme@lists.infradead.org;
	Thu, 21 May 2026 08:22:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8F28968BFE; Thu, 21 May 2026 10:21:53 +0200 (CEST)
Date: Thu, 21 May 2026 10:21:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 1/2] nvme-pci: fix dma_vecs leak on p2p memory
Message-ID: <20260521082153.GA10917@lst.de>
References: <20260520174953.2989852-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520174953.2989852-1-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260521_012201_011758_D02ED6C1 
X-CRM114-Status: GOOD (  18.68  )
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

On Wed, May 20, 2026 at 10:49:52AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We don't unmap P2P memory, so allocating the dma_vec for it was being
> leaked on completion.
> 
> Fixes: b8b7570a7ec87 ("nvme-pci: fix dma unmapping when using PRPs and not using the IOVA mapping")
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/host/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 139a10cd687f9..744b388eea956 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -966,7 +966,8 @@ static bool nvme_pci_prp_save_mapping(struct request *req,
>  {
>  	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
>  
> -	if (dma_use_iova(&iod->dma_state) || !dma_need_unmap(dma_dev))
> +	if (dma_use_iova(&iod->dma_state) || !dma_need_unmap(dma_dev) ||
> +	    iod->flags & IOD_DATA_P2P)

Missing braces around the & for our usual style?

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


