Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904A6C87FCA
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IcriSyW4cF+Ytp84YJTKg9topiDDLs0Y3NGPAkcNTSs=; b=LTYNHBIAmA3dvFIGxC1LtCVT4H
	t6MAAqIID7IvGPHCxw1p8USKF31s4gBtoQKR2ojutQtEyj8jiOBSZf3LdanGH+f+V3/tkE7NmFagg
	oLIjkkHf6KuUzlRUGZq/t998R0jPCqtpNOyveF2RD7mzqmhYSUabFvDhjTCWPmP47cJ6kgVbsIq3o
	asbejF6XdzxppL5uyM3NAdwKkLUoq71DO+AVqEe68vogBDI9SRNlFcCV8Kji3mm/xXTrNdBtotGuB
	Rl7+1DBj+XaTfwamF4K13JT18iuSYrceVnD5lKywcLV+CZqngLN4n+G0QKiRlLNJP8RMhzCbpHvIh
	RIBo1q3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6fe-00000005fRg-2JFr;
	Sun, 10 Aug 2025 14:05:10 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6fY-00000005fQS-05MP
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:05:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 06A01227A87; Sun, 10 Aug 2025 16:04:49 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:04:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 1/8] blk-mq-dma: introduce blk_map_iter
Message-ID: <20250810140448.GA4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_070504_202122_C29D3FA9 
X-CRM114-Status: GOOD (  11.84  )
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

> +struct blk_map_iter {
> +	phys_addr_t			paddr;
> +	u32				len;
> +	struct bvec_iter		iter;
> +	struct bio			*bio;
> +};

This now mixes the output previous in the phys_vec, and instead
of keeping it private to the implementation exposes it to all the
callers.  I could not find an explanation in the commit log, nor
something that makes use of it later in the series.

If possible I'd like to keep these separate and the output isolated
in blk-mq-dma.c.  But if there's a good reason to merge them, please
add it to the commit log, and also clearly document the usage of the
fields in the (public) structure.  Especially the len member could
very easily confuse.


