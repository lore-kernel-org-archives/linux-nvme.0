Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A6E2C25B10
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 18:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Eq9hGzdoEOi0XlsIFcKTRfKBzDl1/4F7fb6G8sz6okI=; b=ZxXL5huvt1mF9C64AvhOunlxdR
	XeVE/IQq2TxPpERv4JuC1ytDTNgYxGbdJoUFdmozDf9NTUuruJP4diWWFz1vUX/lX6wZz+ByJ6CdC
	Knq5P+yNdkeRsBVAswC7wXt7xH4o+fn5bz2z8N0fvY62OToVam0SAxLk8thp0TOuq5QwUgf4C2/aR
	1IoS08qYmmdnYdnKT/l0w6V8RIxgJ5xBtqqx6plZmXx7iQoYVPif2wAsyvFR9MsQ/bScApfkSHTkH
	x6xqQ8dNXNiCcledePktYERMkSDDTlPVQoDbWrVlPmbLmZy4vlkLEU2OTuQcl/CGWJZ5pBYvGawLz
	89KK3ytQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5VQV-00000006C4X-0pQ7;
	Fri, 10 May 2024 18:57:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5VQS-00000006C3q-2jv2
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 18:57:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 14AA4CE0B49;
	Fri, 10 May 2024 18:56:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5704C113CC;
	Fri, 10 May 2024 18:56:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715367416;
	bh=ECaDfO5MsNDA5UYbwvN2Kr+iU2d22VaDi3QcHpzAw6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p1sgAvhfSX3ExUtvbZqiIs1cXjbERgdIloprJYf05b33LZLczfOneKbjGOlGE4aBR
	 1ZrZuKJY7NccMR/3QMJbCQfOqvUjWnnbSlL8Pa5mD167VSwUc1d4LoznKVb0g3XqIr
	 Ys47ZyO2teHAB7j1HY3RwsSEDeuw3N5A32JgvEuqQ3c5oNo3ZQFerc+LCav3N/2z8d
	 KgSY3vRTcZwCegUC9+1IaZN5D+t6gaw0W7yHEvA/3cvSDSGY1L5J/WApgBffSY/Gqe
	 xcHXbJIsPbkje5pu1KtTpg+zVDq4KBM+RcvGzw32x49o+d4VXZcaRQ9MvFXFP6hHW7
	 GEtchJ0hZKhAw==
Date: Fri, 10 May 2024 12:56:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, martin.petersen@oracle.com,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] block: unmap and free user mapped integrity via submitter
Message-ID: <Zj5t9TwrT77KGOyr@kbusch-mbp.dhcp.thefacebook.com>
References: <CGME20240510095142epcas5p4fde65328020139931417f83ccedbce90@epcas5p4.samsung.com>
 <20240510094429.2489-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510094429.2489-1-anuj20.g@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_115700_893300_33756617 
X-CRM114-Status: GOOD (  10.76  )
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

On Fri, May 10, 2024 at 03:14:29PM +0530, Anuj Gupta wrote:
> The user mapped intergity is copied back and unpinned by
> bio_integrity_free which is a low-level routine. Do it via the submitter
> rather than doing it in the low-level block layer code, to split the
> submitter side from the consumer side of the bio.

Thanks, this looks pretty good.

>  out_unmap:
> -	if (bio)
> +	if (bio) {
> +		if (bio_integrity(bio))
> +			bio_integrity_unmap_free_user(bio);
>  		blk_rq_unmap_user(bio);
> +	}

Since we're adding more cleanup responsibilities on the caller, and this
pattern is repeated 4 times, I think a little helper function is
warranted: 'nvme_unmap_bio(struct bio *bio)', or something like that.

