Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CA2C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 02:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JLrkAoAeIR+NUEtd2BCrXsdqGQzFQ5LxanLtbHvm32I=; b=C5rYpyq2Qx+T4wQKy0jj02AYpl
	Y3t7Tq2r0mUnEYhwfzm6unRhSOcpFPhUYJ8HHxLErv3bfO/cQSa/2ig6XnKQFP6G31YAyRfAUXIfN
	gagLH+/K3EBB0TqcXwDYt+kRvEBfaUsCW/Zosv/+JEwJ1EWuULREGtNzItW2xlQ+b9pisfZS1P36S
	5Hwg/eQMwphhZkHQnsR+MVzIsFgwz+Aj5yn95LFmg5ravLV1E2H9unhBSJu53t+/JNGK2VMYUsMQN
	AUR8Fmh26xiT8cVAtU7uftAvYXz+EcRRUwI1d6J+Xfdn5aRV5DrIuCiaGjAzo97Lgy672H2Lc5zxB
	zoZMG94A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YVr-00E5Of-55; Tue, 05 Jul 2022 02:42:07 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8YVm-00E5KI-WB
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 02:42:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656988922; x=1688524922;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eLFQwSzFJECaf6OosUXPb3bAWqxxfdqOwKldJTt0WWA=;
  b=dmQuwzUUaG807KA4gk22K8UulwTDp/8zZ4P7UVBZOzDur0qQgzGLNK6q
   HWx0edxNSTU55gDJ59Nx3ihgyjoqrVqdZ6urMNufxke93TmpkS4xl3Em8
   oev2p5h2ExL7I5N5SY1cI+A9zfxX/s1zyfFvxdvxzqAP8glBw/kdKr3zF
   2qmSqMKJWa7AM7/u2attiqgXycnnjlMqrpgpeIek47ozGq2AApI5fS8CK
   cdwBrwZEM8MS7B3atWbU46f/VvcSUQe1pIEAJc6HzqsX9YV2q5Pq+rnJ3
   wT6/7zBCPP4tP1gxblqTLrnxzZqmI/y05eRRXIBSo+Wkf1uJxOgMCxOFO
   A==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="309130059"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 10:41:58 +0800
IronPort-SDR: ewnN8ydHQNo8u/efZCGhUE+AuIcJte5dR+E3JlUqIj+OhIgmNBS2btowsP7rFMxFZFJGxEx1e7
 qzYD4Y6YE0RolyerqSyPIe19F956HKToXBJyRalrJOVxKKwRbZk9TD9ljDVZusx4PrkLa4z0E9
 pD//tAg8THeHCNooNuvVp136LVmBc2fV6dLt5Nka5vwTyx2njIrBHhZOzqbZNnh4fuuZlLQ/6a
 nX0yAlxMvpSl1S998KeUb9WdeZgMGVnVKwgVR3PnybEk/mZQXupgEM8aoVm/EJYl8Ijc9GMzRT
 rJ54wyFRuqgFMBZ2ALqpcWYU
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:03:49 -0700
IronPort-SDR: WYu7XaolPCteCVNI75/VqIpXTdzMsogv92Ajf8VpcMOCzgGur8zl7ORO28LkzAd184DH+3dAD7
 INq5/uCr4vO7AwOjicicreIYZEFcsVAvaTCNjRfOvO/mtj8EZgKtDMsZrwwgNwENupR04IrYKV
 B1yyOuGPrfobnUBMiu3n2hKpzB4zIT4cBqIrAc4NMD0fagEZnQ2W3TmGWmm8zi6FSMPGQIwXQJ
 vJh5VS8Fv5xoXiNqBEjXZhhfqG0F0ysrAOMfrJkFTeL5gAroZLhp5omxACgdDBxvwQsaCe+ePd
 SKk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Jul 2022 19:41:58 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4LcRlV0pk9z1RwqM
	for <linux-nvme@lists.infradead.org>; Mon,  4 Jul 2022 19:41:58 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
	reason="pass (just generated, assumed good)"
	header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
	opensource.wdc.com; h=content-transfer-encoding:content-type
	:in-reply-to:organization:from:references:to:content-language
	:subject:user-agent:mime-version:date:message-id; s=dkim; t=
	1656988917; x=1659580918; bh=eLFQwSzFJECaf6OosUXPb3bAWqxxfdqOwKl
	dJTt0WWA=; b=LxNrLO6ZbhFAEyfNq/L4fgqsvZQ2q8/DaqYFxH1c3UdTOPTE1r5
	7l/q3VK5nUDxITXFtViV5NQBYZ37l6jLhNJiEokGXl9mH/iQ6YtBEcrPYx1GKuCx
	huC8gnq5XN9+Qbjxix/p6z7sl5bD2f6NyMovHjXKZkHhA9IF37hNwGl4oLgxMgko
	cENFGIVP2uLj7rt1UtxGAJa+/ey8TEnbEUXLHMi/3RZvTSHPxUuu8luydePeF+Ga
	5PiVtNhx8ZweXEoOvw1fkTwnPOguw488PeZdw2302XHTcJETVehzzN18n9/D8gUt
	GC5xZaBbhqWaTWyWdI3I99yYZLTLcpqeB+Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
	by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qMJj9z-paZ2N for <linux-nvme@lists.infradead.org>;
	Mon,  4 Jul 2022 19:41:57 -0700 (PDT)
