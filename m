Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B37CC54FB3
	for <linux-nvme@archiver.kernel.org>; Mon, 26 May 2025 05:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4wwc8UauzmXQBUl64dv+5rxzntTNKpq3jYtuHurAEEQ=; b=lJHnL23N0D2Hm5KwBlIFnDyIFl
	FtEZnovG1LlFcyTuXC4mo/KAwIsP6CteXUOBTIyT5/sLFvlR2AKmPIxzErEuQtIKYo1XiiYBuneJw
	yOCZFFoMV+TAcPxUfSHxHPU4FOzYmAuv2ZE94c9uSMXLYOZWyB7L5GXzdi9moTivSbOFDm53FSu/v
	+2VaonX7ujPDVRYjqYcz2grAO12f/BCVRa/kec/PztYeoPDRZ+ZH6iUsGKNJ2QUjp19c0wjRE/j67
	zya1PdfulINF5ZOjW7fWTIL2BOvyLbTyY8ijVzsTtL9OtLLHqw7F0FsBuJ+6iyMQV8xGiUShkkqwY
	nquGzvqw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQEK-000000085n6-3FR6;
	Mon, 26 May 2025 05:18:32 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJQEF-000000085mq-2XLo;
	Mon, 26 May 2025 05:18:27 +0000
Date: Sun, 25 May 2025 22:18:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDP5o1qb02iwgw-V@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDCqGLY4irp-6N5M@kbusch-mbp>
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

On Fri, May 23, 2025 at 11:02:16AM -0600, Keith Busch wrote:
> > Maybe having common code is good to avoid copies, but I suspect most
> > real users would want their own.
> 
> But the end goal is that no host memory buffer would be needed at all.
> A buffer is allocated only in the fallback path. If we have the caller
> provide their buffer for that fallback case, that kind of defeats the
> benefit of reduced memory utilization. So it sounds like you might be
> suggesting that I don't even bother providing the host instrumented copy
> fallback and provide an API that performs the copy only if it can be
> offloaded. Yes?

Well, I'd expect most uses cases of things like GC to use the "fallback"
for now - because copy isn't actually that often supported, and when it
is performance might not be good enough.  So we'll need to optimize
for both cases.  Maybe a fallback code is useful, but I'd leave the
buffer management for it to the caller so that it can reuse them.  Or
maybe don't bother given how trivial the code is anyway.  The use case
for common code would be strong if it refactored existing code and
showed that existing callers actually have enough common logic that
it's worth the effort.


