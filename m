Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E80CCD195
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Oct 2025 06:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=edx/YwGpbN2PMGRnfnapzPGj89fKoVF4x2Uy1O/7+6I=; b=IX7QNrvpn6ACk6x74QM0WnuzHH
	kqNx+haAJg7PLCQlkUPzglspxNgW5m4/2G+Lx2e11EYhUA8+HgjEL50nUxRa+Y4e7q0RAQd6/Jr2W
	YxYWmh78U2RwjLKQ2tR7m07MMLDIVf7fhZk/D9JdfQkmjxqMs1G18UpmIvV/XtyyBPtS7oYbO99Y2
	yS6u9zp9wvit228yoBVnZsTt2M65CZeFancBlnGu1/dl8pSPfeTcbnMFA4+k21XaBIzUQfe8Huhqh
	boEvP96Mj7nGV8/+YgBGwXZfu2qz8A6V3W9AC+e8vEajb1kJ0YBge7+l/Vprjs8PNR0TfnxH6ETWt
	58AO3KCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9du3-00000006lid-0kv0;
	Fri, 17 Oct 2025 06:25:27 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9du0-00000006lhz-0m6Y
	for linux-nvme@lists.infradead.org;
	Fri, 17 Oct 2025 06:25:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 96FB4227A87; Fri, 17 Oct 2025 08:25:19 +0200 (CEST)
Date: Fri, 17 Oct 2025 08:25:19 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251017062519.GC402@lst.de>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com> <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251016_232524_517317_FE93309C 
X-CRM114-Status: GOOD (  17.94  )
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

On Fri, Oct 17, 2025 at 08:32:00AM +0300, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Make sure that CPU is not synced and IOMMU is configured to take
> MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.

Please write a commit log that explains this.  Where was DMA_ATTR_MMIO
recently introduced?  Why?  What does this actually fix or improve?

> @@ -184,6 +184,12 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
>  		 * P2P transfers through the host bridge are treated the
>  		 * same as non-P2P transfers below and during unmap.
>  		 */
> +		if (iter->iter.is_integrity)
> +			bio_integrity(req->bio)->bip_flags |= BIP_MMIO;
> +		else
> +			req->cmd_flags |= REQ_MMIO;
> +		iter->iter.attrs |= DMA_ATTR_MMIO;

REQ_MMIO / BIP_MMIO is not block layer state, but driver state resulting
from the dma mapping.  Reflecting it in block layer data structures
is not a good idea.  This is really something that just needs to be
communicated outward and recorded in the driver.  For nvme I suspect
two new flags in nvme_iod_flags would be the right place, assuming
we actually need it.  But do we need it?  If REQ_/BIP_P2PDMA is set,
these are always true.