Received: from [10.225.163.105] (unknown [10.225.163.105])
	by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4LcRlS47xBz1RtVk;
	Mon,  4 Jul 2022 19:41:56 -0700 (PDT)
Message-ID: <fe0c09f3-0c0c-0527-88aa-21e13d91a23c@opensource.wdc.com>
Date: Tue, 5 Jul 2022 11:41:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 09/17] block: pass a gendisk to
 blk_queue_clear_zone_settings
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: dm-devel@redhat.com, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org
References: <20220704124500.155247-1-hch@lst.de>
 <20220704124500.155247-10-hch@lst.de>
From: Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220704124500.155247-10-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220704_194203_155339_E76A772C 
X-CRM114-Status: GOOD (  20.90  )
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
> Switch to a gendisk based API in preparation for moving all zone related
> fields from the request_queue to the gendisk.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  block/blk-settings.c | 2 +-
>  block/blk-zoned.c    | 4 +++-
>  block/blk.h          | 4 ++--
>  3 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 35b7bba306a83..8bb9eef5310eb 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -946,7 +946,7 @@ void disk_set_zoned(struct gendisk *disk, enum blk_zoned_model model)
>  		blk_queue_zone_write_granularity(q,
>  						queue_logical_block_size(q));
>  	} else {
> -		blk_queue_clear_zone_settings(q);
> +		disk_clear_zone_settings(disk);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(disk_set_zoned);
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c
> index 7fbe395fa51fc..5a97b48102221 100644
> --- a/block/blk-zoned.c
> +++ b/block/blk-zoned.c
> @@ -622,8 +622,10 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
>  }
>  EXPORT_SYMBOL_GPL(blk_revalidate_disk_zones);
>  
> -void blk_queue_clear_zone_settings(struct request_queue *q)
> +void disk_clear_zone_settings(struct gendisk *disk)
>  {
> +	struct request_queue *q = disk->queue;
> +
>  	blk_mq_freeze_queue(q);
>  
>  	blk_queue_free_zone_bitmaps(q);
> diff --git a/block/blk.h b/block/blk.h
> index 58ad50cacd2d5..7482a3a441dd9 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -406,10 +406,10 @@ static inline int blk_iolatency_init(struct request_queue *q) { return 0; }
>  
>  #ifdef CONFIG_BLK_DEV_ZONED
>  void blk_queue_free_zone_bitmaps(struct request_queue *q);
> -void blk_queue_clear_zone_settings(struct request_queue *q);
> +void disk_clear_zone_settings(struct gendisk *disk);
>  #else
>  static inline void blk_queue_free_zone_bitmaps(struct request_queue *q) {}
> -static inline void blk_queue_clear_zone_settings(struct request_queue *q) {}
> +static inline void disk_clear_zone_settings(struct gendisk *disk) {}
>  #endif
>  
>  int blk_alloc_ext_minor(void);


-- 
Damien Le Moal
Western Digital Research

