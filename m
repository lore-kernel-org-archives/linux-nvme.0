Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE32CA0FFE
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 05:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rPsgnf0q4u1cG9WVov2a/T0rgatCQv4Hm7x2TtI+rMk=; b=zgM/hbuSnGGwF71c0h2UJomORx
	k6OAaQ2sTXlwMFebZFiydP+x8pmWYJy7RHxjFxxcXMC9FTjxQYo46DkS6UEvLwLZ5+u4jZak2oPN0
	aa12FHZXZAoCK5/zKnpoamsMEbnEGUbdOZD6CC8ficHwOHt8JBJtBAZv3kBYd8aT+q3d4GVcJJMso
	y6N90kEm0RJnb0m0GS+2bSRLz8Q+aZO0r6FGNfItYwO0RM91nRZEHtjvwdWOxycoE55rcpM5kHDyr
	PW44E2/tDCAi8eI2iGzGoWFk0zliElfG0fIeXSdzobXyLnrwl+4E0hR2jzUtTITYon5v7Tw9EOyld
	UEnQT18g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJrE-0000000FNGk-2nLP;
	Tue, 02 Sep 2025 05:47:04 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utJgj-0000000FKp4-3sZG
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 05:36:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5E5D68AA6; Tue,  2 Sep 2025 07:36:08 +0200 (CEST)
Date: Tue, 2 Sep 2025 07:36:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	iommu@lists.linux.dev, willy@infradead.org, netdev@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250902053608.GA11396@lst.de>
References: <20250821204420.2267923-1-kbusch@meta.com> <20250821204420.2267923-2-kbusch@meta.com> <aKxpSorluMXgOFEI@infradead.org> <aKxu83upEBhf5gT7@kbusch-mbp> <20250826130344.GA32739@lst.de> <aK27AhpcQOWADLO8@kbusch-mbp> <20250826135734.GA4532@lst.de> <aK42K_-gHrOQsNyv@kbusch-mbp> <20250827073709.GA25032@lst.de> <aLJYPGKE4Y_6QzY2@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLJYPGKE4Y_6QzY2@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250901_223614_100335_66B295CC 
X-CRM114-Status: GOOD (  19.98  )
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

On Fri, Aug 29, 2025 at 07:47:40PM -0600, Keith Busch wrote:
> On Wed, Aug 27, 2025 at 09:37:09AM +0200, Christoph Hellwig wrote:
> > On Tue, Aug 26, 2025 at 04:33:15PM -0600, Keith Busch wrote:
> > > virt boundary check. It's looking like replace bvec's "page + offset"
> > > with phys addrs, yeah?!
> > 
> > Basically everything should be using physical address.  The page + offset
> > is just a weird and inefficient way to represent that and we really
> > need to get rid of it.
> 
> I was plowing ahead with converting to phys addrs only to discover
> skb_frag_t overlays a bvec with tightly coupled expectations on its
> layout. I'm not comfortable right now messing with that type. I think it
> may need to be decoupled to proceed on this path. :(

willy got really angry at this for all the right reasons, and we
still need it fixed.  Can we just revert the unreviewed crap the
network folks did here to move the kernel forward?

