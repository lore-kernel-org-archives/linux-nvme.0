Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7907AD1036F
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:Cc:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Sk9uGPysXdIRkaFiFWJcSGc7lTclv5i7BdR3e3rYDN4=; b=iwby3i+oylwiB01RGIcW2ev4+N
	LvU1m4T8My00PV84kYqpDtB1IwidyxoPmuhI0ZeZhyWpDIizAQsv0T9ZZF453kIFM9f4yjdQegSD/
	qRjKomYk3dW5N+pSsXsXAUB1wBJ28htNgkv3qGsuV6ml4dRWURcw/mogPWEqCdDmYxXByaELehPGs
	45ZqsBigE7IJ+RdWSXPj8rJ7R3raWg/OtwQbxyWGnVBRZfHXHiTrFXcK/B5zheszW8AXwIwIz4p1E
	ZXhdnIlWRYR9990+w66tTjN7z7vpO9GYadgZqi9MwOlAwhIjLEQ8rDTJcvrQ+NFJU5ltaerX7+TTv
	tLpd8LBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO5ZJ-0000000EGI1-0frr;
	Wed, 26 Nov 2025 02:47:45 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO5ZH-0000000EGHp-3FGm
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:47:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C473960017;
	Wed, 26 Nov 2025 02:47:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30622C4CEF1;
	Wed, 26 Nov 2025 02:47:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764125262;
	bh=1oNBzvNf2gAnqRUnior1QIt69ZATe3IeVffGuLQOlxw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=D4K8BnfBegX3TznlV3lhq2+xjh9BYEp+0UbR+3lwBOmuZUG9EK+QqAzB+IOe74JYg
	 Ai5MX7dXbkGB196M8hWzezrEbznSDh+eihzkL/4QobubgwlVZPcc20BnKt3l/pr5v3
	 o3NENGCan5q+u8n9+hmbYk3G5UzwFu2kOmhBYYtkcr1n/cMQMGAH68V5lKQh9NjTOO
	 jJx+PTorrzdDGTlHjeSqP5LkmMD+bV9vK3yGO/LXxAf+6HJXKaxNAlI8YZCBAzQ/Cu
	 VPahFm/SBiANIwY5Ue0zwbrgMmjACZSL4KvPf5z/fvM1mcXwZY9QtT+PfIHRjG8se/
	 ifIIBihadXhYg==
Message-ID: <09e48eba-6f00-455a-8299-8b8bb4122c7e@kernel.org>
Date: Wed, 26 Nov 2025 10:47:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev,
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 bpf@vger.kernel.org, "Martin K . Petersen" <martin.petersen@oracle.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH V3 5/6] f2fs: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, cem@kernel.org
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-6-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20251124234806.75216-6-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/25/25 07:48, Chaitanya Kulkarni wrote:
> __blkdev_issue_discard() always returns 0, making the error assignment
> in __submit_discard_cmd() dead code.
> 
> Initialize err to 0 and remove the error assignment from the
> __blkdev_issue_discard() call to err. Move fault injection code into
> already present if branch where err is set to -EIO.
> 
> This preserves the fault injection behavior while removing dead error
> handling.
> 
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>  fs/f2fs/segment.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index b45eace879d7..22b736ec9c51 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1343,15 +1343,9 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  
>  		dc->di.len += len;
>  
> +		err = 0;
>  		if (time_to_inject(sbi, FAULT_DISCARD)) {
>  			err = -EIO;
> -		} else {
> -			err = __blkdev_issue_discard(bdev,
> -					SECTOR_FROM_BLOCK(start),
> -					SECTOR_FROM_BLOCK(len),
> -					GFP_NOFS, &bio);
> -		}
> -		if (err) {
>  			spin_lock_irqsave(&dc->lock, flags);
>  			if (dc->state == D_PARTIAL)
>  				dc->state = D_SUBMIT;
> @@ -1360,6 +1354,8 @@ static int __submit_discard_cmd(struct f2fs_sb_info *sbi,
>  			break;
>  		}
>  
> +		__blkdev_issue_discard(bdev, SECTOR_FROM_BLOCK(start),
> +				SECTOR_FROM_BLOCK(len), GFP_NOFS, &bio);

Oh, wait, bio can be NULL? Then below f2fs_bug_on() will trigger panic or warning.

Thanks,

>  		f2fs_bug_on(sbi, !bio);
>  
>  		/*


