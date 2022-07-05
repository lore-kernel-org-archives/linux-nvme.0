Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1013BC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=InVgZvT2fNfa3C6hxqq56NMk3nOBMyq82/UOfCDVYZQ=; b=JLkzYGg6da7p4lRfa8GxN3d0ab
	n6D2SuzY+xo3nZt4WBouPSqw52V+rgpE6Z2f3NhjEy/0w1VPZZwhjef7kETqJRhF67Xkse5867tgT
	L9yVkAKyWcball66hfJzDtFtX4CCtdXkzzVZKVEl5UWTV4aWiDFNtnA705Eq2b+sSzq273cfV7SR8
	Nks7a/lUy1cUWxWHNNeRhpeHHUVQnqz95ez7UtEcMcuqZts85JQTMMs60Wyo611H29ObOSjt4K2dd
	Rnu67TdkbVsDHxQUV6S/rfFtmpiy2wMXwF4GpXnqv8VdCCIZ5grnqqOYt+LGvJz5yQw87j2dBfrnl
	nRuwvqyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YiO-00EA1S-1C; Tue, 05 Jul 2022 02:55:04 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YiK-00EA0E-JO
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:55:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656989698; x=1688525698;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1y6wAypb2e7pXog7C7mFRuD3grgqGrQRog8SU6seADI=;
  b=JzA0HL9gn6hyGGsvX/rfrHMSW9x8wagA6CubDqv59HNsxtOXElq/z5Hd
   bpu/Sh2N2cbElCxtnPLGuxmVrkcU+a2FSmWtk5uvoyHbZhm56QsBveC/V
   Xw/g9BZ5uFLft5eVcf66G1SPJ+/PhllVcuc988lGUIEicurQ6bd6oAIPk
   ANRyxEMAZ0E88qAD4DEQlpIYRWEpa5Ee4O1N9oH4VWiYZmJNa2EtDOxac
   GjDD6G4iKR+QIaw0oTkFl5u0UujR+Nb9bk+trEjrYCDKyTae/5tVAjjmF
   KvXSXIzKlGLDcj5qDlwClqKp7mrnnmDyin4TUDlOvpUDM/n0ss/H8tsvA
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="204808278"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:54:58 +0800
IronPort-SDR: QeGWG0U6ZrgWRp9ovpRWNok8zJsWxYY32VDm8TOvYGtf7e6o4VObhopCCp5s+kmQ1WpqkPfJRg
 n/DvwpcugV7ZpMEj0cbRmvZEMHFZA31haaCEF//WLiIopvjR5stAB0C6cR2R6rwmAG5r3vnKuH
 AbkQKIe5Tz5VMzUHdke+3efI6rRCo8/Fq36Qe5DLMLVNg5RBFF0M5w+64SfvBqJV4caVKnGs4+
 joJ3MWIFiBs87wKk6R2J2aVXGuiOp3wyNdupZ9y/Z0GJTRyUsi7T5+ApdxlXst2apZdowzxoL/
 X+7kmel9cG/oAsNbbLxVv+Ik
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:12:19 -0700
IronPort-SDR: PLAD4/6TJmNY19ExHgthOP3DqIyy/69XVljZ6DQk373/o2c3Rb//SZ2AAv/qtlxAlTDW1qpOiU
 CsaNoIm2LfK5nXZzY8VLAIV5gQs4Nz3ZbIDFv3U9RzhjwuLZ2KDZe1haqGhsbVi53lJqOoINzU
 898uCrQpNkn0ZTUdhE2FYyiXZwgHrniqccQYwa3q2HqatRuom0vZ9Plhgj9n88Xc+slxeFWBP4
 ImZqIw/gvbid6/qG6y82AdukJOWfAC/PlszCvtkKGcjHQW+4iuiXkiALyQOm++5/T+jFV82f3v
 cF4=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:55:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcS2W6ZyTz1Rwnx
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:54:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656989699; x=1659581700; bh=1y6wAypb2e7pXog7C7mFRuD3grgqGrQRog8
	SU6seADI=; b=ajSE4pQESPSpjDj92KGRa6Ue0IELvkjnqKFeY7hE9S1kmQo1tW0
	LyBdWz0Kh9uY5d1m/VdR5V4c2ZHSZRz54+LP8bbt4v51rYCV2xMboLtELOMO1FZW
	CFmOrLE/GSeukmUDozhBMlM5lpTcXWy0nFgn+asMpFwupUTet5EvQk4L0XZlxBQ5
	5rhGgHRdDhYE/1zCdfin8lQGBxr2BdOezRRYrDFAmta/inoTT5/cHdu3yOf8+G3G
	Tz4VEGLAP9YUs8Dza8UjPuHpHY0t3rBHpXAUXiDEhF2pgDf088hoiO/4iAZbkPWx
	tYtGJlBkF44FcfsY1xFjy8ynO+hT6RL24yA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nM3sKMAutGef for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:54:59 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcS2V2zgZz1RtVk;
	Mon,  4 Jul 2022 19:54:58 -0700 (PDT)
