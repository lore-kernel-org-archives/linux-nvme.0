Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C1AD10373
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qt1MZpNKWoqgVDxQoUbhRRb+/kXBWmuaotwFheQ1vHc=; b=vhIxQdKYyveqrR9vRsGnx1uBME
	6iZZ4+5r6z2yM3BruK9ZN3G+i7/dIUFTSu4geZEKVqa9I6RTC3/Nq+maoe5V+6tk+HU1Xguj/Kfwz
	04xWdn7/Pc59DImQUCE2gyazI/r65XgNq06DgVr8NbbTuG00t2nU/kwcZdSFizRKXWoxgnJrvx1T7
	I424Zp05qyaGvGb0P0dSe+f3Vp8QN16nvlfvRBv7B27GW1bgVN9ggfbsWv6grfy8Nfg+deaWLEvqX
	o11cK68/OhRT40n5GIBkcHL1/YQwnUTIQpalgQwMKMUxoaBYULredk+JeyxuAnrsRhX10rzyFMcHo
	vs5QhP6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO5PE-0000000EFrR-0I0P;
	Wed, 26 Nov 2025 02:37:20 +0000
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO5PB-0000000EFr6-3NUL
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:37:18 +0000
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-7a435a3fc57so6493171b3a.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764124637; x=1764729437; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qt1MZpNKWoqgVDxQoUbhRRb+/kXBWmuaotwFheQ1vHc=;
        b=mXK2VeG5pAimhDlfETIuxFRvNW8tQ3bRkbpfvrrHHwQIO5xtyvjOFIiOw/w3h32aXx
         sSH3v0KimEGfmSMwxMSkMTbJLoLNm5ktx1+r2rEPvbRRYYtRMG65/9eVbrShreTdBnpF
         q96iZjFnyga/K6cz55/zmKwB+g3TmEcniSbSrTNVJCqCzCJFgjbQgTm4fEWHEwNWJvx3
         671alKBDQ8Voa4Cl8Ne8L1NfY+bwgsLRlppLzT5Gwfb8qGNd0Ya+Z5W23h3vN/Jc4//Q
         8fXRa0dm+7a9d9FWpLhRtECI2bdchu4yVd1YajzE3ErAD+Ak2usgd8bk5YzoWxbWd67B
         2Jkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764124637; x=1764729437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qt1MZpNKWoqgVDxQoUbhRRb+/kXBWmuaotwFheQ1vHc=;
        b=SneWCFodwdb2naZuNbp8RDAVZjSpaC+3Kz5n3cEOQoretL8gEWSo27Boi2YyQmw2eV
         I+upfNzUJKQpSNFx5AzaDZ6ML/3f4UTVbGzuHrPeirsac1xWQHgF7WhwKeyG8n8eTSs1
         sD/GrlFwXpgd7HEjYMziFVxk61m3yUukJOwiaizBx+co0QlTWqLmVOCiwW8cAKOcUWPg
         LI2JyBHGsXIQGnzCfYduPtYkOWP5ReVht3FgnzD6Dxc15+tGt3pvouzHcNatypudwpGx
         xe7jBo5pbsRNbHSDQ/mUmMFcd8+BW4Uapd0JB/r7nc0J15tEcpTsG53PgbQu0fOpsBVl
         MkGg==
X-Forwarded-Encrypted: i=1; AJvYcCXwPZHkJNWxy6icSkdrLdpCxTeHU5z83zMr74AkeRMnQD0F0a8mNixC40vV/ay9t/eOAXpfME2abM3s@lists.infradead.org
X-Gm-Message-State: AOJu0YwEX8GZ7NriivWDLY2plQKPWDuk65j0pcCcgwnAHiuxMMrgTz6Q
	mxqGdRF6XkEMMxmjC1PzfmkzE4wu4h9r5UKf8bj/2ewc59GXhs2jnVYp
