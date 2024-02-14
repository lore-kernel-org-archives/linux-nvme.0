Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF60C48BC3
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Feb 2024 16:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R0ADXAcnx55rHzVKxCSUweqUJ0IxcRwiblhtNC8mXI8=; b=KP+uqj1SyNkpfKVdztRfxgth4s
	Xhd1C+MDx6lXiKDwGEsFwzWxxNjDwwmS/bH6vug6zT5z98J7hfwT5rHs/STLIwwHHWgdMacDn42bk
	uC9A/K8v+TFohD1iUzKXGa0w1H2j3/Socm2j0ODwg0BRoEoPZyNP1dCfJGRXrpwOrjb3kLUC7l7SZ
	Lk+QIBwEPVHDeg2lvqBX7Wm4UHOeCrqpS7LgVBFaFUHGPPsA2mNJo9mIzBV8yfgeS206lwR4JN3x6
	fv3OGlGWio/gBoNIEACky0LrKVYupzGMil3EEqc/JehtAP9ZzwKxy575to72Z9LgFt858RseGS6A8
	kTacnGWQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raIKU-0000000DZYe-3LWv;
	Wed, 14 Feb 2024 16:41:50 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raIKP-0000000DZXz-3EzN
	for linux-nvme@lists.infradead.org;
	Wed, 14 Feb 2024 16:41:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D5D1761B0E;
	Wed, 14 Feb 2024 16:41:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14B19C433F1;
	Wed, 14 Feb 2024 16:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707928904;
	bh=rtzaQewjWyFqgXvX8Cpq/QwLjOpb1280iFp5zLTTWx8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oP/9iHXzZ4W3ZkEIKY9irpzbod0eFARuDjHbe93lj1nSEHbUYvXg3uHTnMtH9Jkmt
	 SuqEPiKzPsRKrc5m74cY32AfDw/qAVaFGETVY32JqsFWgRSR5RvlcF0t1HdI+GtK3f
	 x7Ye1fDwGN5Zfei+HU++QCasgmImmcKpwQHy6MC660hAUJZxnILvlV4RFM0QLgt23B
	 7/MSUOriFsS4NiTahlVGWkpfjqfgxTAnimulbm1unYOY2l/Zum4l+1qVgQG/9qVV6w
	 y1Iu8twIAaK4onCIbUsBWRJCER2TwLsWCJSJCFsh8Bk0OtJHI7HhALtsWjs3Dx7xQN
	 XKys4GJgd5Tmw==
Date: Wed, 14 Feb 2024 16:41:38 +0000
From: Will Deacon <will@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: sagi@grimberg.me, hch@lst.de, axboe@kernel.dk, kbusch@kernel.org,
	joro@8bytes.org, robin.murphy@arm.com, jgg@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, murphyt7@tcd.ie, baolu.lu@linux.intel.com
Subject: Re: [PATCH v1 0/2] nvme-pci: Fix dma-iommu mapping failures when
 PAGE_SIZE=64KB
Message-ID: <20240214164138.GA31927@willie-the-truck>
References: <cover.1707851466.git.nicolinc@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1707851466.git.nicolinc@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240214_084145_875466_26F90760 
X-CRM114-Status: GOOD (  16.99  )
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

Hi Nicolin,

On Tue, Feb 13, 2024 at 01:53:55PM -0800, Nicolin Chen wrote:
> It's observed that an NVME device is causing timeouts when Ubuntu boots
> with a kernel configured with PAGE_SIZE=64KB due to failures in swiotlb:
>     systemd[1]: Started Journal Service.
>  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 327680 bytes), total 32768 (slots), used 32 (slots)
>     note: journal-offline[392] exited with irqs disabled
>     note: journal-offline[392] exited with preempt_count 1
> 
> An NVME device under a PCIe bus can be behind an IOMMU, so dma mappings
> going through dma-iommu might be also redirected to swiotlb allocations.
> Similar to dma_direct_max_mapping_size(), dma-iommu should implement its
> dma_map_ops->max_mapping_size to return swiotlb_max_mapping_size() too.
> 
> Though an iommu_dma_max_mapping_size() is a must, it alone can't fix the
> issue. The swiotlb_max_mapping_size() returns 252KB, calculated from the
> default pool 256KB subtracted by min_align_mask NVME_CTRL_PAGE_SIZE=4KB,
> while dma-iommu can roundup a 252KB mapping to 256KB at its "alloc_size"
> when PAGE_SIZE=64KB via iova->granule that is often set to PAGE_SIZE. So
> this mismatch between NVME_CTRL_PAGE_SIZE=4KB and PAGE_SIZE=64KB results
> in a similar failure, though its signature has a fixed size "256KB":
>     systemd[1]: Started Journal Service.
>  => nvme 0000:00:01.0: swiotlb buffer is full (sz: 262144 bytes), total 32768 (slots), used 128 (slots)
>     note: journal-offline[392] exited with irqs disabled
>     note: journal-offline[392] exited with preempt_count 1
> 
> Both failures above occur to NVME behind IOMMU when PAGE_SIZE=64KB. They
> were likely introduced for the security feature by:
> commit 82612d66d51d ("iommu: Allow the dma-iommu api to use bounce buffers"),
> 
> So, this series bundles two fixes together against that. They should be
> taken at the same time to entirely fix the mapping failures.

It's a bit of a shot in the dark, but I've got a pending fix to some of
the alignment handling in swiotlb. It would be interesting to know if
patch 1 has any impact at all on your NVME allocations:

https://lore.kernel.org/r/20240205190127.20685-1-will@kernel.org

Cheers,

Will

