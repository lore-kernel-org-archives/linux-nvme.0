Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09B99C3DA5D
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 21:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3pSWobgjknaihXxsRac6TJ2zUdr0D6Wfwa4XbTMod1w=; b=mxwugoO9+xuyyjxDsPnFMA8Jba
	kufd0Qm9AJ9YcV7o5xsYta4gLmjVWYBm9UMqdDnQ9hNH1D6Kjjj7nMOCK8mn8X1PSZXBxJs7pyO54
	eAMqs5b+cjMc2r+JaFeqXqzk3So/RSBNUKfTvQlbGNflXb2L91L2UrPj4TAY7UD0rPFqx5Xh8x6Zw
	l1GlMCai6rACY7uriNaUIUIw23ZsUExHPZlMBCW6Mdvk2/aQecQuIjRA9H5ZBTd127OVfrMp6RzyC
	A2Tnc+o6esmNorSHG5NET4Z4W4Q1fURIB8TUZE7mnfHDQgnwRoQg+MMBKzQ2AsuiNgmzKeSjlQOhC
	Ec3zt5iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUC0j-0000000EwgG-2NSo;
	Wed, 17 Jul 2024 21:16:29 +0000
Received: from todd.t-8ch.de ([159.69.126.157])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUC0g-0000000EwfU-0GBY
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 21:16:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1721250980;
	bh=DIyKadB4zXLlZJwaQInwG9qHfs495Tc0NTHXpqh9K14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QgTtztGELU+/aFOwNpl5sTMUjyw27GKFo4tsPt+SPmslPvwjYQdQUrCfALLoymkDV
	 i0mtrcnaswUNhfWGCU3vVJ289dTgoBHv/g/NoeghvDmKAxq83yjQ1jHtzGwOVUVjDd
	 wS6Fmt8wcrweWLo1S4/SaR3Y2KGfVM5vDdPbSRsU=
Date: Wed, 17 Jul 2024 23:16:19 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>, 
	Martin Wilck <martin.wilck@suse.com>, Ayush Siddarath <ayush.siddarath@dell.com>
Subject: Re: [PATCH v4] nvme_core: scan namespaces asynchronously
Message-ID: <64ec91e8-4ff2-4c56-a468-c194f803db6b@t-8ch.de>
References: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717185550.22102-1-stuart.w.hayes@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_141626_281947_8B4A36A6 
X-CRM114-Status: GOOD (  15.28  )
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

Hi,

two tiny nitpicks that can probably be fixed during patch application.

On 2024-07-17 13:55:50+0000, Stuart Hayes wrote:
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 782090ce0bc1..dc43146dc03d 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4,6 +4,7 @@
>   * Copyright (c) 2011-2014, Intel Corporation.
>   */
>  
> +#include <linux/async.h>
>  #include <linux/blkdev.h>
>  #include <linux/blk-mq.h>
>  #include <linux/blk-integrity.h>
> @@ -3952,6 +3953,35 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>  	}
>  }
>  
> +/*

Kernel-doc with /** ?

> + * struct async_scan_info - keeps track of controller & NSIDs to scan
> + * @ctrl:	Controller on which namespaces are being scanned
> + * @next_nsid:	Index of next NSID to scan in ns_list
> + * @ns_list:	Pointer to list of NSIDs to scan
> + *
> + * Note: There is a single async_scan_info structure shared by all instances
> + * of nvme_scan_ns_async() scanning a given controller, so the atomic
> + * operations on next_nsid are critical to ensure each instance scans a unique
> + * NSID.
> + */
> +struct async_scan_info {
> +	struct nvme_ctrl *ctrl;
> +	atomic_t next_nsid;
> +	__le32 *ns_list;
> +};
> +
> +static void nvme_scan_ns_async(void *data, async_cookie_t cookie)
> +{
> +	struct async_scan_info *scan_info = data;
> +	int idx;
> +	u32 nsid;
> +
> +	idx = (u32)atomic_fetch_add(1, &scan_info->next_nsid);

atomic_fetch_inc() ?

> +	nsid = le32_to_cpu(scan_info->ns_list[idx]);
> +
> +	nvme_scan_ns(scan_info->ctrl, nsid);
> +}
> +

