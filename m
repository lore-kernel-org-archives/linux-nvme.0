Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA496C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 03:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RHlzRc8n9OpkaYDKpSPncL/olcn9ibermQbpUXLe02k=; b=ojXDzErz4PQssE+HnXvP9+5K+Y
	2O4cJPnP4Qf/c5hEOdQjU0BAuN4baywYRinpu51FAMRPZOaR+yKqDWwnkK0mgfyQtv9qCn1MITLf1
	H6jE4qecnzNz4YAMypSA2lV6z7rzSJhcRDBY/jQH5MH5Y7uMTEkeCHyWEwn+Id/knTpd6TD2IwJqA
	ngm394JOqSQqxFDwLSuvfa6bpd6hTS5mlApfFsFFowsDzgunFMDxWwbeftU3QPyRNfMqvSxIulzlr
	qTyb3vLMuWVKtNywPs+qZTte6bOXblshzHeZv1f1+otkuQ/7D28AMQbIM5Bxq2ksi/C2hn5nyevFI
	3Hd+pvJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGu4l-003T98-A1; Thu, 28 Jul 2022 03:20:39 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGu4i-003T69-A9
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 03:20:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658978436; x=1690514436;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hgHCcX+r6a1k41oBN3+yo/cGQgZRJNC14DbPvta/5ZU=;
  b=rB+RfuaAtpt1nWdjCdL1eGcdv1oubxrL4xH3MaMPqkwRg1JL4Y82j1kR
   WPMufrXqqhkYaVAzLgKXFCkPD03v7ypmoRoM7nebZKIPUPRSWfDQ+6aKK
   Cf0Bnl4ah6MKbw+wGMVut+TmjQygGlq+QpzFrXpdqto4DPZD7pFZxmMMa
   OCTLCjQv9F7MnWZZ34GeJlhu/iT3WfRv5jyPAYl08HTcOMa8AsKO5/Jtd
   khQvB039qbkJ79ZiZzVCdKSCncGCQChs/BEysl/mZiHJbZWmnH1+fOs6T
   qQ1d6w0diBdB+NNlMRffM+5wnLtbCrdOaltp1KxTsvvj9r1T+tN4QWq5s
   w==;
X-IronPort-AV: E=Sophos;i="5.93,196,1654531200"; 
   d="scan'208";a="205666837"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2022 11:20:34 +0800
IronPort-SDR: vFf+oBxfaqKKsdzP8XBZuP4kr/Xyl6OrNnNOtFZWbOH1LkGvgJFRwQ4wbETfg0fdSJjkwCf28g
 PUbc4s377aifJOTbgJqvAggGoCzlk4cBtt2sGkZAG8m7sz3EudXoLiiMzcllQujVbLpZ/EtifB
 MDQjZ472xmlEVOIj9t+SNVPVWOZ2Ig6p1XiDgJsLGcPSl6RuMn2LAcKk+4SAj2b2z88zjJKP6M
 aOHaZxX5ni7puN/ycX0D5gsztezaWmAvTLwXqkMm+WdFCejzkYJ7S2if6NZ5rsnbpeko4+NZAi
 /v6G4pgkjXP2kUh+A3A68cGW
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 19:36:42 -0700
IronPort-SDR: 2RSbAY4EpVAVotJ7DrQrsHLCM/2tv8ARqJ/BjMx2QHKiZxmBnJU5G5bjv0zYKx5iMpzkIZky+O
 E+TKqN8C/sUaeiEYO6ZRHCOL4H8wLfFfTCaRvViU/jGEmNUPvX/FNYp/YX653kxjoVl4NeERpe
 LJKCvmZbC0e5+UUm4frXlopF+rvRcMCsUsE0JuJfgej9pg7uLFfwnofrZp5A4c5QKWmLF2HrDI
 02KFXuVRJjRWvyE0lJjUYmpD3sxEFvOUxS1b+5+mQ935OsF9KNyw0A1wt1ND2aCXkqt+yOzV52
 8+I=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 27 Jul 2022 20:20:34 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LtbWP5nDpz1Rwry
	for <linux-nvme@lists.infradead.org>; Wed, 27 Jul 2022 20:20:33 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1658978432; x=1661570433; bh=hgHCcX+r6a1k41oBN3+yo/cGQgZRJNC14Db
	Pvta/5ZU=; b=NKStJLOIOnUZKambVwNOSsQrcKFb7GHwVZOLxOjRjCMmL1Yx+9L
	LQ0ITW6boOQntA60H4ee2oW3m4m3speBRffYVVM5NTXAydmLZtkVExzFd6bvlzEd
	He/vsJaY6a9NKqUMpY/9kW6JffapuGVk+NicNR4ALQUfQ8HZJNFzt46URym/5KCG
	u91hHGZ1llYcCsI2cHxw2xWYetBKu4uVUQw2xqW4+0uYAD1S0EK3BoIR6xXl0fcK
	nm+ppd75mFR9x1kvy6pZiZNRYM6cJqkb8frFWy3ip0Foe85MNkJhqKYkDZP+cz+7
	Hh59MC/ED6mwR+u9hB/zaYG6zUOd7q+tExA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id nRRyn2ADEIlT for <linux-nvme@lists.infradead.org>;
	Wed, 27 Jul 2022 20:20:32 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LtbWK6WzGz1RtVk;
	Wed, 27 Jul 2022 20:20:29 -0700 (PDT)