X-Gm-Gg: ASbGncsFlrSzJQ1DNGb88nofpJ5n8HKUwpQ+Nc3rE72jptUZuF8lBf1hMEdugmkR4LN
	jjBRnjaG4gMDAZwJwD9FMXO4GT/PO/7WSTSBWnryLmuN3QSyT7moaZ1B3tv4LFJbw7XLvOIDffN
	PURaM/IGuQ6BSPAdR8enlCWKNZoGBF0KHFUAVPBvuceFwfz6YzKxQmKKiiqUOewVGmM6PGOfAqK
	rHIQU9rkrfR/rBYkaGrv/Ev3rFyLQinymCWJRpMiCz8sRnfUsgIbxWOFQIC3r8EuYz48LBXriuo
	FonCcrCqOD9AdZtNId1YLfdb2FssfvW97YoF5cpwyE4kLO/tfNM6eaT+a6RgR8sfK8VzLSxir07
	bYeVh6L59HlffvSrllLQKV+XMSXsdB25TPlZyAsK9z559XP9LEOtCaUfvdwLRUiUp3AcXi0VWek
	1CKWjyKgjllHuVizMU+RfYy+g3rkMsmg==
X-Google-Smtp-Source: AGHT+IFMPVdPASuME6boYfK9CSm7iGISD/qVZKhPKWlRPsY/Zck4GXkccO8MN1rBK0lovp98a7V31w==
X-Received: by 2002:a05:6a00:3906:b0:77f:efd:829b with SMTP id d2e1a72fcca58-7c58e602dcdmr17676868b3a.22.1764124636518;
        Tue, 25 Nov 2025 18:37:16 -0800 (PST)
