Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7FCECCD193
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Oct 2025 08:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=otwxnM0q4gQgAgbUYofgaj/CTQ811FgIgj3W4w/r24k=; b=N+7U0YCN0yYfPbpEhv2w2SNrjU
	ZSR+qsxU6SrF70hct+2nW1KqEpfORf2uKyOasohAkZayirAPERhW2JrqIxgnXN3kEkIFGOEnwPOr7
	kgd0LY6xiQoEBUzLUlHrWdwAFbmcMLbGZyxaOuVFSnzBUFT2wgUErl2b/K4pq+VAkoTQmBGTTYcdn
	MVQ4M3ViUfcvyK7P1pqOcs05hITNa48Vuuni14Ljny+EVcpjroq58212fjHXjFeDRJBRPB/mPNtcu
	c9WGDZNsiC2xZGkoXjtVzeeKrS9nm5e6ON9u/Jrv5m0pZMmrrQ6c5cx7DYSd8Iz/3EccLDu64Qzgh
	YbX3NDrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAldA-0000000CT8n-1Jgr;
	Mon, 20 Oct 2025 08:52:40 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAld7-0000000CT7k-43mK
	for linux-nvme@lists.infradead.org;
	Mon, 20 Oct 2025 08:52:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1FF7D40B29;
	Mon, 20 Oct 2025 08:52:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580E3C113D0;
	Mon, 20 Oct 2025 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760950357;
	bh=XctXBijRc2JDDIlhKVK5AdZ/zUsO7k+Gdyg6LFp/1/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdAz6XsE9T5PJ0dRt5Z4ZTU7tNu7N2NW3W3508ZVu8eEwMR7FT+qFqRcJ7F5bvZkT
	 zghrNdurS3+fiBKPa4JpeEPnsW8r3m/K1/4N3o/s+Te6D8MBQhaAAdq2D6fgocUUs7
	 3UWUGGQdF4MS1UiCGXB/oU9KlTOkWE4qOmkqUyAhulP0mWm7Nl/u84HM0JBK7p14kP
	 dhuPVdyKO1+oHJLI1BeiSDsmmsG5dVc+QyOOPYa+TSUfqKXgql5L1ebgSa8E7nMLat
	 deG2jAjmXcyKp47DOJ4aHRWEkpsv3y5FOdQO1P5pddNxEK2crDixaJk/6Sm9JHcddk
	 uVBvLq0qEPR/A==
Date: Mon, 20 Oct 2025 11:52:31 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 3/3] block-dma: properly take MMIO path
Message-ID: <20251020085231.GM6199@unreal>
References: <20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com>
 <20251017-block-with-mmio-v1-3-3f486904db5e@nvidia.com>
 <20251017062519.GC402@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017062519.GC402@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251020_015238_043614_62E803C4 
X-CRM114-Status: GOOD (  12.59  )
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

On Fri, Oct 17, 2025 at 08:25:19AM +0200, Christoph Hellwig wrote:
> On Fri, Oct 17, 2025 at 08:32:00AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > Make sure that CPU is not synced and IOMMU is configured to take
> > MMIO path by providing newly introduced DMA_ATTR_MMIO attribute.
> 
> Please write a commit log that explains this.  Where was DMA_ATTR_MMIO
> recently introduced?  Why?  What does this actually fix or improve?

What about this commit message?

Author: Leon Romanovsky <leonro@nvidia.com>
Date:   Mon Oct 13 18:34:12 2025 +0300

    block-dma: properly take MMIO path

    In commit eadaa8b255f3 ("dma-mapping: introduce new DMA attribute to
    indicate MMIO memory"), DMA_ATTR_MMIO attribute was added to describe
    MMIO addresses, which requite to avoid any memory cache flushing, as
    an outcome of the discussion pointed in Link tag below.

    In case of PCI_P2PDMA_MAP_THRU_HOST_BRIDGE transfer, blk-mq-dm logic
    treated this as regular page and relied on "struct page" DMA flow.
    That flow performs CPU cache flushing, which shouldn't be done here,
    and doesn't set IOMMU_MMIO flag in DMA-IOMMU case.

    Link: https://lore.kernel.org/all/f912c446-1ae9-4390-9c11-00dce7bf0fd3@arm.com/
    Signed-off-by: Leon Romanovsky <leonro@nvidia.com>