Message-ID: <63350fdc-9cc8-3034-c8d6-8dcff50780f4@opensource.wdc.com>
Date: Thu, 28 Jul 2022 12:20:28 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 08/11] dm-zone: use generic helpers to calculate offset
 from zone start
Content-Language: en-US
To: Pankaj Raghav <p.raghav@samsung.com>, hch@lst.de, axboe@kernel.dk,
 snitzer@kernel.org, Johannes.Thumshirn@wdc.com
Cc: matias.bjorling@wdc.com, gost.dev@samsung.com,
 linux-kernel@vger.kernel.org, hare@suse.de, linux-block@vger.kernel.org,
 pankydev8@gmail.com, bvanassche@acm.org, jaegeuk@kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 Luis Chamberlain <mcgrof@kernel.org>
References: <20220727162245.209794-1-p.raghav@samsung.com>
 <CGME20220727162254eucas1p1fd990f746d9f9870b8d58ee0bd01fedd@eucas1p1.samsung.com>
 <20220727162245.209794-9-p.raghav@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220727162245.209794-9-p.raghav@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_202036_447734_530A3427 
X-CRM114-Status: GOOD (  19.65  )
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
> Use the bdev_offset_from_zone_start() helper function to calculate
> the offset from zone start instead of using power of 2 based
> calculation.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/md/dm-zone.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
> index 3dafc0e8b7a9..31c16aafdbfc 100644
> --- a/drivers/md/dm-zone.c
> +++ b/drivers/md/dm-zone.c
> @@ -390,7 +390,9 @@ static bool dm_zone_map_bio_begin(struct mapped_device *md,
>  	case REQ_OP_WRITE_ZEROES:
>  	case REQ_OP_WRITE:
>  		/* Writes must be aligned to the zone write pointer */
> -		if ((clone->bi_iter.bi_sector & (zsectors - 1)) != zwp_offset)
> +		if ((bdev_offset_from_zone_start(md->disk->part0,
> +						 clone->bi_iter.bi_sector)) != zwp_offset)
> +
>  			return false;
>  		break;
>  	case REQ_OP_ZONE_APPEND:
> @@ -602,11 +604,8 @@ void dm_zone_endio(struct dm_io *io, struct bio *clone)
>  		 */
>  		if (clone->bi_status == BLK_STS_OK &&
>  		    bio_op(clone) == REQ_OP_ZONE_APPEND) {
> -			sector_t mask =
> -				(sector_t)bdev_zone_sectors(disk->part0) - 1;
> -
>  			orig_bio->bi_iter.bi_sector +=
> -				clone->bi_iter.bi_sector & mask;
> +				bdev_offset_from_zone_start(disk->part0, clone->bi_iter.bi_sector);
>  		}
>  
>  		return;


-- 
Damien Le Moal
Western Digital Research

