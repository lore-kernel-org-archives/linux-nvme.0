Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A608C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 05:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6TOahZ1Ow/XBa1Cm/OddYBbYelxBfg1MBmWBoUYasW0=; b=s0oDf9LDXWGnGoU0BzsZj9RqLf
	+Z14AN4EvAnDQSdp8l8/7tcgCvvRpFXEmW9pYPmB8rvj2+URLlZDMgnyIJZGply1Gc51z+NGl4SpL
	x1/CVp/0wfJiyySHVdFExRTsEOQzpK+cXi0w+kzC4o4Jzx72t15PZwZYwDzXr/HAkgMf0KzguRYsK
	MMHdFFvLlQAIePpYvXMeClD/VGkIPj0yQaVHIDRvQAdguo5n7OZWVjM1UoXcWsn4PU5sZC5Bfzppm
	Ut35HP93Qq0/HYRwehCmbLmuzh9upr3DWLw1bVHjVqlT5t2sE4QraHCbKURoFk1QAhixet8opWSwP
	RTz2/9eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHgM-0000000C1xF-27K4;
	Sat, 01 Jun 2024 05:53:34 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDHgJ-0000000C1w1-16Q4
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 05:53:32 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3643A68D17; Sat,  1 Jun 2024 07:53:23 +0200 (CEST)
Date: Sat, 1 Jun 2024 07:53:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com,
	anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
	gost.dev@samsung.com, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 01/12] block: Introduce queue limits and sysfs for
 copy-offload support
Message-ID: <20240601055323.GB5613@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102830epcas5p27274901f3d0c2738c515709890b1dec4@epcas5p2.samsung.com> <20240520102033.9361-2-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-2-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_225331_664403_54D96C88 
X-CRM114-Status: GOOD (  23.51  )
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

On Mon, May 20, 2024 at 03:50:14PM +0530, Nitesh Shetty wrote:
> Add device limits as sysfs entries,
> 	- copy_max_bytes (RW)
> 	- copy_max_hw_bytes (RO)
> 
> Above limits help to split the copy payload in block layer.
> copy_max_bytes: maximum total length of copy in single payload.
> copy_max_hw_bytes: Reflects the device supported maximum limit.

That's a bit of a weird way to phrase the commit log as the queue_limits
are the main thing (and there are three of them as required for the
scheme to work).  The sysfs attributes really are just an artifact.

> @@ -231,10 +237,11 @@ int blk_set_default_limits(struct queue_limits *lim)
>  {
>  	/*
>  	 * Most defaults are set by capping the bounds in blk_validate_limits,
> -	 * but max_user_discard_sectors is special and needs an explicit
> -	 * initialization to the max value here.
> +	 * but max_user_discard_sectors and max_user_copy_sectors are special
> +	 * and needs an explicit initialization to the max value here.

s/needs/need/

> +/*
> + * blk_queue_max_copy_hw_sectors - set max sectors for a single copy payload
> + * @q:	the request queue for the device
> + * @max_copy_sectors: maximum number of sectors to copy
> + */
> +void blk_queue_max_copy_hw_sectors(struct request_queue *q,
> +				   unsigned int max_copy_sectors)
> +{
> +	struct queue_limits *lim = &q->limits;
> +
> +	if (max_copy_sectors > (BLK_COPY_MAX_BYTES >> SECTOR_SHIFT))
> +		max_copy_sectors = BLK_COPY_MAX_BYTES >> SECTOR_SHIFT;
> +
> +	lim->max_copy_hw_sectors = max_copy_sectors;
> +	lim->max_copy_sectors =
> +		min(max_copy_sectors, lim->max_user_copy_sectors);
> +}
> +EXPORT_SYMBOL_GPL(blk_queue_max_copy_hw_sectors);

Please don't add new blk_queue_* helpers, everything should go through
the atomic queue limits API now.  Also capping the hardware limit
here looks odd.

> +	if (max_copy_bytes & (queue_logical_block_size(q) - 1))
> +		return -EINVAL;

This should probably go into blk_validate_limits and just round down.

Also most block limits are in kb.  Not that I really know why we are
doing that, but is there a good reason to deviate from that scheme?


