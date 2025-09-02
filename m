Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B947ECA1005
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 19:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zEMmmETiaw0c4k/TL5oNxkz2D+EDNLodiiBp0k7Ncus=; b=sO4FEt+adKbkzwKqY4FvwHNmSJ
	XYAm5JQTJcsIICHPDIvVb9v/UiF1gLz8Ba+b3SNs4BwpVLBTBHKIkSyDh6sDdkImPZclhkezEMTbY
	f7CM7naeeT9xEy0epnSCw5p7r6JQIOHHZsaklhZ+IorYvJ7bPehumk+5Qvm2HE8vNPamMs994WTlb
	+lMaWvQ3U+veGvh0WoxsNDvkmar01ecXZXGK0NSbFPg+nAz2rh8u/1Vh11aISWt4GdzovwoNURnw+
	sTj1A0Gm1tM7OiXej3rvRTnQZPhRLtubkdO7mSrLjIwcItJJXmNexIsmESx4tgCx1P8K9TWstgdeX
	I2hUdZCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utWQw-00000001e5Y-0Hj0;
	Tue, 02 Sep 2025 19:12:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utSOr-00000000Vck-3Vm5
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 14:54:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id CCD7D68B05; Tue,  2 Sep 2025 16:54:10 +0200 (CEST)
Date: Tue, 2 Sep 2025 16:54:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	leon@kernel.org
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <20250902145409.GA13103@lst.de>
References: <20250829142307.3769873-1-kbusch@meta.com> <20250829142307.3769873-3-kbusch@meta.com> <20250902053358.GB11204@lst.de> <aLcBA-Z8yZ44t4ZK@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLcBA-Z8yZ44t4ZK@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_075422_018045_F85417E2 
X-CRM114-Status: GOOD (  20.61  )
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

On Tue, Sep 02, 2025 at 08:36:51AM -0600, Keith Busch wrote:
> > We are actually about to run out of REQ_* bits with the current
> > encoding.  We could shrink the space for REQ_OP_ a bit to create
> > more, or try to move some flags out into BIO_ flags (like
> > REQ_ALLOC_CACHE) or kill them by looking at pointers instead
> > (REQ_INTEGRITY), or by overlaying flags that can't be used with
> > the same of (REQ_FUA vs REQ_RAHEAD vs REQ_UNMAP for example).
> > And maybe we can come up with a more coherent scheme for
> > REQ_PRIO / REQ_BACKGROUND / REQ_SWAP and maybe REQ_IDLE that create
> > another priority scheme in addition to the I/O priorities.
>  
> Sure, but can we do that effort separately from this? I'm mainly trying
> to align with Leon's DMA series that adds REQ_MMIO so that we won't have
> flag conflicts.

I was just thinking out aloud how we could reclaim them, not trying
to take that on for this series.

