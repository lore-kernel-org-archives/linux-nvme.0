Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24DAC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 08:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y21LBJdGe48zPICwqLuuPos8BNzKynUqkchxm/61eHk=; b=tOMTg7hgS6O1SNI3Ag5vGMS4DA
	eFM8iiYlpYjnQsxFg93R3v4xXJK95YF861ELqJdVgbaznlAg3aLl8hYrQZIsmDp4p1FpsY1mEWx3I
	j6Pro7VD+f6QENOkiDgqCE6ZmBSDiHJMhbqxWJVEvg5oYyPMxFVsYH7HkYqSiNAq3+RoHqRnoAxz3
	XzdSL3tmuDwPvpYQRo02osKUzHGTcT6DyKgJ6Nb7IXZjDzWAy4A9zMfnBhKUKWEcyVgCA3hrtfjQA
	Xkd/p0Oe/gwF/LL+nD7XUsLJoyBTSGmnmz7qVzl/8HX4osw+dW+m4tD5yp9vKEZOuhBFgQD2mJbRx
	ZpvkbQ4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngMMR-00FvUw-Vf; Mon, 18 Apr 2022 08:03:52 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngMMO-00FvRn-Tb
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 08:03:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1650269028; x=1681805028;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=rst7WZOXaJnTOprfWYkoaRENgax/3SjcG41/Nf0ZaiQ=;
 b=EmdD7FamYGmavx1pUGfT1fI8RCXuQt/sLKvEI6XvEoYEa8tCQJHYWMyo
 Da7WKAwPjA16523o9E8lfx4JbLWg8frrVTynHnbW9K4X48xKLE17yOQLs
 mkwASqVuZyKzzQoisr5JTJIuVDHTf26WfCZIso66cwu/xCcidWuGkO/W5
 R2/CQ+sSFuMH4Emih9V5GXcnM+a6LIp0jX3c0cIm/hzBYecHWGkNHDbnr
 SNsZV1bfPDTMSWIFjZamgunEf/JRpA0fPKVSddWPtklGmwtuFtP0tGN0C
 JK6ot2tLzuYFojWRJpFcL7kjrrKZTllBi1m/OJDf+a8cDnRllznYi9wjH g==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; d="scan'208";a="302341804"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:03:44 +0800
IronPort-SDR: 1OGZwvMtVLL3BFKVI3LrGRSUQZa+hdozH9/7EHofROJMYurscyWZm+3oTovG37c5GXpFg6aUfg
 8JqXzN6Al9A4bNJc1Ot+J8hrc+n5exup6/eAwm3hiJiGn7UZtJC1afiRMZwF3t3OJJfQ7o3Xrv
 uq2/ZPGCN/vYVm187+rH91ezw1KBBAmSyzbXYfmBvRR5iXRzSDwXmNaMJfcnilk32QhbLZ3FNb
 9DilGEFJ0uLdExnkVqtsnCD6oNIOBeSibsHRnSQpZtq5gZDYBYf0guYzHnbpWyo0fMTssya5hr
 UvH6gA8MGcoDvGLOMfxkALnO
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 00:34:50 -0700
IronPort-SDR: 5mPXLo9W9F9zhhRoqqy2T5gEPsmRnJ6YResLCkntzfCHctqShy+XLQ0p0ChzbqkjO1M1IuT/x+
 fwTxJ65Y/AX6LJF698/YiRylQl05v9fjc6swQygyoVprXSu3X8fm+KlO5HvPw+kzaK6Cz0+1pK
 3LeMBBEJrBF58jUoD5FKelHBWL1WcsCwaxVIOFy9LIVU9e5rU7cLccbdT8g1rvwUGJuPNvh0GR
 /7xRQDEmExhAtyFnglP5eY+5nfZbd5HrBJtF+MCkDb/oUpN1jpkAjMDyfCoE20MOKSqJ/lDY/I
 HYA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 01:03:45 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfZl58Fbz1SVpC
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 01:03:43 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1650269022; x=1652861023; bh=rst7WZOXaJnTOprfWYkoaRENgax/3SjcG41
 /Nf0ZaiQ=; b=k/wWzmmm2mZiM/ewBYvITJF4lq6rUDh2cOF7medHWCRms6ali4K
 cmsUMPnv+11ke+dcJMqdHi78/nHqy7qP8KSBVECU/14iKM2QiwMZ5RSyv3w8qT7S
 xlveFRxheMNhYX6ukLpVSJjx7rJm1hUviNx0vdLPyHXo9hRa3+JS30WcAvz31Pdj
 REkM1jfEzC/yE6LWYc1GnErshn9kE3jwbU3zXmWIjE2FGZwQcw8k8zOw/wl74Ik/
 4p11eeyi0wRjJXJE9DwwkghyuPjiZnJUMe5TVmPA4z2xIF/G5tJciClJzAeXlh6d
 O8hZxw8UZiDqrwR15XLejWpz4dbpVOf4kAw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id ggmy79rBctNu for <linux-nvme@lists.infradead.org>;
 Mon, 18 Apr 2022 01:03:42 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfZg2dWsz1Rvlx;
 Mon, 18 Apr 2022 01:03:39 -0700 (PDT)
Message-ID: <034efb57-9e1d-41ed-1855-e2b057b03ea7@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:03:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 11/11] xen-blkback: use bdev_discard_alignment
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 linux-s390@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 xen-devel@lists.xenproject.org, linux-um@lists.infradead.org,
 Mike Snitzer <snitzer@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 Stefan Haberland <sth@linux.ibm.com>, linux-raid@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-12-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-12-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_010349_041010_13B7932C 
X-CRM114-Status: GOOD (  21.05  )
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

On 4/18/22 13:53, Christoph Hellwig wrote:
> Use bdev_discard_alignment to calculate the correct discard alignment
> offset even for partitions instead of just looking at the queue limit.
> 
> Also switch to use bdev_discard_granularity to get rid of the last direct
> queue reference in xen_blkbk_discard.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/xen-blkback/xenbus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
> index b21bffc9c50bc..04c90cb8955f6 100644
> --- a/drivers/block/xen-blkback/xenbus.c
> +++ b/drivers/block/xen-blkback/xenbus.c
> @@ -583,14 +583,14 @@ static void xen_blkbk_discard(struct xenbus_transaction xbt, struct backend_info
>  	if (bdev_max_discard_sectors(bdev)) {
>  		err = xenbus_printf(xbt, dev->nodename,
>  			"discard-granularity", "%u",
> -			q->limits.discard_granularity);
> +			bdev_discard_granularity(bdev));
>  		if (err) {
>  			dev_warn(&dev->dev, "writing discard-granularity (%d)", err);
>  			return;
>  		}
>  		err = xenbus_printf(xbt, dev->nodename,
>  			"discard-alignment", "%u",
> -			q->limits.discard_alignment);
> +			bdev_discard_alignment(bdev));
>  		if (err) {
>  			dev_warn(&dev->dev, "writing discard-alignment (%d)", err);
>  			return;

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

