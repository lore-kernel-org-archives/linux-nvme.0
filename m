Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 481C1C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nHmaisavURHuGC45H2EbKdePFHPLBGWsE13a5R4nB3E=; b=ATbFObPB+PFgQ60guoP8AYqtvD
	8DA4SL2dx5pK6M1WJ0Zy0biosDl0FXaeEsck0BClJ9BrCfYMg/ILVluAF/lbCbXnf/UPIX0tO8uzS
	cm3u/7WlCgsnmoEVYguff0GfCmFdtaglX3FKUZA0XvKb0fcP6Oe+aP15ewPCOBkTEaukAmxj36hqb
	KoiZyJvo4cSMUyJJtbdQ7rUEvprDsLLwnScZVBrSxKdFJikW2FXX5jhfhUzKkcbpFyfOIXZ+moQcn
	b7NNhRaLfuDb6kIT2/6CMlqJIkvzZN3TqYfjpmGUND+JfoyLSUVdYdwywt8CoJtg+KpazaviFpuSN
	weB7bKSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YUj-00E4t4-By; Tue, 05 Jul 2022 02:40:57 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YUf-00E4qO-Ck
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:40:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988853; x=1688524853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=989zBONpd6lbkl0CE+LWDcNz1wqrb3C//HCnh1qmPLg=;
  b=nr1e3wr5TkrZwt0DbMVnSyeZ5MNr96slu+k16islPpoEHc23g2Fpv9+l
   1YKx4ZuOdHCtjdzsUCfW8lBHvVeM6Hg5tWr65rZB5ciDbCHnzUOZ4To1y
   8L0LTuXOwikdR5VYRZ/JtLv0euQLdu3D7Y+r0B5P+zYQgmG36m8x+19UI
   cbQEe18dQcTdJx93PUFPMnDuoE8PRW1YE4PB0bPoVo9hZlx4DP5J6tPib
   Csr+cRj9vH1/WCEyYSTV9XtU5SK3Ta4PQKnF1AakNPeQSyM5SqjZ67y/0
   WgDPYwHYrEp5Un3WBN4dNdIe4berfUA04A+ohq1UVfiGiyDTuixvEwvNy
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="316926064"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:40:51 +0800
IronPort-SDR: 6oWTLFO/2LMVhV6UKjR98mrZ2+tJQW2jWesSviSylVXkTcVCplfnnwXCk8+BENOi1gqTBWo8HJ
 69pZJ3/bX/QbV26cSNnabjMFoAfjKqZ8BVfwPt7yRE6LRlbmZzuqOwhWFSVcmMwJm1c+ADPyBB
 ciN5NeWUoHmTN8VycjFa+fSUiK0hsVKgUyXff+/ah3nbZibYYMGm8At3a/OvCGqV3T9F02Vf8b
 GgWhmJwdiWCQjaknPgZVnJHxPnCOWppKH5uUzcSV49lOwuAqpTn1svsZoCs6qdIEenj07pVoMr
 JKG0UwLxzkUaHNyTz3iZ6ZFl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 18:58:10 -0700
IronPort-SDR: FHCldK2cMahugVwcr/Q5OLYWELyheteXsh+Wr7kmna9guyByOPYNvfDNmgt+kXFO1NCWRAac6T
 MMULXhx7+aQ9VGGZ5KWKqQCUXIxcwJ9mIqUv5pbyhU59vZge5k3oW570QRS6XYhs1IYUdiwQb/
 /jHe8lVFs9EJpbfB59vp91m61xbkbIe8RzDxIAvljcekxAuxQi+LX307wv8cpB56I9nOOyEiGq
 KtpgG2gizNDXCszwEr2v6FQ7PSgYn2a23OP0CD3UVfPQEYZA4L6u5sAHfGpfBDOIG+IR4iuTtK
 YC0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:40:51 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRkB6hzWz1Rwqy
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:40:50 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656988850; x=1659580851; bh=989zBONpd6lbkl0CE+LWDcNz1wqrb3C//HC
	nh1qmPLg=; b=paDgPg9oId8zVLLFZw9dR66ws9BeKUZ+7UHToefYzTKjMIF7Ui4
	Lr/tTWbctO5OilyRIKvuWp7hI54vi3WU6ehYAN1LxXeA9ntNAXdKDO82iA5o6LZG
	Zb7CKRrEg9wkmTILvTofbfA1G6PLlM/McBq2bRXbi8t3AJYOKF4Cz5niaBCU5Dtp
	slxC6s3it7Q/gMaqrl9xfwOfOqU1UkSySw4Gt+9ZjkBKS7I5hf7+TWMekA0D5mfY
	7fHk4C43m65CxxTCiZ4TEPZ8B7ap1/PS7AP3pDcFf5o/dk3+TNve3NzJ6gS02Hrj
	YesqinqMPs76FpY8C0a65eEL25AxXOUI4mA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aAqVPr5hlX7C for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:40:50 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRk93N6wz1RtVk;
	Mon,  4 Jul 2022 19:40:49 -0700 (PDT)
Message-ID: <71dae34b-b5fb-e3d2-941a-0dd0836e542d@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:40:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 07/17] block: simplify blk_check_zone_append
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-8-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-8-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_194053_491332_EC30903F 
X-CRM114-Status: GOOD (  20.55  )
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
> Use the bdev based helpers instead of open coding them.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-core.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index bc16e9bae2dc4..b530ce7b370c4 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -565,7 +565,6 @@ static int blk_partition_remap(struct bio *bio)
>  static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  						 struct bio *bio)
>  {
> -	sector_t pos = bio->bi_iter.bi_sector;
>  	int nr_sectors = bio_sectors(bio);
>  
>  	/* Only applicable to zoned block devices */
> @@ -573,8 +572,8 @@ static inline blk_status_t blk_check_zone_append(struct request_queue *q,
>  		return BLK_STS_NOTSUPP;
>  
>  	/* The bio sector must point to the start of a sequential zone */
> -	if (pos & (blk_queue_zone_sectors(q) - 1) ||
> -	    !blk_queue_zone_is_seq(q, pos))
> +	if (bio->bi_iter.bi_sector & (bdev_zone_sectors(bio->bi_bdev) - 1) ||
> +	    !bio_zone_is_seq(bio))
>  		return BLK_STS_IOERR;
>  
>  	/*

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

