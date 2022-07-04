Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC751C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jul 2022 06:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7bGi9xI4iorkcVbln3g/qStzSU7lPTlpqpORsarXxE8=; b=20D0gZIB/dObqn/hX/x46JWhf8
	5+5MHrHU34VReOOk2lztS/Bj5uL6R/gaoA4Tfx1iwPvil7/7AlfE+1YnnZmwkGnyjhop2KRKe+k54
	nQwDaI2PiF1+Eo0D3Hhn7/NsR5lXoqYDVYOk7fIKwx1eEi8YFG8etsI1ux3r9NYhgV/tIYdwpJvMs
	WujbE88S1Jas4D5etnTOEvTO0a4A1IG6eXyrd9CYUp4z4IXvDeChCy+8SnghBAnL1rk8ZRgnAYXWI
	SCzPJeYObB1yjMbz5Xe4xEYrTE6P0TFKmQomEzOrDNvZCA3elNr5mvOpuN+V9RhGFW9tYnrkaRLmD
	QNuyhNAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8FEm-005GaV-UW; Mon, 04 Jul 2022 06:07:12 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8FEj-005GVS-QU
	for linux-nvme@lists.infradead.org; Mon, 04 Jul 2022 06:07:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 49FFF68AA6; Mon,  4 Jul 2022 08:07:00 +0200 (CEST)
Date: Mon, 4 Jul 2022 08:07:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux-foundation.org,
	Stephen Bates <sbates@raithlin.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v7 16/21] block: add check when merging zone device
 pages
Message-ID: <20220704060700.GA28966@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-17-logang@deltatee.com> <20220629064629.GC17576@lst.de> <7da06e08-7dd1-f37c-4382-bc59a1b1e819@deltatee.com> <39bf0071-0acf-12fd-3d3e-06dfd87bb409@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <39bf0071-0acf-12fd-3d3e-06dfd87bb409@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220703_230710_043171_7B4C231B 
X-CRM114-Status: GOOD (  17.61  )
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

On Thu, Jun 30, 2022 at 03:50:10PM -0600, Logan Gunthorpe wrote:
> Oh, it turns out this code has nothing to do with REQ_NOMERGE. It's used
> indirectly in bio_map_user_iov() and __bio_iov_iter_get_pages() when
> adding pages to the bio via page_is_mergeable(). So it's not about
> requests being merged it's about pages being merged.

Oh, true.

> So I'm not sure how we can avoid this, but it only happens when two
> adjacent pages are added to the same bio in a row, so I don't think it's
> that common, but the check can probably be moved down so it happens
> after the same_page check to make it a little less common.

Yes, looks like we have to keep it.

