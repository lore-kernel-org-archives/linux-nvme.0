Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FC3C19F2B
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 03:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q5RszaOSiDctFodhZucuZGEPruV4rmyFnKVuLfcWwQw=; b=YH6muE6fU7aNLbysYMgAvnE7e8
	B941dNz5I4gm1qvD2NGQQw/NH4Q40Fvli2OcXZenFVfI8uKZH2Htjf7wovxQexkqP61ZIwU72v/XX
	QYfu/YH3+Kv6gOnXwnPbR1cBqDwdkRa8ObAav5HbsKhg338f25mTSsSq5/daBKC370ENLLOl0RDgi
	ezYTdbt1lijkVfCtPH347BVQ/3F9Aa7VQcHxV0hA+CSxUSO4KGsfGXlyLMk1CC7bbCEXsWRvk+dzg
	Ts74F0+sDTCBpIZeegM1MsRL6e1aDKGAKZEHDPgEzTVYREBHqiiD8NFLiuGw9S0cE4SX+JLkZzsgM
	BfAXtdig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGtuD-003N06-5s; Thu, 28 Jul 2022 03:09:45 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGtuB-003Myl-69
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 03:09:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658977781; x=1690513781;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nqijlvS6KaE4GXf3iVMG7xf3y9RZd23p19tnc3ApLbI=;
  b=pqxlJjN5LDIGaEtXFJBIG/ytfGRjoQ9ixLSDxmh7gtfekf7/aolnXIHB
   VldLqiPrlryveIBK/8bXLeFDA7Hy5qjoVVrY1KQDfAJ1CKMKklDiprYqT
   462E5gQUN4xRzWtGhZybgrNHkvG9aWXEpzruPyQWpNEXA8C4ooP4cNI8u
   6+toTTrNjNhMug4Cpb9DEJqZYI6n+rfrM6bkkaVlGwXQ6xUCvuar5RhcB
   F2yjwDPzMqs24PIzlMgC0D1YwTBJO/PoeXAtWn1YJoe1Nou7fRh9X7VsQ
   RHdtCKaEnx9Us6PI90eiMnxaFrj3iZQbBzf1scxtZOsFOVIQolrX3L60D
   g==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="212066138"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:09:41 +0800
IronPort-SDR: zCQxFZxxb5/qjmct1Kd4PkVAwsV4CZQHb8Qj0g7nbv82NwRAs5i0XY/Lb2nnWJ76aJBzMEAUDI
 eLbU5i2l6g3UurVNxhauRxlXu30X22/oEvmVpMUz6tRG+4lEbbxdJt6gI+Q9IK8uOn8bPuvNOs
 89AqVKhItflQ+CR1dEPI+1xmy8vb6hNoX59PIK3C94pVYGD/AlGrONp7QGxG2jEyl0Um7t+MnP
 He/lLq5CRzt4rzg5f3vrF8049T/5oJsV7ZgTMU6EsbJs535zD4JtnRFPSQJi9Xt+uNUGg6HRYx
 YoVCCT3atxBEBR9eay+6+D/4
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:25:50 -0700
IronPort-SDR: 9DbQF0HoRxTKmvGyNYTLOPnsjGnPmbVZw/lgmHfCj9jns8txpLKKqHxMzsXr7htNujnrgkogFr
 UavHn5ZfJLL1ScLSpaf8mojj6mFroRCfLvGm+1xoCm7ZpIDI8NZC2PESOcCL/bPf1m+mqYWC/3
 X8AVsVB9d6Upun2uDAv/qQt2T0o/Pj0kzGETQkLFw/SC01/+PqbMwh+mM3r8dxnze3nhPP9f02
 H007yDFlnqCtcQqUJEOIMk1urQeyrtT/J+HtL5zGekoiIlOcQzHW+hsedTSjGn6gQgYxlM93H/
 f5E=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:09:43 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbGt0BHGz1Rwnl
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 20:09:42 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658977781; x=1661569782; bh=nqijlvS6KaE4GXf3iVMG7xf3y9RZd23p19t
	nc3ApLbI=; b=SXiHalPzMTGwNNgh4+Il5+zB50qTAPCKRhS58s9kciWi5AWNQlw
	31618sj464KJuwE1T/LekUc7kYc+3NWSPp0AlHq8FLzDVBecuDevIw3fJQXFMwSP
	irSCqGAOwUdiR05L73MENh40+BSY1Hg4W4I+jZBJYjZzHgCPjG61dhGGmhThrkpR
	3+dHmTGurwSxIuOYhIQ2NvDU9GeixxRxlYVADmhRro5HF+HE2Dja3O+U5WRYcj75
	6rvFyAAd9qgFC4ngQvrDasNt5JuUxaR6OS7hdB7jVsqoi2FtZlxMD9THl1Sqv6S8
	Q21s1bjvMJ1OqO94CofTuDT+xxa+MPmuRFA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 47MUL4nhXXyY for <linux-nvme@lists.infradead.org>;
	Wed, 27 Jul 2022 20:09:41 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbGp0d8bz1RtVk;
	Wed, 27 Jul 2022 20:09:37 -0700 (PDT)
Message-ID: <137b8772-a2cc-f195-1c0d-476214fabd52@opensource.wdc.com>
Date: Thu, 28 Jul 2022 12:09:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 04/11] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
 snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162250eucas1p133e8a814fee934f7161866122ef93273@eucas1p1.samsung.com>
 <20220727162245.209794-5-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_200943_316253_22232C61 
X-CRM114-Status: GOOD (  23.21  )
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

On 7/28/22 01:22, Pankaj Raghav wrote:
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place and adds now
> support for npo2 zone devices.
> 
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/nvme/target/zns.c | 3 +--
>  include/linux/blkdev.h    | 5 +++++
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index c7ef69f29fe4..662f1a92f39b 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -241,8 +241,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
>  {
>  	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
>  
> -	return bdev_nr_zones(req->ns->bdev) -
> -		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
> +	return bdev_nr_zones(req->ns->bdev) - bdev_zone_no(req->ns->bdev, sect);
>  }

This change should go into patch 3. Otherwise, adding patch 3 only will
break the nvme target zone code.

>  
>  static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 1be805223026..d1ef9b9552ed 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1350,6 +1350,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  	return BLK_ZONED_NONE;
>  }
>  
> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
> +{
> +	return disk_zone_no(bdev->bd_disk, sec);
> +}
> +

This should go into a prep patch before patch 3.

>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;


-- 
Damien Le Moal
Western Digital Research

