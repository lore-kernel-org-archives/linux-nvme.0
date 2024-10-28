Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E65D339B2
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Oct 2024 18:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KFrL9FuvdKBO9EhiqXb//Q4SV/TeRWnP4sdnQwEIZq0=; b=dgWkqz9mFEG5O8+nlVStSk7Z1I
	LNFBOwodOKijf3mxScSqHE8My21KDIQaly/Lo8EFwXu6BRlzACSN14ZnUrLZYYKYikLl+K7M4Yq+5
	yxTpt4SGCBDaLJ/iY6xd4jm87pUB0g1syr2NHSEtyvJNVjB9gXXZN6TtejEgNdxtR3wEBlwlADf6a
	0Ris+O5NGoKkdWbGpWch2hRsCKOti+8CAnOZuDZQZx49Ten7vRuG0aMRX8UuZ/ThNtBAzVyfOPY7U
	YMFhj9ZN5Q7krWjFTyplQpH7S7DoUq4opUpv+P+00303He/5CPY/ty2LTKXuuMugyPlXlKIT7Zz1o
	x2XIosRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UTa-0000000Boyd-0Nkl;
	Mon, 28 Oct 2024 18:28:26 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t5UTX-0000000BowD-2P7I
	for linux-nvme@lists.infradead.org;
	Mon, 28 Oct 2024 18:28:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 40F4EA42AF7;
	Mon, 28 Oct 2024 18:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46CDC4CEE4;
	Mon, 28 Oct 2024 18:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730140101;
	bh=9iGMLbwbu5+Y6xL5FtHUey8KkpvIorHUri9eopVp1bE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EtaFK3pduFuYsNn4Y7vW1E2l8VducP0vst+UuBVEbClW4TWipnGHfz233fzJPLCp+
	 A8MRUIYC0+zA/CM3TbtJ1baS+UV1GvKGP0/Xu+HTYmzt6DJJI4akRbyQlZuKLR1PxK
	 spZ+zcbKZqLolf9P5ku2y3lq4gNNZA+Af5r7z2cpagVx7I8KvRjidzMAXhV0m6tffA
	 S7Z0oPNwV6kv0xsSjIkq0tLfhpRA7b0nVQDSdTWRXEimMGWEhNnHTy/txVooweHpWM
	 wtikULfejvKP5embybCWsN/6Rll2WIBurWpHWzaokEHX3ZC+tVhEJuljI7i+MtbL1d
	 A/quvdDcUEdvA==
Date: Mon, 28 Oct 2024 20:28:15 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: Re: [PATCH 09/18] docs: core-api: document the IOVA-based API
Message-ID: <20241028182815.GH1615717@unreal>
References: <cover.1730037276.git.leon@kernel.org>
 <f7ee023a7497ad3d8a7a31b12f492339d155ac39.1730037276.git.leon@kernel.org>
 <30e87c78-1021-4fa4-8aa6-e81245e77379@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30e87c78-1021-4fa4-8aa6-e81245e77379@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241028_112823_770558_E307579C 
X-CRM114-Status: GOOD (  14.66  )
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

On Mon, Oct 28, 2024 at 12:12:34PM -0600, Logan Gunthorpe wrote:
> 
> I noticed a couple of typos below:
> 
> On 2024-10-27 08:21, Leon Romanovsky wrote:
> 
> > +Part Ie - IOVA-based DMA mappings
> > +---------------------------------
> > +
> > +These APIs allow a very efficient mapping when using an IOMMU.  They are an
> > +optional path that requires extra code and are only recommended for drivers
> > +where DMA mapping performance, or the space usage for storing the dma addresses
> 
> The second 'dma' should be capitalized as it is in other uses.
> 
> 
> > +    int dma_iova_sync(struct device *dev, struct dma_iova_state *state,
> > +		size_t offset, size_t size, int ret);
> > +
> > +Must called to sync the IOMMU page tables for IOVA-range mapped by one or
> > +more calls to ``dma_iova_link()``.
> 
> "Must be called" instead of "Must called"

Thanks, will fix.

> 
> Thanks,
> 
> Logan

