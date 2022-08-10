Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AD0C00140
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Aug 2022 17:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q1ceyBr/Zm1hd27TaG1mCrAXDFoerj8cTz0cw4OCTu4=; b=dNP5nRgkvPATIgg27lniFH88OM
	2WuAtXlMK/MfbfvmyVkziZ40kgUbcMM5H95IUrH/nzMq7ZnmRqgzdUIRO9Jc7ttblbN+6J/lb7LOn
	X8ntkpvIJG06ZlJM00NG2rX/YiRmJ50kQkstvCdRkyANMQYLvbUylwYok3b1JCcrICIODgg+A8MZd
	5ABFl36EPTInozyJqAOtF0Md0wRbV0NEWO6kC6rtZXbphlJvuWEU6TunOHrUVtsO+k4EOCVEtK+C5
	kWWsu6Q5aczy31hq0aPFKHS67y1gkOaeZ22n5wG7Xi1tNGDHXlwOdogayQlJ+xkC6gfshJGmTVeVB
	egaV3EJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLp8g-00DA6D-R2; Wed, 10 Aug 2022 17:05:02 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oLp8c-00DA4K-Jr
	for linux-nvme@lists.infradead.org; Wed, 10 Aug 2022 17:05:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1660151098; x=1691687098;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=HLAG2MAdQMkynHzaOpUgDbLqFXb4qGmeTI64Ae+vFXc=;
  b=ANlxH394xoXYeOWc9vqZJPSdPWpqAW0wkPIW/lrDBAZP2SQMflrJ9jEN
   pK0s46mj6RAcABm22g084ynRYf4Oz9qPQ6VqnfNYhzjlS/XL53X75lWPP
   NY0gPnnkJd65PmPIDvFiLIrcuZal4ZFOUdzshvRMkXwETRO2i5XgGOrx7
   WY4zL2lcnJY9FrnHipueVnmHyi//bVIshovSFLdSoEcA3VSLu2v37CbIA
   /Ea7HcgfDc8yKDvpYaCrphCd+s12oDrpUpHIQgCRtGqlEf/ymGEp4sSq2
   HhVOOOu5pR2I2E67p17hVH0zYsO8drLn+c3ORgJZ3Gj/Mf9mG+1Hur0dP
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,227,1654531200"; 
   d="scan'208";a="320459331"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2022 01:04:58 +0800
IronPort-SDR: F3PUrmB2PnIwVwYgWHgAED5JJaMjALQrjgutidbHBCMcNf5gvRjdA4DkZjjMrUk63zNvpuayq2
 rVlTOzOIPi7mceWUUDCip+AEElnSYW++u79jbXwc9AYrLKsiWFqbZkb4nsc/UA8MppQTTHmjCL
 wJcon/vZMQDRnjOXNREzIPXAKagUr6zGe69mJyKj76lVLif6tCcUgYsre91wGyyZSgrtV1Meqi
 vgskjZ2vokXD/FsEVZBh5jQTBdYT2VJn6l0PPFCNkvhD7dM8j1FZDCgT2tJ7LNaDBoD/a8SI8f
 U8/oPHvTcpbvMXszMY111zIQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 09:20:33 -0700
IronPort-SDR: YMXIq5IDQFXziWQg9TlgNiFsSHhaqtSlbLvFZjIOYOK7VSJdFvigvxYKKB8JlEbYk+f1C1VSiS
 RMUy5wcY6rhGCYhkJufiZWKCGj0almSZ+Lp03jhNo7j1R3dbqfk315hvLJudlTDPRb5nu6t6of
 yfiRYg/0A4mKU66aQTpVOZmylAZ9FBnkYT4wjDHrX9NUgsRMjRvnkbnfpfD2yRbOUeeIloGT2n
 2bW6k9PEb+GMQmhBfzSWUgnOzMhl/PNmcVRsiKDODbvf30xhVSHnXfgpJb2LuLYAvKYS2l2uQw
 bZM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Aug 2022 10:04:59 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4M2xBd69DYz1Rwnm
	for <linux-nvme@lists.infradead.org>; Wed, 10 Aug 2022 10:04:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1660151096; x=1662743097; bh=HLAG2MAdQMkynHzaOpUgDbLqFXb4qGmeTI6
	4Ae+vFXc=; b=TdfgDS5faJoHWDTYREJ381G9CP4HfuOIRXtpaJJLW4wBI1b/SHP
	AAkVbsUoTm+239ekFaNGKrcFMFe97CSgbrthryJciRMN50+Hj71pirupyCdhqi6T
	nVjIHr240xCCGgE7SICObVKAbOpVhYujaiuVVwgYovQXuEeGbelXwwXLVAvBIp8G
	Y4ubnW7OIfiPkDXk7oDgjAqg3dlQDL2sDsz9Ur2ZXZZM5JcQtGlXBakRDQavd7i/
	D06VIMSlVdwwuwlNK5Pfp2LCEkLucBn9DWwygSFnmvhJ6s2UUTlJF/BlKW1FQ4cS
	RW73Ij0jIvGIaehRGYHzOcu12QVeBBmbZxw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YmcauswWwOxA for <linux-nvme@lists.infradead.org>;
	Wed, 10 Aug 2022 10:04:56 -0700 (PDT)
Received: from [10.111.68.99] (c02drav6md6t.sdcorp.global.sandisk.com [10.111.68.99])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4M2xBb523Qz1RtVk;
	Wed, 10 Aug 2022 10:04:55 -0700 (PDT)
Message-ID: <89327143-48b1-297a-bf16-1ea7a2128595@opensource.wdc.com>
Date: Wed, 10 Aug 2022 10:04:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v9 04/13] nvmet: Allow ZNS target to support
 non-power_of_2 zone sizes
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, Johannes.Thumshirn@wdc.com,
 snitzer@kernel.org, axboe@kernel.dk, agk@redhat.com, hch@lst.de
Cc: dm-devel@redhat.com, matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, pankydev8@gmail.com, jaegeuk@kernel.org,
 hare@suse.de, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 bvanassche@acm.org, Luis Chamberlain <mcgrof@kernel.org>
References: <20220803094801.177490-1-p.raghav@samsung.com>
 <CGME20220803094806eucas1p24e1fd0f3a595e050d79c4315559d97ae@eucas1p2.samsung.com>
 <20220803094801.177490-5-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220803094801.177490-5-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220810_100459_443546_EE7389BB 
X-CRM114-Status: GOOD (  23.25  )
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

On 2022/08/03 2:47, Pankaj Raghav wrote:
> A generic bdev_zone_no() helper is added to calculate zone number for a
> given sector in a block device. This helper internally uses disk_zone_no()
> to find the zone number.
> 
> Use the helper bdev_zone_no() to calculate nr of zones. This let's us
> make modifications to the math if needed in one place and adds now
> support for zoned devices with non po2 zone size.
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
>  
>  static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 5aa15172299d..ead848a15946 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1345,6 +1345,11 @@ static inline enum blk_zoned_model bdev_zoned_model(struct block_device *bdev)
>  	return BLK_ZONED_NONE;
>  }
>  
> +static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
> +{
> +	return disk_zone_no(bdev->bd_disk, sec);
> +}
> +
>  static inline int queue_dma_alignment(const struct request_queue *q)
>  {
>  	return q ? q->dma_alignment : 511;

I know that it is generally better to introduce a new helper together with its
user, but in this case, these 2 changes belong to different subsystems. So I
think it really may be better to have 2 patches here. Jens can decide about this
though.

-- 
Damien Le Moal
Western Digital Research

