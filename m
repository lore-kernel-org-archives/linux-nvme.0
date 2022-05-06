Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91F7AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q3US34YJgONnJD9h1EkDdS6yuKW3dbSHTGgaEGCJ69w=; b=Egr/8jcXDs7ziynSSl7GDOoxa2
	GZHwSu6pAgZYmM+84vWU2oyNFiRND/MIDDFmiiXGD3IsPTwZOCbqsW6vHtKx1mXKimE1ev1qSUUNf
	ZVrhtuJa8AXy/VjQkknkNZrJZCkQhP+l8DFlYxIZQjEd7lSnj+M8+IxnOCT2h7MQjl3qebWU+vSav
	7zqEZq1WS2Rwg6qeW1Sy/OhU2iZ453JImfZokf8y3BeBPR4P1aBQkpvs2pjK8GDejbKEfeOznl2As
	zOxnkMVuRuVyN5elz8QnSC0WhcXuiuno4Irkg7Em9U5K7Cbddnu6+emkfWS5QMynOgiY1P/fCMgeR
	SD1qsTdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nn0Ay-004BXF-KF; Fri, 06 May 2022 15:47:28 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nn0Ai-004BNx-39
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 15:47:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651852030; x=1683388030;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=59Rf2fI9Uw9YDeWqGexMB7hcfRNyi4rusRKW1UzXakE=;
 b=UPhaNH1HB59YdI0UfCr0GyPrvskFZ2hHMrZ1L5hRkoXA2PS6eg7x8X3y
 dC8Fgvx1LTW5QoTy9Q3EHNdLs2SNV0zYa3pwfTK/LyazzZwSaJD0k2k5l
 MA5kOSmTY3ePURE1T2tOm7Z7BJCGfD9MW/rIUOBy/gcIe6HeqOz8HxaAf
 j9WTi49zS9mFhhnVf940Tt8d4+UYWcElDmFvfNUdhG4WCw2mp5Trw3H41
 UK3jD+Oqc6lDtrtvX5J7tZILB8q9DyAEBzpgG+/WAektSzBqDNQK2UwVO
 8bCZYKY02QUGmTVZGdcVav1N5drytv3BIZAClOeNUKimw8nPwHGhhgT/P A==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647273600"; d="scan'208";a="204569999"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 May 2022 23:47:06 +0800
IronPort-SDR: Ut4VA5dWAXtuIOKHWFmIg6rnVSRzEddqs0xyFYGy4Qg2O6t+eWEDMtJXLHCmhfS+uJk/ma3mHt
 IrH54ttzduO+sUzsloENAUOJXRA66MfY0iZFAKeSvW8ixxjIeiRrKydOPxr5nnX0Bx10UUKVBb
 6z9ROtLwd9bPl45+ry46LP7Hmg9doyHjBltdyMznExNZ4RnBw3O+R11jMLdm3xegJCaiRZw922
 e6SnwGUA05GMpDqPNkhUO3YR1im8aNs0LUCyxIwmFY1Vgo77X4eVgSUQ952Dc4xCYfOLpR/Ink
 VK3lKyPb/O3rEyL3oGWXJJD5
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 May 2022 08:16:45 -0700
IronPort-SDR: 5oatlRs20eR5awT+8iFrVLGpWBeeTV0oIdhejNid3KOjyjATwUjyvl2heywobxBYmVlvT7BCMi
 n4yEOHfe/M6bPYDrYMbMCb4PFsdWYTCj1SeF7dTIrnF4PZe+U7WeJzOMkwpOFgegDLsNJ7h9qk
 1+fcUcv07OYH6Z9iV1VxclcvwVpcLFu1tuOq28PQDae38uxu+K4WYeLtjrKCNEuEKrbI4YYU9H
 7EcfEWYcWvK7dyHVbhk42rjB96gKvqirSxOcF75BCSgdMolkBA+555ISGgeqlHs/qTXcmMadLE
 gvg=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 May 2022 08:47:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Kvw174mjCz1SVpB
 for <linux-nvme@lists.infradead.org>; Fri,  6 May 2022 08:47:07 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651852026; x=1654444027; bh=59Rf2fI9Uw9YDeWqGexMB7hcfRNyi4rusRK
 W1UzXakE=; b=X/b6rmohjasoazviVlFH//kXZ5lOWuyvheX6ZGozEy/Jw39WmZE
 lWU+QQpYsARF7Q6O4/8mG0d3aCioDx7xyZIAIKTrW0ge4u3Pm2yFjBgrk6Svbp1D
 qLdbvfRaBSO07Bd6/hziKh9hDjSHP65ov9mYNr5Zq/ukRH0DvyhVmLKf4RGT+tuR
 i6crnhIeY12x/o89Q7N/fW+YJmKZqB+udn3/wJI+Ap0WGDz0A0Sq6iPrRuVjo/TY
 LV0aC4gcGtWY5HAvjpY3WevY+iJIvEEbaiCdQDE5D9HajIcIDrYtCpyIUqEdBFAX
 4ZhZ7bLuMpsdOgiZ7WIFkPP1CjEbyCK2YmA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id IMoiYwH2R3oF for <linux-nvme@lists.infradead.org>;
 Fri,  6 May 2022 08:47:06 -0700 (PDT)
