Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3564C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 08:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rfVamULdJYI1lj5tggztXBanZVbsBTdISqllFINPmZE=; b=lnvIjR7d/4CAGTxRKkaRbY4HMT
	DLdUh/M8LlbN3/u/OEzcQkAzIE1v1ib5fDDGbPCVu+GqBKcntZL2cggCoT2+aOjsHo087yBN9e0B1
	iQOYXze0omY0bCsV7dxI6B6ByMvCWmqHR+f66dCmJ9tLViND56sZPm7Ol6YP/guTIj4NCffEjBkdR
	YbkqbAFCd4MTcB1EdncEt6PMge6bYS1w5TzBqlk1CeHNXnrcf39BjkCy1wYt0soBZphvRV1kzlYDq
	1htr9nGnMkgJXH97tJkeDenEy+J6/U+0zwMXK2kXNZ7HpuOtapjHbYrecUIRmm05VU8DlkLJmyp5w
	Wu0BF4xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngMJd-00FuiR-85; Mon, 18 Apr 2022 08:00:57 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngMJZ-00FugU-KI
 for linux-nvme@lists.infradead.org; Mon, 18 Apr 2022 08:00:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1650268853; x=1681804853;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=N3pAk4FME4FfpMn1iEoaJawKiDbUT/rSC5t+NXLtpDE=;
 b=TapGlo87u8LKsMnAQTlrejv1MB/+xU6wSjD7Moco1C3GFhwEeazy4g9e
 ar+0o80c6UaGi/3zNUlOdbAdfW7O4t6wmBjj81VWOefvcQkz+wWM5jToQ
 UfpOLSij44qF5bcis4kf53SiB0E8X/46GVFg1dKX67Io08OlMQa0AGukQ
 rgIF6iIofqigC3/0pcc9z6iUB+kIhO8pwszAH1GwdAfrj8nV4nFCMP5Vu
 Mfw9zJP7fJvg2k4OaCJWHcJo5/DFNSbUCsHAOsj8sgWVCCBbf4wgYp+BL
 cBlIIoT+/lH0i2DC3zWaKC8E3Jzy96tHap+WxBK8hTZ9999kHMJw0zbui w==;
X-IronPort-AV: E=Sophos;i="5.90,269,1643644800"; d="scan'208";a="197010058"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2022 16:00:19 +0800
IronPort-SDR: UtX1nW+jLhDhHK354ZjhWwtzNmx797a1bXMP7BniW1n9nGiHGW67eCyOu84aEaBRh6Ij3r9AbE
 tlZXEMo0w2Dd8Gdal+Ivwm/7QU69j7v97kux1l5YLuHmwtuo/ulDk7irR1PEN1QQpbP6UVj2Ct
 gaGaXykh4rJhe7Kc2oTiF413sp7qxEjvUYAXaTGrDkOszwxKBmqH/jdJaJX4tGIytyglR6Vxmz
 vgEM/5n/l3bdDz3PaRl2vCrU2IM3vCzEfBOjET8Aypfaf25PPXLbYcgoSHSfbEAqfuMq3v+AE9
 nOGynYEIsOMAWGetvd04BbSU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 00:30:39 -0700
