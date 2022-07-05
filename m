Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D51DEC43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BDS0rrqYRFxKDEcfzl3zAW4ac4cjalg9So95G6+cIWA=; b=CT5fR2+alqFqUx+OPmDmVk/Gyj
	aKzgIyzaGbyfcKJ75uKYpo24HeQ1iBnqhZzFMrMZFn8EBJUOBqHqu8BkFSeGuOTEZI9JVI3bZg2v7
	xnpjxMZuEFh28MUVRcl0fTwcN4cbEiK7zTqH3yHkVd0VELI2U1GaC4F6lANFactPDGWD/HtwtyktL
	vmGGC4ptlbIEaQy5GXtF+8Dv4CnmzYg/PKZPxc3AdaWvAJdsl/GHCuaIRstlalG2PmUqtJRF8INeR
	KT+xS5xcFe8XXjpZMPGMPUMNX+z+ssSSIuNSv4HeSwcM3Xl8hFTXCRH5JjAWatyE9vbJp13qKeYxk
	2H689NMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YHT-00E29p-QM; Tue, 05 Jul 2022 02:27:15 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YHR-00E28l-Bz
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:27:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988031; x=1688524031;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=H9XI8GruQ80NCeMld+98UNkxXwXGjKj3wo7+vopk20s=;
  b=jKmPUzjXE376axcTh8/esvb2rXCW9fr54tniVPSclqyHRa6URUpkrjOU
   CYVO57Jb8SbUdaSdaUQK09VRbjNBweSXpNzM4CE3e2Yl5iX9j9clTEoUv
   pjdb1lxK/iJyWuhN62U5sxPXKlIXmIn8HYVQPZZuPAwsKsHPwO7p9loGT
   nfpYI5b2kNqw457YDoEEr5jHI7MYb25+y5LiZm7/sng8HBZHnJ/XB1Ft0
   gQYCieQHfhNx4E6K2Kl+JIYJcj5shFqcCKOYEwaVz4hezMleG4VAUrc1E
   6oUCNliKZnxvXN6TfPwmM0cAVB/yIhrxBTxBr0qWVVX7YCZiYnt35hHAM
   w==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="204806020"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:27:07 +0800
IronPort-SDR: to5QjbymPNJP8MPcuwCPgUrXkgAo1E92W/ZZ3d+0rwzRsWFHYhxluY364xQhg8yI2yeFaKa3Rh
 aFuDu2lecTrqZ8VDWf3kcfLLCP+x5D1q5Bh2ndBWY6JM/Yb5OSJLHOQPRgsubMqCDnfVSKz8wb
 zhA/SmdqBzg7i0TUpgkd7F2zy7nAw0HKEhdLNtGAvkT34PJyc0XX4+IQ8t/yhgjAH/FPR9XvZP
 8uT/SWuym7Qqwcnx5cWNVR6U568IQaCYZOPQa0QXMcKLule9+DQMKdmbnMn8wq2ZAoS4CwZYQ3
 Q59NxiA+YrWGKB9xMho7vM3j
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:44:28 -0700
IronPort-SDR: meWamf7KLjzvnn8qBkXk9y/+BwsSYFMtokT3lZlElqWVkGktx/iT/B1zkjF0omqMb7E7y9x6RY
 2TeBQTDSsgt45syRBK4eZ7Ls0kVf7FcM481nNGSE4Ssa09BXj/Ykd/fCj7B8cW5LffzM/re9Io
 ccAffTmwy51xhtVpDurzWf9dTEYD93G7Qdn/Bw5eCFKyjSrt6Nju1l6KELs8CEmd/IlFVTBptH
 vlW002mejRYr/fr4aM21h/65lKLUXzEtFHZQQddV3m6NeP7N6KwOMmUNb7q1IxKRziOoe62W2G
 Gis=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:27:10 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRQP2rTZz1Rwnx
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:27:09 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656988028; x=1659580029; bh=H9XI8GruQ80NCeMld+98UNkxXwXGjKj3wo7
	+vopk20s=; b=FykuHavTbjLln/rzw6hHJnsJWiQiK4Bp5Bwd7PXUrGvFyrSqpKy
	/MDqTAPyF74GlvBoR5VH0X3hIYITFUoyFC5HxfLx53PKhbq7QllTG2WxqpsAtuUS
	pqz+nRXfUJew1yl2LLxnDj59Kfwm39JsPwCd3r+RsjB2vbjMw0E+4XDGrVt8+GKY
	j8dm37bkdxm/DAd+AEqiP1AKqwi8nuxfcxfRpxVmi3KaG68vgjJXYyBMPO5RJWwO
	V9ZafDo1BC6f++rTc8MPRZJVg9orOeFc8UWSl5+y59Is8Jk/fXuulk8g9BwUez+o
	yay5SdI7AHLaN6fJ6/xiKfbDJtZiXrzKnCA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nvUXVQfUyXwy for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:27:08 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRQN0bjRz1RtVk;
	Mon,  4 Jul 2022 19:27:07 -0700 (PDT)
Message-ID: <2938c7b0-aeb5-f540-1c07-58551c449a3c@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:27:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 02/17] block: call blk_queue_free_zone_bitmaps from
 disk_release
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-3-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_192713_441861_FFF7D5E6 
X-CRM114-Status: GOOD (  18.84  )
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
> The zone bitmaps are only used for non-passthrough I/O, so free them as
> soon as the disk is released.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-sysfs.c | 2 --
>  block/genhd.c     | 1 +
>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
> index 58cb9cb9f48cd..7590810cf13fc 100644
> --- a/block/blk-sysfs.c
> +++ b/block/blk-sysfs.c
> @@ -776,8 +776,6 @@ static void blk_release_queue(struct kobject *kobj)
>  	blk_free_queue_stats(q->stats);
>  	kfree(q->poll_stat);
>  
> -	blk_queue_free_zone_bitmaps(q);
> -
>  	if (queue_is_mq(q))
>  		blk_mq_release(q);
>  
> diff --git a/block/genhd.c b/block/genhd.c
> index b1fb7e058b9cc..d0bdeb93e922c 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1165,6 +1165,7 @@ static void disk_release(struct device *dev)
>  
>  	disk_release_events(disk);
>  	kfree(disk->random);
> +	blk_queue_free_zone_bitmaps(disk->queue);
>  	xa_destroy(&disk->part_tbl);
>  
>  	disk->queue->disk = NULL;

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