Message-ID: <535739b6-ee61-eccb-1dfc-3c57eab21cea@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:54:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 15/17] dm-zoned: cleanup dmz_fixup_devices
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-16-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-16-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_195500_731532_1921FAEB 
X-CRM114-Status: GOOD (  22.95  )
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

On 7/4/22 21:44, Christoph Hellwig wrote:
> Use the bdev based helpers where applicable and move the zoned_dev
> into the scope where it is actually used.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-zoned-target.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index 6ba6ef44b00e2..95b132b52f332 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -764,8 +764,7 @@ static void dmz_put_zoned_device(struct dm_target *ti)
>  static int dmz_fixup_devices(struct dm_target *ti)
>  {
>  	struct dmz_target *dmz = ti->private;
> -	struct dmz_dev *reg_dev, *zoned_dev;
> -	struct request_queue *q;
> +	struct dmz_dev *reg_dev = NULL;
>  	sector_t zone_nr_sectors = 0;
>  	int i;
>  
> @@ -780,31 +779,32 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  			return -EINVAL;
>  		}
>  		for (i = 1; i < dmz->nr_ddevs; i++) {
> -			zoned_dev = &dmz->dev[i];
> +			struct dmz_dev *zoned_dev = &dmz->dev[i];
> +			struct block_device *bdev = zoned_dev->bdev;
> +
>  			if (zoned_dev->flags & DMZ_BDEV_REGULAR) {
>  				ti->error = "Secondary disk is not a zoned device";
>  				return -EINVAL;
>  			}
> -			q = bdev_get_queue(zoned_dev->bdev);
>  			if (zone_nr_sectors &&
> -			    zone_nr_sectors != blk_queue_zone_sectors(q)) {
> +			    zone_nr_sectors != bdev_zone_sectors(bdev)) {
>  				ti->error = "Zone nr sectors mismatch";
>  				return -EINVAL;
>  			}
> -			zone_nr_sectors = blk_queue_zone_sectors(q);
> +			zone_nr_sectors = bdev_zone_sectors(bdev);
>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
> -			zoned_dev->nr_zones = bdev_nr_zones(zoned_dev->bdev);
> +			zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  		}
>  	} else {
> -		reg_dev = NULL;
> -		zoned_dev = &dmz->dev[0];
> +		struct dmz_dev *zoned_dev = &dmz->dev[0];
> +		struct block_device *bdev = zoned_dev->bdev;
> +
>  		if (zoned_dev->flags & DMZ_BDEV_REGULAR) {
>  			ti->error = "Disk is not a zoned device";
>  			return -EINVAL;
>  		}
> -		q = bdev_get_queue(zoned_dev->bdev);
> -		zoned_dev->zone_nr_sectors = blk_queue_zone_sectors(q);
> -		zoned_dev->nr_zones = bdev_nr_zones(zoned_dev->bdev);
> +		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
> +		zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  	}
>  
>  	if (reg_dev) {


-- 
Damien Le Moal
Western Digital Research

