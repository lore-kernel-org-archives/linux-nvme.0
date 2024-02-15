Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42642C4829E
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Feb 2024 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2+vqOZSHMRdn7qWZ6K9Yjb9RZvwmKqJC6JhroaX4jE0=; b=utVbqHQ9TIqtfD/U11mXRro2b0
	e/K2EQFay4HI7ikWcAakU36Jo2g91EehOMF5TOV2OQtns1aZs+VVEkrtNMey+xhNrSKBrHLaMYfCw
	VFFNtGxBktyCf5msNl+P8xAGWJyk2oxc/1ez5AqzzdU79juyTmfQlBf8QPxXIQEdJsNOG991/OSIH
	cODb4K8n30pY2vAIMdOnui6K30hh0MpuTnDWzTN9DjkGsWz9dkD+v7LzbieCphy0NzxC61leunPxo
	NQzS61K5zUOlC2rPP+pmxLYQ6/ccnUSOs/Xeb/NXlJv+rs1B7P5xbipcWMhLV0HnrgYxgqUz9Ne14
	V70zdjEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raeiK-0000000H0Ls-2Lie;
	Thu, 15 Feb 2024 16:35:56 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raeiH-0000000H0LY-1NLf
	for linux-nvme@lists.infradead.org;
	Thu, 15 Feb 2024 16:35:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D6F35614F6;
	Thu, 15 Feb 2024 16:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14BCFC433C7;
	Thu, 15 Feb 2024 16:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708014951;
	bh=+zLAj2dv1mxs8pQKcOIXqeYT4laZWT/mVwhK3HGd0EI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tENlyL1UhctC1ji35rmACH436KEsEf4wY7vf0fttSzkY8KreDcVR/jZml77spbPUH
	 rgub6XHTDa0aqSrzK8aUSw4xUBinSCzAt4NlclazOXyL0V2PqC/+MiYDKxwr5H9bnt
	 OEm6HW4sobAE76phqUDf7Pj2GXYUE07BiLTzEXozU9MkEYMilt4jW6ZZuW4p6toTud
	 W7d98aimoio4WX+HHTuI4obLTqDf1T+46JUITse0X/YyCk+GBWaMy2+L9MhyJZ4X+f
	 OPcIx3ZE6DyFSiE7a9CB64Ne5Z29MHA2w0FjcArhgyWeQB9KmbTCJImnIAgkgj0ZEe
	 8uL9RNKVccbqQ==
Date: Thu, 15 Feb 2024 16:35:45 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <20240215163544.GA821@willie-the-truck>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <20240214164138.GA31927@willie-the-truck>
 <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
 <20240215142208.GA753@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215142208.GA753@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240215_083553_435660_91D4F1EC 
X-CRM114-Status: GOOD (  13.55  )
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

On Thu, Feb 15, 2024 at 02:22:09PM +0000, Will Deacon wrote:
> On Wed, Feb 14, 2024 at 11:57:32AM -0800, Nicolin Chen wrote:
> > On Wed, Feb 14, 2024 at 04:41:38PM +0000, Will Deacon wrote:
> > > On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> > And it seems to get worse, as even a 64KB mapping is failing:
> > [    0.239821] nvme 0000:00:01.0: swiotlb buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
> > 
> > With a printk, I found the iotlb_align_mask isn't correct:
> >    swiotlb_area_find_slots:alloc_align_mask 0xffff, iotlb_align_mask 0x800
> > 
> > But fixing the iotlb_align_mask to 0x7ff still fails the 64KB
> > mapping..
> 
> Hmm. A mask of 0x7ff doesn't make a lot of sense given that the slabs
> are 2KiB aligned. I'll try plugging in some of the constants you have
> here, as something definitely isn't right...

Sorry, another ask: please can you print 'orig_addr' in the case of the
failing allocation?

Thanks!

Will

