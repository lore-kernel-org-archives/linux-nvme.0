Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF0F6C2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 06:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=abyuWLLhH2vmfAInoW4MufjI8udDV/7HiRaYhb1cGIA=; b=c1al8Pd++z8fIXOM+tCTM4Eois
	HSfZP+vVrqVP1R6XfZaLdus02euzfDFPCKaQOoV1LUMWGCRxO7RUT8YRdGPOhselxYQHBwGzW29ZX
	B9FGuue4IrxZBHFNgHW2/ULG48svq4vLZhtBT3wPwcArm093VeVF1PkCqW5d4xsT3UT8zEfbNHIO4
	inMTEeNspA17UiU7Zffb3H09K5pXkYHBBvJjJllGS3GeaZRnkBEKynYNW1Z+Os+tFNzLSZktzeHxw
	VU6KRcK94TsNy7EbjFAOVRtklBBWDsbJ+0mmWy7sT8kzkV8SsshMjZihe/UKJmJ7YcqMXrGiCuLpx
	GcGpGvcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiOW-00000009M9h-1I3m;
	Thu, 27 Jun 2024 06:14:08 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiOT-00000009M9G-08tw
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 06:14:06 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6143968AFE; Thu, 27 Jun 2024 08:14:01 +0200 (CEST)
Date: Thu, 27 Jun 2024 08:14:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 03/10] block: copy bip_max_vcnt vecs instead of
 bip_vcnt during clone
Message-ID: <20240627061401.GA16047@lst.de>
References: <20240626100700.3629-1-anuj20.g@samsung.com> <CGME20240626101516epcas5p19fb40e8231d1832cab3d031672f0109e@epcas5p1.samsung.com> <20240626100700.3629-4-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626100700.3629-4-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_231405_245890_99758E0B 
X-CRM114-Status: GOOD (  13.57  )
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

On Wed, Jun 26, 2024 at 03:36:53PM +0530, Anuj Gupta wrote:
> If bio_integrity_copy_user is used to process the meta buffer, bip_max_vcnt
> is one greater than bip_vcnt.

Why?

> @@ -647,12 +647,12 @@ int bio_integrity_clone(struct bio *bio, struct bio *bio_src,
>  
>  	BUG_ON(bip_src == NULL);
>  
> -	bip = bio_integrity_alloc(bio, gfp_mask, bip_src->bip_vcnt);
> +	bip = bio_integrity_alloc(bio, gfp_mask, bip_src->bip_max_vcnt);
>  	if (IS_ERR(bip))
>  		return PTR_ERR(bip);
>  
>  	memcpy(bip->bip_vec, bip_src->bip_vec,
> -	       bip_src->bip_vcnt * sizeof(struct bio_vec));
> +	       bip_src->bip_max_vcnt * sizeof(struct bio_vec));
>  
>  	bip->bip_vcnt = bip_src->bip_vcnt;
>  	bip->bip_iter = bip_src->bip_iter;

So trying to compare this to how the bio data path is cloned, it seems
like bio_integrity_clone is still copying the bvec array.  With the
concept of the immutable bvecs we've had for years this should not
be required.  That is reuse the actual bio_vecs, and just copy
the iter similar to bio_alloc_clone/__bio_clone.

