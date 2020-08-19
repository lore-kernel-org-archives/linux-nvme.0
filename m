Return-Path: <SRS0=A4m9=B5=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222A1C433E3
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 06:56:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B90C320885
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2020 06:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TkY5YDvg";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uRThKpBV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B90C320885
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ZRBXSpZjGvVLzFMKI662w35H4HR9AMCAjlnlDZL4uEk=; b=TkY5YDvg3VDafzBB6VvX5FrExt
	cWZsFj64ttrQIjJflrudUROJuOLBmEnjvke9J8amR/UuL2Ga21BHApwBjRM5bl+nV7vFF7l5uwkrF
	Z5KiD691G0hBmEF6m+7nND8QtXS3iNGVnyNa9tfg0RHF8+ngtbTqBXM12YBlYP0P5R69gei5Jz76j
	QafWz4suGoue/bSY3GrZXmWkckfqapX9HVpMwIIN+ukGCczGcoev2kCpjxGxmhr8Lg9AC2OrKK6Vb
	PRK5DebXaIqncK1qrEI+Vf3CHd5XN7jRYgoDXXvEbKZcfiRZnRZoujAHycTAJ+s6Zp81NY0fE5GDt
	ZJDR7IBQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k8I1f-0005AJ-Fn; Wed, 19 Aug 2020 06:56:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I0v-0004rQ-KG; Wed, 19 Aug 2020 06:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=z2KvWaZyjho7ndXMH0ORSIBGMLsoLoOlaFmWAQTQuew=; b=uRThKpBVD38wHW4O1Rw+m7ReIB
 6g8DAFjC8rOV8slo1/sXfbFmSe2ZQ/D8oXBbMOULOMMqWf/LF2YgmRNBRhy6xw/WNcPfIgir5jkfY
 jMUBZNOtuPrAml+wEbfI5OBf4FZwNLx4AJ6KLMbazwwdxWKTRuJ8t4QvNBD00a4zi7/l8eeZNVCHo
 TVip/vAV16StqtD9sSi3vWzGnecdc/pw7stv6o2Z7fnoWC5+a2JoL1fYWc4VJinapBZy26rlLUcYn
 mtr0U1RQYeE7P0ovTcYzaF9TaQqsHNEEbAFwOJIquRs9u5qnSydzfDIu7+tbwzSbcDpvLkPbTkcNu
 ySmmqGNA==;
Received: from [2001:4bb8:198:f3b2:86b6:2277:f429:37a1] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k8I0q-0008Kr-1o; Wed, 19 Aug 2020 06:55:57 +0000
From: Christoph Hellwig <hch@lst.de>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Matt Porter <mporter@kernel.crashing.org>, iommu@lists.linux-foundation.org
Subject: a saner API for allocating DMA addressable pages
Date: Wed, 19 Aug 2020 08:55:27 +0200
Message-Id: <20200819065555.1802761-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, alsa-devel@alsa-project.org,
 linux-samsung-soc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-doc@vger.kernel.org, nouveau@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi all,

this series replaced the DMA_ATTR_NON_CONSISTENT flag to dma_alloc_attrs
with a separate new dma_alloc_pages API, which is available on all
platforms.  In addition to cleaning up the convoluted code path, this
ensures that other drivers that have asked for better support for
non-coherent DMA to pages with incurring bounce buffering over can finally
be properly supported.

I'm still a little unsure about the API naming, as alloc_pages sort of
implies a struct page return value, but we return a kernel virtual
address.  The other alternative would be to name the API
dma_alloc_noncoherent, but the whole non-coherent naming seems to put
people off.  As a follow up I plan to move the implementation of the
DMA_ATTR_NO_KERNEL_MAPPING flag over to this framework as well, given
that is also is a fundamentally non coherent allocation.  The replacement
for that flag would then return a struct page, as it is allowed to
actually return pages without a kernel mapping as the name suggested
(although most of the time they will actually have a kernel mapping..)

In addition to the conversions of the existing non-coherent DMA users
the last three patches also convert the DMA coherent allocations in
the NVMe driver to use this new framework through a dmapool addition.
This was both to give me a good testing vehicle, but also because it
should speed up the NVMe driver on platforms with non-coherent DMA
nicely, without a downside on platforms with cache coherent DMA.


A git tree is available here:

    git://git.infradead.org/users/hch/misc.git dma_alloc_pages

Gitweb:

    http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_pages


