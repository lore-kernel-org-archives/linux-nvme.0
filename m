Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57642C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0zhYL+gKSF8OuCcdno95lAOWNl+3qrV99a4xMzj8N3E=; b=j246zjlLjGnoa91uM0cbbwgXVJ
	FyIJuxJWK3F+eul1XCpBwaO6krpHHbRoq7qXi1tPjMwvx5VuA3UCJ1MOQNI0/xCO0npdu/Rtm8ZWL
	x+9xlITlKH4WT8xHsNyr17Ksn+CufsdTH+XRyMNGmWl7FP+k+3XoOr3pWDxlef2DDHMNNA6AXURxF
	NWDoI9MlBX5BX6nNuMoeqBEMYHsP5caWllE5YBvcoUy4jbvAC5+QXVR6NwLDcJHV2J42oF8f2MoXj
	vhegDRQt292ZWW1k+uBCEnVGtshtlrcc2PV9Z/sBhoNKZ20d15M8UIAHBvH3ThE/qdU2Bqc2jgmYk
	UGgDsa8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YM7-00E3Dh-Ox; Tue, 05 Jul 2022 02:32:03 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YM5-00E3Bb-CX
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:32:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988319; x=1688524319;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ro+fI82nD1IGiNFuAK6LUHDwCz2uvuI1Aih9ZqsmmTw=;
  b=OsqE3LH4TcM6sri7vz223seHMcjy4rxmWHX7wuPUmYsT10p9nqcfR2X3
   M1kMaKPLyBJLIGjaHFy4Q5SJYXytnN4bYgHZW4xKn46iXw6tOGbjg3TaC
   QOodZ7cbxpY9Lt1hI1jVLJJNh3/u8XmNKp8IM9RD+WAleYc18WP8r2ztM
   VTHZkaNFMGk/hKBvr3004b6P0APA9GeTLw/KClu4jd+K/YwSdiOrx/4sB
   8b0mU5ASBfwynuwWvHIAO+V1rGIs4CTy2KJmEojUej56FIPKUZMp/SonU
   tK8fY2gjnQ2A7DXn//tsl7YC5Rx+8r0ZzE7slym/4C+4JNI0yUMSmYGU9
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="204806529"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:31:59 +0800
IronPort-SDR: W39tdaWpxCucbynMrkDALOMDQqAX9zoaVHK5DNMI5VvCrxXd81qgCdF+va1kb2WLq385iNoROU
 e5xt0Maezg580tjpZN07Agj6gu59/PhovtYX7oB+oqTNust4oX7EaGsofKFYKk9Meqf+p18Q0e
 BuqdhnKboLZnbzaTT1y5658MLgN4zfiG4acaPKKisggX2fU7FmMMEsa0hPY07r369jktYYZdRj
 KC7kchlvOxTsOlszgWH5zKqWw3msiFBAU0F7kos8rUPouwB2TejdwTlM2xoWkj12aKT07bXi5W
 0Zh8PIX2d4ZfYDS5DGtiu5Vl
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:53:52 -0700
IronPort-SDR: l+FdwrKrnJ3WPrDb4qnIARG03urSGw3dSWTqO1lomcKs3GqnVnFlm5h1y6zofl8kIrcpk6Ipli
 cpbKxyLmgyizUYO8V8mHgXuWxFtmXisXz3eXGYB314itBaSvdqdylmoll7lA3EsupqMTcFX0+U
 VFTD/WnYO+W1PGhYyyiIc1Qy1ZxMYsKQpz2hURNRvYX+Sve6IwMlZZJxz+DYLYRWY0k0LqvXTY
 GLpCrqefqgrtNh2sabbkmm+1CTYVsJWLDt+iA8CUc7fiQ1JjCtIFc1yZOvyKJ9/VvEiCdqoz71
 jCg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:32:01 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRX04zJ2z1Rwnl
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:32:00 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656988320; x=1659580321; bh=Ro+fI82nD1IGiNFuAK6LUHDwCz2uvuI1Aih
	9ZqsmmTw=; b=E5si8k2AyrL9p+0u2wPVEH9uM3pJyLDKNMYvqS466EiGZ7b8VQB
	Gb7Iy6h91Um4fbaue0VXVzRShIykbnYeMZvnb0bxB8zYCtpzUrAjwtYgn7KT4mmq
	w2zTI8JvTz+HT4F0gPIrfPyrHTbIGKHiVf5t31RyJvGffCAOhmbdeeyf1o0kTdLj
	lJ4Fh/bBLjt4LSpdng5pQRsC8rebZ3TnSbPRmIizfLfBp3vLt503L0IQAg7BryG3
	tCYgfcbvIbno2pSFTz0V4SYjsIt5ctML2m4WttC3NQ5aT85/DsjznkS0LsLpru2v
	7MWgNzCTA7jMlsE8ue0OR8OyDB8cIgKXfqw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ITAQbetoHVIY for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:32:00 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRWz1GBQz1RtVk;
	Mon,  4 Jul 2022 19:31:58 -0700 (PDT)
Message-ID: <9e815a0b-0d60-730a-51f8-6ba749b5c60e@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:31:57 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/17] block: export blkdev_zone_mgmt_all
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-6-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_193201_518809_4578D0DB 
X-CRM114-Status: GOOD (  21.60  )
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
> Export blkdev_zone_mgmt_all so that the nvme target can use it instead
> of duplicating the functionality.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-zoned.c      | 10 +++++-----
>  include/linux/blkdev.h |  2 ++
>  2 files changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 90a5c9cc80ab3..7fbe395fa51fc 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -185,8 +185,8 @@ static int blk_zone_need_reset_cb(struct blk_zone *zone, unsigned int idx,
>  	}
>  }
>  
> -static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
> -					  gfp_t gfp_mask)
> +int blkdev_zone_mgmt_all(struct block_device *bdev, unsigned int op,
> +			 gfp_t gfp_mask)
>  {
>  	struct request_queue *q = bdev_get_queue(bdev);
>  	sector_t capacity = get_capacity(bdev->bd_disk);
> @@ -213,8 +213,7 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
>  			continue;
>  		}
>  
> -		bio = blk_next_bio(bio, bdev, 0, REQ_OP_ZONE_RESET | REQ_SYNC,
> -				   gfp_mask);
> +		bio = blk_next_bio(bio, bdev, 0, op | REQ_SYNC, gfp_mask);
>  		bio->bi_iter.bi_sector = sector;
>  		sector += zone_sectors;
>  
> @@ -231,6 +230,7 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
>  	kfree(need_reset);
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(blkdev_zone_mgmt_all);
>  
>  static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_mask)
>  {
> @@ -295,7 +295,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  	 */
>  	if (op == REQ_OP_ZONE_RESET && sector == 0 && nr_sectors == capacity) {
>  		if (!blk_queue_zone_resetall(q))
> -			return blkdev_zone_reset_all_emulated(bdev, gfp_mask);
> +			return blkdev_zone_mgmt_all(bdev, op, gfp_mask);
>  		return blkdev_zone_reset_all(bdev, gfp_mask);
>  	}
>  
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 270cd0c552924..b9baee910b825 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -302,6 +302,8 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
>  extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>  			    sector_t sectors, sector_t nr_sectors,
>  			    gfp_t gfp_mask);
> +int blkdev_zone_mgmt_all(struct block_device *bdev, unsigned int op,
> +			 gfp_t gfp_mask);
>  int blk_revalidate_disk_zones(struct gendisk *disk,
>  			      void (*update_driver_data)(struct gendisk *disk));
>  


-- 
Damien Le Moal
Western Digital Research

