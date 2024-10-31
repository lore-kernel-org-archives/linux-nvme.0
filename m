Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0DCEE6895D
	for <linux-nvme@archiver.kernel.org>; Thu, 31 Oct 2024 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+1W5ztuKBvbZRuqjnT62E662/+w04qJuoAip5s1KGYk=; b=NYWE6eoHWp4P1oRjhlAc7q4DgW
	qbUcUxnYPHxv08EvNk8UkhZD5g/isRl2Kd1tvp5QBRdUo2kAGaOfjRjjN5RfqIh+rv6yodoJdnJL4
	KB5aoyOzHwxV6pr3bsm8ymNKjfHVJN0DBiFueebQmYGCbdCk/XkfH1PGr+5szLtdNMrBzvXBhnoqt
	Yk7obz7iPdlCdx37B0tEAUg/ie97C1Q/BThJBUVDp4Xqy4sCdOSk3CT21F6QDiSegVk4hbfV58mzb
	KXJdc+XoIhwJF8d9ABbG0chlcVHraN0C8Z0Gu2G52e7creGWOdNPkcYeMRPkYgkHUhJFR2Qk4i1Yf
	RJVKXVug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Qdv-00000002xGG-1dKm;
	Thu, 31 Oct 2024 08:34:59 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Qds-00000002xFn-3NCl
	for linux-nvme@lists.infradead.org;
	Thu, 31 Oct 2024 08:34:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 86DED68AA6; Thu, 31 Oct 2024 09:34:50 +0100 (CET)
Date: Thu, 31 Oct 2024 09:34:50 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20241031083450.GA30625@lst.de>
References: <cover.1730298502.git.leon@kernel.org> <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3144b6e7-5c80-46d2-8ddc-a71af3c23072@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241031_013457_010376_4483FE67 
X-CRM114-Status: GOOD (  15.37  )
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

On Wed, Oct 30, 2024 at 07:44:13PM -0600, Jens Axboe wrote:
> On Christoph's request, I tested this series last week and saw some
> pretty significant performance regressions on my box. I don't know what
> the status is in terms of that, just want to make sure something like
> this doesn't get merged until that is both fully understood and sorted
> out.

Working on it, but I have way too many things going on at once.  Note
that the weird thing about your setup was that we apparently dropped into
the slow path, which still puzzles me.  But I should probably also look
into making that path a little less slow.