Received: from [10.225.103.215] (hn9j2j3.ad.shared [10.225.103.215])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kvw133RlTz1Rvlc;
 Fri,  6 May 2022 08:47:03 -0700 (PDT)
Message-ID: <39a80347-af70-8af0-024a-52f92e27a14a@opensource.wdc.com>
Date: Sat, 7 May 2022 00:47:02 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 10/11] null_blk: allow non power of 2 zoned devices
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, jaegeuk@kernel.org, hare@suse.de,
 dsterba@suse.com, axboe@kernel.dk, hch@lst.de, snitzer@kernel.org
Cc: Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
 bvanassche@acm.org, linux-fsdevel@vger.kernel.org, matias.bjorling@wdc.com,
 Jens Axboe <axboe@fb.com>, gost.dev@samsung.com, jonathan.derrick@linux.dev,
 jiangbo.365@bytedance.com, linux-nvme@lists.infradead.org,
 dm-devel@redhat.com, Naohiro Aota <naohiro.aota@wdc.com>,
 linux-kernel@vger.kernel.org, Johannes Thumshirn <jth@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Alasdair Kergon <agk@redhat.com>,
 linux-block@vger.kernel.org, Chaitanya Kulkarni <kch@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, linux-btrfs@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220506081105.29134-1-p.raghav@samsung.com>
 <CGME20220506081116eucas1p2cce67bbf30f4c9c4e6854965be41b098@eucas1p2.samsung.com>
 <20220506081105.29134-11-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220506081105.29134-11-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_084712_195699_F0644C8B 
X-CRM114-Status: GOOD (  26.93  )
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