Received: from [10.189.138.37] ([43.224.245.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f1262364sm19518773b3a.58.2025.11.25.18.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Nov 2025 18:37:16 -0800 (PST)
Message-ID: <b18c489f-d6ee-4986-94be-a9aade7d3a47@gmail.com>
Date: Wed, 26 Nov 2025 10:37:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [f2fs-dev] [PATCH V3 6/6] xfs: ignore discard return value
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, axboe@kernel.dk,
 agk@redhat.com, snitzer@kernel.org, mpatocka@redhat.com, song@kernel.org,
 yukuai@fnnas.com, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
 jaegeuk@kernel.org, chao@kernel.org, cem@kernel.org
Cc: dm-devel@lists.linux.dev, linux-raid@vger.kernel.org,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 bpf@vger.kernel.org, linux-xfs@vger.kernel.org,
 Yongpeng Yang <yangyongpeng@xiaomi.com>
References: <20251124234806.75216-1-ckulkarnilinux@gmail.com>
 <20251124234806.75216-7-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
In-Reply-To: <20251124234806.75216-7-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_183717_856385_6930E5F4 
X-CRM114-Status: GOOD (  21.51  )
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
> __blkdev_issue_discard() always returns 0, making all error checking
> in XFS discard functions dead code.
> 
> Change xfs_discard_extents() return type to void, remove error variable,
> error checking, and error logging for the __blkdev_issue_discard() call
> in same function.
> 
> Update xfs_trim_perag_extents() and xfs_trim_rtgroup_extents() to
> ignore the xfs_discard_extents() return value and error checking
> code.
> 
> Update xfs_discard_rtdev_extents() to ignore __blkdev_issue_discard()
> return value and error checking code.
> 
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>   fs/xfs/xfs_discard.c | 27 +++++----------------------
>   fs/xfs/xfs_discard.h |  2 +-
>   2 files changed, 6 insertions(+), 23 deletions(-)
> 
> diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
> index 6917de832191..b6ffe4807a11 100644
> --- a/fs/xfs/xfs_discard.c
> +++ b/fs/xfs/xfs_discard.c
> @@ -108,7 +108,7 @@ xfs_discard_endio(
>    * list. We plug and chain the bios so that we only need a single completion
>    * call to clear all the busy extents once the discards are complete.
>    */
> -int
> +void
>   xfs_discard_extents(
>   	struct xfs_mount	*mp,
>   	struct xfs_busy_extents	*extents)
> @@ -116,7 +116,6 @@ xfs_discard_extents(
>   	struct xfs_extent_busy	*busyp;
>   	struct bio		*bio = NULL;
>   	struct blk_plug		plug;
> -	int			error = 0;
>   
>   	blk_start_plug(&plug);
>   	list_for_each_entry(busyp, &extents->extent_list, list) {
> @@ -126,18 +125,10 @@ xfs_discard_extents(
>   
>   		trace_xfs_discard_extent(xg, busyp->bno, busyp->length);
>   
> -		error = __blkdev_issue_discard(btp->bt_bdev,
> +		__blkdev_issue_discard(btp->bt_bdev,
>   				xfs_gbno_to_daddr(xg, busyp->bno),
>   				XFS_FSB_TO_BB(mp, busyp->length),
>   				GFP_KERNEL, &bio);

If blk_alloc_discard_bio() fails to allocate a bio inside
__blkdev_issue_discard(), this may lead to an invalid loop in
list_for_each_entry{}. Instead of using __blkdev_issue_discard(), how
about allocate and submit the discard bios explicitly in
list_for_each_entry{}?

Yongpeng,

> -		if (error && error != -EOPNOTSUPP) {
> -			xfs_info(mp,
> -	 "discard failed for extent [0x%llx,%u], error %d",
> -				 (unsigned long long)busyp->bno,
> -				 busyp->length,
> -				 error);
> -			break;
> -		}
>   	}
>   
>   	if (bio) {
> @@ -148,8 +139,6 @@ xfs_discard_extents(
>   		xfs_discard_endio_work(&extents->endio_work);
>   	}
>   	blk_finish_plug(&plug);
> -
> -	return error;
>   }
>   
>   /*
> @@ -385,9 +374,7 @@ xfs_trim_perag_extents(
>   		 * list  after this function call, as it may have been freed by
>   		 * the time control returns to us.
>   		 */
> -		error = xfs_discard_extents(pag_mount(pag), extents);
> -		if (error)
> -			break;
> +		xfs_discard_extents(pag_mount(pag), extents);
>   
>   		if (xfs_trim_should_stop())
>   			break;
> @@ -496,12 +483,10 @@ xfs_discard_rtdev_extents(
>   
>   		trace_xfs_discard_rtextent(mp, busyp->bno, busyp->length);
>   
> -		error = __blkdev_issue_discard(bdev,
> +		__blkdev_issue_discard(bdev,
>   				xfs_rtb_to_daddr(mp, busyp->bno),
>   				XFS_FSB_TO_BB(mp, busyp->length),
>   				GFP_NOFS, &bio);
> -		if (error)
> -			break;
>   	}
>   	xfs_discard_free_rtdev_extents(tr);
>   
> @@ -741,9 +726,7 @@ xfs_trim_rtgroup_extents(
>   		 * list  after this function call, as it may have been freed by
>   		 * the time control returns to us.
>   		 */
> -		error = xfs_discard_extents(rtg_mount(rtg), tr.extents);
> -		if (error)
> -			break;
> +		xfs_discard_extents(rtg_mount(rtg), tr.extents);
>   
>   		low = tr.restart_rtx;
>   	} while (!xfs_trim_should_stop() && low <= high);
> diff --git a/fs/xfs/xfs_discard.h b/fs/xfs/xfs_discard.h
> index 2b1a85223a56..8c5cc4af6a07 100644
> --- a/fs/xfs/xfs_discard.h
> +++ b/fs/xfs/xfs_discard.h
> @@ -6,7 +6,7 @@ struct fstrim_range;
>   struct xfs_mount;
>   struct xfs_busy_extents;
>   
> -int xfs_discard_extents(struct xfs_mount *mp, struct xfs_busy_extents *busy);
> +void xfs_discard_extents(struct xfs_mount *mp, struct xfs_busy_extents *busy);
>   int xfs_ioc_trim(struct xfs_mount *mp, struct fstrim_range __user *fstrim);
>   
>   #endif /* XFS_DISCARD_H */


