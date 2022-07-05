Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D9E1C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZEMrT6AMVkgCx2KcwMahJ8zXEKbZiPs1GStY9ERiR8g=; b=FxjKOy4Yo59tlFS05v6Ph3Da6f
	Fv22U13Tt2j6AGGcWoR+09mQXgDrG0+Wm9UAtxYpI/HViUvg2z4LoJtISIrPoS6u6+gvd3F84D4vc
	qnyiySiwGmpML8RY1GZyOjz9eEQChiJmvc7isLowZU0IPbhWmZ9F3LhqQ6uvwOs3KYz73Sgrkozpk
	le1SDUvNfJahpLoEFrhoZaV+c9f1lIa1QgVhtb5m/ryonY3ZewWR1UIiE45qxNmLhNNV04K+fCvia
	Akof/XWUgN4dlncbDRkKYDmfwIUBWiYCmAr+1L/zot+5pIOyoBI+N7ERBih/IE+SE2suKK8Cvjcgd
	F30pTEPg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YTs-00E4YC-DL; Tue, 05 Jul 2022 02:40:04 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YTl-00E4U8-CF
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988797; x=1688524797;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=76dpMhf7+ALfZDOaNq1izucr4zB/Vi7DG75jhXxoFXg=;
  b=a8yo7AV4LQ4e9M/7Oyo5xX5tuLWn4slhTS5ZlEvlElx5fzBZ/mMX1YOS
   WYz0KcPlUsd8KZ+ukso5r4KxFTctP8uXWaOWz+YSg1rYVu27OLqiJvfv+
   lZ5jB4/twayojY4zNA8JHEbSSpClV9ShcrzbMn+eGjPgtbJL1CITNEBLh
   SGEPKcdffnF+EGKyHRwzW49hRNG3xQ7Ya2F3aeyX5pqSf2dJ4JgRBdmRK
   GlPcdrZpcqdtJLYNpTQtWhr6Ej1q79m3WRSHs55KrLma50/UvSsLjyglW
   SGdarb4hPV8A2WAbIOU44iB1pCxqfb0SO8miKDrxhNgUvVuVP+lc9h3KI
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="205520001"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:39:56 +0800
IronPort-SDR: S9kO34GveBrXeWKZyPKK5qeSIXT2U9zABWciZxGquv5wacIjoJ5xkWI8kK2oLJFPN+uPoun64q
 mdA5Hg6M4L6NDhECJLCDRz/2rfcVdZ2UXQVYMlu2k6nWMgh8LWBLJc1IKQMW/FDDPQq7uyAL2s
 kEiZmKIQqxz9NNqLdDgCeE/HZxyhbSTAzUMGjouplH9vmKdNAPTRXLN/08scd0xSstRzVLPXxi
 MTiEHKCgAQ8yZT7IQTk9fFsKFzMKvjRgSEzyJVcwTFXeIn1TCF2P/JdiyMCSaUtcna8r40Qt8I
 gcIOq3v2jVoUZhVPd0bOgrT5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:01:48 -0700
IronPort-SDR: 0F/3fyIe8ff6X593iJiOTHMkbWQEvMRiVtC2E0kIIcHD8e9/65GEMlu87VzBZT9uE5GeDH63kU
 8kvUzGfTts/LT2YmsY+Ho4bhlPOImSob87q4aN5FeOh1CAVIoEDH4bGCWZ5/sMW3tZeQSuh+n2
 yzcHnPgtFF+blrGc1WYej/9OtFurIEbicN6jy9hjNo/Od9Tt8i8SsyVRrWpYG9n161s1wVukG/
 FD0I3X0TELmlAUYwsENi6sLnCcKI9ivqLEmnZ1Q9IkG8F246rCbz/ymcvCFA54Ox+jHX86MkkU
 r/Y=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:39:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRj82dhGz1Rwqy
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:39:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:references:to:from:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656988795; x=1659580796; bh=76dpMhf7+ALfZDOaNq1izucr4zB/Vi7DG75
	jhXxoFXg=; b=VSY0ELQVkD6r3eKYtH/37TiJOqFm8hz/xFBkqaXImabgPK2ZdQY
	vOG8i6j2tEs1ikP209S6UdmWk/4SF1YefC20UUtKm42LyLNBS0GL23I6ZV4XoCLq
	/FJw/usWppw2iqo0tkrfdvaivhOG5YsIbUqkv3JsGh/YA4yUNNsGYMnMB9tv/O25
	t2r2jObHmJkwqQV5zIOiMrU0jQEAjMmfDNiWoit7iVpzUfLhd8PGhS65UGRxesuP
	YNceuVAB5aqScsAyJUMILA1+baUDg4F04K9iGAwDjQFpe/WHCP+NFLiIVIl3N2kI
	E5J5Ttwuls5cTLJ3JfgKbdPnTbyVYbxBy2A==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eUPIc8WNT7cz for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:39:55 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRj614KWz1RtVk;
	Mon,  4 Jul 2022 19:39:53 -0700 (PDT)
