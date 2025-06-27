Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825E5C7EE2A
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jun 2025 16:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W9L9/2IlH59KoNo72ZuQrbZj7UjOO0RlgNZjx5UyK5g=; b=g7c2nRX5ra5O9FRBWlDe6uzYuQ
	fCkjyhw+Cdvcv2dP/Pk2izZ+9wfpEGjNWq2kG9Fta6LaA8J1VJ/Ys8NiCdKHaA2dUlWalecNMB7Kx
	iMQ+tbX8eabpHJGhGeOMUeXEaqTa5kpAjc7yuDqhgcn/j1ks1xaXpScgtkPD09XfzmKhjfSEVJ2xx
	ZO9ZTa7UmaFR+YfrmJgM418DQ542vamjkB0XpDyA7Zy9THTqCdAGQhMvZrbtha8wHW+17v+JDcQdr
	UFfh77KZgYrrn41q7r1dv3EzZ4bk7o4ow61fT5DSB2dY0SMcjXnmZ0pT3WDPoDHiTUuIzImHBNuUV
	i5kTvAPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVBus-0000000FGEF-3LRi;
	Fri, 27 Jun 2025 16:27:06 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVB6R-0000000F7aL-0yxI
	for linux-nvme@lists.infradead.org;
	Fri, 27 Jun 2025 15:34:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 808966111F;
	Fri, 27 Jun 2025 15:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B07C4CEE3;
	Fri, 27 Jun 2025 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751038498;
	bh=eV6UPyQupWZyH5CaGFeLs90y5amWd+ZIXGdb67QPlxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mLuB8QYEFqRyLJS8HKGoRgjB2EowyBRr4EuqbaKc6MT2bBf7yOhJ3kLLJaInZstfs
	 Uh8J+xqL+zx20WQCuBEuSeUKnpwmPi5mysG01vsM3ZwLUUQr3GQSYr5vyeY3G6z1Te
	 aQDQIGDfe0RF1hnEfhPsFEVHPybzFQv7kvh1j5o21u2UTYRkgObGJl6xYBR1bhnqS1
	 da5ZT1uE0utKHnmpgpS8PH+SK8iln9aHFJw/oUlGQcmsh0l23u1HVg7gHZiKjb5/Mz
	 qTb/qCR2gc2qdCJ9QN+RhXlp/oy+Q/cM+fAaaJ7Y/I9BW36KXSr4rwgBXIu9gYFb43
	 KP0Drr86fnBgQ==
Date: Fri, 27 Jun 2025 09:34:56 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: uring_cmd specific request_queue for SGLs
Message-ID: <aF66IGSMATG9-sLy@kbusch-mbp>
References: <20250624211444.2835077-1-kbusch@meta.com>
 <20250625060915.GB9391@lst.de>
 <aFxzXOZUFtt6hyPA@kbusch-mbp>
 <20250626051413.GC23248@lst.de>
 <aF1nUYSXvLE33osR@kbusch-mbp>
 <20250627072524.GA1329@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627072524.GA1329@lst.de>
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

On Fri, Jun 27, 2025 at 09:25:24AM +0200, Christoph Hellwig wrote:
> 
> Oh, you are referring to blk_dma_map_direct?

Yes, exactly. Sorry I shortened the name to the ambiguous "direct", but
I think we're on the same page now.

Back to this patch, I get that this uring_cmd path wouldn't be able to
use the more efficient coalesced mapping when the IOMMU is on, and
instead map each segment indiviually. I think that's still better than
the alternative, though.

