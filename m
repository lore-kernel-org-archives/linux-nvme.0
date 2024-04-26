Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857E9C4345F
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Apr 2024 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pqa0NzFoeApFAzyne0cdkXHVpCVWc4/zSi9vzjdu9t0=; b=Fzhq323g2Ou02d9T5HuAr43vBi
	ZHxO6cTPT0YMQkBzve7SLgFfOHbdkb39B5ItC3STpZ/iC2700Ri5izZATDpQXhTTOU3FLKb8VtDCr
	ImZVjT5vyHVvEfA8RVsKXE1hhvMiEcozN4FYggPCUuOb/Q+3vUZnYtxRIO6UwbzhhG9WNiD1NqBGx
	Hn+Ab74Y7BEjCj65IAEvEGg2A4DIw3F0GmLAYMP1WZeoQCLdRVaMQxQPqCSnozabr9BHMuLnOt86e
	ki44pH8/kfOgwBk++Mnk1Mofpsh+J/gI+aEq7Xrg0TNInDEvfW8lz5cxke1KRKKRCq1hrFGWVZEdS
	WoOjqWnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0NOg-0000000D0lR-1abE;
	Fri, 26 Apr 2024 15:21:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0NOT-0000000D0jt-21P2
	for linux-nvme@lists.infradead.org;
	Fri, 26 Apr 2024 15:21:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BAC2C620A8;
	Fri, 26 Apr 2024 15:21:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E2DC113CD;
	Fri, 26 Apr 2024 15:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714144904;
	bh=xPK28Iox1vdryqRd/xtRp+PiKJObrHW3XTZr3b861Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WIep1t4uVRkLM3U/+qJKwPwYMz6vBbHFexic/usbb6GBGMhrkyhUJgI64pY5KQdp4
	 Wl23tcLgMMBYY6dW4FXrNEdwYpjAdfxmAbbhE3ARedOiEjTT9LGyL4ZBOeBmOmX7is
	 gtKhr27omT1mnCXobOrXiHLRNo5Skg6FhofdvbngpC2NciWYBhnJJZQwQcmOYUyubk
	 lh8yPc8ffDTgZSFkPzmz2CiMnvNxng9ZbY/FrO+HC5xPE7sJBIFjIRenB8/i70zZQd
	 H4M1SGdWuNqUH1loHQpKIru4p2yt8F7V2Le21FC/7XhfK+HnclLpxnmHxIsMb+C1va
	 W1VAOLo96APyw==
Date: Fri, 26 Apr 2024 09:21:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, hch@lst.de,
	brauner@kernel.org, asml.silence@gmail.com, dw@davidwei.uk,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 09/10] block: add support to send meta buffer
Message-ID: <ZivGhB0rGwBb8Eic@kbusch-mbp.dhcp.thefacebook.com>
References: <20240425183943.6319-1-joshi.k@samsung.com>
 <CGME20240425184708epcas5p4f1d95cd8d285614f712868d205a23115@epcas5p4.samsung.com>
 <20240425183943.6319-10-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-10-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240426_082145_584079_D721EA7D 
X-CRM114-Status: GOOD (  10.75  )
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

On Fri, Apr 26, 2024 at 12:09:42AM +0530, Kanchan Joshi wrote:
> diff --git a/block/fops.c b/block/fops.c
> index 679d9b752fe8..e488fa66dd60 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -353,6 +353,15 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
>  		task_io_account_write(bio->bi_iter.bi_size);
>  	}
>  
> +	if (unlikely(iocb->ki_flags & IOCB_USE_META)) {
> +		ret = bio_integrity_map_iter(bio, iocb->private);
> +		WRITE_ONCE(iocb->private, NULL);
> +		if (unlikely(ret)) {
> +			bio_put(bio);
> +			return ret;
> +		}
> +	}

Should this also be done for __blkdev_direct_IO and
__blkdev_direct_IO_simple?

