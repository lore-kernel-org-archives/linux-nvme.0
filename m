Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512D1C433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  6 May 2022 15:42:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C9R4vO36FMVtFFDfmrbze/9k4c361/y3/N3db59jat4=; b=VMswhr0TtQtBEkzFIEnczihH+V
	WB9H/TKfnNZRCpHKGKTHzJTiG9Tu+PgkThlo32MaW7LeT1KEZrJQT66hFfS4us/xfuAU/BvdhGWmn
	NPNDe4WaG8NcBKWB60Z43b/e19VlGNfDNlo4Trmle5VfJl6sN1USQVcRh/JBnTxU2KHDtZ/0GpSon
	oGjpzIxvFj03FvbeDDTNGQ3n9XbyHsaWLHQtsT4evPkjVaE7DV2nVN32/ARx8A2+etYSunqUfT+ub
	c2beK6lXxjE38cFH3nWqwA3XhMIvAKSoBD+NIMCgS6andgOrzXByTFPCzIylCAB1wUwtEWiWhDSm4
	BXQk8sUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nn05p-0049Xw-Ck; Fri, 06 May 2022 15:42:09 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nn05j-0049Tv-Ql
 for linux-nvme@lists.infradead.org; Fri, 06 May 2022 15:42:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1651851724; x=1683387724;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=CudXlomFZkQJESGju0/Iz+s8hFiIaxDM6HlQScgYRIU=;
 b=lGqHuXw0VyC55A58Xyqu65cygbKtlxN6FrYLohL+7Sfic4hK6O+gNxs6
 gla70cOMptwhiVciFxkBO0nsTJW0XChJClMbIptYMbtpbD4/HsvacIydg
 toXLH2zEgseCBB1L4S43gzGZNAwq920rVcuUY9z0xVHIsDbck3qf4zafK
 njkOsMjqp8esMownzgOYAVVIeurj6HpLk8g1VXoKotBW5pZlIxqYvqdqK
 p97gbQtXn7T8B2hMw5I/nSGNxh4l2zpsMAgqMwq/OxYawBrv6fAy11RcM
 Uses1vgr3ob5IC1Vy7TevH8Y+/6KbJA5bdZ0YBz3+kn2k8kDg3U6UmEN9 A==;
X-IronPort-AV: E=Sophos;i="5.91,203,1647273600"; d="scan'208";a="200577738"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 06 May 2022 23:42:00 +0800
IronPort-SDR: jZNFsi8gWhu3tVSeW5cCS3fH8oh1+7nTyoF2O0S0KOlE8y9Y5NY61V/y0NbligjfXeik5nBoG8
 hKJpOBSpfAWVhp+mil0umfrGhvI1fShY43N7PDHfxVhCzD57lT9ZgZmX4WLL8AZOfhUsD66Qcg
 MxSoVWSQtcDL5+GLKvyfuolVAMPOzgL0h9lNXKq72WgY9fOCmK+vgq8vBaEgue2UvmjBLd3GcC
 B4uA9GekwDeagpafoYeV8dzVvHcLsJAhIwGMW09er+zaBRJ18uwMZbI7L2lVncUZUnX1vgDC0B
 25xreIQv2YJTqKgfm1UJCm9j
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 May 2022 08:11:36 -0700
IronPort-SDR: 0MPuUVyCe0q9dP5yK7SjiKmqyFOwjvZiSQC5I21mzHQqgUMtWLT9Og4oi8T4QUSUI0sslM6rfc
 gJJU/MTpY3ev8urW26viAmEmXf2GzlReucq80ZP6Cd9YnyN7AVGrI8J/v8VyCMwTXwXrA9CpO7
 ZaQiPSnAGrJAlHh7H+l6NfGMbUAcfJ01vSPQOyqRwj41cQFYmxZXjDCfApd4YfDcw8f6qdU7TH
 +P6FG8+X6lPTl4jFOIcuqYmCOnPCveex3gI5ZljuNZhdP78ZpfYfpDjzohB36efdxfwKleAc3p
 Jk8=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 06 May 2022 08:42:00 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KvvvC21SCz1SVpD
 for <linux-nvme@lists.infradead.org>; Fri,  6 May 2022 08:41:59 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1651851718; x=1654443719; bh=CudXlomFZkQJESGju0/Iz+s8hFiIaxDM6Hl
 QScgYRIU=; b=WbBRu0S7iR1SmhEVR9i30Kql+kUpme4JxK84Ex4n5H1AfUhQ0EA
 s43ehh3Jxi03c/aa1PkPy9zpXcal9LS0jQoLHXDoQ8X64pfmVU8F+Y8nBgHjfgas
 nkAL+jnWw5ThcR+Jq1BNnuhc0o/mhwqQ5IiqOdwPxU5eHhWBbzcI7rR1dUJwE2Fi
 SMt7XqWc9/XGM7LK0GmzTFUNkZ+KteMkRDfpeOhq0if7HyNffaZrnfkJFK1T736p
 S4EMQmEAWtxxz4M7PkJBG2UGqoKaNk93iakpAHvYx7Hk5wLPL3e1zc9RYTuzeG/j
 dNxUKQCZnRC3KA89AxMPNpyTuxFnJGOFejw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id 3qQM-FhGMY1D for <linux-nvme@lists.infradead.org>;
 Fri,  6 May 2022 08:41:58 -0700 (PDT)
Received: from [10.225.103.215] (hn9j2j3.ad.shared [10.225.103.215])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Kvvv75djhz1Rvlc;
 Fri,  6 May 2022 08:41:55 -0700 (PDT)
Message-ID: <7f1bd653-6f75-7c0d-9a82-e8992b1476e4@opensource.wdc.com>
Date: Sat, 7 May 2022 00:41:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3 11/11] dm-zoned: ensure only power of 2 zone sizes are
 allowed
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
 <CGME20220506081118eucas1p17f3c29cc36d748c3b5a3246f069f434a@eucas1p1.samsung.com>
 <20220506081105.29134-12-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220506081105.29134-12-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220506_084204_114402_C7940E9F 
X-CRM114-Status: GOOD (  22.43  )
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
> From: Luis Chamberlain <mcgrof@kernel.org>
> 
> Today dm-zoned relies on the assumption that you have a zone size
> with a power of 2. Even though the block layer today enforces this
> requirement, these devices do exist and so provide a stop-gap measure
> to ensure these devices cannot be used by mistake
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  drivers/md/dm-zone.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3e7b1fe15..27dc4ddf2 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
>  	struct request_queue *q = md->queue;
>  	unsigned int noio_flag;
>  	int ret;
> +	struct block_device *bdev = md->disk->part0;
> +	sector_t zone_sectors;
> +	char bname[BDEVNAME_SIZE];
> +
> +	zone_sectors = bdev_zone_sectors(bdev);
> +
> +	if (!is_power_of_2(zone_sectors)) {
> +		DMWARN("%s: %s only power of two zone size supported\n",
> +		       dm_device_name(md),
> +		       bdevname(bdev, bname));
> +		return 1;

return -EINVAL;

The error propagates to dm_table_set_restrictions() so a proper error code must
be returned.


> +	}
>  
>  	/*
>  	 * Check if something changed. If yes, cleanup the current resources


-- 
Damien Le Moal
Western Digital Research