On 2022/05/06 17:11, Pankaj Raghav wrote:
> Convert the power of 2 based calculation with zone size to be generic in
> null_zone_no with optimization for power of 2 based zone sizes.
> 
> The nr_zones calculation in null_init_zoned_dev has been replaced with a
> division without special handling for power of 2 based zone sizes as
> this function is called only during the initialization and will not
> invoked in the hot path.
> 
> Performance Measurement:
> 
> Device:
> zone size = 128M, blocksize=4k
> 
> FIO cmd:
> 
> fio --name=zbc --filename=/dev/nullb0 --direct=1 --zonemode=zbd  --size=23G
> --io_size=<iosize> --ioengine=io_uring --iodepth=<iod> --rw=<mode> --bs=4k
> --loops=4
> 
> The following results are an average of 4 runs on AMD Ryzen 5 5600X with
> 32GB of RAM:
> 
> Sequential Write:
> 
> x-----------------x---------------------------------x---------------------------------x
> |     IOdepth     |            8                    |            16                   |
> x-----------------x---------------------------------x---------------------------------x
> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
> x-----------------x---------------------------------x---------------------------------x
> | Without patch   |  578     |  2257    |   12.80   |  576     |  2248    |   25.78   |
> x-----------------x---------------------------------x---------------------------------x
> |  With patch     |  581     |  2268    |   12.74   |  576     |  2248    |   25.85   |
> x-----------------x---------------------------------x---------------------------------x
> 
> Sequential read:
> 
> x-----------------x---------------------------------x---------------------------------x
> | IOdepth         |            8                    |            16                   |
> x-----------------x---------------------------------x---------------------------------x
> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
> x-----------------x---------------------------------x---------------------------------x
> | Without patch   |  667     |  2605    |   11.79   |  675     |  2637    |   23.49   |
> x-----------------x---------------------------------x---------------------------------x
> |  With patch     |  667     |  2605    |   11.79   |  675     |  2638    |   23.48   |
> x-----------------x---------------------------------x---------------------------------x
> 
> Random read:
> 
> x-----------------x---------------------------------x---------------------------------x
> | IOdepth         |            8                    |            16                   |
> x-----------------x---------------------------------x---------------------------------x
> |                 |  KIOPS   |BW(MiB/s) | Lat(usec) |  KIOPS   |BW(MiB/s) | Lat(usec) |
> x-----------------x---------------------------------x---------------------------------x
> | Without patch   |  522     |  2038    |   15.05   |  514     |  2006    |   30.87   |
> x-----------------x---------------------------------x---------------------------------x
> |  With patch     |  522     |  2039    |   15.04   |  523     |  2042    |   30.33   |
> x-----------------x---------------------------------x---------------------------------x
> 
> Minor variations are noticed in Sequential write with io depth 8 and
> in random read with io depth 16. But overall no noticeable differences
> were noticed
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/block/null_blk/main.c  |  5 ++---
>  drivers/block/null_blk/zoned.c | 14 +++++++-------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index 5cb4c92cd..ed9a58201 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1929,9 +1929,8 @@ static int null_validate_conf(struct nullb_device *dev)
>  	if (dev->queue_mode == NULL_Q_BIO)
>  		dev->mbps = 0;
>  
> -	if (dev->zoned &&
> -	    (!dev->zone_size || !is_power_of_2(dev->zone_size))) {
> -		pr_err("zone_size must be power-of-two\n");
> +	if (dev->zoned && !dev->zone_size) {
> +		pr_err("zone_size must not be zero\n");

May be a simpler phrasing would be better:

pr_err("Invalid zero zone size\n");

>  		return -EINVAL;
>  	}
>  
> diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
> index dae54dd1a..00c34e65e 100644
> --- a/drivers/block/null_blk/zoned.c
> +++ b/drivers/block/null_blk/zoned.c
> @@ -13,7 +13,10 @@ static inline sector_t mb_to_sects(unsigned long mb)
>  
>  static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
>  {
> -	return sect >> ilog2(dev->zone_size_sects);
> +	if (is_power_of_2(dev->zone_size_sects))
> +		return sect >> ilog2(dev->zone_size_sects);

As a separate patch, I think we should really have ilog2(dev->zone_size_sects)
as a dev field to avoid doing this ilog2 for every call..

> +
> +	return div64_u64(sect, dev->zone_size_sects);
>  }
>  
>  static inline void null_lock_zone_res(struct nullb_device *dev)
> @@ -62,10 +65,6 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	sector_t sector = 0;
>  	unsigned int i;
>  
> -	if (!is_power_of_2(dev->zone_size)) {
> -		pr_err("zone_size must be power-of-two\n");
> -		return -EINVAL;
> -	}
>  	if (dev->zone_size > dev->size) {
>  		pr_err("Zone size larger than device capacity\n");
>  		return -EINVAL;
> @@ -83,8 +82,9 @@ int null_init_zoned_dev(struct nullb_device *dev, struct request_queue *q)
>  	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
>  	dev_capacity_sects = mb_to_sects(dev->size);
>  	dev->zone_size_sects = mb_to_sects(dev->zone_size);
> -	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
> -		>> ilog2(dev->zone_size_sects);
> +	dev->nr_zones =
> +		div64_u64(roundup(dev_capacity_sects, dev->zone_size_sects),
> +			  dev->zone_size_sects);
>  
>  	dev->zones = kvmalloc_array(dev->nr_zones, sizeof(struct nullb_zone),
>  				    GFP_KERNEL | __GFP_ZERO);


-- 
Damien Le Moal
Western Digital Research

