Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 348E5C54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 16:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8fYeddrDha2PXTESHh73+YQejGkfHJ8iUzXWluxSjyw=; b=IOj8T8R4eWljr1eUjewzhwkY1G
	5owq0qBVnZmKi8LTdarLSbNbejZHAq/HoF3Aajfy+9AQcq7IL/tuFv+lDDO21ah326g6boDXVAYSE
	jdG1YdqIzGWtVZEtUmp+cuZqdpf65T7Ci9Xy+OlpTGg02MJ3sW9mN9jDMwSrQDKIINAdh/ihGU1rb
	RLs1Gf1M5gZHtWZoadBvA3esb6hg2gPdNPuaU/WCbDdQ7fx/Qcb06Dg+xZ9gSixdzzhGB94tsTn+y
	PXyIzGbVoUMf8iVlIv3KQVvIcRimhcTMgWMyL/iPHhASeIvXjf/51B885+twu+7uosg+/ZJGVxwBJ
	4ksk9YoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGMo-00000005Rah-3HgF;
	Thu, 07 Mar 2024 16:13:10 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riGMm-00000005RaA-0F5N
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 16:13:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 8EE43CE2504;
	Thu,  7 Mar 2024 16:13:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E22CC433F1;
	Thu,  7 Mar 2024 16:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709827984;
	bh=xC1nCyIdKfL4m5uxzrpTcUTAtu9QopfH5IwbC6GR/Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hvRGLSAaI+Dj1v8Ns8E2YMT/aIg2qkVtfF41SYs2ai/Lb+l4FNRN9zdrwfKA2fP+a
	 JIMn/Zw4oX9/RtaPWJ6LCgN/u5/D0Usfs1Jeo78MwSebqSqIFbFmqaUWUEGJogQM10
	 4ZGQLEJbtcWbaQ5sIM7jvdSYQr/M+TZmlXG5Kh4Zlt7agYYkpajiGg7PcgJfs+pKTA
	 +DqlSsogpGznDgdfoTVj8kEzUNOJpiRVwSrEin//Pn52BowxeD7IcRCO1Bwd8XV+qO
	 6C8xCwPl68C5746bJ0zNfF1Rzn2MnJqR9kawwW0PczkzAAMAVIsRLaMDBTliLIvWM4
	 1PQ2Or2UF3N8g==
Date: Thu, 7 Mar 2024 09:13:01 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 06/10] ext4: switch to using blk_next_discard_bio directly
Message-ID: <ZennjRhWR2PVtoGU@kbusch-mbp>
References: <20240307151157.466013-1-hch@lst.de>
 <20240307151157.466013-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307151157.466013-7-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_081308_372608_44D95868 
X-CRM114-Status: GOOD (  11.83  )
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

On Thu, Mar 07, 2024 at 08:11:53AM -0700, Christoph Hellwig wrote:
> @@ -3840,12 +3840,16 @@ static inline int ext4_issue_discard(struct super_block *sb,
>  	trace_ext4_discard_blocks(sb,
>  			(unsigned long long) discard_block, count);
>  	if (biop) {

Does this 'if' case even need to exist? It looks unreachable since there
are only two callers of ext4_issue_discard(), and they both set 'biop'
to NULL. It looks like the last remaining caller using 'biop' was
removed with 55cdd0af2bc5ffc ("ext4: get discard out of jbd2 commit
kthread contex")

> -		return __blkdev_issue_discard(sb->s_bdev,
> -			(sector_t)discard_block << (sb->s_blocksize_bits - 9),
> -			(sector_t)count << (sb->s_blocksize_bits - 9),
> -			GFP_NOFS, biop);
> -	} else
> -		return sb_issue_discard(sb, discard_block, count, GFP_NOFS, 0);
> +		unsigned int sshift = (sb->s_blocksize_bits - SECTOR_SHIFT);
> +		sector_t sector = (sector_t)discard_block << sshift;
> +		sector_t nr_sects = (sector_t)count << sshift;
> +
> +		while (blk_next_discard_bio(sb->s_bdev, biop, &sector,
> +				&nr_sects, GFP_NOFS))
> +			;

This pattern is repeated often in this series, so perhaps a helper
function for this common use case.

