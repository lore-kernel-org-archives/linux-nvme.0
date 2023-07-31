Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0047C001DE
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 13:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvWG4luZ7dlK4iBvObeFJ0vKbtYprEdoeIHxGcL3E70=; b=q7RO3LzYmKd7RBb7bnjKs43Rey
	IoAh5ZdbSmV5y58x/qwhkZNtp4uJ9UHJgqoCF0H1cs1xClBqbXm+FAQ/fcedbgJsP7KHcMWyu6CUY
	W9e0ThwzscWwJwUZMClTMN0ijgNVOGN++jjZ6jPrLAPB/drlP6kUFUzJM8QamhTHb2kEvcuxYy/zb
	MJJ8uzkFp8EfrEhd7SeyOClxwZkkVXeYkurHjsCCWnxAaEdw/V6pkGCXMrZh+hYY4fCEA4AErL/Nv
	qhDcTWI0f89Qmbnp7qxKshqHqtkCIPMjn2AkhaQadzLHNg51t23MNRypiqHbFodDXmYKyZTlFgbBV
	o/eGKxjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTDn-00FqZl-0c;
	Mon, 31 Jul 2023 13:46:03 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
	id 1qQTDm-00FqZR-04;
	Mon, 31 Jul 2023 13:46:02 +0000
Date: Mon, 31 Jul 2023 06:46:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] nvme: zns: limit max_zone_append by max_segments
Message-ID: <ZMe7Gck9MSo8Fn+a@infradead.org>
References: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731114632.1429799-1-shinichiro.kawasaki@wdc.com>
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

On Mon, Jul 31, 2023 at 08:46:32PM +0900, Shin'ichiro Kawasaki wrote:
> To avoid the unexpected BIO split, reflect the max_segments limit to the
> max_zone_append limit. In the worst case, the safe max_zone_append size
> is max_segments multiplied by PAGE_SIZE. Compare it with the
> max_zone_append size obtained from ZNS devices, and set the smaller
> value as the max_zone_append limit.

This is true only for NVMe and a hand full of drivers that
set the virt_boundary.  For others the maximum size is completely
unrelated to the maximum number of segments.

Can you reword the commit log a bit to make that more clear?

> diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
> index ec8557810c21..9ee77626c235 100644
> --- a/drivers/nvme/host/zns.c
> +++ b/drivers/nvme/host/zns.c
> @@ -10,9 +10,11 @@
>  int nvme_revalidate_zones(struct nvme_ns *ns)
>  {
>  	struct request_queue *q = ns->queue;
> +	unsigned int max_sectors = queue_max_segments(q) << PAGE_SECTORS_SHIFT;
>  
>  	blk_queue_chunk_sectors(q, ns->zsze);
> -	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
> +	max_sectors = min(max_sectors, ns->ctrl->max_zone_append);
> +	blk_queue_max_zone_append_sectors(q, max_sectors);

And while this looks correct, it also feels pretty ugly.  Shouldn't a

	blk_queue_max_zone_append_sectors(q,
		queue_max_sectors(q), ns->ctrl->max_zone_append);

do the same thing in a somewhat more obvious way given that max_segments
is already taken into account for the queue_max_sectors calculation?