Diffstat:
 Documentation/core-api/dma-api.rst                       |   92 ++----
 Documentation/core-api/dma-attributes.rst                |    8 
 Documentation/userspace-api/media/v4l/buffer.rst         |   17 -
 Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst |    1 
 arch/alpha/kernel/pci_iommu.c                            |    2 
 arch/arm/include/asm/dma-direct.h                        |    4 
 arch/arm/mm/dma-mapping-nommu.c                          |    2 
 arch/arm/mm/dma-mapping.c                                |    4 
 arch/ia64/Kconfig                                        |    3 
 arch/ia64/hp/common/sba_iommu.c                          |    2 
 arch/ia64/kernel/dma-mapping.c                           |   14 
 arch/ia64/mm/init.c                                      |    3 
 arch/mips/Kconfig                                        |    1 
 arch/mips/bmips/dma.c                                    |    4 
 arch/mips/cavium-octeon/dma-octeon.c                     |    4 
 arch/mips/include/asm/dma-direct.h                       |    4 
 arch/mips/include/asm/jazzdma.h                          |    2 
 arch/mips/jazz/jazzdma.c                                 |  102 +------
 arch/mips/loongson2ef/fuloong-2e/dma.c                   |    4 
 arch/mips/loongson2ef/lemote-2f/dma.c                    |    4 
 arch/mips/loongson64/dma.c                               |    4 
 arch/mips/mm/dma-noncoherent.c                           |   48 +--
 arch/mips/pci/pci-ar2315.c                               |    4 
 arch/mips/pci/pci-xtalk-bridge.c                         |    4 
 arch/mips/sgi-ip32/ip32-dma.c                            |    4 
 arch/parisc/Kconfig                                      |    1 
 arch/parisc/kernel/pci-dma.c                             |    6 
 arch/powerpc/include/asm/dma-direct.h                    |    4 
 arch/powerpc/kernel/dma-iommu.c                          |    2 
 arch/powerpc/platforms/ps3/system-bus.c                  |    4 
 arch/powerpc/platforms/pseries/vio.c                     |    2 
 arch/s390/pci/pci_dma.c                                  |    2 
 arch/x86/kernel/amd_gart_64.c                            |    8 
 drivers/gpu/drm/exynos/exynos_drm_gem.c                  |    2 
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c      |    3 
 drivers/iommu/dma-iommu.c                                |    2 
 drivers/iommu/intel/iommu.c                              |    6 
 drivers/media/common/videobuf2/videobuf2-core.c          |   36 --
 drivers/media/common/videobuf2/videobuf2-dma-contig.c    |   19 -
 drivers/media/common/videobuf2/videobuf2-dma-sg.c        |    3 
 drivers/media/common/videobuf2/videobuf2-v4l2.c          |   12 
 drivers/net/ethernet/amd/au1000_eth.c                    |   15 -
 drivers/net/ethernet/i825xx/lasi_82596.c                 |   36 +-
 drivers/net/ethernet/i825xx/lib82596.c                   |  148 +++++-----
 drivers/net/ethernet/i825xx/sni_82596.c                  |   23 -
 drivers/net/ethernet/seeq/sgiseeq.c                      |   24 -
 drivers/nvme/host/pci.c                                  |   79 ++---
 drivers/parisc/ccio-dma.c                                |    2 
 drivers/parisc/sba_iommu.c                               |    2 
 drivers/scsi/53c700.c                                    |  120 ++++----
 drivers/scsi/53c700.h                                    |    9 
 drivers/scsi/sgiwd93.c                                   |   14 
 drivers/xen/swiotlb-xen.c                                |    2 
 include/linux/dma-direct.h                               |   55 ++-
 include/linux/dma-mapping.h                              |   32 +-
 include/linux/dma-noncoherent.h                          |   21 -
 include/linux/dmapool.h                                  |   23 +
 include/linux/gfp.h                                      |    6 
 include/media/videobuf2-core.h                           |    3 
 include/uapi/linux/videodev2.h                           |    2 
 kernel/dma/Kconfig                                       |    9 
 kernel/dma/Makefile                                      |    1 
 kernel/dma/coherent.c                                    |   17 +
 kernel/dma/direct.c                                      |  112 +++++--
 kernel/dma/mapping.c                                     |  104 ++-----
 kernel/dma/ops_helpers.c                                 |   86 ++++++
 kernel/dma/pool.c                                        |    2 
 kernel/dma/swiotlb.c                                     |    4 
 kernel/dma/virt.c                                        |    2 
 mm/dmapool.c                                             |  211 +++++++++------
 sound/mips/hal2.c                                        |   58 +---
 71 files changed, 872 insertions(+), 803 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
