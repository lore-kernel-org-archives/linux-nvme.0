Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A24C30653
	for <linux-nvme@archiver.kernel.org>; Sun,  7 Jul 2024 09:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3kQGKV8yt7sq4WXAb0XmLrAWHgzThLy3Ck6eSUBRlxI=; b=FZnawBQgvNPmrKK3Sppd9ZAJyp
	MbWsuIoDzTZ1iPvjLoP4dDXYZbf6OTQ/KS4s/AiW3XnaCOMGdmrv8hitxJyQzBo8SIs4xVe9HvrUR
	+gOfFai0Tbkwoim+rrbTjzfOUClMWa0/wR1hf3Vn5SuTlUKw4DwFYjX2OZmKLmNRNyFt9P+ECkYOa
	Dc4oXcDAJyrx1fFKKt7uAkSma29zpX/CPU3Zrv3M4relIlfJb9CB/1FVq/1ODNHsp55Dt3pDOR5F7
	ZRLjKGBDr++udbV0Un/FSzV2w7wYF5Ehk+nH3+4GCSw86B/hbonIbJyKTUQab1uZxboN+nbB9f6Pf
	KlHT9YkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQO0b-00000001Zo1-1IVW;
	Sun, 07 Jul 2024 09:16:37 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sQO0X-00000001ZnW-38g8
	for linux-nvme@lists.infradead.org;
	Sun, 07 Jul 2024 09:16:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1EE9BCE0861;
	Sun,  7 Jul 2024 09:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E6FC3277B;
	Sun,  7 Jul 2024 09:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720343790;
	bh=izDf2P+sHbjiti59EE/8GV6nvVep7QKF5KGW0AiU1Mc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CrzWOY/iDzSJOaiIMaP3xE97eiLSDi4CB0wI1+TEQAHNCz2g05KYsFt/aL1GPMP5r
	 HBnYK2RTylUHc0Vx3NyVD3bOosNt0zckrQesG42uJ6MRet5D6FmAW0PeAe7m5PvfaN
	 iwrSjlS4jkggMxmOqgmohWVRswxNEnNV8RBiej41b/zEaRlr+A3diLegBHOwF8ZWa6
	 9dtd/aY/wBeNy4rWL2+0ucK1I0ZgukePTbNlgwltGYYIXxXU7unResX6O/FNT5nk51
	 W41NViVj5N3M41fW4A1fLX7G15TRIE214CPnx2WARzr2ky472lBfuc0iEJOgY0DDB3
	 Pn2He452QkIyw==
Date: Sun, 7 Jul 2024 12:16:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240707091626.GH6695@unreal>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
 <a7f1c69a-bbaf-4263-b2c2-3c92d65522c2@nvidia.com>
 <20240706062604.GA13874@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706062604.GA13874@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240707_021634_063420_46A1B90D 
X-CRM114-Status: GOOD (  16.69  )
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

On Sat, Jul 06, 2024 at 08:26:04AM +0200, Christoph Hellwig wrote:
> On Fri, Jul 05, 2024 at 10:53:06PM +0000, Chaitanya Kulkarni wrote:
> > I tried to reproduce this issue somehow it is not reproducible.
> > 
> > I'll try again on Leon's setup on my Saturday night, to fix that
> > case.
> 
> It is passthrough I/O from userspace.  The address is not page aligned
> as seen in the printk.  Forcing bounce buffering of all passthrough
> I/O makes it go away.
> 
> The problem is the first mapped segment does not have to be aligned
> and we're missing the code to places it at the aligned offset into
> the IOVA space.

Thanks for the explanation.

