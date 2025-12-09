Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1EAD3B7EA
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Dec 2025 06:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IXpwq5FEtInBMxUA0RicmhzzUDVMNqKUUZ2yGuTaS8Q=; b=fos9+eZ3UNDugZVyfDI/kqlBsv
	qvcHzK48JLPK3a9QbTcP0eMvVIVoAEoa+PnoVpCIK/6wMRE2/QYByKF4Juv5Bfdlsu8Hmvjv2TntF
	dI+t8zCIO8N/ipIVvEQWjEFgyMNWsawRy4wKrqcTMc6ugGvKqHXs513TTIgNyEPBhqY1LmiLr3j+A
	Gw6hjGrz8L6UrSa37Hnhqj2a4p+aSwTrFPDbiQmN+YEwQvRF05vIMgzR/zPYTxfBqJykJWDPoScfw
	qwt0lO5BcQd4hnuOoZFdHujTF2+nbWj4OE0pIdlJ1Og6P7M60pWl7Sj4LvsoOnMINkmfbjDvL1YPT
	Ks032C2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSrOW-0000000Du6a-3nVW;
	Tue, 09 Dec 2025 06:40:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSrOU-0000000Du66-4Bns
	for linux-nvme@lists.infradead.org;
	Tue, 09 Dec 2025 06:40:20 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0972768AFE; Tue,  9 Dec 2025 07:40:16 +0100 (CET)
Date: Tue, 9 Dec 2025 07:40:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, kbusch@kernel.org,
	hch@lst.de, kch@nvidia.com, axboe@kernel.dk,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: set virt boundary according to capability
Message-ID: <20251209064015.GC27728@lst.de>
References: <20251208222620.13882-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208222620.13882-1-mgurtovoy@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_224019_174617_5A4675C7 
X-CRM114-Status: GOOD (  21.51  )
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

On Tue, Dec 09, 2025 at 12:26:20AM +0200, Max Gurtovoy wrote:
> Some controllers advertise DWORD alignment for SGLs, so configure the
> virtual boundary correctly for those devices.
> 
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>  drivers/nvme/host/pci.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index e5ca8301bb8b..eacc89cd25eb 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3326,7 +3326,9 @@ static unsigned long nvme_pci_get_virt_boundary(struct nvme_ctrl *ctrl,
>  {
>  	if (!nvme_ctrl_sgl_supported(ctrl) || is_admin)
>  		return NVME_CTRL_PAGE_SIZE - 1;
> -	return 0;
> +	else if (ctrl->sgls & NVME_CTRL_SGLS_BYTE_ALIGNED)
> +		return 0;
> +	return 3;

I don't think this is correct.  NVME_CTRL_SGLS_BYTE_ALIGNED requires
each SGL to be aligned, but is not a virt boundary.  The dma_alignment
value in the queue_limits already takes care of that.


