Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F29C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=moIBOWQn7K95Xp9J6EXAkxjnOCYc7eYLgqbPUxSFmeo=; b=abi9IV7qaI1AqyieE/0LP+HP+B
	OYRPereDdD6fOJHXLEwYs56lSYKTG51Vd+C2ATXq1kXm+tGg72P/fzueYSxy7OFu7cLHAZYwSQHef
	O56N5ZDQiqxa9/RKXHTSbbQI9x4kK/7TJ6ZkGjBiv6MVdsKydRbasgqIrwR9u6B/HNGzSKw0relLE
	ezAkK5wB8YDAg/NxTwoC9b5oT5xdtHLEFrggjPUOTIBkU/a4PwvMbMBEGCeTE9CDB2vZ09XehD8U+
	BZRMz0bYayBJmEvSLvMFN4hyT3npZQfmaxynix9Me13wou1UuM9kvSrG/875iIpvfMcQDmTAO3bEa
	ObMwbJow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YGz-00E26T-Jn; Tue, 05 Jul 2022 02:26:45 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YGv-00E25f-Vt
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988001; x=1688524001;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=VEo1U38lZifgVX/C/QfJsivX3yshQFhlwAOpNUkJGpE=;
  b=At3xcjc8K7UHoZWymtorBXrrjoG5qncv341gCKj0WB/oLMARClMQFAAe
   YM49Coz2xSzQhTRa3Z4b6lTiDisGG7ICwt6TtTI4/CH+jMVu9ZoZKlK4f
   EvzcFXZXYG+BkhlFU/2cwjz6i9mDakLsZvr6w5Fq0YyTmd/WDMPe4Bnx5
   zsooiNseSuxiWorkC5gfb1EleiFV8vL8sOtQ1VuWBQnRjjSygvMP3d2CK
   XsxD50zeP7KFTcKqlSFY0bm3NW83KXnX6fFrJpLzEFnrXtWmEp3cAAH0g
   +WzSQi4G7jARk5pkd6jQGMARxU+l3bIsi/hN5UD4z4LH9b3qzLqfkQ+YG
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="205518665"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:26:36 +0800
IronPort-SDR: 1XDZQU065z6EB0pgZ+H3Lled1oXCSI/vZ5iTWKvIdbH48ElVNlcfd/KHkMNlGWFLtwTkCnO0Kd
 n8q8EX3j1rQjG0npDkl8RaTTjLH4scu59OSbN7C16Y/3P66TJNgfp7S9/CeoQ6+f0g9arYx/U1
 +P1ibpI+vjdqoNkPiEXq4FBs/G/8KUOR2xSN3xdB3CbmQER3Rcer7Z0NSNB6gi7pMf6Y2TwV5I
 g6wSLb6SYf/MTbWrw3y+c10mzNQRDnh1A2obA1wi2RuNGKCrTuZgASyARypv1XQlspcqJdU4Ki
 k6eUITlp9i2eohr0FYTot+mH
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:48:27 -0700
IronPort-SDR: RROrZ/BxbBzXypNe7i7AbUf7f9udNf7zKXKWuDynBoXjLkVjytoume2BK+Yu+ToNoUmDIJpJrW
 6ilwJfthEnBqc01i4o5Cjhq3xbRX3CV7u1TtPS/dRRhlbw1BAMsnGnmMNon62NTccEYWjPoQcw
 Wmj33eP4W+3o0HOzANj8pUJA545PA6vjNuahwMumgQ+V+kxWBrsMLNy4Kop5p0IYI/qe+WetD7
 SFQRTyvpiqtVpf6/VX34BdTyXpNG4eODRtwVB7NpxVTRZ3nV6m0SurPsC+BrNlVG66IofwyJH2
 6iM=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:26:36 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRPl5B3gz1RwqM
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:26:35 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656987995; x=1659579996; bh=VEo1U38lZifgVX/C/QfJsivX3yshQFhlwAO
	pNUkJGpE=; b=QPBNupleFdg5rjY4nn3+iZEtHgP/8ZnS/N3S0RmZFXPhE+gEyfw
	XtsrovW3DugFQmBhSJYdjn1S/0XmA6JPAea8g3+fv6IvvpheiVktUnJa6cFAbWJl
	ZWzoMv93zI4QSpBByd3GhMdaBlZVSDqqpmjr1oH8LT9lqpRXeLoS4g06AI6Uc1el
	9tGHLjFwHii0kNI8suSz38UQ6m2wJtA5vKTjSAmSybgtFfKsbeO0uaTzr75IvmWK
	tF2yt4WUjm3Fb52tgSb7ZeCItHXhqjS5JWC6i2M9CchBFd1tdTIBruOOdHk0Wnbx
	1UFF50Zr3DU/AISjUvdI1DmgHnv79Yrg9vg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id DvNHP5kNfyVH for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:26:35 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRPk0fwcz1RtVk;
	Mon,  4 Jul 2022 19:26:33 -0700 (PDT)
Message-ID: <cf7b3c89-b820-9b27-b3ed-b9b625e59482@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:26:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 01/17] block: remove a superflous ifdef in blkdev.h
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-2-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_192642_139027_D8C72311 
X-CRM114-Status: GOOD (  24.06  )
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
> It doesn't hurt to lways have the blk_zone_cond_str prototype, and the

s/lways/always

> two inlines can also be defined unconditionally.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/blkdev.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index b9a94c53c6cd3..270cd0c552924 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -899,8 +899,6 @@ static inline struct request_queue *bdev_get_queue(struct block_device *bdev)
>  	return bdev->bd_queue;	/* this is never NULL */
>  }
>  
> -#ifdef CONFIG_BLK_DEV_ZONED
> -
>  /* Helper to convert BLK_ZONE_ZONE_XXX to its string format XXX */
>  const char *blk_zone_cond_str(enum blk_zone_cond zone_cond);

This is defined in block/blk-zoned.c and so not compiled if
CONFIG_BLK_DEV_ZONED is not defined. But I guess this should be fine since
if there is a user of this function with !CONFIG_BLK_DEV_ZONED, a build
should fail anyway.

>  
> @@ -915,7 +913,6 @@ static inline unsigned int bio_zone_is_seq(struct bio *bio)
>  	return blk_queue_zone_is_seq(bdev_get_queue(bio->bi_bdev),
>  				     bio->bi_iter.bi_sector);
>  }
> -#endif /* CONFIG_BLK_DEV_ZONED */
>  
>  /*
>   * Return how much of the chunk is left to be used for I/O at a given offset.

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

