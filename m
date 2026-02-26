Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D558EFD8FD8
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SJ1AhvynDdlFRk48gXgAE4XaXjtI0+PjudnQ2o+KxI0=; b=AESR/AwVg1dVyMUNRPU/yvW1Mm
	bTiKV0507gaysGRpBtv0TQadtEkGDZH3m80uZ74IEDdOB5q7HeZ74ZR5UaCBP8l2MLoMeGpC0ZNoO
	h5V88hTHGKN2R6nsjggVytWEkC1AtoaKdPQaX6kYPU4GKQw9+xNP1YON+DMgCRY0O/Y7Q0luf/kPh
	DdFdeWvAdq94gDe1UPjWNUkICsX4x6qGmgcHDsokj8MKyNdyC89AXRUy8BVJdfWRGP/n79PV04W52
	S4Xo0xfSCxY3YLFcNcYQLJDXxNr16dUV2axOkNgTUP6dyuc8ugKOIUW7Mo5IAf8fmAQXLlvJNK90B
	hGbGh9hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vveaA-00000006mF0-1UDH;
	Thu, 26 Feb 2026 16:51:22 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvea7-00000006mDh-31BM
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 16:51:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 06A40439E8;
	Thu, 26 Feb 2026 16:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C89C116C6;
	Thu, 26 Feb 2026 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772124678;
	bh=Rczk4O71IOsFzcw9HhF8E4yDBHU7/PvT6EEB1f/+tl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b4YQA4WghHnGtVdeVboJz024XIzMZ2sirK240ybYRJu0lE/c2KEgk/S5s5q6NrkO3
	 HvEOjedTesJXPeBJwg9F9exruiQPPrBtRkiRXZ5WgBOYemTdwWApigQulb1yJ2VGjA
	 61GAY2I1x+LfYJSOuIy4L3UkiD9GaKeFJou6LjqwK8CxieBzeR1SZQYJI8Z4yg3LlM
	 nBw8BhpMNdeIongUxgj0S2zJCeTCbI2ORHvpl1JnU0tqHLvKUPmDRCA96BXa+cQDf4
	 4+cwN55f3ifY2cj288zQ/NQ3E6/sU4CSDz2j3di70ehOXr5kaB+Cg0VKze/ZW6MMVF
	 EnJ00V3g0cFjA==
Date: Thu, 26 Feb 2026 09:51:16 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	nilay@linux.ibm.com
Subject: Re: [PATCH 2/2] nvme: fix unmatched id's under delayed path deletion
Message-ID: <aaB6BJV3FvAVBuPq@kbusch-mbp>
References: <20260225202109.447144-1-kbusch@meta.com>
 <20260225202109.447144-2-kbusch@meta.com>
 <20260226153740.GB31615@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226153740.GB31615@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_085119_778271_8109F3AC 
X-CRM114-Status: GOOD (  13.93  )
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

On Thu, Feb 26, 2026 at 04:37:40PM +0100, Christoph Hellwig wrote:
> I find the retry logic a bit odd and different from other places
> do in similar areas.  What I'd expected is either a "nr_retries" or
> "did_retry" variable initialized to 0/false, then checked here to
> be not set (plus the IS_ENABLED() for multipath) and incremented/set
> below.
> 
> But independent of that, the actual logic looks fine.

I was able to test this, and it does work when we're specifically
blocking on the delayed removal. But there's a different race this
doesn't handle: controller A's scan_work may depend on controller B's
scan_work to finish first to remove a final reference on the deleted
namespace when A is trying to add a newly created namespace that
recycled the NSID.

This is looking pretty tricky to resolve. The best solution I'm coming
up with so far is to have the scan_work synthesize a
NVME_AER_NOTICE_NS_CHANGED event for every controller in the subsystem,
then re-kick their scan work if the scan_work removed anything.

