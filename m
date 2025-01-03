Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3734E77188
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Jan 2025 06:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DBA6MG5IDtTDKSncOhfPeJCh4wnh85/YPUtfbpnsPLY=; b=rUjp2y7HykyQoD9f4eMGdK1aY+
	LHrLnsMPYI2qP5Inj5zkj3Vg7AE7lMXhjKV37TiEgVgH+fN9Nd59led1856/t8HvuEVx6du2e2B28
	jN2PxIPxekRyGxz5w13GXg7q7mxSM6FJ6vbgOCiVJDKwnPjfBMGRDeDZQyxNxqdTVtjqLAQkXFBfL
	JZQ0L92706Pw5FodS6+aZiggSkQWb0AqOlb6iPAMxS8KHIIQ5VCmPymSKSq9oHf/mQArAzB6g/ZT3
	umj+6USUJisjRlhpC3sUoxBZcxikTyHpFCC+s2nrqJGOHyM00VFe/aVtrGfc0pk7qO9sFGzT+boTd
	Lq/Rkb3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbcj-0000000CGnV-16BE;
	Fri, 03 Jan 2025 06:57:33 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTbcg-0000000CGmm-2BUV
	for linux-nvme@lists.infradead.org;
	Fri, 03 Jan 2025 06:57:31 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D01268BEB; Fri,  3 Jan 2025 07:57:25 +0100 (CET)
Date: Fri, 3 Jan 2025 07:57:25 +0100
From: Christoph Hellwig <hch@lst.de>
To: Atharva Tiwari <evepolonium@gmail.com>
Cc: James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-fc: add DIF support for intergrity metadata
Message-ID: <20250103065725.GA28303@lst.de>
References: <20241226091415.354329-1-evepolonium@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241226091415.354329-1-evepolonium@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_225730_698983_F34B086D 
X-CRM114-Status: GOOD (  17.75  )
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

On Thu, Dec 26, 2024 at 02:44:15PM +0530, Atharva Tiwari wrote:
> This patch enhances the NVMe over Fibre Channel (NVMe-FC) driver to 
> handle requests with integrity metadata (DIF).
> 
> - Added the inclusion of `<linux/blk-integrity.h>` to enable integrity operations.
> - Implemented support for mapping integrity metadata using `blk_rq_map_integrity_sg`.
> - Ensures proper handling of requests with integrity metadata, including error cases where mapping fails.

This isn't really how we write commit logs.  The mechanics are
visible in the patch.  Also please wrap commit log lines after 73
characters.

> +	/* Handle requests with integrity metadata (DIF) */
> +	if (blk_integrity_rq(rq)) {
> +		ret = blk_rq_map_integrity_sg(rq, freq->sg_table.sgl);
> +		if (ret < 0) {
> +			sg_free_table_chained(&freq->sg_table, NVME_INLINE_SG_CNT);
> +			freq->sg_cnt = 0;
> +			return -EFAULT;
> +		}
> +		freq->sg_cnt += ret;
> +	}

Who is going to look at the integrity sglist?  Who is setting a
max_integrity_segments value for nvme-fc?

How was this tested?


