Return-Path: <SRS0=h+kd=CH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C76BFC433E6
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 10:02:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BF4E20825
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Aug 2020 10:02:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gQeFtukY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n3k0nGvo";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eqAsNNwO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BF4E20825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=INIILhiRDmJfOyjMxbp49/klsrf1wOUHxbHkmad9JU0=; b=gQeFtukYc+pIQJBNasLttl/fY
	1cjQARAVGqS2R7LY5DjaGSeyFX/kaCA4Erqy/2UsY57toOtv6zk6si+0bHRK5dq4kbyc99hSatij1
	88j38j7nMZ6DeCVlVzy3ikWIBWIPudUca9ME1HoX3UJRDBsVpCdRONJs5sTPfDVyVl3a86FPLjAwR
	PFbCb+X4DMM44A00PBdifz+sshlpYXCfbYFqMSNSEIl0PxMCrzsZg+UZTmhOg2s67QUK3tzPIU93G
	Z+vR3Z+qtq/NnljMZ2sa85DQ4icb8X43QqUrMfAAvJoGOLl8swMEHrLqdOL4oJ445ZtFiPwIN5aZB
	lqwaWwi0A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kBxgY-0002lM-Nj; Sat, 29 Aug 2020 10:02:10 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBxgU-0002l0-QV; Sat, 29 Aug 2020 10:02:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=5rCM23C9dAmyfKnS7EiAetzEAurj8T8DGBfswZowxdU=; b=n3k0nGvoVZmNXgN58ciJB67G9E
 GBwICDWVp/V7JFBwyIT4Dtyf5jMGCzATCgnJkXW6qiYwu4ci4kMWk/n15hO2h5uG/FeJ0L7R42ZoK
 Ky84Rzri/vvzgJwPidlSbMcoxmFGrsp2AyCeFVFXW9oiE+5uJPZtJdl/+TGhaQPuM43t0bkCyvNOe
 433VIF1DCDVsBgJXxVxu83DV6aXzlvKGGAtdgxm77h8aB3cyza3HuZSTJ2VO9QFV7zypCdvzx0arV
 5MSYNNC9Se7GsR6UB3nPvavAJFe163mDjxIF3ygh5P/pLFC7BcurHGb5593YgXsUvrwmrUSVenGrS
 VpkThBVw==;
Received: from mout.gmx.net ([212.227.17.20])
 by casper.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kBxgQ-0003XV-86; Sat, 29 Aug 2020 10:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598695313;
 bh=3F15H2PNzBIc0EFjrxqHH0XfkEEFa8OSmYddqGK8H+0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=eqAsNNwOWYlrqP2eZbW1UeCojWvEnyA1EsjpP2pcr1goJMPlAEGIlQoGDavAI6WMC
 rrErExl0gVJL4cr8VphpEnuS/krk9xeAMI0H270yKp5GKnaXm0YYs+H5VufGYkgou8
 fDdbS2zW2hCRJEFsKgwWIio5R/hpzP6fwkCr9jv8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.169.105]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MryTF-1kzqb42Rgj-00nwOw; Sat, 29
 Aug 2020 11:47:03 +0200
Subject: Re: a saner API for allocating DMA addressable pages
To: Christoph Hellwig <hch@lst.de>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Joonyoung Shim <jy0922.shim@samsung.com>,
 Seung-Woo Kim <sw0312.kim@samsung.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, Ben Skeggs <bskeggs@redhat.com>,
 Pawel Osciak <pawel@osciak.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Matt Porter <mporter@kernel.crashing.org>,
 iommu@lists.linux-foundation.org
