Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90421CCD19A
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Nov 2025 08:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2ae9dVXaMyDnd4Kw/4lTGXVV+GojOzw7T+c7SR5U7ak=; b=d1hCXsILj1/LeYz5YKwCTw05wr
	yBW5HiezbislQkPsxHOAQQnopKvspoxpEBdtc7N/jtlJAHZ5YelFVPjR2FWOFZFScI5YPXzNI4WXn
	FdyCvAjWh8EXQwiY4XACnfUxdiZ3lwtUqq5O+ViA99cjvgKZjhzt+AMtiSEf5NbIk6zOf+birms3v
	trsVk2sP9KSA8IZvRjdEKmivUTSJ8RdzCKUMtatzjSrz1YeUOEYNr7wVRwgTJUEQlxvu3GaGpYXfv
	cAcBq+tarc+dKovFNC7HoDTsKIsSY045ewbpdKXSLlRBUn976lMrBfk7GtdlGSgjY0jVxaM4CcAyS
	glfbRStg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLGhb-000000001So-0OyL;
	Tue, 18 Nov 2025 08:04:39 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLGhV-000000001Rl-49qx
	for linux-nvme@lists.infradead.org;
	Tue, 18 Nov 2025 08:04:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4C26167373; Tue, 18 Nov 2025 09:04:27 +0100 (CET)
Date: Tue, 18 Nov 2025 09:04:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Cc: linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
	axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
	mpatocka@redhat.com, song@kernel.org, yukuai3@huawei.com,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com, jaegeuk@kernel.org,
	chao@kernel.org, cem@kernel.org
Subject: Re: [RFC PATCH] block: change __blkdev_issue_discard() return type
 to void
Message-ID: <20251118080427.GA26299@lst.de>
References: <20251118074243.636812-1-ckulkarnilinux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118074243.636812-1-ckulkarnilinux@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_000436_482798_2471D6B0 
X-CRM114-Status: GOOD (  21.30  )
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

On Mon, Nov 17, 2025 at 11:42:43PM -0800, Chaitanya Kulkarni wrote:
> Due to involvement of all the subsystem making it as an RFC, ideally
> it shuoldn't be an RFC.

I think best would be a series that drops error checking first,
and then changes the return type.  That way we can maybe get all
the callers fixed up in this merge window and then drop the return
value after -rc1.
>  			gfp_mask)))
>  		*biop = bio_chain_and_submit(*biop, bio);
> -	return 0;
>  }
>  EXPORT_SYMBOL(__blkdev_issue_discard);
>  
> @@ -90,8 +89,8 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
>  	int ret;
>  
>  	blk_start_plug(&plug);
> -	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);
> -	if (!ret && bio) {
> +	__blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, &bio);

ret now needs to be initialized to 0 above.

> index 8d246b8ca604..f26010c46c33 100644
> --- a/drivers/nvme/target/io-cmd-bdev.c
> +++ b/drivers/nvme/target/io-cmd-bdev.c
> @@ -366,16 +366,11 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
>  		struct nvme_dsm_range *range, struct bio **bio)
>  {
>  	struct nvmet_ns *ns = req->ns;
> -	int ret;
>  
> -	ret = __blkdev_issue_discard(ns->bdev,
> +	__blkdev_issue_discard(ns->bdev,
>  			nvmet_lba_to_sect(ns, range->slba),
>  			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
>  			GFP_KERNEL, bio);
> -	if (ret && ret != -EOPNOTSUPP) {
> -		req->error_slba = le64_to_cpu(range->slba);
> -		return errno_to_nvme_status(req, ret);
> -	}
>  	return NVME_SC_SUCCESS;

nvmet_bdev_discard_range can return void now.

> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b45eace879d7..e6078176f733 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1346,7 +1346,7 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  		if (time_to_inject(sbi, FAULT_DISCARD)) {
>  			err = -EIO;
>  		} else {
> -			err = __blkdev_issue_discard(bdev,
> +			__blkdev_issue_discard(bdev,
>  					SECTOR_FROM_BLOCK(start),
>  					SECTOR_FROM_BLOCK(len),
>  					GFP_NOFS, &bio);

Please fold the following 'if (err)' block directly into the injection
one, and either initialize err to 0, or use a direct return from that
block to skip the last branch in the function checking err.

>  	blk_finish_plug(&plug);
>  
> -	return error;
> +	return 0;

Please drop the error return for xfs_discard_extents entirely.


