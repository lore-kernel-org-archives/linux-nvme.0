Return-Path: <SRS0=VgBB=FA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C5BC56202
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:11:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B49702075A
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Nov 2020 01:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EcUF6syS";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CJdcPtV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B49702075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=867JbX0tvBt05EKXAZUTOHR8bnMYI8c0E/+uY24bhzc=; b=EcUF6sySWK7NsY8+zVqxzVzP6
	UJfEB3+HY4OHkjn7hzAJPNPtnCHOMqW/9cOVFBZQ20m/c+G6JijBhcThe5ijIo4tCA03HwNgbT6GT
	aV21epHtlVSLPlfQ34FNpzgu8+HzzwO9xbsgjKQtGZ/AxxMhHpc9uNM276ztMzxZHMO1BWXoFjnpF
	dWsv+5BRQNGnO31Vs0d7tdvHkZDk4rVQzJHI/Yx9TIEvdyoiSthMMwtjMUU3vqrpHoQhIkFGhcRBR
	mbmxhN61DzdkDzm/VtvB/d3fiHstuDl9MsOOZNKGm9K2MxK+0GM9+4byEkaYtJlEXtVTwY0nrD/oB
	Szmo2dkJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ki5oa-00078u-9A; Thu, 26 Nov 2020 01:11:16 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ki5oX-00078D-QV
 for linux-nvme@lists.infradead.org; Thu, 26 Nov 2020 01:11:15 +0000
Received: by mail-pf1-x441.google.com with SMTP id w187so117356pfd.5
 for <linux-nvme@lists.infradead.org>; Wed, 25 Nov 2020 17:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=f8bMvE80grJsQDxQbN+SXa4Ok4avPUhhCBLg+N5g7uE=;
 b=CJdcPtV0FUzyxFptDYgR6iAeEpy/fm/U+qwm7MjSAUITShNs3IGjSdma/ci1d+UdB1
 /4QBGWKw7GesxoQFO7vGWULXUqZeTgSL72KBwgOOTOpdW6FEjFkGl8KvyOmWfu5zn3C8
 2D8lQB9/sXcZGuetWYq/y9fJ/4tVoCfZkFM+w/twGxXZf6jIBGOeoFgX3V3eoJ4SxFtL
 DMlA1WjSzrfwym46BYlZOU4NNlAHgEZUyXcv6V6vuCHVbSrKNoE7MZTnCkoIzELetkkK
 3iGfzFOaAaJYntoqnGECTiJfY05IPhrPMzUEVWqaaAGWlk8VKPKZsqmpzgCIg3k/819j
 bQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to;
 bh=f8bMvE80grJsQDxQbN+SXa4Ok4avPUhhCBLg+N5g7uE=;
 b=RnE/soFfXxNWxQPihHTulm85L5nzJfYgY94tgux4R8Ah/LBaQpjpkPqVq2kEPLeyVj
 tq0aMajYVzbHOQTYQgrfYmhBtoAgt21HFYPsONcv9C7Gt3TE7+XsiQaYl+9LMrsv1Ew1
 P3+TdlHksvrAAMzZJyjgm4O6CRZpO20NbnEhWamdt7axJpJFfxXri5AUcuWveHebgY7v
 b/FtCNMZAeLZFXPdc0gIXVtbtCaxhclFrw2fHOHKa+WQAwdQ4aseMpUZmLDljcB5n34R
 k2TqnjyODsonprjBBs+iZd5Otve8vYT0pKfpv/2hSK2nFoTQrXNnIEi8/IZblL1aL42p
 D9NQ==
X-Gm-Message-State: AOAM531pNiks80Rp0+IvgpdD5VJ61hQNG95JgH4a23pZ11B6jS7RAL8M
 kWHFXwHwvRXRSccKmzK66iY=
X-Google-Smtp-Source: ABdhPJy2rvS54nam6WzB3Gos6rktAfztTZ/apost62cNhHmAqWfXtcE8/JRGjAG0GRNN0NDnAydY0Q==
X-Received: by 2002:a17:90a:8909:: with SMTP id
 u9mr643556pjn.100.1606353071628; 
 Wed, 25 Nov 2020 17:11:11 -0800 (PST)
Received: from google.com (c-67-188-94-199.hsd1.ca.comcast.net.
 [67.188.94.199])
 by smtp.gmail.com with ESMTPSA id s10sm3915048pjn.35.2020.11.25.17.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2020 17:11:10 -0800 (PST)
Date: Wed, 25 Nov 2020 17:11:07 -0800
From: Minchan Kim <minchan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 60/78] zram: remove the claim mechanism
Message-ID: <20201126011107.GA57352@google.com>
References: <20201116145809.410558-1-hch@lst.de>
 <20201116145809.410558-61-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201116145809.410558-61-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201125_201113_901030_000AE150 
X-CRM114-Status: GOOD (  27.91  )
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
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
 Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
 linux-fsdevel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 16, 2020 at 03:57:51PM +0100, Christoph Hellwig wrote:
> The zram claim mechanism was added to ensure no new opens come in
> during teardown.  But the proper way to archive that is to call
> del_gendisk first, which takes care of all that.  Once del_gendisk
> is called in the right place, the reset side can also be simplified
> as no I/O can be outstanding on a block device that is not open.