References: <20200819065555.1802761-1-hch@lst.de>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <73b81ba2-3f1c-cce9-0bcf-e739c2a2f6d8@gmx.de>
Date: Sat, 29 Aug 2020 11:46:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200819065555.1802761-1-hch@lst.de>
Content-Language: en-US
X-Provags-ID: V03:K1:oJ0DWTaeXj/z2c6/t19vHP7YStT4MiWtTWeFmCetTtBo49Hh4sa
 MXIOt4fOrWhKcajKOQn9yDtXPWoBtqQjT0jJihKGRY7MdilOq6ZLvEQJAHP/3tQc3VMSqjw
 8nrw+oyKRGNPfYAhYsTPKH1SOnK7ozn1tLaEFYkGuZxVaZV1fMUaMHgotwKVH1EV+Qr8QAH
 zOF0hIOTIYaJkqfweauPA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YSvMmYjYn2c=:/m8g7XF+r82HSgzWi4LtEl
 H9fP7iZRq72u0EEgzlvZpTFqBGGg3CRWV/n1CogS49rTKf91Nz8HM6SP8TPQKInqpuO99z3ej
 IsRLQVLXSpTs/9XZPn5hAEiqvF7TZpbVD+zl2DmuAqwRwmrVVTevAtvh2NXp6WDtW8V3nt64e
 yStyRFtETkoULZ+iKUZx7RCRh8bp8VCV+PneF8oCBfhioXbDwCtnDvmI05DBToAipKu7ZYvjN
 JIH8t/bIBpM3eA4DrTutcyW3zQzg6IS6ZLLIq8W4QM+2aDGdN4dDbNg58UYeQRPfV4g8hbph2
 cb/TBGzegMPmIgVtPYMBfq1z+INKcWlU73t0rsxbsdYZ1pfF2Sp9O80/KBeqVoA5O3uEkYF5S
 6jj/cPO8sLhXbMgu7VAr82HZTOASgN7Re/+iBCbxo1CQre+gzV9Hn344axSG+xkN5r9ksFpSS
 z7LIaZVwspFnNPzhuT8IGBo3mBwo+2lu9160Da8GXhbOeN7OPs1jdgbAE3eKNFAuFleqXCF+r
 TQlMfKauT6/sDrjkVGRh3O4c3LlZchq0xXjL867g9Eq/PNUJyILmv94Knj+TZiG0PqOLJKHnM
 vzVfibgLOhqqBpxDwlTENjl9YVr0wPUMMp8K9Yc6GlddEkodIGHq6vp92/GkirKgPDn084X5t
 0kVqaT9pOr+bRllM/XWDRd0brrjnVKzG6XOVPZIPShTncCdxjoSNyUJp5DtP8EprbHwAMrdfI
 2OviBsPuAtc6jyV5QSgCR0SzfHWmvTBXv2r3Eh/WsvxBpVo2skuYuyTCk0WimzpcR2jxOQE1t
 fePFfJECBCEtiaH/UdmRFV2aksoOkuygYso3XGAy9iLaLXhn6Dlxb2kRNyH4jhPNlhG2rAPqr
 gEBq0HUK8frCB5gfVYnA8IGyrNGHDOyNgEhBjoswQCoKPMu/OsrMWfNZ+1iOq5yRti3M2bgS7
 w+OGLIIfqlNAh4j2pQ2LURkiM3iHq3PMLxOGJYFbx+9Mg7vDylpqu/owjRr3qGEkmEhzqolEt
 Q4Q3I5VnI9rsW+cgF9saf76UYU1tj/m3fg5aWAKxN/9ZctJldytSR9mXEZFBGMXm5cdWP/hBx
 hgrPUbzhGhkETmQZEGAcLMHi/amEyJBkXmhL8aCCzSal+GABTD7taCMHp9sxzQpaT13TYzOUV
 k0gXBuUsxkYgEz9uvDdhXNrGroo/ox38nwTJcvki4I88NTYksRG9GPtMCp8TkU6lFoE5px1VX
 0Zkn2QmtyVEk8mdGT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200829_110202_437833_EA5A8CC2 
X-CRM114-Status: GOOD (  16.26  )
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

Hi Christoph,

On 19.08.20 08:55, Christoph Hellwig wrote:
> this series replaced the DMA_ATTR_NON_CONSISTENT flag to dma_alloc_attrs
> with a separate new dma_alloc_pages API, which is available on all
> platforms.  In addition to cleaning up the convoluted code path, this
> ensures that other drivers that have asked for better support for
> non-coherent DMA to pages with incurring bounce buffering over can finally
> be properly supported.
> ....
> A git tree is available here:
>
>     git://git.infradead.org/users/hch/misc.git dma_alloc_pages

I've tested this tree on my parisc machine which uses the 53c700
and lasi_82596 drivers.
Everything worked as expected, so you may add:

Tested-by: Helge Deller <deller@gmx.de> # parisc

Thanks!
Helge

