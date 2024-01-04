Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9862EC47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 21:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=p5F8u3xrKU8ESZxmcg8jQ8IAjNp1yE/fjU1J5AXQvGQ=; b=sQS+3TFPSH5J4ziKhYhmlNVH6r
	99anVKZ14t8+B2YL7K46tbufng/YqHw/LTyNInS6gtbbc9MHUFO9xOlL033fVk6MeXciawSD/pHp2
	XwtfASCbgD5c9/+JIMfl4K/lxks5Yhb0lJXOtTi9sQGqCUp59+DVerGACqF0IEtQ2yQz/omjRvutE
	bW7ympqnYxJKbQ+Qo+jsvDtWhUWNIdwr5D/6sMgcyQGFLYasfTnnxcmHnOgyyUz1s04SeJMjtB+6P
	n8IVuibz6vDMpuf8vUPr0v4M0RzyCKZWrcxsNMZr3ONJrJAtm9ZcdDUVWr0VbxFJjVm3Iny0C8lgA
	WTGQG19A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLV5h-00FFSv-1a;
	Thu, 04 Jan 2024 21:17:25 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLV5g-00FFSo-2V
	for linux-nvme@bombadil.infradead.org;
	Thu, 04 Jan 2024 21:17:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=p5F8u3xrKU8ESZxmcg8jQ8IAjNp1yE/fjU1J5AXQvGQ=; b=ty799Qn8Fd+rytCk14M0ZVq25I
	YiBoR7XxLbFmlNS85l+O0gooTrHaDk5fhLePvNU0dGp4e1aMmTnss9STQyHl1VejW4/57v7YeIMBT
	ZP9rfvynFQ/IN6FqUpfPmxtyPBqFFxwyJMh/iOFqQYxJdTTEz1eSljsz03RUgd9NPFc9D695RfHwk
	+08zzTszFt8/e9TS1tjVeg0a9Dg7clSrdazeYNx0BSMUnh50XbIuN4hkn2wwogAacauBJO2ucG1rP
	JnlzoMgHsQUMwe3gYgnlXHjcmHCDNYpPswNwzduYNn/s2OLszGXp84YD0ABSGA9UbbP+tu1yvCFeQ
	WLAfi1sQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLV5Y-00G1t1-Vo; Thu, 04 Jan 2024 21:17:17 +0000
Date: Thu, 4 Jan 2024 21:17:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [LSF/MM/BPF TOPIC] Removing GFP_NOFS
Message-ID: <ZZcgXI46AinlcBDP@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

This is primarily a _FILESYSTEM_ track topic.  All the work has already
been done on the MM side; the FS people need to do their part.  It could
be a joint session, but I'm not sure there's much for the MM people
to say.

There are situations where we need to allocate memory, but cannot call
into the filesystem to free memory.  Generally this is because we're
holding a lock or we've started a transaction, and attempting to write
out dirty folios to reclaim memory would result in a deadlock.

The old way to solve this problem is to specify GFP_NOFS when allocating
memory.  This conveys little information about what is being protected
against, and so it is hard to know when it might be safe to remove.
It's also a reflex -- many filesystem authors use GFP_NOFS by default
even when they could use GFP_KERNEL because there's no risk of deadlock.

The new way is to use the scoped APIs -- memalloc_nofs_save() and
memalloc_nofs_restore().  These should be called when we start a
transaction or take a lock that would cause a GFP_KERNEL allocation to
deadlock.  Then just use GFP_KERNEL as normal.  The memory allocators
can see the nofs situation is in effect and will not call back into
the filesystem.

This results in better code within your filesystem as you don't need to
pass around gfp flags as much, and can lead to better performance from
the memory allocators as GFP_NOFS will not be used unnecessarily.

The memalloc_nofs APIs were introduced in May 2017, but we still have
over 1000 uses of GFP_NOFS in fs/ today (and 200 outside fs/, which is
really sad).  This session is for filesystem developers to talk about
what they need to do to fix up their own filesystem, or share stories
about how they made their filesystem better by adopting the new APIs.

My interest in this is that I'd like to get rid of the FGP_NOFS flag.
It'd also be good to get rid of the __GFP_FS flag since there's always
demand for more GFP flags.  I have a git branch with some work in this
area, so there's a certain amount of conference-driven development going
on here too.

We could mutatis mutandi for GFP_NOIO, memalloc_noio_save/restore,
__GFP_IO, etc, so maybe the block people are also interested.  I haven't
looked into that in any detail though.  I guess we'll see what interest
this topic gains.

