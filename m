Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1850DC2BD09
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 06:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xFbi72mzby7eI0Tphf3eouw76uVFab5Y9OW02/l9/88=; b=RyxeNmmG6dEDwK4yLb4daftw0P
	nbt4JexeCEUFFZflpnk1r08L7MlRMR5mSU9CH1unZMN/AACkwbJRgw0o5DwfetBWSzfmKr3pIhwv2
	2+Ozgq4J6eJ1YYWrHyiTJtL7CsfaLiFSRniSgRCsCA7Rl1w56wfOx5HSo2vi7chsHVKFzM5vrWxG7
	FXacH1qvzek8dBJjzlSvMWFm+I0P6fPMUvnboFRJ11njMS8lZjQHffni8chDkc5vQG70Kpc4WAoli
	jVmWbS50J4M0TRtqjGagyx8VP9I2uE1/c6mp7KoHOuEiFSl0TGHKgha8w4EujkMh9iHaLPKNl/vV4
	ibnbQQsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiW4-00000009N40-0GCj;
	Thu, 27 Jun 2024 06:21:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiVv-00000009N2d-35RV
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 06:21:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 103C168AFE; Thu, 27 Jun 2024 08:21:43 +0200 (CEST)
Date: Thu, 27 Jun 2024 08:21:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v2 05/10] block: introduce BIP_CLONED flag
Message-ID: <20240627062142.GC16047@lst.de>
References: <20240626100700.3629-1-anuj20.g@samsung.com> <CGME20240626101519epcas5p163b0735c1604a228196f0e8c14773005@epcas5p1.samsung.com> <20240626100700.3629-6-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626100700.3629-6-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_232147_950629_72BA746F 
X-CRM114-Status: GOOD (  22.64  )
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

On Wed, Jun 26, 2024 at 03:36:55PM +0530, Anuj Gupta wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> Set the BIP_CLONED flag when bip is cloned.
> Use that flag to ensure that integrity is freed for cloned user bip.
> 
> Note that a bio may have BIO_CLONED flag set but it may still not be
> sharing the integrity vecs.

The design principle of the immutable bio_vecs for the data path
is that BIO_CLONED is just a debug aid and no code should check it.
I'd much prefer to keep that invariant for metadata.

> diff --git a/block/bio-integrity.c b/block/bio-integrity.c
> index 845d4038afb1..8f07c4d0fada 100644
> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -147,7 +147,8 @@ void bio_integrity_free(struct bio *bio)
>  	struct bio_integrity_payload *bip = bio_integrity(bio);
>  	struct bio_set *bs = bio->bi_pool;
>  
> -	if (bip->bip_flags & BIP_INTEGRITY_USER)
> +	if (bip->bip_flags & BIP_INTEGRITY_USER &&
> +	    !(bip->bip_flags & BIP_CLONED))
>  		return;
>  	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
>  		kfree(bvec_virt(bip->bip_vec));

... and the right way to approach this is to clean up the mess
that we have in bio_integrity_free, which probably needs a split up
to deal wit hthe different cases:

 - block layer auto-generated bip_vecs we need it called where it is
   right now, but that side can now unconditionally free the data
   pointed to by the bip_vec
 - for callers that supply PI data themselves, including from user space,
   the caller needs to call __bio_integrity_free and clear
   bi_integrity and REQ_INTEGRITY

this is probably best done by moving the bip_flags checks out of
bio_integrity_free and have bio_integrity_free just do the
unconditional freeing, and have a new helper for
__bio_integrity_endio / bio_integrity_verify_fn to also
free the payload.


