Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17A7C4345F
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Apr 2024 07:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=af4RCBcKrxKkioD9dnse7z5g6CC6X2hny47TaJo+T5g=; b=WjGCwCfJBthlznhO24IWk13Y8Y
	RcXADUyuSPDOLR9YF2HWOLm+ral2mq6fMrLY9ZkHMnOvfVWsg2i8ttL2z2eqINUCUwh1PnQHf+lhO
	qsIB2iewSfr5gIq/ir+BpwtTosdKkZBgkl4mPy5oqyjIqm5A4iYm/E8Uu4hpSC2yObHiqV37YTxBJ
	tcK4uOP1Jo6sijzuj2arRQFJwxF0Kr3CKeF99us41evTR+VxAp1V1iJFw4qQ4X7VGT4Io69zhGTwe
	GC6KqtNT6+Z2eQwD1z4CgpURR+SqnfgRvHumXM+107cSy/pM0gZnjpFTO4b1MR74VmxgnKL1htwsu
	xNzO4Xwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0c7X-0000000F17l-1R8l;
	Sat, 27 Apr 2024 07:05:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s0c7T-0000000F16n-44a6
	for linux-nvme@lists.infradead.org;
	Sat, 27 Apr 2024 07:05:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DC2FC227AA8; Sat, 27 Apr 2024 09:05:08 +0200 (CEST)
Date: Sat, 27 Apr 2024 09:05:08 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, martin.petersen@oracle.com, kbusch@kernel.org,
	hch@lst.de, brauner@kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH 04/10] block: avoid unpinning/freeing the bio_vec
 incase of cloned bio
Message-ID: <20240427070508.GD3873@lst.de>
References: <20240425183943.6319-1-joshi.k@samsung.com> <CGME20240425184658epcas5p2adb6bf01a5c56ffaac3a55ab57afaf8e@epcas5p2.samsung.com> <20240425183943.6319-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425183943.6319-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240427_000512_213288_943002B6 
X-CRM114-Status: GOOD (  15.33  )
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

On Fri, Apr 26, 2024 at 12:09:37AM +0530, Kanchan Joshi wrote:
> From: Anuj Gupta <anuj20.g@samsung.com>
> 
> Do it only once when the parent bio completes.
> 
> Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
> Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
> ---
>  block/bio-integrity.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index b4042414a08f..b698eb77515d 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -119,7 +119,8 @@ static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
>  	ret = copy_to_iter(bvec_virt(&src_bvec), bytes, &iter);
>  	WARN_ON_ONCE(ret != bytes);
>  
> -	bio_integrity_unpin_bvec(copy, nr_vecs, true);
> +	if (!bio_flagged((bip->bip_bio), BIO_CLONED))
> +		bio_integrity_unpin_bvec(copy, nr_vecs, true);
>  }

This feels wrong.  I suspect the problem is that BIP_COPY_USER is
inherited for clone bios while it shouldn't.


