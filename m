Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E92CCDE008
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2026 06:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JMj16uRU/Othk7Jx/zGZRgQYleefmGAoZMxnXGq5wvE=; b=w832M6uQnGpN/goL1gNcxxmftO
	qWP+BHXx41+hElpEu+h4JZkKPoTlUBbbSa0jU6mrC690MPHSs2/xm710uYw5Mr4RD7/knreFqv+iC
	inBCPSxSVpkiPLMS/p7QX5sRBX86qHrsTqciA1RHGNGwZawxpxwSsmlB+7gKpi4iDV4vbrvQWDYZv
	y0uRJbKVWJRXNlOs4BmQkruxnMDdsxRIhVF34uzh0DyZFI8eXgpuBk+0ehM6ZBcllTWkCfxSrldFk
	PuVaL7xTyJa8at9bsQT4n4608MV+JdJU3yeqVKXXMmbgf1MUDPtksQyB5useOcimuNZ8gky1mAW2c
	u2hBtexA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Ji-0000000AcMw-0aMj;
	Fri, 26 Jun 2026 06:45:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wd0Jf-0000000AcMb-1bJL
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jun 2026 06:45:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8A1FF68B05; Fri, 26 Jun 2026 08:45:28 +0200 (CEST)
Date: Fri, 26 Jun 2026 08:45:28 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
	bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com
Subject: Re: [PATCHv2 09/17] nvme: add Clang context annotations for
 nvme_subsystems_lock
Message-ID: <20260626064528.GI10731@lst.de>
References: <20260614131541.2017845-1-nilay@linux.ibm.com> <20260614131541.2017845-10-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614131541.2017845-10-nilay@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_234531_569870_C675C2E9 
X-CRM114-Status: GOOD (  11.86  )
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

> -static LIST_HEAD(nvme_subsystems);
> +static __guarded_by(&nvme_subsystems_lock) LIST_HEAD(nvme_subsystems);

Having the guard_by before the LIST_HEAD makes this a real mess to
read.

Can we add a

#define LIST_HEAD_GUARDED(_list, _lock) \
	__guarded_by(_lock) LIST_HEAD(_list)

and use that instead?  And maybe do these after the lock declaration.
While the compiler doesn't care, that's much easier to follow for
humans.

> +	/*
> +	 * Initializing subsys->ctrls list doesn't need to be protected
> +	 * using @nvme_subsystems_lock. So suppress the Clang's warning
> +	 * declaring context_unsafe.
> +	 */
> +	context_unsafe(INIT_LIST_HEAD(&subsys->ctrls));

This could also use a helper.


