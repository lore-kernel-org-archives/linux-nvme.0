Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6763C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 09:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c6XpL24hSrj1sj6Sfz5IRJdlg5cgqfE7ChjM/+TQ3ms=; b=EoKBjiWiPMzMhBuQCrbH2JhZ40
	iDyi8NoMLT9ELYDhy1sx0MINfJ8KfDBEis7/vmn7FJ06Dr3E5j7clKRsEhPh0hPpuBBoqQtugYhO0
	8rDZWbsUkFUmyeeOc6LadUKSRzUeK1vE6YPUIHegh3V/YDD3Ht/0RVAR8DDv3QgDdoAnrVNFgzU61
	PG1yHI7wwFX70i3oA/kfqQKTqSihUTGUq7af/ARyJ/PTvxpisjHCPN0GRlpmptR48jtsbfYv0axZf
	eOxaqFBDtmBq7THo4mU0XrdBtu2UTF0frf5yHe9t2pqezO1kbes9jJqZ/ut1b3wabDLH8iD5YkAHk
	eB3AYBQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFA2G-009gJM-2w;
	Mon, 18 Dec 2023 09:35:40 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFA2C-009gIj-2u
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 09:35:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8E384CE0FD6;
	Mon, 18 Dec 2023 09:35:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3ACC433C7;
	Mon, 18 Dec 2023 09:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702892133;
	bh=PdHvoka0eRTRzrIhBD8Y+azqZmjNt6H86o7Q4PS3jto=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ixzIFM8AXAn2cja/sTESRTfJoPsg4QgxKJKyvmiQM1CWZvFLAr5MOkpcMN5Ys5906
	 T8lUM+06OuvSGYR1vOezMXxxqsQquG8879ZlIu4jDA+oxOiue63P+nt0QAXJLhWxjj
	 3bwrmS3JwSRWLln1vScF91Vne6aa858bo9b3C3EZBPaGmRIS91eu5THp6C1F1xCrAa
	 kClzMKYkkxYj2vY6CDTStAonyBqcFheLWMSCSp+Zwqk7HBKDH0ghgzyyugA2cOtdny
	 xgjGGTAbU9lsmnyRKUvlHqbIU27gfNYWiNkdsKdroDVxWtstQUzQM1ztQt6soO5+pJ
	 4u5RYHjamVwZw==
Message-ID: <7d3c7ab1-490a-498c-9e15-a33a36788b61@kernel.org>
Date: Mon, 18 Dec 2023 18:35:30 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] virtio_blk: cleanup zoned device probing
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, "Martin K. Petersen" <martin.petersen@oracle.com>,
 dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-2-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_013537_397505_7F2098B3 
X-CRM114-Status: GOOD (  20.82  )
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
> Move reading and checking the zoned model from virtblk_probe_zoned_device
> into the caller, leaving only the code to perform the actual setup for
> host managed zoned devices in virtblk_probe_zoned_device.
> 
> This allows to share the model reading and sharing between builds with
> and without CONFIG_BLK_DEV_ZONED, and improve it for the
> !CONFIG_BLK_DEV_ZONED case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> ---
>  drivers/block/virtio_blk.c | 50 +++++++++++++++++---------------------
>  1 file changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index d53d6aa8ee69a4..aeead732a24dc9 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -748,22 +748,6 @@ static int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  				       struct request_queue *q)
>  {
>  	u32 v, wg;
> -	u8 model;
> -
> -	virtio_cread(vdev, struct virtio_blk_config,
> -		     zoned.model, &model);
> -
> -	switch (model) {
> -	case VIRTIO_BLK_Z_NONE:
> -	case VIRTIO_BLK_Z_HA:
> -		/* Present the host-aware device as non-zoned */
> -		return 0;
> -	case VIRTIO_BLK_Z_HM:
> -		break;
> -	default:
> -		dev_err(&vdev->dev, "unsupported zone model %d\n", model);
> -		return -EINVAL;
> -	}
>  
>  	dev_dbg(&vdev->dev, "probing host-managed zoned device\n");
>  
> @@ -846,16 +830,9 @@ static inline void virtblk_revalidate_zones(struct virtio_blk *vblk)
>  static inline int virtblk_probe_zoned_device(struct virtio_device *vdev,
>  			struct virtio_blk *vblk, struct request_queue *q)
>  {
> -	u8 model;
> -
> -	virtio_cread(vdev, struct virtio_blk_config, zoned.model, &model);
> -	if (model == VIRTIO_BLK_Z_HM) {
> -		dev_err(&vdev->dev,
> -			"virtio_blk: zoned devices are not supported");
> -		return -EOPNOTSUPP;
> -	}
> -
> -	return 0;
> +	dev_err(&vdev->dev,
> +		"virtio_blk: zoned devices are not supported");
> +	return -EOPNOTSUPP;
>  }
>  #endif /* CONFIG_BLK_DEV_ZONED */
>  
> @@ -1570,9 +1547,26 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	 * placed after the virtio_device_ready() call above.
>  	 */
>  	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> -		err = virtblk_probe_zoned_device(vdev, vblk, q);
> -		if (err)
> +		u8 model;
> +
> +		virtio_cread(vdev, struct virtio_blk_config, zoned.model,
> +				&model);
> +		switch (model) {
> +		case VIRTIO_BLK_Z_NONE:
> +		case VIRTIO_BLK_Z_HA:
> +			/* Present the host-aware device as non-zoned */
> +			break;
> +		case VIRTIO_BLK_Z_HM:
> +			err = virtblk_probe_zoned_device(vdev, vblk, q);
> +			if (err)
> +				goto out_cleanup_disk;
> +			break;
> +		default:
> +			dev_err(&vdev->dev, "unsupported zone model %d\n",
> +				model);
> +			err = -EINVAL;
>  			goto out_cleanup_disk;
> +		}
>  	}
>  
>  	err = device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);

-- 
Damien Le Moal
Western Digital Research


