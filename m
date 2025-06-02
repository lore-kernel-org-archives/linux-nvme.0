Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFDFC5B549
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Jun 2025 04:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kxEvP93Wfl+81a5qScLy9c/kMrzau8pAQI/zcSNv4lE=; b=3WrPo7uulDWtF+mOHny/FeMcZA
	tNXqtaKO1iRx/ni1JtKGsVFGTtKBl3/VPAQYHTYemToEtjSpvvx1KvJ2daaw7k1rrDo5OyhkdgnrC
	hQAJxmDjLueBvBOaCUBHcMjHOM4IycN7iCDgWAaBoOG3Yi3h+UgGlDeFFIZ9wexWnXazujc+KNN7M
	mjo0qcD66fhOQIFYGbn1in6esKTUgFdyDot+DdvmLpTIuNEkox3uIMqxLSi4mn17qFa3P4fnUnoxO
	sweQQy1eVW258sQa+ChHcUmhSfzTCTl2YxcogOQCvW9Y2IpBZog2Wg8BHR4J0XEF0/HnD0pHUNtmA
	n3Wddrig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxGC-00000006iYj-2cGV;
	Mon, 02 Jun 2025 04:58:56 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uLxGB-00000006iYQ-07d1;
	Mon, 02 Jun 2025 04:58:55 +0000
Date: Sun, 1 Jun 2025 21:58:55 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	Mark Harmstone <maharmstone@fb.com>
Subject: Re: [PATCH 1/5] block: new sector copy api
Message-ID: <aD0vj0O-4P92Rkqx@infradead.org>
References: <20250521223107.709131-1-kbusch@meta.com>
 <20250521223107.709131-2-kbusch@meta.com>
 <aDBt1qXj90JO1y2v@infradead.org>
 <aDCqGLY4irp-6N5M@kbusch-mbp>
 <aDP5o1qb02iwgw-V@infradead.org>
 <aDX6NjOuGvxhbw7C@kbusch-mbp>
 <aDa_O4HGWjy_35I7@infradead.org>
 <aDeRNvT5x_qRj3kX@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDeRNvT5x_qRj3kX@kbusch-mbp>
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

On Wed, May 28, 2025 at 04:41:58PM -0600, Keith Busch wrote:
> On Wed, May 28, 2025 at 12:46:03AM -0700, Christoph Hellwig wrote:
> > On Tue, May 27, 2025 at 11:45:26AM -0600, Keith Busch wrote:
> > > Just fyi, the initial user I was planning to target with the block
> > > layer's copy fallback isn't in kernel yet. Just an RFC at this moment on
> > > btrfs:
> > > 
> > >   https://lore.kernel.org/linux-btrfs/20250515163641.3449017-10-maharmstone@fb.com/
> > > 
> > > The blk-lib function could easily replace that patch's "do_copy()"
> > > without to much refactoring on the btrfs side.
> > 
> > Well, that code would be much better off using a long living buffer,
> > because the frequent allocations are worse.  
> 
> No argument against that. I'm just adding context for where this blk lib
> patch was targeted. I'm happy to help on both sides to make it more
> usable, though refactoring other block copy implementations (splice,
> kcopyd, xfs gc) to a common api looks like a much longer term project.

FYI, I'm happy to take care of XFS GC, but I don't think we need any
library code for that.  And I doubt any other async implementation would
share much code besides the low-level helpers.

So the question is if there are many potential users of sync helpers.
Maybe the answer is no and we should just not bother with that code for
now and only add it when/if it actually starts sharing code?


