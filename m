Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C54E6895E
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 09:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z2dgvvT5RBe5koacjbgSyiEtM/pQ8NsFoMDGV/Ofs+4=; b=nz8OtySh7Gy27/cD5gIqegZmZ1
	HMPGzzhad/6n9wcHUZVQPzZPZesZzX3TjhciBVj71D0GhYBCeiQmV7yb7v9myYayD5hWT7W9yu347
	wkve/ybZScViERIVo1tpAP72vBt7ZenjOu12xAagbSiGcdSYPduaPb1FNhnKLfYF/13c5PK+KBKFX
	HSZByD0Mb53UOmcwnQukuVfUyxYTNo/pii24TLjv++iwCZSUvoqaQ7DjllYxWLgwJSUAgwR0Z8Afl
	oSEx0E0hpRaLcOIhj7lec1ZMXonrB2VaHM31UzUi4nLjNmyEG/jU3it+H3RhAB6/G8cy9FkLZmDIp
	6Ma5hQOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6R8U-000000031W0-1xBv;
	Thu, 31 Oct 2024 09:06:34 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6R7Z-000000031Mc-031m
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 09:05:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5BDA4A43A76;
	Thu, 31 Oct 2024 09:03:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E46ACC4CEC3;
	Thu, 31 Oct 2024 09:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730365535;
	bh=GG1JVJs4dR1AOjE1AJ7ilFPgtAWW0eecmwqTp/vt+xo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QmlWshUdBNcB1FWxXRPNndrpzxX3aAqhzeAeIGagnyn4fy5f45tGBkaDIMtVIOMSH
	 f2449uvXl29R43CYnG1NWyJNJFs8AcYS+J3/4AoaP+t4DGqAhmFlaAi0DonSP1IJXs
	 nqTFKGmBX62BU7Kq02whoNjJqhZNJXu4xTMAUf5TA9MsBWXeKgqU/7OfPHX4JQdM6Q
	 cYeO/+jCF2CQ7VRPVWNfb4dd0leBLAU/Wm+kzEVcI2myW0Ik/rO07OwQb1Z9w7wpM9
	 cbflE1vTPSMudvnmxNiKBwpQsf9zOOlAijHfeIWAa1xqN0InkTRlZPm0qFA7PRteHE
	 VKaKdM1Y44eGA==
Date: Thu, 31 Oct 2024 11:05:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 00/17] Provide a new two step DMA mapping API
Message-ID: <20241031090530.GC7473@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
 <20241031083450.GA30625@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031083450.GA30625@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_020537_236006_7F9FC167 
X-CRM114-Status: GOOD (  18.71  )
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

On Thu, Oct 31, 2024 at 09:34:50AM +0100, Christoph Hellwig wrote:
> On Wed, Oct 30, 2024 at 07:44:13PM -0600, Jens Axboe wrote:
> > On Christoph's request, I tested this series last week and saw some
> > pretty significant performance regressions on my box. I don't know what
> > the status is in terms of that, just want to make sure something like
> > this doesn't get merged until that is both fully understood and sorted
> > out.

This series is a subset of the series you tested and doesn't include the
block layer changes which most likely were the cause of the performance
regression.

This is why I separated the block layer changes from the rest of the series
and marked them as RFC.

The current patch set is viable for HMM and VFIO. Can you please retest
only this series and leave the block layer changes for later till Christoph
finds the answer for the performance regression?

Thanks

> 
> Working on it, but I have way too many things going on at once.  Note
> that the weird thing about your setup was that we apparently dropped into
> the slow path, which still puzzles me.  But I should probably also look
> into making that path a little less slow.
> 
> 

