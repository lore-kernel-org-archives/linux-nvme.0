Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF5AF10775E1
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Mar 2026 16:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ID1zm2iqh5UB2/KBN9LdtoZvDHClQtDWf4LCSIvKNT0=; b=vHX1uGvAQOF6JcoTAAY5UGUhcA
	7/k3aO/k9EfA6KqTTc4XA0O5HInxzRR6kflGtoC8SW8hkllVsOO07UXfhkSfPhZFgHtvf0peuMTaM
	oCk3ncyDht0d//uPk2b5CAbFYHjG+yDsOTolAqi26ZaQuGItbf8oyADZ6BLnNXkdxEPxMNjSzg2hZ
	LBiBL3ChGOvaF4iw9hadvDY+n557ib94HhxFNeMA7pJ5nJlgmGFbFuS+itHKlgEfddsJ2GYZKDwwh
	bBAkT0RYhtl6hjUtt3AA6oo7Goz6P6RGK9rm89c5SiGFznVHuCcpEsYkflvLlSNGLDNZ17GDKWik+
	/CcGIi5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2tw8-00000008z5T-40hF;
	Wed, 18 Mar 2026 16:40:00 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2tw6-00000008z2l-1AUd
	for linux-nvme@lists.infradead.org;
	Wed, 18 Mar 2026 16:40:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CA081BD0;
	Wed, 18 Mar 2026 09:39:46 -0700 (PDT)
Received: from [10.57.59.172] (unknown [10.57.59.172])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95BB13F778;
	Wed, 18 Mar 2026 09:39:49 -0700 (PDT)
Message-ID: <c116c75e-4e85-4f57-abb7-ba80bbc8f863@arm.com>
Date: Wed, 18 Mar 2026 16:39:47 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] scsi: sas: skip opt_sectors when DMA reports no real
 optimization hint
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: ahuang12@lenovo.com, axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
 hch@lst.de, iommu@lists.linux.dev, ionut_n2001@yahoo.com,
 john.g.garry@oracle.com, kbusch@kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 m.szyprowski@samsung.com, sagi@grimberg.me, stable@vger.kernel.org,
 sunlightlinux@gmail.com
References: <20260318074314.17372-1-ionut.nechita@windriver.com>
 <20260318074314.17372-2-ionut.nechita@windriver.com>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260318074314.17372-2-ionut.nechita@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260318_093958_766070_4C4649BA 
X-CRM114-Status: GOOD (  28.38  )
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

On 2026-03-18 7:43 am, Ionut Nechita (Wind River) wrote:
> From: Ionut Nechita <ionut.nechita@windriver.com>
> 
> sas_host_setup() unconditionally sets shost->opt_sectors from
> dma_opt_mapping_size().  When the IOMMU is disabled or in passthrough
> mode and no DMA ops provide an opt_mapping_size callback,
> dma_opt_mapping_size() returns min(dma_max_mapping_size(), SIZE_MAX)
> which equals dma_max_mapping_size() — a hard upper bound, not an
> optimization hint.
> 
> On a Dell PowerEdge R750 with mpt3sas (Broadcom SAS3816, FW 33.15.00.00)
> and intel_iommu=off the following values are observed:
> 
>    dma_opt_mapping_size()  = dma_max_mapping_size() (no real hint)
>    shost->max_sectors      = 32767
>    opt_sectors             = min(32767, huge >> 9) = 32767
>    optimal_io_size         = 32767 << 9 = 16776704
>                            → round_down(16776704, 4096) = 16773120
> 
> The SAS disk (SAMSUNG MZILT800HBHQ0D3) do not report an
> Optimal Transfer Length in VPD page B0,so sdkp->opt_xfer_blocks remains 0.
> sd_revalidate_disk() then uses min_not_zero(0, opt_sectors) = opt_sectors,
> propagating the bogus value into the block device's optimal_io_size
> (visible as OPT-IO = 16773120 in lsblk --topology).
> 
> mkfs.xfs picks up optimal_io_size and minimum_io_size and computes:
> 
>    swidth = 16773120 / 4096 = 4095
>    sunit  = 8192 / 4096     = 2
> 
> Since 4095 % 2 != 0, XFS rejects the geometry:
> 
>    SB stripe unit sanity check failed
> 
> This makes it impossible to create XFS filesystems (e.g. for
> /var/lib/docker) during system bootstrap.
> 
> Fix this by only setting opt_sectors when dma_opt_mapping_size() returns
> a value strictly less than dma_max_mapping_size(), which indicates a
> genuine DMA optimization constraint from an IOMMU or DMA ops backend.
> When they are equal, no backend provided a real hint, so leave
> opt_sectors at its default of 0 ("no preference").
> 
> Fixes: 4cbfca5f7750 ("scsi: scsi_transport_sas: cap shost opt_sectors according to DMA optimal limit")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
> ---
>   drivers/scsi/scsi_transport_sas.c | 16 ++++++++++++++--
>   1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index 12124f9d5ccd..6b4de5116feb 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -240,8 +240,20 @@ static int sas_host_setup(struct transport_container *tc, struct device *dev,
>   			   shost->host_no);
>   
>   	if (dma_dev->dma_mask) {
> -		shost->opt_sectors = min_t(unsigned int, shost->max_sectors,
> -				dma_opt_mapping_size(dma_dev) >> SECTOR_SHIFT);
> +		size_t opt = dma_opt_mapping_size(dma_dev);
> +
> +		/*
> +		 * Only set opt_sectors when the DMA layer reports a
> +		 * genuine optimization constraint.  When opt equals
> +		 * dma_max_mapping_size() no backend provided a real
> +		 * hint — the value is just the DMA maximum, which is
> +		 * not useful as an optimal I/O size and can cause
> +		 * mkfs.xfs to compute invalid stripe geometry.
> +		 */
> +		if (opt < dma_max_mapping_size(dma_dev))

The point is more that dma_opt_mapping_size() is *always* only ever a 
constraint, never a target. This code should be coming up with its own 
idea of whether max_sectors is large enough to be meaningless, and 
picking an initial opt_sectors value based on that, and only *then* 
potentially reducing that value further if the DMA API indicates it 
would be more efficient to do so. Making this conditional makes little 
sense even if it wasn't clearly still broken when dma_opt_mapping_size() 
== (dma_max_mapping_size() - n) for most non-zero values of n.

That said, the comment in sd_revalidate_disk() implies that opt_sectors 
itself is also only intended as an upper limit rather than a specific 
preference, so there wouldn't seem to be any harm in deriving a 
suitably-aligned value from dma_max_mapping_size() either.

Thanks,
Robin.

> +			shost->opt_sectors = min_t(unsigned int,
> +					shost->max_sectors,
> +					opt >> SECTOR_SHIFT);
>   	}
>   
>   	return 0;


