Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A1E4CA0EFA
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Aug 2025 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xOY/8qKn5PCXnU8hLz8l39axe/A3+5o35RqPq3Xzuwk=; b=mchA4vuJa9CpwBRdDaEsYMuD0c
	dGVqp7/lfPoC6vdPiJb55YLGyxn4DXZSUN2y3QkUbD3lPOJpNpnaZf9YO/d8NvttzbZv4d+ZiVKBP
	9w5zqWXSK1zJaJvvA8M1a9Ud7qIQksiQkZVOTzNwYpUtAchZHN1qDSbisRybKHkJNHlUkWlZscxeT
	RmMLhVFKNyyKUCdyTPHie51mTR+bEInibNs1g1zrRJxqUOCEiuAZgC+AP7NjFbv5yNt7bHfbI06I/
	gEA+/MFoAoUU3kCQ/eWMUOCIxIMWvboICRF7gD1E4IZwVG7i9SqGTuEFkmzyJR3qkwqYW/WIXGp0V
	ddmiaMlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqtSn-0000000C3OJ-1S4O;
	Tue, 26 Aug 2025 13:11:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqtLB-0000000C1u4-2jTV
	for linux-nvme@lists.infradead.org;
	Tue, 26 Aug 2025 13:03:59 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id A230067373; Tue, 26 Aug 2025 15:03:45 +0200 (CEST)
Date: Tue, 26 Aug 2025 15:03:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250826130344.GA32739@lst.de>
References: <20250821204420.2267923-1-kbusch@meta.com> <20250821204420.2267923-2-kbusch@meta.com> <aKxpSorluMXgOFEI@infradead.org> <aKxu83upEBhf5gT7@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKxu83upEBhf5gT7@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250826_060357_847133_B1B781BA 
X-CRM114-Status: GOOD (  18.99  )
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

On Mon, Aug 25, 2025 at 08:10:59AM -0600, Keith Busch wrote:
> On Mon, Aug 25, 2025 at 06:46:50AM -0700, Christoph Hellwig wrote:
> > On Thu, Aug 21, 2025 at 01:44:19PM -0700, Keith Busch wrote:
> > 
> > Also use the chance to document why all this is PAGE_SIZE based and
> > not based on either the iommu granule size or the virt boundary.
> 
> This is a good opportunity to double check my assumptions:

Always a good idea!

> 
> PAGE_SIZEs, iommu granules, and virt boundaries are all power-of-two
> values, and PAGE_SIZE is always the largest (or tied for largest) of
> these.

I just had an offlist conversation with someone trying to make a nvme
device with a virt boundary larger than PAGE_SIZE work.  No idea
where that device came from.

I hink IOMMU granule > PAGE_SIZE would be painful, but adding the
IOMMU list to double check.

It would also be really good to document all these assumptions with
both comments and assert so that we immediately see when they are
violated.