Message-ID: <a71ac62a-9fcd-5282-9c4d-17348dff18c5@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:39:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 05/17] block: export blkdev_zone_mgmt_all
Content-Language: en-US
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-6-hch@lst.de>
 <9e815a0b-0d60-730a-51f8-6ba749b5c60e@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <9e815a0b-0d60-730a-51f8-6ba749b5c60e@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_193957_534025_4D642F09 
X-CRM114-Status: GOOD (  25.94  )
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

On 7/5/22 11:31, Damien Le Moal wrote:
> On 7/4/22 21:44, Christoph Hellwig wrote:
>> Export blkdev_zone_mgmt_all so that the nvme target can use it instead
>> of duplicating the functionality.
>>
>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

Actually, looking again at this, if we generalize
blkdev_zone_reset_all_emulated() into blkdev_zone_mgmt_all(), we should
not allocate the need_reset bitmap if op is not reset. And the emulation
for open/close/finish all is a bit tricky as we have to look at the
current state of the zones, so we still need the report. The bitmat should
this be something like "do_op" and the bits in it set using a helper for
the zone depending on the op. Then using that function as is in nvmet will
work. Otherwise, as-is, I think it will break something in nvmet.

> 
>> ---
>>  block/blk-zoned.c      | 10 +++++-----
>>  include/linux/blkdev.h |  2 ++
>>  2 files changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
>> index 90a5c9cc80ab3..7fbe395fa51fc 100644
>> --- a/block/blk-zoned.c
>> +++ b/block/blk-zoned.c
>> @@ -185,8 +185,8 @@ static int blk_zone_need_reset_cb(struct blk_zone *zone, unsigned int idx,
>>  	}
>>  }
>>  
>> -static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
>> -					  gfp_t gfp_mask)
>> +int blkdev_zone_mgmt_all(struct block_device *bdev, unsigned int op,
>> +			 gfp_t gfp_mask)
>>  {
>>  	struct request_queue *q = bdev_get_queue(bdev);
>>  	sector_t capacity = get_capacity(bdev->bd_disk);
>> @@ -213,8 +213,7 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
>>  			continue;
>>  		}
>>  
>> -		bio = blk_next_bio(bio, bdev, 0, REQ_OP_ZONE_RESET | REQ_SYNC,
>> -				   gfp_mask);
>> +		bio = blk_next_bio(bio, bdev, 0, op | REQ_SYNC, gfp_mask);
>>  		bio->bi_iter.bi_sector = sector;
>>  		sector += zone_sectors;
>>  
>> @@ -231,6 +230,7 @@ static int blkdev_zone_reset_all_emulated(struct block_device *bdev,
>>  	kfree(need_reset);
>>  	return ret;
>>  }
>> +EXPORT_SYMBOL_GPL(blkdev_zone_mgmt_all);
>>  
>>  static int blkdev_zone_reset_all(struct block_device *bdev, gfp_t gfp_mask)
>>  {
>> @@ -295,7 +295,7 @@ int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>>  	 */
>>  	if (op == REQ_OP_ZONE_RESET && sector == 0 && nr_sectors == capacity) {
>>  		if (!blk_queue_zone_resetall(q))
>> -			return blkdev_zone_reset_all_emulated(bdev, gfp_mask);
>> +			return blkdev_zone_mgmt_all(bdev, op, gfp_mask);
>>  		return blkdev_zone_reset_all(bdev, gfp_mask);
>>  	}
>>  
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 270cd0c552924..b9baee910b825 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -302,6 +302,8 @@ unsigned int blkdev_nr_zones(struct gendisk *disk);
>>  extern int blkdev_zone_mgmt(struct block_device *bdev, enum req_opf op,
>>  			    sector_t sectors, sector_t nr_sectors,
>>  			    gfp_t gfp_mask);
>> +int blkdev_zone_mgmt_all(struct block_device *bdev, unsigned int op,
>> +			 gfp_t gfp_mask);
>>  int blk_revalidate_disk_zones(struct gendisk *disk,
>>  			      void (*update_driver_data)(struct gendisk *disk));
>>  
> 
> 


-- 
Damien Le Moal
Western Digital Research

