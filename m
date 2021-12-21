Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA3C8C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Dec 2021 09:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWqIBVbz1Vlrgp6F0IwR6I3NkaWmlH3PGg6sgbTAZb0=; b=rT2L95wkQCF6j+FiDK0rpmnOSh
	zqsgl0McYVGiV+O2c7FF+IdOqjYmh8MW0SPJzFb56RB6ZYPs/LcJ5S51zUrDb0S/ls0A8AfSNW8RT
	DvE9ilCzQXJ/UQpdu5jN+sxzsaKh7JR+t7IzMePjdnL7jDVaqod2LHtRMsLCRJ8juuF7xBr9dNZn6
	Nh8TAgE8DfHbCHy96JtikxriLHeW+6URFiU+Vx7K2mAXXOx3JGDxZT8bKgd0HRqPju5ab6S7I/oSo
	xrp97qzsZvJr3w1fRP3UwreG439Uj2naHJcSy1x09W+DM6x2i+95XpIdpC9BeIgRPDRUEk3rpGPWL
	YGvSrMkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzb5s-0061kM-64; Tue, 21 Dec 2021 09:06:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzb5o-0061hh-4O
 for linux-nvme@lists.infradead.org; Tue, 21 Dec 2021 09:05:58 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D4A5B68B05; Tue, 21 Dec 2021 10:05:52 +0100 (CET)
Date: Tue, 21 Dec 2021 10:05:52 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v4 17/23] block: add check when merging zone device pages
Message-ID: <20211221090552.GD7949@lst.de>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-18-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117215410.3695-18-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211221_010556_335411_9E809E41 
X-CRM114-Status: GOOD (  14.84  )
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

> +/*
> + * Consecutive zone device pages should not be merged into the same sgl
> + * or bvec segment with other types of pages or if they belong to different
> + * pgmaps. Otherwise getting the pgmap of a given segment is not possible
> + * without scanning the entire segment. This helper returns true either if
> + * both pages are not zone device pages or both pages are zone device pages
> + * with the same pgmap.
> + */
> +static inline bool zone_device_pages_are_mergeable(const struct page *a,
> +						   const struct page *b)

Merging is only really a use case here.  This really checks if they
belong to the same pgmap, so I suspect that should be in the name.

