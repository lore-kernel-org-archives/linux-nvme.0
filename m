Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E50C04FFE
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 22:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pYqRunH9K+qBKaXoKqrBv713BL75faWgqRnl+hTvRkc=; b=DU61O3BS8kRaV95bXGh8GseAUL
	gjRq2Bag3Sd7JUGnt0E3fF+aOtseVaVvfvWLiwrDGCbZgAGdtpnY2FXgy358biYDbLMmesMPje+Wl
	IilJROqwZuZj+S+kJTQoj4UuMuXpwrlhg+8AbTQ/wAe18z1+gT/rCMWt/z9/NLp2k8FfQkzD7Prtx
	lybE9vdmvrOi3qX/yDZBeYIMGMATove0wMdavBWjOS6jHaZHl11oBeBZOipk9/h/O51DheCP4VqX7
	FAAygOJy0ReqhMc8RQ9/ZTzfat5nPmoNEa7TaqN0x7pzTpWQsLKQPEbz20vrdFhQeXFvJPcgYxzaq
	KaobM6ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vcO-00000008rXI-1MQV;
	Sat, 11 May 2024 22:55:04 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5vcB-00000008rWx-0jL5;
	Sat, 11 May 2024 22:54:51 +0000
Date: Sat, 11 May 2024 15:54:51 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: hare@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 3/5] block/bdev: lift restrictions on supported blocksize
Message-ID: <Zj_3O8QOQ6IRZ9IK@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-4-hare@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510102906.51844-4-hare@kernel.org>
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

On Fri, May 10, 2024 at 12:29:04PM +0200, hare@kernel.org wrote:
> From: Hannes Reinecke <hare@suse.de>
> 
> We now can support blocksizes larger than PAGE_SIZE, so lift
> the restriction.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  block/bdev.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bdev.c b/block/bdev.c
> index b8e32d933a63..d37aa51b99ed 100644
> --- a/block/bdev.c
> +++ b/block/bdev.c
> @@ -146,8 +146,8 @@ static void set_init_blocksize(struct block_device *bdev)
>  
>  int set_blocksize(struct block_device *bdev, int size)
>  {
> -	/* Size must be a power of two, and between 512 and PAGE_SIZE */
> -	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
> +	/* Size must be a power of two, and larger than 512 */
> +	if (size < 512 || !is_power_of_2(size))

That needs to just be replaced with:

1 << (PAGE_SHIFT + MAX_PAGECACHE_ORDER)

We're not magically shooting to the sky all of a sudden. The large folio
world still has a limit. While that's 2 MiB today, yes, we can go higher
later, but even then, we still have a cap.

  Luis