It would be great if it makes the mess simple. Let me have a question
Please see below.

> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/zram/zram_drv.c | 76 ++++++++++-------------------------
>  1 file changed, 21 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> index 6d15d51cee2b7e..3641434a9b154d 100644
> --- a/drivers/block/zram/zram_drv.c
> +++ b/drivers/block/zram/zram_drv.c
> @@ -1756,64 +1756,33 @@ static ssize_t disksize_store(struct device *dev,
>  static ssize_t reset_store(struct device *dev,
>  		struct device_attribute *attr, const char *buf, size_t len)
>  {
> -	int ret;
> -	unsigned short do_reset;
> -	struct zram *zram;
> +	struct zram *zram = dev_to_zram(dev);
>  	struct block_device *bdev;
> +	unsigned short do_reset;
> +	int ret = 0;
>  
>  	ret = kstrtou16(buf, 10, &do_reset);
>  	if (ret)
>  		return ret;
> -
>  	if (!do_reset)
>  		return -EINVAL;
>  
> -	zram = dev_to_zram(dev);
>  	bdev = bdget_disk(zram->disk, 0);
>  	if (!bdev)
>  		return -ENOMEM;
>  
>  	mutex_lock(&bdev->bd_mutex);
> -	/* Do not reset an active device or claimed device */
> -	if (bdev->bd_openers || zram->claim) {
> -		mutex_unlock(&bdev->bd_mutex);
> -		bdput(bdev);
> -		return -EBUSY;
> -	}
> -
> -	/* From now on, anyone can't open /dev/zram[0-9] */
> -	zram->claim = true;
> +	if (bdev->bd_openers)
> +		ret = -EBUSY;
> +	else
> +		zram_reset_device(zram);
>  	mutex_unlock(&bdev->bd_mutex);
> -
> -	/* Make sure all the pending I/O are finished */
> -	fsync_bdev(bdev);
> -	zram_reset_device(zram);
>  	bdput(bdev);
>  
> -	mutex_lock(&bdev->bd_mutex);
> -	zram->claim = false;
> -	mutex_unlock(&bdev->bd_mutex);
> -
> -	return len;
> -}
> -
> -static int zram_open(struct block_device *bdev, fmode_t mode)
> -{
> -	int ret = 0;
> -	struct zram *zram;
> -
> -	WARN_ON(!mutex_is_locked(&bdev->bd_mutex));
> -
> -	zram = bdev->bd_disk->private_data;
> -	/* zram was claimed to reset so open request fails */
> -	if (zram->claim)
> -		ret = -EBUSY;
> -
> -	return ret;
> +	return ret ? ret : len;
>  }
>  
>  static const struct block_device_operations zram_devops = {
> -	.open = zram_open,
>  	.submit_bio = zram_submit_bio,
>  	.swap_slot_free_notify = zram_slot_free_notify,
>  	.rw_page = zram_rw_page,
> @@ -1821,7 +1790,6 @@ static const struct block_device_operations zram_devops = {
>  };
>  
>  static const struct block_device_operations zram_wb_devops = {
> -	.open = zram_open,
>  	.submit_bio = zram_submit_bio,
>  	.swap_slot_free_notify = zram_slot_free_notify,
>  	.owner = THIS_MODULE
> @@ -1972,34 +1940,32 @@ static int zram_add(void)
>  	return ret;
>  }
>  
> -static int zram_remove(struct zram *zram)
> +static bool zram_busy(struct zram *zram)
>  {
>  	struct block_device *bdev;
> +	bool busy = false;
>  
>  	bdev = bdget_disk(zram->disk, 0);
> -	if (!bdev)
> -		return -ENOMEM;
> -
> -	mutex_lock(&bdev->bd_mutex);
> -	if (bdev->bd_openers || zram->claim) {
> -		mutex_unlock(&bdev->bd_mutex);
> +	if (bdev) {
> +		if (bdev->bd_openers)
> +			busy = true;
>  		bdput(bdev);
> -		return -EBUSY;
>  	}
>  
> -	zram->claim = true;
> -	mutex_unlock(&bdev->bd_mutex);
> +	return busy;
> +}
>  
> -	zram_debugfs_unregister(zram);
> +static int zram_remove(struct zram *zram)
> +{
> +	if (zram_busy(zram))
> +		return -EBUSY;
>  
> -	/* Make sure all the pending I/O are finished */
> -	fsync_bdev(bdev);
> +	del_gendisk(zram->disk);
> +	zram_debugfs_unregister(zram);
>  	zram_reset_device(zram);
> -	bdput(bdev);
>  
>  	pr_info("Removed device: %s\n", zram->disk->disk_name);
>  
> -	del_gendisk(zram->disk);
>  	blk_cleanup_queue(zram->disk->queue);
>  	put_disk(zram->disk);
>  	kfree(zram);
> -- 
> 2.29.2
> 

With this patch, how deal with the race?

CPU 1                                     CPU 2

hot_remove_store
  zram_remove
    zram_busy
      return -EBUSY
                                         open /dev/zram0
    del_gendisk
    zram_reset and destroy


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
