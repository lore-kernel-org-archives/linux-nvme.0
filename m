Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F42AC48BC4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Feb 2024 14:22:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XeoYw2+FdsnaAik2s5iH6M0xzQRMBQSj8gfxC3xiT5o=; b=A4hp6bJO1g0ydUzIwlVeJuf+Cl
	lt85znvu79vX+Oy/e19kiAU6yX5PgF/qV1WkeA1CJwNaf88/UtFPObqXxOJtao4rQisZiSa/XrAWO
	iO5fh9ZTq5uRPRA1T+Jtx0mD2vV3nrpCy4x99nkMAFhQFRPqalfGKJz6BEyDi9y5gT1U9lX81e79h
	+BYs3BYI4BoD7AlK3epzqt4kTccNRqwmfLzqFj8WGom88b1CTTFzDM1dWIG7qiJSTZewyGHgU52Pl
	HqgPFOxjPnq3kpI17WiyDVIWlQn1ySlynPPrx71xF3rUXk1kVProOXf5bQppmglelUhYPWyCysoru
	ZhJvsvIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1racd1-0000000GXO4-10kM;
	Thu, 15 Feb 2024 14:22:19 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raccy-0000000GXNL-0nKr
	for linux-nvme@lists.infradead.org;
	Thu, 15 Feb 2024 14:22:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7F15761D91;
	Thu, 15 Feb 2024 14:22:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6FF7C433F1;
	Thu, 15 Feb 2024 14:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708006935;
	bh=ECMr//ZIck/Tif42+N9tnk+eC4TmXipGsgU9IFIbA/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JER++TAe+qybmy9TeGC3CbZVTBJu3mnF3b1XXqc8gR3Y9k0QHLEYWJm5RJaTlrJVR
	 pZRK+KwTU/cVQWws6A5Ho+jU5yQjjWj8q4GwlzCDybj3eroe3yJRL3X0GElb3+qaj3
	 Wx09/kzw8JI2PE6BsYq6Cc4waRRh5ywH33JtGarmTTbcz3HLjC3IgbmBZkREiUQkGL
	 jkhEjiNjKw+S4kv2raEIecGvl3VHH3r4h81ct8YLX/JlIQgczJTDSBQkF4pZFLXphy
	 Zab0FuPaTRxUfe7qB0jPQOxIqAF/Bu+8BLFhaSpI2kogq5Y5pw7F36YnhG1iWbUcK6
	 2vUp2qYP2Fw7g==
Date: Thu, 15 Feb 2024 14:22:09 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <20240215142208.GA753@willie-the-truck>
References: <cover.1707851466.git.nicolinc@nvidia.com>
 <20240214164138.GA31927@willie-the-truck>
 <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zc0bLAIXSAqsQJJv@Asurada-Nvidia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240215_062216_350266_DD103199 
X-CRM114-Status: GOOD (  28.12  )
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

On Wed, Feb 14, 2024 at 11:57:32AM -0800, Nicolin Chen wrote:
> On Wed, Feb 14, 2024 at 04:41:38PM +0000, Will Deacon wrote:
> > On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> > > It's observed that an NVME device is causing timeouts when Ubuntu boots
> > > with a kernel configured with PAGE_SIZE=64KB due to failures in swiotlb:
> > >     systemd[1]: Started Journal Service.
> > >  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
> > >     note: journal-offline[392] exited with irqs disabled
> > >     note: journal-offline[392] exited with preempt_count 1
> > >
> > > An NVME device under a PCIe bus can be behind an IOMMU, so dma mappings
> > > going through dma-iommu might be also redirected to swiotlb allocations.
> > > Similar to dma_direct_max_mapping_size(), dma-iommu should implement its
> > > dma_map_ops->max_mapping_size to return swiotlb_max_mapping_size() too.
> > >
> > > Though an iommu_dma_max_mapping_size() is a must, it alone can't fix the
> > > issue. The swiotlb_max_mapping_size() returns 252KB, calculated from the
> > > default pool 256KB subtracted by min_align_mask NVME_CTRL_PAGE_SIZE=4KB,
> > > while dma-iommu can roundup a 252KB mapping to 256KB at its "alloc_size"
> > > when PAGE_SIZE=64KB via iova->granule that is often set to PAGE_SIZE. So
> > > this mismatch between NVME_CTRL_PAGE_SIZE=4KB and PAGE_SIZE=64KB results
> > > in a similar failure, though its signature has a fixed size "256KB":
> > >     systemd[1]: Started Journal Service.
> > >  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 262144 bytes), total 32768 (slots), used 128 (slots)
> > >     note: journal-offline[392] exited with irqs disabled
> > >     note: journal-offline[392] exited with preempt_count 1
> > >
> > > Both failures above occur to NVME behind IOMMU when PAGE_SIZE=64KB. They
> > > were likely introduced for the security feature by:
> > > commit 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers"),
> > >
> > > So, this series bundles two fixes together against that. They should be
> > > taken at the same time to entirely fix the mapping failures.
> > 
> > It's a bit of a shot in the dark, but I've got a pending fix to some of
> > the alignment handling in swiotlb. It would be interesting to know if
> > patch 1 has any impact at all on your NVME allocations:
> > 
> > https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org
> 
> I applied these three patches locally for a test.

Thank you!

> Though I am building with a v6.6 kernel, I see some warnings:
>                  from kernel/dma/swiotlb.c:26:
> kernel/dma/swiotlb.c: In function ‘swiotlb_area_find_slots’:
> ./include/linux/minmax.h:21:35: warning: comparison of distinct pointer types lacks a cast
>    21 |         (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
>       |                                   ^~
> ./include/linux/minmax.h:27:18: note: in expansion of macro ‘__typecheck’
>    27 |                 (__typecheck(x, y) && __no_side_effects(x, y))
>       |                  ^~~~~~~~~~~
> ./include/linux/minmax.h:37:31: note: in expansion of macro ‘__safe_cmp’
>    37 |         __builtin_choose_expr(__safe_cmp(x, y), \
>       |                               ^~~~~~~~~~
> ./include/linux/minmax.h:75:25: note: in expansion of macro ‘__careful_cmp’
>    75 | #define max(x, y)       __careful_cmp(x, y, >)
>       |                         ^~~~~~~~~~~~~
> kernel/dma/swiotlb.c:1007:26: note: in expansion of macro ‘max’
>  1007 |                 stride = max(stride, PAGE_SHIFT - IO_TLB_SHIFT + 1);
>       |                          ^~~
> 
> Replacing with a max_t() can fix these.

Weird, I haven't seen that. I can fix it as you suggest, but please can
you also share your .config so I can look into it further?

> And it seems to get worse, as even a 64KB mapping is failing:
> [    0.239821] nvme 0000:00:01.0: swiotlb buffer is full (sz: 65536 bytes), total 32768 (slots), used 0 (slots)
> 
> With a printk, I found the iotlb_align_mask isn't correct:
>    swiotlb_area_find_slots:alloc_align_mask 0xffff, iotlb_align_mask 0x800
> 
> But fixing the iotlb_align_mask to 0x7ff still fails the 64KB
> mapping..

Hmm. A mask of 0x7ff doesn't make a lot of sense given that the slabs
are 2KiB aligned. I'll try plugging in some of the constants you have
here, as something definitely isn't right...

Will

