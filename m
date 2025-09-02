Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB27CA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 05:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q8fwJBX46O+tFjIViWwkJM4Mm8c9+7Lcw84iLkR44kQ=; b=yB8o+w5t21gvps5LD0Xgf2JNM8
	Y8jVF5S1V7dc3CTujF+enPQ2xbFMeUQvaPDCQRZm/Xai3nNz2Pru1CZJCaUCUHqyk4HMlnDQT+pqq
	1nF37pl5GYQdFlXorGduOhxIe1gY5dQCSSKyStEOQd9dqsL8KbGzMH1YQuNdz9Yc9WbwOB0knmUYi
	Ep0EiwuJhktqBhzOYnOJ7d1e0G5RfKXYsgjG2wxq8C+DXQkbi1rSz/udMipH5zbBIkv/ohInEmKTd
	LhFG2WYwmGcNc5S3xvWkcne3+kDBQbVZbDBWI7UpI1qI2hBshYY2fOu6h3gywW96UnGzwbEgX/+mB
	X1hsJixw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJoX-0000000FMTm-0vwO;
	Tue, 02 Sep 2025 05:44:17 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJee-0000000FKPG-0i63
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 05:34:05 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3DD2B68AA6; Tue,  2 Sep 2025 07:33:59 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:33:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, martin.petersen@oracle.com, jgg@nvidia.com,
	leon@kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <20250902053358.GB11204@lst.de>
References: <20250829142307.3769873-1-kbusch@meta.com> <20250829142307.3769873-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829142307.3769873-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_223404_349219_D6C92C09 
X-CRM114-Status: GOOD (  17.00  )
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

On Fri, Aug 29, 2025 at 07:23:07AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> We only need to consider data and metadata dma mapping types separately.
> The request and bio integrity payload have enough flag bits to
> internally track the mapping type for each. Add flags for these so the
> caller doesn't need to track them, and provide separete request and
> integrity helpers to the common code for unmpaping. This will make it
> easier to scale as new mappings are added without burdening the caller
> to track such things.

We are actually about to run out of REQ_* bits with the current
encoding.  We could shrink the space for REQ_OP_ a bit to create
more, or try to move some flags out into BIO_ flags (like
REQ_ALLOC_CACHE) or kill them by looking at pointers instead
(REQ_INTEGRITY), or by overlaying flags that can't be used with
the same of (REQ_FUA vs REQ_RAHEAD vs REQ_UNMAP for example).
And maybe we can come up with a more coherent scheme for
REQ_PRIO / REQ_BACKGROUND / REQ_SWAP and maybe REQ_IDLE that create
another priority scheme in addition to the I/O priorities.


