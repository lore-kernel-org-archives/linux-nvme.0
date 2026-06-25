Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C795ECDE008
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 11:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p7UjoSZjBgjyufVnsfF+rFlecXx2zMfdv+4FTKeMWqQ=; b=ynLcOit9mOnmLZf2IjpoJm2JQF
	fAV89YuQbGwUrsg35cwV7Y+cZM7JEeheIPFr9VO0paLS4YRdoIojpH2y8+YzXMqNOkvlmJSP46mqK
	PcTERp+kTgnOHVkFksRLSNeZ5uFCq/quKafOPu3f0dlnbnNQqgnSLZ3yyL0HKHnZy5QxRvjMAlBSk
	dauFTHvluMXMZmLFOlAguL9tXqESL9AvJL9JF2nrZqjRp8Jtx48iBjPlTnVcG9R1bMckuV4r4Sl6r
	YZEBnBfiYgi0r5esxqp/vFR4PgDvH5ftYieE0gFpe2lY+ratTNMXUdBFLX+2Zeg5j+cia97qIr99o
	VmCLVsIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcijp-000000098u8-04Gk;
	Thu, 25 Jun 2026 11:59:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcijl-000000098qQ-3BhX
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 11:59:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2896B68B05; Thu, 25 Jun 2026 13:59:10 +0200 (CEST)
Date: Thu, 25 Jun 2026 13:59:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Xixin Liu <liuxixin@kylinos.cn>
Cc: linux-nvme@lists.infradead.org, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] nvme: zns: cap zone report nr_zones by DMA
 buffer size
Message-ID: <20260625115909.GA18766@lst.de>
References: <cover.1782280420.git.liuxixin@kylinos.cn> <8ed1b6a33454.1782280420.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ed1b6a33454.1782280420.git.liuxixin@kylinos.cn>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_045917_952919_29D349A8 
X-CRM114-Status: GOOD (  19.50  )
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

On Wed, Jun 24, 2026 at 01:53:40PM +0800, Xixin Liu wrote:
> With Partial Report (PR=1), the Number of Zones (NZ) field in the report
> header must equal the number of zone descriptors fully transferred in the
> DMA buffer (ZNS Command Set Specification Rev 1.2, section 3.4.2).
> 
> nvme_ns_report_zones() does not cap the parse loop by max_in_buf derived
> from buflen.  Cap nz with min3() over the device-reported count, nr_zones -
> zone_idx, and max_in_buf.
> 
> Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
> ---
>  drivers/nvme/host/zns.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index 8ed1b6a33454..2a152e87bd76 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -155,7 +155,8 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
>  	struct blk_zone zone = { };
>  
>  	if ((entry->zt & 0xf) != NVME_ZONE_TYPE_SEQWRITE_REQ) {
> -		dev_err(ns->ctrl->device, "invalid zone type %#x\n", entry->zt);
> +		dev_err(ns->ctrl->device, "invalid zone type %#x at zone %u\n",
> +			entry->zt, idx);
>  		return -EINVAL;
>  	}

This looks fine, but unrelated.  Please split it into a separate patch.

The rest looks good as well.

