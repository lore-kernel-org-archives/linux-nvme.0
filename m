Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9032EC04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 03:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nB8SUBhjfqfKw8b2Tu4L2k+wNFQ3VWpISV71rW8zWWo=; b=FYWNUSGqyEhGbP5WO2t+LeZcPy
	iBfA0Pgok24K6cQtN0704bl4eOU6FBDtaX4+gKh/N3+zA3dKrLFe3A3KW11i+m1KrVZ0J4Y/X7gtU
	28vQT4y2G73OBhf40ClkA1aqLSGdEbwvYClAT/LP2Ja84IgTqgpIxlhpj06WswuTlSHXrQlxWVq4Z
	eCTEaSELrobhwmntauNjpqeZfELjxx6WhmGESR+cBcUYHfcQMAIgwW3yk61sOKugvvEK9aaNPPSZP
	gsEIK5Z7T1m+Tv5Wskle8RxWf3GTfo1XCff1wEG2Dkp5JM5GzfPipt+moE90ZQlSV05tELh/AIKfV
	u7j+zfRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGu2T-003Roc-Lt; Thu, 28 Jul 2022 03:18:17 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGu2O-003RlH-Qe
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 03:18:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978292; x=1690514292;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QUbay5Dzz476bfBAfIiryaPk/r7bibYqxCGIlUR7KkE=;
  b=l5pY1IcATOrnkNQsmY+opgxuJSKKG1NQ4hoJCiX68fStL7sXUC27kG7Q
   za6P0JnNU67y8Od8icmjQ19KV7jYK0GV37Wun2V+mD05V4QLkpNqvpeQz
   CTqUS1RLUmILiFblxszI8Rr+FWehGqScylt7V1KTjPEc/qY9V5Xo2Aia3
   DpZVimcjIBId72LbeepnY3ZuGjSDXlKPite9aqnapFWse3jY6/8wInRy1
   HZoXhjp5M5R4tsMaz3cc5XeUTV+rVX67LmmfieApUkeWZ8DkNVOvHgOOe
   xS5fvraliJIYhPW3VoMHsLzQtUPmA+sQFDkO1iSqv8Gmmer6kVvwv0V5X
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="311434913"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:18:12 +0800
IronPort-SDR: cIO3xHZWg7lyR3PUJXq9uWR/MoACtKS/T+cWvKPpBsxpgI2HGTqoCbAXzyStCOuz1OzTk4w1ds
 vyiksqW8Mb4IkwKzFTu5MCBXKowx8vvSLDzzF3IN4yfwKouHH2VTYerU3FEsKMmFPcG+AJ786E
 u2NOo79o5X81gmGjYHrmeXfz1QaB7AokafET89sYRAAe2eucBxYkBy5CIZK0fslAEIY5JG/0F+
 FNuJRVLO7avBL4USgaXXuDvKlk8mcy+r8KfATvJ0/pR3BUIu0nEjvXutEkySC7fSfSYx0LnbbE
 0FNoShOAfOyX2SgcjqYykOVU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:39:23 -0700
IronPort-SDR: u3t6Lq4g4sIMmCz4J6DzGjZlcRI+tKGQF2NkUM5yiIkkJnGRIchOyc9d9ReuL8/lCLqw6bwimz
 67KGCe/Xy0ChUgowy6WGVH0q5Sh9TD5qgdNfQq1RacdjPX2WQw78S04d2qq9dFGjOAKJ3Ew3D2
 vb6LBRlJQu0EdU3k3jdD6kHs3ThPNjLVO5yLvpmCc7pc18g8CoHGADs7gpfjmViuuHKeDggsEu
 MFMkQpZGzC2DOlEFob7B/NMeQ4KjYcVi9b8ZckAWgcO5q2DKFvyZpwWKnKM2jND3DcB7QPdL+6
 6OA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:18:12 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbSg6N26z1Rws4
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 20:18:11 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658978291; x=1661570292; bh=QUbay5Dzz476bfBAfIiryaPk/r7bibYqxCG
	IlUR7KkE=; b=lKBs5qRnYH5ts92SJQZPDRWNJklAKbXmn1WcOWOwkVRujX7YWOK
	DZ+7Asp8HND14dbFptTMkS3rmN57c6Mt2aOJ4MB9hEpYgiq7rBt0bfxD/nWX9wB7
	fr5wwZTPZAqNr8Qchphg84x974x8IeuBpFQ/UJw1NQ2x0el8dNh5bRP6UV2T+aO1
	qpx0B/uLh+UhdveaDjEf9rXYLdcG6wPwrTIexPF64AyMi8AMqCoFEVkzAfoO5FrD
	2uRsKfRcarmcTWhHalHv2cqa7D8mUC8RisldkJTuw4la5IZCxXwQUpAv/MlgPaWX
	Lq/8193sxFHTRmVFt6DQ/6qR+cV+OTWB5TA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 8nEXLt-sm_9s for <linux-nvme@lists.infradead.org>;
	Wed, 27 Jul 2022 20:18:11 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbSc2CCQz1RtVk;
	Wed, 27 Jul 2022 20:18:08 -0700 (PDT)
Message-ID: <6f93c6f4-240d-2d61-c53d-b5e66895ebcf@opensource.wdc.com>
Date: Thu, 28 Jul 2022 12:18:07 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 07/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
 snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162253eucas1p1a5912e0494f6918504cc8ff15ad5d31f@eucas1p1.samsung.com>
 <20220727162245.209794-8-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-8-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_201813_041220_262F49A5 
X-CRM114-Status: GOOD (  19.21  )
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
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> dm-zoned relies on the assumption that the zone size is a
> power-of-2(po2) and the zone capacity is same as the zone size.
> 
> Ensure only po2 devices can be used as dm-zoned target until a native
> non po2 support is added.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zoned-target.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index 95b132b52f33..16499b75c5ee 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -792,6 +792,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  				return -EINVAL;
>  			}
>  			zone_nr_sectors = bdev_zone_sectors(bdev);
> +			if (!is_power_of_2(zone_nr_sectors)) {
> +				ti->error = "Zone size is not power of 2";

Let's clarify:

	ti->error = "Zone size is not a power of 2 number of sectors";

> +				return -EINVAL;
> +			}
>  			zoned_dev->zone_nr_sectors = zone_nr_sectors;
>  			zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  		}
> @@ -804,6 +808,10 @@ static int dmz_fixup_devices(struct dm_target *ti)
>  			return -EINVAL;
>  		}
>  		zoned_dev->zone_nr_sectors = bdev_zone_sectors(bdev);
> +		if (!is_power_of_2(zoned_dev->zone_nr_sectors)) {
> +			ti->error = "Zone size is not power of 2";

Same comment.

> +			return -EINVAL;
> +		}
>  		zoned_dev->nr_zones = bdev_nr_zones(bdev);
>  	}
>  


-- 
Damien Le Moal
Western Digital Research

