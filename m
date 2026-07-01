Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9ABCC43458
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2026 09:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2I4SEOxas6X0x5H7zz6wH0Lfb6ZZgh0f8mcYajOzvc4=; b=sSTCkdXx6Lz6CEYmqgh5u2J46e
	6dlfr466hrKxtLn6nM48vgGKzGlirWFHU77lpKbV6K3j083Lph7CyMWPrtCmIyAUCZdxv4YzqcacO
	jb7tKkRAlwsx7YgXmIJkLkJRDndUS/ZQSiFbzzpNp8HHHJ0OLnA2OWueIvER3rbMs7IsRIoQY1Agw
	XN0m55j40e/J2EzXzCbYaYwtgrOUhG9DG4HUSdWyolAfb0qQo8Voi1CfN2vg/x0eOaicepKsvsfGJ
	a1eU6kPfTNAQNw1JICv86Al+lrgrDImsco8RK0Tq+APoOogMiwJ845B8AlMXWxhTMerr4emW5/cLP
	Y3CC7iMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weqrZ-000000019Ph-2XH8;
	Wed, 01 Jul 2026 09:04:09 +0000
Received: from mailrelay-egress5.pub.mailoutpod3-cph3.one.com ([2a02:2350:5:424::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1weqrV-000000019Om-1zKg
	for linux-nvme@lists.infradead.org;
	Wed, 01 Jul 2026 09:04:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1782896637; x=1783501437;
	d=konsulko.se; s=rsa1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=2I4SEOxas6X0x5H7zz6wH0Lfb6ZZgh0f8mcYajOzvc4=;
	b=M8LfqDYdrxNmY6wM9ssCGtFKfo1sypg4ZbtkSenfafxQDvH9IMfhD44UynTuwLB9Hw0Qwgfo2ICZu
	 eWUKJC1nUMJOxNA0nFml8AZRouIEJmvI3l3V4ihlgsIuwchepcql0xdoV3ElGLLF/xQzEO1SFlJCkc
	 cYYOyzbyOM4KsieeNmZf3FtPPrqRuwjCOU0Q8+8Gtxjn6klEuht74qQhWj6hwx+BrRM/NXfwDM6qNe
	 eTcuo2bRWcx5vg7tGRgEQyxANAeyjs62txgoWVpDfbmAQGKbwA5VK+KzR3YkAkywY4i6kZZkZ5T9z0
	 G1zVpQgRIMP84CiwE6HCAw3ZZY1XARg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1782896637; x=1783501437;
	d=konsulko.se; s=ed1;
	h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:
	 subject:cc:to:from:from;
	bh=2I4SEOxas6X0x5H7zz6wH0Lfb6ZZgh0f8mcYajOzvc4=;
	b=aAtI26ZDbZmqTZCwHgKvV78ZV6Jz/T53rPuFdKmoYl8nQ3SZmDExBtXiXcfeM5nDrzylNZWcSD9kT
	 rKHZcHHAg==
X-HalOne-ID: ca031a73-752b-11f1-9565-314137fccf3e
Received: from localhost.localdomain (c213-102-77-204.bredband.tele2.se [213.102.77.204])
	by mailrelay2.pub.mailoutpod2-cph3.one.com (Halon) with ESMTPSA
	id ca031a73-752b-11f1-9565-314137fccf3e;
	Wed, 01 Jul 2026 09:03:57 +0000 (UTC)
From: Vitaly Wool <vitaly.wool@konsulko.se>
To: Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Vlastimil Babka <vbabka@kernel.org>,
	Harry Yoo <harry@kernel.org>,
	Hao Li <hao.li@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-mm@kvack.org,
	Vitaly Wool <vitaly.wool@konsulko.se>
Subject: Re: Re: [PATCH] mempool: optimize mempool resizing
Date: Wed,  1 Jul 2026 11:03:51 +0200
Message-Id: <20260701090351.869635-1-vitaly.wool@konsulko.se>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260625131738.b7c10540e5c598cc9b60e19d@linux-foundation.org>
References: <20260625131738.b7c10540e5c598cc9b60e19d@linux-foundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260701_020406_589135_594B4CFD 
X-CRM114-Status: GOOD (  32.68  )
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

Hello Andrew,


On Thursday, June 25, 2026 at 10:17:38 pm +02:00, Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Thu, 25 Jun 2026 21:49:15 +0200 Vitaly Wool <vitaly.wool@konsulko.se> wrote:
> > 
> > From: Vitaly Vul <vitaly.vul@partner.samsung.com>
> > 
> > Resizing mempool to a bigger size currently requires a new allocation and a
> > data copy to a new larger elements array which doesn't go well with the
> > idea of having a fast and deadlock free memory allocations during exreme VM
> > load.
> >
> > This patch introduces a new parameter max_nr for a part of the mempool API,
> > which denotes the maximum size of the pool. With it in place we can avoid
> > any allocations in mempool_resize() since we can either grant the resizing
> > request or reject it basing on thr maximum allowed size of the elements
> > array. For those few users of the mempool API that actually use
> > mempool_resize() it is a clear upgrade because the maximum number of
> > elements is known upfront.
> >
> > Derivative APIs (like mempool_init_kmalloc_pool()) are mostly left intact,
> > substituted by the new mempool_init_kmalloc_resizable_pool() API where the
> > pool is actually meant to be resizable.
> 
> Thanks.
> 
> It would be helpful to have a description of what inspired this work.
> Presumably there is some observed problem in nvme or in zone-blockdev
> use? Can you please describe the problems and also describe what
> effect the patch had upon them?

We are using mempool for a variable number of large buffers, the maximal size of the pool is always known. However, as these buffers are large, we don't want to waste too much memory on a saturated full sized pool.

Besides, it takes a lot of time (seconds!) to saturate such a pool and we would absolutely love to avoid that.

Basing on the above, one can conclude that we're using mempool_resize() quite often. And for that to be efficient, we need to know if we can grow the pool  without having to re-allocate the elements array and copy the data. 

Since all the existing users of mempool_resize() actually know the maximum pool size for their respective cases, the easiest way to implement this is to introduce the hard maximum, and that is what this patch is doing.

<snip>
> Seems strange to return -EINVAL if new_min_nr is too low, but -ENOSPC
> if it is too large.
> 
> Also, (pet peeve), ENOSPC means "No space left on device". If this
> errno ever makes it back to userspace, the operator will be running
> `df' and wondering what the heck happened.

Hmm, I see your point. Let's go with -EiNVAL in both cases.

> Also, AI review had things to say:
> https://sashiko.dev/#/patchset/20260625194915.387663-1-vitaly.wool@konsulko.se

Sashiko is doing a great job indeed. My 2c on that:

1. mempool_create() should create pools with max_nr = max(min_nr*2, 1); and this will be fixed in the next version of the patch.
2. There were no forward-progress guarantees during pool growth in mempool_resize(), this patch just makes things simpler and more obvious.
3. pool->min_nr update will be fixed in the next version of the patch.

Thanks,
Vitaly

