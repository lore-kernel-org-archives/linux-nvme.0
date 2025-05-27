Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE4A5C54ED1
	for <linux-nvme@archiver.kernel.org>; Tue, 27 May 2025 17:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1LRCWaOlOHsNEzMNJQ0MMvOipv22cbmRGvozIebZVLE=; b=n1qszxWEpLiIqcaXKA1PSjNpGX
	7K0JMrEIBMAoEWGqfsoBg9qJP+rCi3RjJnPz6EF/rHs5s2camFB/SRpWGqgJ32qcCMmB8E4lv1Cdm
	EE0SbuhWyyK2Luy5/FEENsN5ubQVlnWiCkzUH6QwCrr6Npzo6EmtzF1kg+MJ64tvtkO9xirF8ndG6
	qkWAikE2ixaVNcAFUAQ7Y6WyAj4D8Wv8SXlCu2KK288jr4dTuBjSivncHiYM5xNID/nJHZcuFcqRe
	sMoXqEuTsMfw8eLCWesUZdmUxTuYwIgoA7OaCwIhLtJM8ay5hNZLFOYWDjWyqwTdZ4ikkHjro6Osl
	jrJvmorg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJyMn-0000000BHVQ-0AXE;
	Tue, 27 May 2025 17:45:33 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uJyMk-0000000BHUG-0RND
	for linux-nvme@lists.infradead.org;
	Tue, 27 May 2025 17:45:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 686A8A4A6FB;
	Tue, 27 May 2025 17:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFE4C4CEE9;
	Tue, 27 May 2025 17:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748367929;
	bh=Hg7+II8HEX5zi/FluJO3H7vljaGyCQoWcCtOW5y0tpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYxPGptj4xyzvLholB4bpFVUA4rlJWG6jnK/pvlYQWKl7O1mfx6czMU2rGI9/E3sl
	 toRQMnPPwASqJ/0FIASpln8CxbrR2L5cr7K96TRyFM6PhP4H72zYl/f8zpsU/8Q5XU
	 4HRkc4X9qFGZxd/wTmpu/QNRixK7ZcjD667ZzoCBDaWND3wB6MI75721/KeBZGDxgx
	 yyrPifQwS6A8Uj8wgHOhq8krJMqjsXL4irnpV1lu6ZnjYy7UYx9C4rD7YO7YGaSphO
	 xP8PeuCAGloDi5MJVDKIByVzAuN0sse+w81dSpboCAew4DQR0lRgbkInhC11cyL5HY
	 kJNEGHulPacTQ==
Date: Tue, 27 May 2025 11:45:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aDX6NjOuGvxhbw7C@kbusch-mbp>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
 <aDP5o1qb02iwgw-V@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDP5o1qb02iwgw-V@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250527_104530_216949_140A55ED 
X-CRM114-Status: GOOD (  15.07  )
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

On Sun, May 25, 2025 at 10:18:27PM -0700, Christoph Hellwig wrote:
> Well, I'd expect most uses cases of things like GC to use the "fallback"
> for now - because copy isn't actually that often supported, and when it
> is performance might not be good enough.  So we'll need to optimize
> for both cases.  Maybe a fallback code is useful, but I'd leave the
> buffer management for it to the caller so that it can reuse them.  Or
> maybe don't bother given how trivial the code is anyway.  The use case
> for common code would be strong if it refactored existing code and
> showed that existing callers actually have enough common logic that
> it's worth the effort.

Just fyi, the initial user I was planning to target with the block
layer's copy fallback isn't in kernel yet. Just an RFC at this moment on
btrfs:

  https://lore.kernel.org/linux-btrfs/20250515163641.3449017-10-maharmstone@fb.com/

The blk-lib function could easily replace that patch's "do_copy()"
without to much refactoring on the btrfs side.

