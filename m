Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E82C43334
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 12:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2LocjIvAraf6pKTUxyJdivW7tgoU+OmHZLLIaS+qI0=; b=qb2qoa23a+GvAWvW2JfH+3ozMN
	IPD7BsCzj8SC/GLzLKV2hhlIpxjR1ch0r9w1jAteWctgxks8GrQgqmC+V733kxVNkV8ip7xbznivu
	RmT18cCYyeflcSe1W7HZsvnIzIXUemdfRpR1M12GY4GkH0Y+lEa5QhsVzhDJ5W8nkep3AKQaiuEZn
	s8FkUDiJkl7TttneAYHBhqhJbbuYCbiu7iYnfe0ycH3KrkKevz0VyoXJNm+pvSYNQNJPvlkIFjSfd
	EWpYuaOmwcr9WaQIRhi1lZPk4eJxPUOLboztTdcXTH7grHsC8gPxcs/R5h38lb761ggHfVNHYFCEM
	DaFqx7gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o93hK-009mOX-55; Wed, 06 Jul 2022 12:00:02 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o93hH-009mMT-8U
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 12:00:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657108799; x=1688644799;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S2dmgFWYC+DLGT+2UImPSe0KHi+Xt6J1e3za4GRwE7w=;
  b=Qbc4lD90HRoV4SDKRLeyvI14WcrB8ogSOqIEUwSw3O6SUnZYPZTa+L+O
   9D2ay+t9HUrfQePceYLdaFp2i5p7sz0Q/+Oc15TGaM/VKFFC195hiVZ1O
   ouk7l3s+XjxJP555F//w4K9VTomeuWXW8lK2hxm5HSsOSNSxSM+WMCxKs
   fom7Kmjyhq28U93xGakbb6ZynbVDdbDjfH8y7K88dZN+nvIebdygOtI8J
   Vs5kwGioBa32AmN79o3r7HsmEUDkitnLDLSH32YiakFUKVCT4xw8Afs61
   NIc/gulF1/nXAV3i7nbikP23e05ooXYOq34nK5eMudbcSz56J0jYXo6DE
   A==;
X-IronPort-AV: E=Sophos;i="5.92,249,1650902400"; 
   d="scan'208";a="309304221"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 06 Jul 2022 19:59:57 +0800
IronPort-SDR: 8dZedq/mgUYKWmhedgegBC0Z5q9zcxmlecLbv6t0o0knPsa2dTNdPDBNyrkGAL8sSuAxLJk6v7
 ZshfgIbvjBta3PY0mpBlYIVjMVv9rtfejEtgNo/9UIdzt2dsv0RTwxOd9dLvCvq9MY7NNwq+l8
 5IF53StvCgoOpfyC2dBTqn/sOrqFtv0+y2sRkUDGGCKbaRztjk1zA0Axyvq56/emmzqQf5FAEr
 Ndc52PU6mbIKRP7s97blAgnWlnzZeQN9r8I+86Y4BIl6vyafdxNa3v4G24poM3KhdmXrk9Ch+y
 5FkWSqRGe+eVA7fbk7I+Mzq0
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2022 04:17:11 -0700
IronPort-SDR: b3USrcRj4ASYN0TSQvQJPWQ0KfZcgmwFS6psUsols0ZeA7xUSFQgR3GnL7jazYb8R3/xGEcWvM
 k3TVWm83pSHjL2hISTucNJZeynIZlYgAfkxfoR27IiYU8NVEXfrQLNG3sh+wV7X18U62X+RVuI
 89CVLKfSigoYYucjbxoDCSh+pjv9bEnTmxDmFoY0yOEmCq7oEKsOPrXr6J1Ao9Kknv4v8dF3Qx
 4007G3j/ue5D4LSUFktTvodkToAPR09bbUCwVe1yQUdKcceO3ih8WxwTuFTC6Ast0G4rJDdGNY
 FU0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 06 Jul 2022 04:59:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LdJ4s05Vcz1Rwnm
	for <linux-nvme@lists.infradead.org>; Wed,  6 Jul 2022 04:59:57 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1657108796; x=1659700797; bh=S2dmgFWYC+DLGT+2UImPSe0KHi+Xt6J1e3z
	a4GRwE7w=; b=avHgtOoHfjG2jZbK/Ao6W/WEgzDeTcABzDscIyeIu1p+yuqVxUA
	lJw8q+ItgcV6S/fQQD7aYlkqS242FQGlSRu8GD/YNdTXno/fccZN40gWFPal71Dx
	H54S7gz+49t8UFuxiiRFuqcuOJpa4Ae79aiiv6Td3g2wu4XazfLEzKx/+yBr2Twu
	10oAdTgJTPSsFHwff4ZYe2z8PbQJoDdu/bjHOU5vk6FzYayBQqy6rFKTSHLwXIdV
	zUhDbYe608WcO3MTSHNtOBJQ7lTDXX/DhbvkWzvCnfGWe/4aFwXnB7MAyRiC3TU9
	zmzfluzOggYYn1il0WKL4anelfrTwfCchvw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id saSkiLo3C5X4 for <linux-nvme@lists.infradead.org>;
	Wed,  6 Jul 2022 04:59:56 -0700 (PDT)
Received: from [10.225.163.110] (unknown [10.225.163.110])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LdJ4q5LQPz1RtVk;
	Wed,  6 Jul 2022 04:59:55 -0700 (PDT)
Message-ID: <07305397-4756-52b3-eda9-a572b5cdb3c4@opensource.wdc.com>
Date: Wed, 6 Jul 2022 20:59:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 13/16] nvmet:: use bdev based helpers in
 nvmet_bdev_zone_mgmt_emulate_all
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220706070350.1703384-1-hch@lst.de>
 <20220706070350.1703384-14-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220706070350.1703384-14-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_045959_391716_2675D978 
X-CRM114-Status: GOOD (  21.80  )
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

On 7/6/22 16:03, Christoph Hellwig wrote:
> Use the bdev based helpers instead of the queue based ones to clean up
> the code a bit and prepare for storing all zone related fields in
> struct gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/nvme/target/zns.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
> index c4c99b832daf2..9d8717126ab31 100644
> --- a/drivers/nvme/target/zns.c
> +++ b/drivers/nvme/target/zns.c
> @@ -413,7 +413,7 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
>  		ret = 0;
>  	}
>  
> -	while (sector < get_capacity(bdev->bd_disk)) {
> +	while (sector < bdev_nr_sectors(bdev)) {
>  		if (test_bit(blk_queue_zone_no(q, sector), d.zbitmap)) {
>  			bio = blk_next_bio(bio, bdev, 0,
>  				zsa_req_op(req->cmd->zms.zsa) | REQ_SYNC,
> @@ -422,7 +422,7 @@ static u16 nvmet_bdev_zone_mgmt_emulate_all(struct nvmet_req *req)
>  			/* This may take a while, so be nice to others */
>  			cond_resched();
>  		}
> -		sector += blk_queue_zone_sectors(q);
> +		sector += bdev_zone_sectors(bdev);
>  	}
>  
>  	if (bio) {


-- 
Damien Le Moal
Western Digital Research

