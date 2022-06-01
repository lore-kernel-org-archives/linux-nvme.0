Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C10C2C433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jun 2022 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XzRbUF1jnfDbE/Fe5fI3N5pqvOV993doGpweYp7JP/k=; b=Aztii2q/KVSCDOARTqFeQDCPkG
	/7WG+rcN5u6OvXlLYl3JO30K1dmFGYYwJ002TYyA/n6kl3DJ9RSmbHDtlF1TqdRV0LstKCVvxF0O1
	4NZQMTFmFXzNvHK3iZ3Gk5giWquJ9whkVieTC9/fvlYUaLtVM27EtDJCXgX4Z1sI5QyyJG26dVArq
	5qcm6EP8PnwUgoep/IkD7lEpktv6QXlGmEMtVVtUF5XFvS+BX5C+gvghvzZPYh3YQtaFGI5lMd1m2
	3oEZrbLYtP7KEGy53yBmq+ea0LOu9ZLzbPECntnYqj17uR+lW8l2FrnCEd/8MmEo7TzalJVfw4jR2
	O+A0o1gQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwIPG-00EJZc-EK; Wed, 01 Jun 2022 07:04:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nwIPE-00EJYJ-DK
	for linux-nvme@lists.infradead.org; Wed, 01 Jun 2022 07:04:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C00D661325;
	Wed,  1 Jun 2022 07:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C864AC385B8;
	Wed,  1 Jun 2022 07:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654067075;
	bh=BfAsk3P+5WEVQwfCV3N2UzTi5iZs95agLnGWAp6Lvso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kd2/kzakSesSChevVq3SafU+B04oNWyNUh1UNpOrbH7SWTxzlN+lyP5MwKhBb+/p6
	 z+XD701W2xtoWCv+4MKqii1IMzIC9q9aoAPbkGjpWG23RDOoVfrgW51I4COCJSJqkS
	 2JfuMLXtYG61hSXg7PRzPfm+MsjOHihY3CNdIVU6LgGU4R2QThf6oqgmZWKe5byGwy
	 FKsmV7YBe+MnVv6Uz180jU7SpA1CFJELS8CVnfvahvArK326gv6mIFrNm7uSZlfoJm
	 F8eBtcGPPB7nXqLhakeeVsKy64boFtnRdrRSx2yo61puc92G54MKbHev29X+OrAF1j
	 ZZt3SnV4WffEQ==
Date: Wed, 1 Jun 2022 00:04:25 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@fb.com>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Kernel Team <Kernel-team@fb.com>, hch@lst.de, bvanassche@acm.org,
	damien.lemoal@opensource.wdc.com, pankydev8@gmail.com,
	Keith Busch <kbusch@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv5 07/11] block/bounce: count bytes instead of sectors
Message-ID: <YpcPecSPRG6kkydy@sol.localdomain>
References: <20220531191137.2291467-1-kbusch@fb.com>
 <20220531191137.2291467-8-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531191137.2291467-8-kbusch@fb.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220601_000436_530178_11B1893B 
X-CRM114-Status: GOOD (  20.30  )
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

On Tue, May 31, 2022 at 12:11:33PM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Individual bv_len's may not be a sector size.
> 
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> v4->v5:
> 
>   Updated comment (Christoph)
> 
>  block/bounce.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bounce.c b/block/bounce.c
> index 8f7b6fe3b4db..fbadf179601f 100644
> --- a/block/bounce.c
> +++ b/block/bounce.c
> @@ -205,19 +205,26 @@ void __blk_queue_bounce(struct request_queue *q, struct bio **bio_orig)
>  	int rw = bio_data_dir(*bio_orig);
>  	struct bio_vec *to, from;
>  	struct bvec_iter iter;
> -	unsigned i = 0;
> +	unsigned i = 0, bytes = 0;
>  	bool bounce = false;
> -	int sectors = 0;
> +	int sectors;
>  
>  	bio_for_each_segment(from, *bio_orig, iter) {
>  		if (i++ < BIO_MAX_VECS)
> -			sectors += from.bv_len >> 9;
> +			bytes += from.bv_len;
>  		if (PageHighMem(from.bv_page))
>  			bounce = true;
>  	}
>  	if (!bounce)
>  		return;
>  
> +	/*
> +	 * Individual bvecs may not be logical block aligned. Round down
> +	 * the split size so that each bio is properly sector size aligned,
> +	 * even if we do not use the full hardware limits.
> +	 */

Please write "might not" instead of "may not", since "may not" is ambiguous; it
sometimes means "are not allowed to".  Likewise in other patches.

"Sector size" is ambiguous as well.  I think you mean "logical block size"?

- Eric