IronPort-SDR: Lu0mjqqAUtBD88rTzkCRhA3SzQ/YsQFgkQosvqn/+MhvfJb4GizxgsJ1KpjjI9xdhx+pXcdurH
 XAH3/EaHzqcA6RRWdCp0bfxUK/5iCbMh3y2Mn4hauQXgfUmrFlUhFFBDE1Mdy+zFrtZB7LBplH
 zdMi7ma0dW57gRXr0vRS5RWBpYyYJmpnqvwqiqk0h0pCYkZagFV2zPkPS9MeM6U4U+H3zw9onP
 L9V0WUBf4SysEQGopcubHPhA9Fl70PPPp22XuMYSLwz+xf7OvbXqFHg2eyC+WwHPKzzX1pO8vw
 yCE=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
 by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 18 Apr 2022 01:00:20 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4KhfVp2sBVz1SVp4
 for <linux-nvme@lists.infradead.org>; Mon, 18 Apr 2022 01:00:18 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
 reason="pass (just generated, assumed good)"
 header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
 opensource.wdc.com; h=content-transfer-encoding:content-type
 :in-reply-to:organization:from:references:to:content-language
 :subject:user-agent:mime-version:date:message-id; s=dkim; t=
 1650268816; x=1652860817; bh=N3pAk4FME4FfpMn1iEoaJawKiDbUT/rSC5t
 +NXLtpDE=; b=MEaqTu1yLViO++hF68PbHZUjVy7TbgArEZJCg3ei0W3w63rahlS
 2Oo9xzEB1Hx/lKCZUW9cGxczRM5Vrelcmvm9LANOVITnzOz8I2ENOdHZ8+QZ1EgN
 AZbTJJPS5t+7rlIrvoqjzTM4/pA02YTjhTAOlM22DwLiDuWvFGrwrZrjedl6MWM0
 LeHSHFh+6fRMFLxAIaOghVOR6xxwYGlJreU3ftYCeSBDAGj6khBFbTabVJETggeQ
 MBI1MQTFt1UdPdWbOrfszs+m5LYz/r5BLn1Raj1hqGWkB0hJMq1rknMyPlvQI86M
 WaEj3itLOmiucUlEX7D/KClfJgATBNly39g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
 by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new,
 port 10026)
 with ESMTP id S07iLtVPxe73 for <linux-nvme@lists.infradead.org>;
 Mon, 18 Apr 2022 01:00:16 -0700 (PDT)
Received: from [10.225.163.14] (unknown [10.225.163.14])
 by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4KhfVj0QSXz1Rvlx;
 Mon, 18 Apr 2022 01:00:12 -0700 (PDT)
Message-ID: <fd915a51-035f-d5c6-42a1-c517e3d1f1b1@opensource.wdc.com>
Date: Mon, 18 Apr 2022 17:00:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [dm-devel] [PATCH 05/11] dm-zoned: don't set the
 discard_alignment queue limit
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 Song Liu <song@kernel.org>, dm-devel@redhat.com,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>,
 linux-s390@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 xen-devel@lists.xenproject.org, linux-um@lists.infradead.org,
 Mike Snitzer <snitzer@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
 nbd@other.debian.org, linux-block@vger.kernel.org,
 Stefan Haberland <sth@linux.ibm.com>, linux-raid@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>
References: <20220418045314.360785-1-hch@lst.de>
 <20220418045314.360785-6-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220418045314.360785-6-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220418_010053_758875_80E8BE3C 
X-CRM114-Status: GOOD (  21.70  )
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

On 4/18/22 13:53, Christoph Hellwig wrote:
> The discard_alignment queue limit is named a bit misleading means the
> offset into the block device at which the discard granularity starts.
> Setting it to the discard granularity as done by dm-zoned is mostly
> harmless but also useless.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/md/dm-zoned-target.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-zoned-target.c b/drivers/md/dm-zoned-target.c
> index cac295cc8840e..0ec5d8b9b1a4e 100644
> --- a/drivers/md/dm-zoned-target.c
> +++ b/drivers/md/dm-zoned-target.c
> @@ -1001,7 +1001,7 @@ static void dmz_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  	blk_limits_io_min(limits, DMZ_BLOCK_SIZE);
>  	blk_limits_io_opt(limits, DMZ_BLOCK_SIZE);
>  
> -	limits->discard_alignment = DMZ_BLOCK_SIZE;
> +	limits->discard_alignment = 0;
>  	limits->discard_granularity = DMZ_BLOCK_SIZE;
>  	limits->max_discard_sectors = chunk_sectors;
>  	limits->max_hw_discard_sectors = chunk_sectors
Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research