>
> Gitweb:
>
>     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_pages
>
>
> Diffstat:
>  Documentation/core-api/dma-api.rst                       |   92 ++----
>  Documentation/core-api/dma-attributes.rst                |    8
>  Documentation/userspace-api/media/v4l/buffer.rst         |   17 -
>  Documentation/userspace-api/media/v4l/vidioc-reqbufs.rst |    1
>  arch/alpha/kernel/pci_iommu.c                            |    2
>  arch/arm/include/asm/dma-direct.h                        |    4
>  arch/arm/mm/dma-mapping-nommu.c                          |    2
>  arch/arm/mm/dma-mapping.c                                |    4
>  arch/ia64/Kconfig                                        |    3
>  arch/ia64/hp/common/sba_iommu.c                          |    2
>  arch/ia64/kernel/dma-mapping.c                           |   14
>  arch/ia64/mm/init.c                                      |    3
>  arch/mips/Kconfig                                        |    1
>  arch/mips/bmips/dma.c                                    |    4
>  arch/mips/cavium-octeon/dma-octeon.c                     |    4
>  arch/mips/include/asm/dma-direct.h                       |    4
>  arch/mips/include/asm/jazzdma.h                          |    2
>  arch/mips/jazz/jazzdma.c                                 |  102 +------
>  arch/mips/loongson2ef/fuloong-2e/dma.c                   |    4
>  arch/mips/loongson2ef/lemote-2f/dma.c                    |    4
>  arch/mips/loongson64/dma.c                               |    4
>  arch/mips/mm/dma-noncoherent.c                           |   48 +--
>  arch/mips/pci/pci-ar2315.c                               |    4
>  arch/mips/pci/pci-xtalk-bridge.c                         |    4
>  arch/mips/sgi-ip32/ip32-dma.c                            |    4
>  arch/parisc/Kconfig                                      |    1
>  arch/parisc/kernel/pci-dma.c                             |    6
>  arch/powerpc/include/asm/dma-direct.h                    |    4
>  arch/powerpc/kernel/dma-iommu.c                          |    2
>  arch/powerpc/platforms/ps3/system-bus.c                  |    4
>  arch/powerpc/platforms/pseries/vio.c                     |    2
>  arch/s390/pci/pci_dma.c                                  |    2
>  arch/x86/kernel/amd_gart_64.c                            |    8
>  drivers/gpu/drm/exynos/exynos_drm_gem.c                  |    2
>  drivers/gpu/drm/nouveau/nvkm/subdev/instmem/gk20a.c      |    3
>  drivers/iommu/dma-iommu.c                                |    2
>  drivers/iommu/intel/iommu.c                              |    6
>  drivers/media/common/videobuf2/videobuf2-core.c          |   36 --
>  drivers/media/common/videobuf2/videobuf2-dma-contig.c    |   19 -
>  drivers/media/common/videobuf2/videobuf2-dma-sg.c        |    3
>  drivers/media/common/videobuf2/videobuf2-v4l2.c          |   12
>  drivers/net/ethernet/amd/au1000_eth.c                    |   15 -
>  drivers/net/ethernet/i825xx/lasi_82596.c                 |   36 +-
>  drivers/net/ethernet/i825xx/lib82596.c                   |  148 +++++-----
>  drivers/net/ethernet/i825xx/sni_82596.c                  |   23 -
>  drivers/net/ethernet/seeq/sgiseeq.c                      |   24 -
>  drivers/nvme/host/pci.c                                  |   79 ++---
>  drivers/parisc/ccio-dma.c                                |    2
>  drivers/parisc/sba_iommu.c                               |    2
>  drivers/scsi/53c700.c                                    |  120 ++++----
>  drivers/scsi/53c700.h                                    |    9
>  drivers/scsi/sgiwd93.c                                   |   14
>  drivers/xen/swiotlb-xen.c                                |    2
>  include/linux/dma-direct.h                               |   55 ++-
>  include/linux/dma-mapping.h                              |   32 +-
>  include/linux/dma-noncoherent.h                          |   21 -
>  include/linux/dmapool.h                                  |   23 +
>  include/linux/gfp.h                                      |    6
>  include/media/videobuf2-core.h                           |    3
>  include/uapi/linux/videodev2.h                           |    2
>  kernel/dma/Kconfig                                       |    9
>  kernel/dma/Makefile                                      |    1
>  kernel/dma/coherent.c                                    |   17 +
>  kernel/dma/direct.c                                      |  112 +++++--
>  kernel/dma/mapping.c                                     |  104 ++-----
>  kernel/dma/ops_helpers.c                                 |   86 ++++++
>  kernel/dma/pool.c                                        |    2
>  kernel/dma/swiotlb.c                                     |    4
>  kernel/dma/virt.c                                        |    2
>  mm/dmapool.c                                             |  211 +++++++++------
>  sound/mips/hal2.c                                        |   58 +---
>  71 files changed, 872 insertions(+), 803 deletions(-)
>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
