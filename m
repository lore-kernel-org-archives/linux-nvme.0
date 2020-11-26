Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DECC56201
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:16:32 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C0DF206C0
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sVOUbvLc";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvBDhQab"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C0DF206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jzEMf/yUNgsKevSZXq90pzl0bHr1OEgYKO7X9L0ODVI=; b=sVOUbvLcKhT2bsADVvZZe+Sjq
	rgDY2a2bTS7ZRkO3U4hWj97mSO5G3RLSvZnVNNqG/Kx2ICU+pZ0DRvFby+/ADTbgkg+EyWUMpEFuF
	cPKKywCyrwuhowCw8wYn8blpvwRfynbS0Hn0LUElDpke0gNd+q96+LBzU8zDMqmriiV972HrKAM/1
	DKkcYF4bgXipkE/4Bpq77V3h/a0x1oEf+rIznVSVA4+/z6ZO/Ha1G7XVP1crdt5Q6eRGbp5ZMco/g
	+mcBzC8LDTME7CO2+Z16BMgFqnbTLFC1hhaYLg1d9TSbP7bIYO1akpMtk/WXtEol9ddG1K07ZuXWB
	6Lo34bQIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki5tb-0007PJ-ML; Thu, 26 Nov 2020 01:16:27 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki5tX-0007O7-KC
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 01:16:25 +0000
Received: by mail-pg1-x542.google.com with SMTP id t21so300725pgl.3
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 17:16:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ffbgfORDd1J1xm3xxXp8xWzEs5sXbivtuhWMZ6CRpX8=;
 b=QvBDhQabcPJJmll9n1XSftf1/oCdc4AbjJKr3e1lsYr3oC6BYqnsjBtTeyYy83i7U3
 CiBd9FBSulwPjxAjN7h2emgRFMFS1h+Lw6DqhxGTuZzg7+z7LjtCeMG+R8Iu7GvPbymk
 ToF3QU0Kl5XY8lJh/Qkx9aL7d+kCec25ZtdGP0mSVt69+sY7dMUe9kHgs59VUC7F5d4d
 nBojS3btHNUmyJAhv9TgzqtLgQeQkeeQKwwl8KyW2EiBpga6aEsYA+VodfFczjdFHus+
 VDSakrHxOOPEEYbfR18sM6jijaOJSIrXZ6isVycVVCHpctMR7iHPW0kXlgmPrbk46btj
 mYxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=ffbgfORDd1J1xm3xxXp8xWzEs5sXbivtuhWMZ6CRpX8=;
 b=CqkrA6Mp7m5SAqVownTwv7fSDvAc72QDtxFC0IoLJ9cN5umK982k5sKqY2vypf7fR6
 Z4feSz6jS00jn9znlFYRV7edeOI6YOvj4Zf0AUIS97k0TMNbb7UwDavMVBly8+Ywr8Gy
 Jg7mma9k8vaB159zqkJlkEL7OduOL79hdj9JnLoziWuKab1nBa4Jx3HQrOKiPMhot41Y
 qqTaqLwMe2OQ8m7s7aSDHCijlq68Z8+PYENw0GDrLFRCaa69fEeMeqVodoq7X//mFMnc
 rWPtFTas3yFsE6t28h08MIZd9Swi3zY+F5dWjZFS/k9lrpNuy7WQGlJ/2uhBjm0WYTg+
 4QdA==
X-Gm-Message-State: AOAM530jZylO15RihrNaDfgtLfx2iP3rFpw3zfb3SFQEAQJhRxB6HBfV
 VrVOxbc2z/L44pLGO6XT0Kg=
X-Google-Smtp-Source: ABdhPJxuwzDVcKoe4o/wMgwyIQrHY+YPGkp4YxJA+sp/vPwpgqgEvxXOvnlOmZ0BtRJFwRde4WH8Zg==
X-Received: by 2002:a62:8cc6:0:b029:19a:87b1:99bb with SMTP id
 m189-20020a628cc60000b029019a87b199bbmr637857pfd.6.1606353381534; 
 Wed, 25 Nov 2020 17:16:21 -0800 (PST)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net.
 [67.188.94.199])
 by smtp.gmail.com with ESMTPSA id e128sm2978987pfe.154.2020.11.25.17.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 17:16:20 -0800 (PST)
Date: Wed, 25 Nov 2020 17:16:16 -0800
From: Minchan Kim <minchan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 61/78] zram:  do not call set_blocksize
Message-ID: <20201126011616.GB57352@google.com>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-62-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201116145809.410558-62-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_201623_744275_4E418B99 
X-CRM114-Status: GOOD (  21.69  )
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
Cc: Justin Sanders <justin@coraid.com>, sergey.senozhatsky.work@gmail.com,
 Mike Snitzer <snitzer@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, linux-nvme@lists.infradead.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com, drbd-dev@lists.linbit.com,
 linux-scsi@vger.kernel.org, xen-devel@lists.xenproject.org,
 Ilya Dryomov <idryomov@gmail.com>, Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 16, 2020 at 03:57:52PM +0100, Christoph Hellwig wrote:
> set_blocksize is used by file systems to use their preferred buffer cache
> block size.  Block drivers should not set it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.

> ---
>  drivers/block/zram/zram_drv.c | 11 +----------
>  drivers/block/zram/zram_drv.h |  1 -
>  2 files changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 3641434a9b154d..d00b5761ec0b21 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -403,13 +403,10 @@ static void reset_bdev(struct zram *zram)
>  		return;
>  
>  	bdev = zram->bdev;
> -	if (zram->old_block_size)
> -		set_blocksize(bdev, zram->old_block_size);
>  	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
>  	/* hope filp_close flush all of IO */
>  	filp_close(zram->backing_dev, NULL);
>  	zram->backing_dev = NULL;
> -	zram->old_block_size = 0;
>  	zram->bdev = NULL;
>  	zram->disk->fops = &zram_devops;
>  	kvfree(zram->bitmap);
> @@ -454,7 +451,7 @@ static ssize_t backing_dev_store(struct device *dev,
>  	struct file *backing_dev = NULL;
>  	struct inode *inode;
>  	struct address_space *mapping;
> -	unsigned int bitmap_sz, old_block_size = 0;
> +	unsigned int bitmap_sz;
>  	unsigned long nr_pages, *bitmap = NULL;
>  	struct block_device *bdev = NULL;
>  	int err;
> @@ -509,14 +506,8 @@ static ssize_t backing_dev_store(struct device *dev,
>  		goto out;
>  	}
>  
> -	old_block_size = block_size(bdev);
> -	err = set_blocksize(bdev, PAGE_SIZE);
> -	if (err)
> -		goto out;
> -
>  	reset_bdev(zram);
>  
> -	zram->old_block_size = old_block_size;
>  	zram->bdev = bdev;
>  	zram->backing_dev = backing_dev;
>  	zram->bitmap = bitmap;
> diff --git a/drivers/block/zram/zram_drv.h b/drivers/block/zram/zram_drv.h
> index f2fd46daa76045..712354a4207c77 100644
> --- a/drivers/block/zram/zram_drv.h
> +++ b/drivers/block/zram/zram_drv.h
> @@ -118,7 +118,6 @@ struct zram {
>  	bool wb_limit_enable;
>  	u64 bd_wb_limit;
>  	struct block_device *bdev;
> -	unsigned int old_block_size;
>  	unsigned long *bitmap;
>  	unsigned long nr_pages;
>  #endif
> -- 
> 2.29.2
> 

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
