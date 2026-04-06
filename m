Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35078EF4EA4
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Apr 2026 06:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wZjNM90OxK1bKf31J1TMpT2H4yds1CcGszVY/6ZlN10=; b=RRRQLLkrajOj8J4UUXTNc5LTDh
	oyRA1YDgGskQ23GaeuWSjZ52HYwWoY1iVGsrBK2XyoDGgzX6kotXnaN10Dual/2ZE9TUz48njysir
	PyCX8WYFZTwT7rnsnwxiBfvLZkV0ispDJ1hH0qj/v8MrS9DffK9YrJBtoj/2zRSGx/FBBiDOc1hYm
	Df2BSfVpMDrDJV44H/4/DuKc5KQ+JFScgeOP1L7ccCjqCZ5A88BTymUqVmRpzAcSXykom8RTTFcSB
	xS4eqYb+mYfHWhyeq7oBvwsdVWzxO7KPbWFjTELhGt/EJ82VWNNpwkJy3l5VAaltEnw/XL2poqgvP
	Lfiiw2Sg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9dUG-00000004qU2-2brL;
	Mon, 06 Apr 2026 06:31:04 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w9dUC-00000004qTN-0YZE;
	Mon, 06 Apr 2026 06:31:00 +0000
Date: Sun, 5 Apr 2026 23:31:00 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org
Subject: Re: [PATCH 1/6] blk-integrity: take sector_t in
 bio_integrity_intervals()
Message-ID: <adNTJEkpIj0wQ--X@infradead.org>
References: <20260403194109.2255933-1-csander@purestorage.com>
 <20260403194109.2255933-2-csander@purestorage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260403194109.2255933-2-csander@purestorage.com>
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

>  /**
> - * bio_integrity_intervals - Return number of integrity intervals for a bio
> + * bio_integrity_intervals - Convert sectors to integrity intervals
>   * @bi:		blk_integrity profile for device
> - * @sectors:	Size of the bio in 512-byte sectors
> + * @sectors:	Number of 512-byte sectors
>   *
>   * Description: The block layer calculates everything in 512 byte
>   * sectors but integrity metadata is done in terms of the data integrity
>   * interval size of the storage device.  Convert the block layer sectors
>   * to the appropriate number of integrity intervals.
>   */
> -static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
> -						   unsigned int sectors)
> +static inline u64 bio_integrity_intervals(struct blk_integrity *bi,
> +					  sector_t sectors)

sector_t is a sector number, not a number of sectors.  So if you need a
64-bit value here, it should just be a u64.

>  {
>  	return sectors >> (bi->interval_exp - 9);

If you touch this, maybe also replace 9 with SECTOR_SHIFT?


