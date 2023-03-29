Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCABEC77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Mar 2023 08:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PCyOzDhhpDfbdpDRKDB3pbp+g0/ddJjuCTzvMhZZ+ss=; b=ll+fWd1FOwOjeQqHHY/J9w4TNj
	x/LXUMcqt8BuoMzhs4Y4twZcYt9Qc2nHNAwrR7dgApkxhxR1VnSykC+J79ocPPhGJyJx4gUE4WRDd
	Qf7zzb+y8456u3gxq+6+hCb0LNSlohcFDyH9AS4h72Heqn/rVjFyyrD0c6nVkF13/sjoZbfYcpec1
	ey9WxrADGcBslQ1zoHfETJs4hcqYkZK87TzUEGyBInsqwiftsSPHRHrJhV6Oslm7Y0qAEQepXw3Kx
	p9UaMVS956L3GPmH/Nu6QACV/9WAhKB7E4qlRqXJyOrCVUA+z1W4xvBmcoIPWmog2lbLwYg5AY1zi
	ugSb5Hxg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1phRM0-00H9DF-2r;
	Wed, 29 Mar 2023 08:40:24 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1phRLx-00H9CX-0w
	for linux-nvme@lists.infradead.org;
	Wed, 29 Mar 2023 08:40:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1680079221; x=1711615221;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E3jSijsKBSV9BsEzQr1YnSfmWJK8g8o7ns6B3bjeHLM=;
  b=k5vROw3JyupPea1hd3Rjn6yRVG85C1enZ9gYmyAzdjATMg6GQQe+eEvC
   S7Z9/1XTqaoAjQgx0qVO0DKQCyC67YEMoWN/EYptVQMKjMv3ySypp729z
   5iuL8a7+a7/igs2SWcjHpPq/l6epj0g7x69YZrdIoxpy2S132heHKxetF
   0ItdrB8JZEPavjLIzEKAbrc7ACU6rexkXptUG7X2fmYUgMhuai0KkzHhV
   gN00wAH/ZX6mXf8OQw0b1fT+0qa3bxbun0CZDY0kzL61DGrvW4RNO6gqG
   +CFpae4pSM+4PopXXBgErcgwEF2HGEO1Ubwf54sYRwWMHeIqjqONzVlZ7
   w==;
X-IronPort-AV: E=Sophos;i="5.98,300,1673884800"; 
   d="scan'208";a="225055335"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Mar 2023 16:40:17 +0800
IronPort-SDR: IrBt2lC7/dwzFkAd1t9zLkA4Tzd1kUSbZFBp+mO8wwIsONtdxk892v70XleqDLbc4d796/kgmd
 NhfqgNPhMDpomI087IIs4Kv44xOEWETZeWMympKnLNhhEstXe7Aydid93y/Zd5DNtTGFnc8bBq
 B+mrA7oeThy+LIC+tVmAtzu1g583mr6RoDekPMvtbayK/sfN5Nf+/0/uI2tsKEWe0YrjuggaBU
 KIxOJcRs0A4ph0AZ/Tuiup4sCp7sTXKbvgaqKKKlS430x9cSvnqlhl1bc1H2dR5RrEuQNsMZRA
 dco=
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 00:56:26 -0700
IronPort-SDR: 1yhE7sqanK02AGNvp08jApcxe0L1SEgXzaWa6AqKWZKbwXuIcL7yy8UhYv/ngPTYE3Hf1kfFFt
 pAzb3W9Rd5BiWnrL7W1FruukE4fCEioV57zXKIJHKOhTh2fhmK2tyBuJU7WR/9+wfnMnv0qZvU
 vv0Wy87vNnrHPxSBnZkwBHMEjoqZpa6CR+tCBTE8yq5KXYsdE5vTb46rsaZ49oekQZiiKRMllU
 YpW7gjGyM25Zr68YWr4tlKpsGYgjkBV/nOU6ktX8q3BA+YdsvKqgc6u/8jpaCT0D2HQ65Ppx7s
 Qn0=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Mar 2023 01:40:18 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Pmg3h6zmTz1RtVq
	for <linux-nvme@lists.infradead.org>; Wed, 29 Mar 2023 01:40:16 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1680079215; x=1682671216; bh=E3jSijsKBSV9BsEzQr1YnSfmWJK8g8o7ns6
	B3bjeHLM=; b=ubojnNRZtniIG4drMxCxpbcUUntc7UVjcuyQDdJq4Y4sJ6P2Jk/
	k8QBkYTtobxjovRwL97Pc69e6lGQwgirLIzioWiy2p3Jz0SYjirs9SQdmSZHzT3K
	/3WMbS6vpWd0887PymxQxyApYp547FWCtFhI6IrU/eOBmbIshIEHOboKDZw7gfQh
	Ftpa4pU/OykstUUR3CAiBB0z+McsaAyRd+hHSFrn4tfUWLYa+IzL93WL2z1O03Pk
	3fMfw8iQf8a88VcuSMAwxMB5p9+NQ2opoKmgeM3osaeh4u18V8DelxYQ26HlS76K
	V967+/rtR1Zczx+Gp7Dk/OcQkfIfDxL09sw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wz5IdfvD_lnj for <linux-nvme@lists.infradead.org>;
	Wed, 29 Mar 2023 01:40:15 -0700 (PDT)
Received: from [10.225.163.116] (unknown [10.225.163.116])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Pmg3Z3bThz1RtVm;
	Wed, 29 Mar 2023 01:40:10 -0700 (PDT)
