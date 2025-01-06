Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A471E7719A
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vcZmHzYzzo81ujg9J2d5MfxCqnXE3MnZ/yOoZtU1fiI=; b=3AdJreiGLILTlydF4PUw9CYhVk
	MpzibmzIULE9Ll+JE4/0avGTRH5XN7M9ziTavYx3G2EdRS+2xvrfmyFsY9fE64b/l2rFcN4OjmFXq
	inQoXLGwoSg68P9up3+0znkLrxvmxAFJCUkNR9U9eRyYbz90zdafwrcaZ9NIUkMCOf4yUlYiXy6Fc
	cR6RJvIRB2iAF6+lSjxqKkPc6O48Ll3ROf+SYaM30/tfDA0W+aau9cKaVMC/fh+l6K2t7oBJr9oMC
	i6ClgaCc2CT425hY12y+P6di16YuenGIxnkyqdy/N4Yv8TA0CNV+I2qw/lPuS79uz4I9EU1aQyDe0
	vysPSZlg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUknb-00000000wQj-0cZF;
	Mon, 06 Jan 2025 10:57:31 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUknC-00000000wLl-0GHb
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 10:57:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 786D5A414C2;
	Mon,  6 Jan 2025 10:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0C0C4CED2;
	Mon,  6 Jan 2025 10:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736161025;
	bh=SkMUfmNVGEp3GjfSVk+aiLBPqi5Z67vJEkjjxoSltas=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cISyFrpkYGIZ0xA4St+nzsQX5WDm6sxgzc+wrYGzjNRhxzimHSKnXZq7QclrbhXwE
	 FMuSeYPq4VMNFQ7rTnYN6sVKskXxXNMPEnDz+MWEroT8P7g2ErJMDekoSvkpc3nFXZ
	 5PK4udGG6H0GLESXC7yq3otBOs9IpW6aeFQWgQAQMnCAXlDMMHHPCr4YEmtkfIa3ZQ
	 /JXAGWghe1vOf1WEhdk5RBuC3C3B5g9gRyotBgWfX7BgMVx0iOJ2LO3M/msXmkddpO
	 RFIJ2fj2GpwyrNB+AYk5NpAAB30BYxbFalF0knbSvf+R1QEifx+9XfEabAUwbtQQIY
	 9K9KfWRS8gdGQ==
Message-ID: <07353499-b62d-488a-9575-12de5d9b6f2e@kernel.org>
Date: Mon, 6 Jan 2025 19:56:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] virtio_blk: use queue_limits_commit_update_frozen
 in cache_type_store
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>, Nilay Shroff <nilay@linux.ibm.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 nbd@other.debian.org, virtualization@lists.linux.dev,
 linux-scsi@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
References: <20250106100645.850445-1-hch@lst.de>
 <20250106100645.850445-7-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250106100645.850445-7-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_025706_169042_5729D8CE 
X-CRM114-Status: GOOD (  14.85  )
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

On 1/6/25 7:06 PM, Christoph Hellwig wrote:
> So far cache_type_store didn't freeze the queue, fix that by using the
> queue_limits_commit_update_frozen helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This should be squashed in patch 2, no ?

> ---
>  drivers/block/virtio_blk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 0a987f195630..bbaa26b523b8 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1105,7 +1105,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
>  		lim.features |= BLK_FEAT_WRITE_CACHE;
>  	else
>  		lim.features &= ~BLK_FEAT_WRITE_CACHE;
> -	i = queue_limits_commit_update(disk->queue, &lim);
> +	i = queue_limits_commit_update_frozen(disk->queue, &lim);
>  	if (i)
>  		return i;
>  	return count;


-- 
Damien Le Moal
Western Digital Research

