Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93FEC35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 09:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zGpWflZPC+kOO1DejABnas9k1cB4w9wgboVXofKBFGg=; b=RHi/Xtsbdkksac/ffNRWV45csg
	box+kCHA3xgUIucHNO3momIKL2iyWGxcssSwQ/L3JRdXgHb76/Nc0fQvTRPSDu9XBpLWfv5IF8T3M
	SEYdrWrSRv01kRuBRIqOSeb29JnfrSbfmeWouq8zepE65MNWxMOog/WlZ9jyGbeJbtPvP51R6RcZC
	SyMcyLBeD86jEbpr6lXbWQXXHh5FjigF0azfExEhxOR8s4oP8QwUZm+elcGWaNBXwlChTejfxO8Y1
	NJnX6634hU3A/40VGIKZu9g/KKtL+injzYqFSpyXRBmxsZMu5LstBHXvmq0HpQXr3bCEl/6h4OZio
	YPB560AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFA3j-009gdR-2g;
	Mon, 18 Dec 2023 09:37:11 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFA3g-009gcN-16
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 09:37:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7AF8CCE0FD1;
	Mon, 18 Dec 2023 09:37:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD6FC433C7;
	Mon, 18 Dec 2023 09:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702892225;
	bh=Z4ThilXJPF52KkpFFtkk2UUa9/0Ai3GpLVjPXlR17A8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pQzvQS+KVHfkHlgbEBnhnpy0T/9Bx/Bzsk4DHPZNtT8gZuB8FzsYEzMa4y/M8HFTh
	 a/79UdFFQ4wb8X6ArgNHaCrumfzFl4c4nvRTtEs7R84rgH0ukIlh69/Oq7/aCEJ/xJ
	 Bp3oSPIeQEpmphihrSKDpgMu/OjpJ1ELUAiLMeRS079UF3wuSSNtgAUWYTP27D0N4e
	 IJvEkMcvnJbegCaHWkoh9e0ZLdb2D9VCH4mabPM+NXvDIRMbuCqMZ425d5qEpsLhcC
	 lQUcyoWmALOQNLsuwJ3tUeuhPUkPompc6LZj0O/RZdmA9kA/XaLDAtGiq6fcQDpfEM
	 DUFigcnPsQiWQ==
Message-ID: <bad7e62c-f4c6-4db9-a1ae-c14d56378072@kernel.org>
Date: Mon, 18 Dec 2023 18:37:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] virtio_blk: remove the broken zone revalidation
 support
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-3-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_013708_725482_E7E2FE04 
X-CRM114-Status: GOOD (  25.54  )
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

On 2023/12/18 1:53, Christoph Hellwig wrote:
> virtblk_revalidate_zones is called unconditionally from
> virtblk_config_changed_work from the virtio config_changed callback.
> 
> virtblk_revalidate_zones is a bit odd in that it re-clears the zoned
> state for host aware or non-zoned devices, which isn't needed unless the
> zoned mode changed - but a zone mode change to a host managed model isn't
> handled at all, and virtio_blk also doesn't handle any other config
> change except for a capacity change is handled (and even if it was
> the upper layers above virtio_blk wouldn't handle it very well).
> 
> But even the useful case of a size change that would add or remove
> zones isn't handled properly as blk_revalidate_disk_zones expects the
> device capacity to cover all zones, but the capacity is only updated
> after virtblk_revalidate_zones.
> 
> As this code appears to be entirely untested and is getting in the way
> remove it for now, but it can be readded in a fixed version with
> proper test coverage if needed.
> 
> Fixes: 95bfec41bd3d ("virtio-blk: add support for zoned block devices")
> Fixes: f1ba4e674feb ("virtio-blk: fix to match virtio spec")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Not ideal... But I think this is OK for now given that as you say, the upper
layer will not be able to handle zone changes anyway.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/block/virtio_blk.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index aeead732a24dc9..a28f1687066bb4 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -722,27 +722,6 @@ static int virtblk_report_zones(struct gendisk *disk, sector_t sector,
>  	return ret;
>  }
>  
> -static void virtblk_revalidate_zones(struct virtio_blk *vblk)
> -{
> -	u8 model;
> -
> -	virtio_cread(vblk->vdev, struct virtio_blk_config,
> -		     zoned.model, &model);
> -	switch (model) {
> -	default:
> -		dev_err(&vblk->vdev->dev, "unknown zone model %d\n", model);
> -		fallthrough;
> -	case VIRTIO_BLK_Z_NONE:
> -	case VIRTIO_BLK_Z_HA:
> -		disk_set_zoned(vblk->disk, BLK_ZONED_NONE);
> -		return;
> -	case VIRTIO_BLK_Z_HM:
> -		WARN_ON_ONCE(!vblk->zone_sectors);
> -		if (!blk_revalidate_disk_zones(vblk->disk, NULL))
> -			set_capacity_and_notify(vblk->disk, 0);
> -	}
> -}
> -
>  static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  				       struct virtio_blk *vblk,
>  				       struct request_queue *q)
> @@ -823,10 +802,6 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>   */
>  #define virtblk_report_zones       NULL
>  
> -static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
> -{
> -}
> -
>  static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  			struct virtio_blk *vblk, struct request_queue *q)
>  {
> @@ -982,7 +957,6 @@ static void virtblk_config_changed_work(struct work_struct *work)
>  	struct virtio_blk *vblk =
>  		container_of(work, struct virtio_blk, config_work);
>  
> -	virtblk_revalidate_zones(vblk);
>  	virtblk_update_capacity(vblk, true);
>  }
>  

-- 
Damien Le Moal
Western Digital Research


