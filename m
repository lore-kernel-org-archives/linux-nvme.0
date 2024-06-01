Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC17C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 06:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EQuicQSLamDh1HGStdR683oi7ookXZdfWjJggp3b3/0=; b=AdDEHLvV0uFLoAVAuSPNxP59mB
	Ck1d/qzsLR+MxhcTb+LoRY3ptDqVonV9kT7xZsoxAx/sz//cXWfZ4zXC9B2qy1hARC3kCqv2/GV0m
	HUBId6shMdMd2rGU544hbSs6gJHARDze9b6CMWewt7+2Ros/Tz+0lDg8nonpD3S/P2I2EV4WSbzhS
	9Yu8ErtoZUE9OaCGvG5GScAcU2pEbAc8rAx17egLtI8ZeiqHsUctfwndaO7xH8dddwPMo7BqZ4Qu/
	2Ma5hyJmpWd/wsDd52FLMpB5k3SDK9AoaNofz1FHlieGpSQSavOoW0NRPoK+jvC3y9HUOOM+aA1eh
	zbBNhYPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDI4l-0000000C4XB-3CtE;
	Sat, 01 Jun 2024 06:18:47 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDI4h-0000000C4Wj-3lar
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 06:18:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C5AF668D17; Sat,  1 Jun 2024 08:18:39 +0200 (CEST)
Date: Sat, 1 Jun 2024 08:18:39 +0200
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
	gost.dev@samsung.com, Vincent Fu <vincent.fu@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 04/12] block: add emulation for copy
Message-ID: <20240601061839.GA6221@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102906epcas5p15b5a0b3c8edd0bf3073030a792a328bb@epcas5p1.samsung.com> <20240520102033.9361-5-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-5-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_231844_109325_309D3877 
X-CRM114-Status: GOOD (  19.28  )
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

On Mon, May 20, 2024 at 03:50:17PM +0530, Nitesh Shetty wrote:
> For the devices which does not support copy, copy emulation is added.
> It is required for in-kernel users like fabrics, where file descriptor is
> not available and hence they can't use copy_file_range.
> Copy-emulation is implemented by reading from source into memory and
> writing to the corresponding destination.
> At present in kernel user of emulation is fabrics.

I still don't see the point of offering this in the block layer,
at least in this form.  Caller usually can pre-allocate a buffer
if they need regular copies instead of doing constant allocation
and freeing which puts a lot of stress on the page allocator.

> +static void *blkdev_copy_alloc_buf(ssize_t req_size, ssize_t *alloc_size,
> +				   gfp_t gfp)
> +{
> +	int min_size = PAGE_SIZE;
> +	char *buf;
> +
> +	while (req_size >= min_size) {
> +		buf = kvmalloc(req_size, gfp);
> +		if (buf) {
> +			*alloc_size = req_size;
> +			return buf;
> +		}
> +		req_size >>= 1;
> +	}
> +
> +	return NULL;

And requiring a kernel mapping for data is is never used through the
kernel mapping is pretty silly as well.


