Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647F1C87FCA
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EYYF7wXy6jKmCBO+UhqZnKFmRQ6a2iF1Lbvm5fOZa9Y=; b=GlApxaaIIrQmi0AfFbfSi0Q7aF
	iEQWa3p4mitWDS2vwk9jzOhUDagWOQ7LBSZ+pJ8AQr+q+xoOYBVcHmeSn2wpGsBHeX5m7sjAWYKzF
	+HF0c5eVO06hJkvLbbPFtZBUVqPXHfS4CWSY7oJgw2JSW5cD0s+Tg9QIUVBQi9NPG1M1TFMs3DroN
	D8RId7LwpN/1NpPzkgtiZxEWI/QobkJqKY/piFd1yc/QIIFLMkPNMifv6NGOolRvwH5HPlCcMbg8W
	G9f4CyyFtZ9RaHfCB08+nnNMjrWY7guKfEG4x/JwtjtOky4d+UFu0Rn/1W4Q11iLsGO3Ds+IL66Bl
	YutABWiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul7Wc-00000005ivP-3Sxb;
	Sun, 10 Aug 2025 14:59:54 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul7Wa-00000005iv1-1SYX
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:59:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id EDD8768BEB; Sun, 10 Aug 2025 16:59:47 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:59:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 2/2] nvme: remove virtual boundary for sgl capable
 devices
Message-ID: <20250810145947.GB5444@lst.de>
References: <20250806145136.3573196-1-kbusch@meta.com> <20250806145136.3573196-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145136.3573196-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_075952_529033_C542165C 
X-CRM114-Status: GOOD (  12.93  )
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

> +	lim->max_segment_size = UINT_MAX;
> +	if (!nvme_ctrl_sgl_supported(ctrl) || admin ||
> +	    ctrl->ops->flags & NVME_F_FABRICS)
> +		lim->virt_boundary_mask = NVME_CTRL_PAGE_SIZE - 1;
> +	else
> +		lim->virt_boundary_mask = 0;

We start out with a virt_boundary_mask by default, so the else branch
here can go away.  This would also benefit from a comment explaining that
we only need the virt_boundary_mask for PRPs, and that as soon as SGLs
are supported for a given queue we don't set it because we don't want to
pay for the overhead it generates.

>  	if (nvmeq->qid && nvme_ctrl_sgl_supported(&dev->ctrl)) {
> -		if (nvme_req(req)->flags & NVME_REQ_USERCMD)
> -			return SGL_FORCED;
> -		if (req->nr_integrity_segments > 1)
> +		if (blk_rq_page_gaps(req) & (NVME_CTRL_PAGE_SIZE - 1) ||
> +		    nvme_req(req)->flags & NVME_REQ_USERCMD ||
> +		    req->nr_integrity_segments > 1)

And this would also really benefit from a comment explaining the high
level rationale behind the checks.


