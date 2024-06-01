Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11847C25B76
	for <linux-nvme@archiver.kernel.org>; Sat,  1 Jun 2024 06:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6g5Cx5zv2e1ls+0tPMXlNRBn8m31lOIhDM+5wci87cc=; b=quisGCpf8xoQ+VC7xW3FlXV1u8
	aqbRw+ZRU7VqXfO+taDKNkKx7Kk92vs4DsORhJXfMKSEIBktvXSc+AEamEbRFYDcA1XRzK6oL/HUY
	bCCgHW5MJei/tujlbUSDmr/jqzz7E/MV9uodP6FStIzunobmQ/zCI9KkOMJogYVu34DR7WBjhlsO7
	5O2SSF3CtJSIrJqj1kwJh33IrIbzh4HW/bhMmAqpN9alPbuCNj+MsCXRPgoy0ToCJX8iuDhrT5mBo
	7/ZmDp2XPWXo87AFJqXpxDzEkhiv7EN+EzOP/fgJ5f2BDraM3NCE4Fu7atWonEezmpAygSQNCQTXu
	oyTgvlFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDI8I-0000000C52S-36jL;
	Sat, 01 Jun 2024 06:22:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sDI8F-0000000C51v-0x7X
	for linux-nvme@lists.infradead.org;
	Sat, 01 Jun 2024 06:22:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 941C868D1C; Sat,  1 Jun 2024 08:22:19 +0200 (CEST)
Date: Sat, 1 Jun 2024 08:22:19 +0200
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
	gost.dev@samsung.com, Javier Gonz??lez <javier.gonz@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v20 07/12] nvme: add copy offload support
Message-ID: <20240601062219.GB6221@lst.de>
References: <20240520102033.9361-1-nj.shetty@samsung.com> <CGME20240520102940epcas5p2b5f38ceabe94bed3905fb386a0d65ec7@epcas5p2.samsung.com> <20240520102033.9361-8-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520102033.9361-8-nj.shetty@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240531_232223_477942_379EE0F7 
X-CRM114-Status: GOOD (  17.44  )
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

On Mon, May 20, 2024 at 03:50:20PM +0530, Nitesh Shetty wrote:
> +	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
> +		return BLK_STS_IOERR;

This sounds like BLK_COPY_MAX_SEGMENTS is misnamed.  Right now this is
not a max segments, but the exact number of segments required.

>  /*
>   * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
> - * 
> + *

Please submit this whitespace fix separately.

> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 8b1edb46880a..1c5974bb23d5 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -1287,6 +1287,7 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
>  
>  /* maximum copy offload length, this is set to 128MB based on current testing */
>  #define BLK_COPY_MAX_BYTES		(1 << 27)
> +#define BLK_COPY_MAX_SEGMENTS		2

... and this doesn't belong into a NVMe patch.  I'd also expect that
the block layer would verify this before sending of the request to the driver.

> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index 425573202295..5275a0962a02 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h

Note that we've usually kept adding new protocol bits to nvme.h separate
from the implementation in the host or target code.