Message-ID: <e725768d-19f5-a78a-2b05-c0b189624fea@opensource.wdc.com>
Date: Wed, 29 Mar 2023 17:40:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v8 1/9] block: Introduce queue limits for copy-offload
 support
Content-Language: en-US
To: Anuj Gupta <anuj20.g@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 James Smart <james.smart@broadcom.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
 joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org
References: <20230327084103.21601-1-anuj20.g@samsung.com>
 <CGME20230327084216epcas5p3945507ecd94688c40c29195127ddc54d@epcas5p3.samsung.com>
 <20230327084103.21601-2-anuj20.g@samsung.com>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20230327084103.21601-2-anuj20.g@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230329_014021_443003_BF8B9597 
X-CRM114-Status: GOOD (  34.19  )
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

On 3/27/23 17:40, Anuj Gupta wrote:
> From: Nitesh Shetty <nj.shetty@samsung.com>
> 
> Add device limits as sysfs entries,
>         - copy_offload (RW)
>         - copy_max_bytes (RW)
>         - copy_max_bytes_hw (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_offload: used for setting copy offload(1) or emulation(0).
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_bytes_hw: Reflects the device supported maximum limit.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> ---
>  Documentation/ABI/stable/sysfs-block | 36 ++++++++++++++++
>  block/blk-settings.c                 | 24 +++++++++++
>  block/blk-sysfs.c                    | 64 ++++++++++++++++++++++++++++
>  include/linux/blkdev.h               | 12 ++++++
>  include/uapi/linux/fs.h              |  3 ++
>  5 files changed, 139 insertions(+)
> 
> diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
> index c57e5b7cb532..f5c56ad91ad6 100644
> --- a/Documentation/ABI/stable/sysfs-block
> +++ b/Documentation/ABI/stable/sysfs-block
> @@ -155,6 +155,42 @@ Description:
>  		last zone of the device which may be smaller.
>  
>  
> +What:		/sys/block/<disk>/queue/copy_offload
> +Date:		November 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] When read, this file shows whether offloading copy to
> +		device is enabled (1) or disabled (0). Writing '0' to this

...to a device...

> +		file will disable offloading copies for this device.
> +		Writing any '1' value will enable this feature. If device

If the device does...

> +		does not support offloading, then writing 1, will result in
> +		error.
> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_bytes
> +Date:		November 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RW] While 'copy_max_bytes_hw' is the hardware limit for the
> +		device, 'copy_max_bytes' setting is the software limit.
> +		Setting this value lower will make Linux issue smaller size
> +		copies from block layer.

		This is the maximum number of bytes that the block
                layer will allow for a copy request. Must be smaller than
                or equal to the maximum size allowed by the hardware indicated
		by copy_max_bytes_hw. Write 0 to use the default kernel
		settings.

> +
> +
> +What:		/sys/block/<disk>/queue/copy_max_bytes_hw
> +Date:		November 2022
> +Contact:	linux-block@vger.kernel.org
> +Description:
> +		[RO] Devices that support offloading copy functionality may have
> +		internal limits on the number of bytes that can be offloaded
> +		in a single operation. The `copy_max_bytes_hw`
> +		parameter is set by the device driver to the maximum number of
> +		bytes that can be copied in a single operation. Copy
> +		requests issued to the device must not exceed this limit.
> +		A value of 0 means that the device does not
> +		support copy offload.

		[RO] This is the maximum number of kilobytes supported in a
                single data copy offload operation. A value of 0 means that the
		device does not support copy offload.

> +
> +
>  What:		/sys/block/<disk>/queue/crypto/
>  Date:		February 2022
>  Contact:	linux-block@vger.kernel.org
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 896b4654ab00..350f3584f691 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -59,6 +59,8 @@ void blk_set_default_limits(struct queue_limits *lim)
>  	lim->zoned = BLK_ZONED_NONE;
>  	lim->zone_write_granularity = 0;
>  	lim->dma_alignment = 511;
> +	lim->max_copy_sectors_hw = 0;
> +	lim->max_copy_sectors = 0;
>  }
>  
>  /**
> @@ -82,6 +84,8 @@ void blk_set_stacking_limits(struct queue_limits *lim)
>  	lim->max_dev_sectors = UINT_MAX;
>  	lim->max_write_zeroes_sectors = UINT_MAX;
>  	lim->max_zone_append_sectors = UINT_MAX;
> +	lim->max_copy_sectors_hw = ULONG_MAX;
> +	lim->max_copy_sectors = ULONG_MAX;
>  }
>  EXPORT_SYMBOL(blk_set_stacking_limits);
>  
> @@ -183,6 +187,22 @@ void blk_queue_max_discard_sectors(struct request_queue *q,
>  }
>  EXPORT_SYMBOL(blk_queue_max_discard_sectors);
>  
> +/**
> + * blk_queue_max_copy_sectors_hw - set max sectors for a single copy payload
> + * @q:  the request queue for the device
> + * @max_copy_sectors: maximum number of sectors to copy
> + **/
> +void blk_queue_max_copy_sectors_hw(struct request_queue *q,
> +		unsigned int max_copy_sectors)
> +{
> +	if (max_copy_sectors >= MAX_COPY_TOTAL_LENGTH)

Confusing name as LENGTH may be interpreted as bytes. MAX_COPY_SECTORS would be
better.

> +		max_copy_sectors = MAX_COPY_TOTAL_LENGTH;
> +
> +	q->limits.max_copy_sectors_hw = max_copy_sectors;
> +	q->limits.max_copy_sectors = max_copy_sectors;
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_sectors_hw);


-- 
Damien Le Moal
Western Digital Research


