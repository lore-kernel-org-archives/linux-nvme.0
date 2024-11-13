Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E043ED41C02
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Nov 2024 04:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/76buq6Uejhyhp1ia3e6pi/BQINnxBJsaZz8kPBFwSE=; b=eSrogzBcD1qxVUt3/01ITOmK+O
	9h+8kna4dJWoDfizkMvyoeeYnuHexH1Tltwv6RgmaxG7YeLge80EpXOHDFpwlAZIiZ2+euUlG4tR6
	8LtM97blJWx/ReTP7yxEalNxZWs7AHHxxLyNtrebj0peNlTr3C91uhYN9dhCyEnOWmgU0B2IO/96a
	VpIwBgFETZsFpF37S0juHEbUZ/zhVOC7p0rlGQw4dRYiRu0AB22IJVf8A4yAv/fuFrd5Uh8iAucBj
	UlNFRgfVKKZFhMX01QuALhD+KcIdXKdGBeyWu3Lo2tpL78ssXs9AUkiGCQ2uud1rdIMe9DqsQYow7
	66H3l/wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tB5SN-00000005ldn-1GD0;
	Wed, 13 Nov 2024 04:58:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tB5SK-00000005ldL-27Eb
	for linux-nvme@lists.infradead.org;
	Wed, 13 Nov 2024 04:58:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id D55FC68AFE; Wed, 13 Nov 2024 05:58:12 +0100 (CET)
Date: Wed, 13 Nov 2024 05:58:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, hch@lst.de,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] nvme-pci: add support for sgl metadata
Message-ID: <20241113045812.GB20379@lst.de>
References: <20241112210620.2650523-1-kbusch@meta.com> <20241112210620.2650523-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112210620.2650523-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241112_205816_708082_580A9168 
X-CRM114-Status: GOOD (  16.84  )
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

On Tue, Nov 12, 2024 at 01:06:19PM -0800, Keith Busch wrote:
> Supporting this mode allows merging requests with metadata that wouldn't
> be possible otherwise, and creating user space requests that straddle
> physically discontiguous pages.

Not just merging, but also creating :)  I.e. it allows to transfer
multiple non-contiguous metadata segements.

> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index e119ba0f8ab8b..12e5064b9cba0 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1985,6 +1985,9 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
>  	lim->max_segments = min_t(u32, USHRT_MAX,
>  		min_not_zero(nvme_max_drv_segments(ctrl), ctrl->max_segments));
>  	lim->max_integrity_segments = ctrl->max_integrity_segments;
> +	if (lim->max_integrity_segments > 1 &&
> +	    !nvme_ctrl_meta_sgl_supported(ctrl))
> +		lim->max_integrity_segments = 1;

Despite the general mess about the SGLS field in the nvme spec, the meta
sgls bit really is a PCIe-only feasture, and this will break metadata
support on RDMA.  The nvme_ctrl_meta_sgl_supported needs to be in pci.c
to set ctrl->max_integrity_segments based on it.

> +static inline bool nvme_ctrl_meta_sgl_supported(struct nvme_ctrl *ctrl)
> +{
> +	return ctrl->sgls & NVME_CTRL_SGLS_MPTR;
> +}

.. and thus I'd move this to pci.c (or just drop the helper).

> +	NVME_CTRL_SGLS_MPTR                     = 1 << 19,

Maybe give the other fields in SGLS a name as well?


