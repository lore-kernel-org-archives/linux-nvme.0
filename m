Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DB1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Dec 2021 08:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/PWdv1NWK7mvnw183RRdSiV81g9zdlvLusN22NKEdZ0=; b=RnuMaDPn9HCjLtC5g4dd8RWv9w
	ZDIdCF3blXWJ8Z48ibjBduTNgcFi0Dri6R+4mqQEtYrKimhj04CfGqVW2eOyQ6SrqQNPuV9LLvkAE
	TTHg+bHdYRdSx3mr060hcf2uFcFfRnM0lWGmFKP7hA1rWSzrlebG7Z7heKMc3HLyrN+dpBNiOCVnl
	dna9WSPgKTwodDylXr2H/9rF8vNcXXtcr2xwuO6rxHNwSdQUekB9TUD51mrHNZCiHXp69PM93k1V5
	xLwjxTSWqe+YcngN8WKM87je6Q1s606v0Z6HiT0Cd8c3wImsoDN7zk//A7iLj3mbl3tNnPvuznAPR
	iAsLvbtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mzwto-009eI8-6p; Wed, 22 Dec 2021 08:23:00 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzwt4-009dyL-I9
 for linux-nvme@lists.infradead.org; Wed, 22 Dec 2021 08:22:15 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 0144B68B05; Wed, 22 Dec 2021 09:22:10 +0100 (CET)
Date: Wed, 22 Dec 2021 09:22:09 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Stephen Bates <sbates@raithlin.com>,
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
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 01/23] lib/scatterlist: cleanup macros into static
 inline functions
Message-ID: <20211222082209.GA22606@lst.de>
References: <20211117215410.3695-1-logang@deltatee.com>
 <20211117215410.3695-2-logang@deltatee.com> <20211221090003.GA7949@lst.de>
 <05095125-464e-4e85-f609-c7bc93d2f479@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05095125-464e-4e85-f609-c7bc93d2f479@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211222_002214_803041_AD4C18AC 
X-CRM114-Status: GOOD (  12.03  )
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

On Tue, Dec 21, 2021 at 10:23:24AM -0700, Logan Gunthorpe wrote:
> > scatterlist.h doesn't have a real maintainer, do you want me to pick
> > this up through the DMA tree?
> 
> Sure, that would be great!

Done.

