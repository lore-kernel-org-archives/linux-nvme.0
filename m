Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54806C04E69
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Jul 2023 07:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a0IV7oU5X6rrGGO6XSfVofpSeXCRWXztXChqXSJhj8Y=; b=1gqpDh5DKFSC4M5mZTJa+bOTEg
	Tz4zQC1ofMVh1DsSLP7bK7LoKM9Y1tJbM7CisvaHZ5vxXm3xsqDErSKEOUakisAYEVnsMnsw7P74v
	Oo0G1A833GoNwCB5iKVPr8MMRzTVV+WjeelWkUPE7S8beWkCHxfbwCFT9Ow7TnHLN5m/mtUv1Gk3q
	divU8zZ8nQPCwCNgKucgaOKBlspwpNn76J0JFoi8DAxYvXshnwA0SY7xcE5vKGK3iHM7p0AVjK3dT
	D3Esf+id7bfL0NvroMAtar/Hfbj/5RwYckAbXUiG/W3J7UozEhH4LVpj3A2UeO0JkDRNvLGtTfbgU
	dz6JEcUg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qMOR7-00AAkR-28;
	Thu, 20 Jul 2023 07:50:57 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qMOR4-00AAjQ-0u
	for linux-nvme@lists.infradead.org;
	Thu, 20 Jul 2023 07:50:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7C7756732D; Thu, 20 Jul 2023 09:50:50 +0200 (CEST)
Date: Thu, 20 Jul 2023 09:50:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
	Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@redhat.com, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, willy@infradead.org, hare@suse.de,
	djwong@kernel.org, bvanassche@acm.org, ming.lei@redhat.com,
	dlemoal@kernel.org, nitheshshetty@gmail.com, gost.dev@samsung.com,
	Vincent Fu <vincent.fu@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v13 3/9] block: add emulation for copy
Message-ID: <20230720075050.GB5042@lst.de>
References: <20230627183629.26571-1-nj.shetty@samsung.com> <CGME20230627184020epcas5p13fdcea52edead5ffa3fae444f923439e@epcas5p1.samsung.com> <20230627183629.26571-4-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627183629.26571-4-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230720_005054_459371_F38393A9 
X-CRM114-Status: GOOD (  21.20  )
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

> +static void *blkdev_copy_alloc_buf(sector_t req_size, sector_t *alloc_size,
> +		gfp_t gfp_mask)
> +{
> +	int min_size = PAGE_SIZE;
> +	void *buf;
> +
> +	while (req_size >= min_size) {
> +		buf = kvmalloc(req_size, gfp_mask);
> +		if (buf) {
> +			*alloc_size = req_size;
> +			return buf;
> +		}
> +		/* retry half the requested size */
> +		req_size >>= 1;
> +	}
> +
> +	return NULL;

Is there any good reason for using vmalloc instead of a bunch
of distcontiguous pages?

> +		ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
> +		if (!ctx)
> +			goto err_ctx;

I'd suspect it would be better to just allocte a single buffer and
only have a single outstanding copy.  That will reduce the bandwith
you can theoretically get, but copies tend to be background operations
anyway.  It will reduce the required memory, and thus the chance for
this operation to fail on a loaded system.  It will also dramatically
reduce the effect on memory managment.

> +		read_bio = bio_map_kern(in, buf, buf_len, gfp_mask);
> +		if (IS_ERR(read_bio))
> +			goto err_read_bio;
> +
> +		write_bio = bio_map_kern(out, buf, buf_len, gfp_mask);
> +		if (IS_ERR(write_bio))
> +			goto err_write_bio;

bio_map_kern is only for passthrough I/Os.  You need to use
a bio_add_page loop here.

> index 336146798e56..f8c80940c7ad 100644
> --- a/include/linux/blk_types.h
> +++ b/include/linux/blk_types.h
> @@ -562,4 +562,9 @@ struct cio {
>  	atomic_t refcount;
>  };
>  
> +struct copy_ctx {
> +	struct cio *cio;
> +	struct work_struct dispatch_work;
> +	struct bio *write_bio;
> +};

This is misnamed as it's only used by the fallback code, and also
should be private to blk-lib.c.


