Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83B8E77182
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2024 08:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZMiM32Uoqs8dR+TTH8r32VBqLmE9MQQt5kZhZ8Gvs60=; b=KeMaqXRauGZjIr9uz0uTQUa5l0
	KNSe0Ph1mETwmF23rX4+h3P7VaH4/Ct2OVR2mBGw6O8bs6DWHrnLULWFmFmwhmziwi/3faWe67uNB
	gwqpjxQKB6RFl+tafQzA2WiuRyspJ7y+w/BxPNSs4D8TxgDb3Wuai7HQvO3t+MakCc3ph+UgDo0nk
	JOF4+Xzo12ws4bPoGnKY2L145LDCfq5s2U4OtQUIcWPE0VefdL3Sby6JK8ElmMcGimZUPe4Eb4Qrd
	LLCjR/hH5H1AfyqOuup/hCCpinodUTVl0culo0M3QJFItwJa7nSSrXozk/ife1vKbn5WtrHzsI502
	lGHuEjMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLer5-0000000HMYU-1RA5;
	Thu, 12 Dec 2024 08:47:31 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLer1-0000000HMW8-3y86
	for linux-nvme@lists.infradead.org;
	Thu, 12 Dec 2024 08:47:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id A9562A42630;
	Thu, 12 Dec 2024 08:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD098C4CECE;
	Thu, 12 Dec 2024 08:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733993246;
	bh=ReOcuWziWEQFCCJQAUurQfV5neoF3l/FqcJT0j3aqF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PJsH8iSLtYHP8paIZEP4nJ8nTDKr+RtFEDNTXjVNpPCq42ZMvoqqJvcpOfszhO4+2
	 5q+56DuWg4SGme3LxI0sBsdYw0j/x32/u0c/gWkJfPUk3sl4nRpHe1PXPf31cktN6C
	 ycJ7bYP1Dw9zQAeddLZhw7WIZ2LfeuPVgl8LORlnkJaVEgJdPeDEnlle2whXBTTqRq
	 ayDuf0vzWweUJC34kQDFaAIuOSnAN7cRVoxR7StJNTRNATxu9LxOExmd8ebhsHoM6O
	 UISY6so5QpmKtPUDrtYL4yyt3DEQVTWhA3MIrNyFAdOxmdoEnPoky4HtSJHNdc0edv
	 zEy13QGAmAO8w==
Date: Thu, 12 Dec 2024 10:47:21 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
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
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v4 06/18] dma: Provide an interface to allow allocate IOVA
Message-ID: <20241212084721.GH1245331@unreal>
References: <cover.1733398913.git.leon@kernel.org>
 <e562e9a5c5107fae2345150e550e9e850dbe3c0c.1733398913.git.leon@kernel.org>
 <20241212084206.GC9376@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212084206.GC9376@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241212_004728_037252_8C9EA46A 
X-CRM114-Status: GOOD (  14.56  )
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

On Thu, Dec 12, 2024 at 09:42:06AM +0100, Christoph Hellwig wrote:
> s/dma/dma-mapping/ in the subject.
> 
> > function call per API call used in datapath as well as a lot of boilerplate
> 
> Please trim commit messages to 73 characters so that they still look good
> in git show output.
> 
> > +bool dma_iova_try_alloc(struct device *dev, struct dma_iova_state *state,
> > +		phys_addr_t phys, size_t size)
> > +{
> > +	memset(state, 0, sizeof(*state));
> > +	if (!use_dma_iommu(dev))
> > +		return false;
> > +	if (static_branch_unlikely(&iommu_deferred_attach_enabled) &&
> > +	    iommu_deferred_attach(dev, iommu_get_domain_for_dev(dev)))
> > +		return false;
> > +	return iommu_dma_iova_alloc(dev, state, phys, size);
> > +}
> 
> Now that dma_iova_try_alloc is the only caller of iommu_dma_iova_alloc,
> maybe merge the two?

Sure, will do

> 
> Otherwise looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks a lot.

