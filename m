Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19009C3064D
	for <linux-nvme@archiver.kernel.org>; Thu, 27 Jun 2024 06:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MFEWn8EXYOrVrn1ZQHA7jF0U+BXDJNNvCIkWbohEkRU=; b=llTp8lSHz/tuy8gny8S5sNg9yw
	O21/yzG+Fj783/UVaDq0+hWAoRlcjhHbO2kfyo3T7VBgWFEHy14/9Lr1gnJn+HxFEfw/OH0tlnTBm
	Kh+qaIFXAOu7/9CtR1rCXOCauSvDr13itxEHsD5BH3SdyZMF1u3raRQ7elklJpdne59cUsKdfa3ca
	dkj8jm0MJ0fTRPdPGELK8UETEJLs5++uzwp3sptKgmcBFw6bxndm+B+Za9LSJ2FS9qSYkOip2T+za
	qwDCKhPv+Dp4UpLhItgMtnhYkXPcBvhM9IAtVnWt8QerUA4IaL8anzjkgodhaq+bo2GOmGSqkPwUc
	9arxLpDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiQe-00000009MOD-1Hst;
	Thu, 27 Jun 2024 06:16:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMiQb-00000009MNZ-1SgD
	for linux-nvme@lists.infradead.org;
	Thu, 27 Jun 2024 06:16:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA9F968AFE; Thu, 27 Jun 2024 08:16:13 +0200 (CEST)
Date: Thu, 27 Jun 2024 08:16:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: asml.silence@gmail.com, mpatocka@redhat.com, axboe@kernel.dk,
	hch@lst.de, kbusch@kernel.org, martin.petersen@oracle.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH v2 04/10] block: Handle meta bounce buffer correctly in
 case of split
Message-ID: <20240627061613.GB16047@lst.de>
References: <20240626100700.3629-1-anuj20.g@samsung.com> <CGME20240626101518epcas5p17e046bca77b218fc6914ddeb182eb42e@epcas5p1.samsung.com> <20240626100700.3629-5-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626100700.3629-5-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240626_231617_629202_A7B9E1DA 
X-CRM114-Status: GOOD (  12.35  )
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

On Wed, Jun 26, 2024 at 03:36:54PM +0530, Anuj Gupta wrote:
> @@ -105,9 +105,12 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
>  
>  static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
>  {
> +	struct bio *bio = bip->bip_bio;
> +	struct blk_integrity *bi = blk_get_integrity(bio->bi_bdev->bd_disk);
>  	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
>  	struct bio_vec *copy = &bip->bip_vec[1];
> -	size_t bytes = bip->bip_iter.bi_size;
> +	size_t bytes = bio_integrity_bytes(bi,
> +					   bvec_iter_sectors(bip->bio_iter));

Maybe add a well documented helper that calculates the metadata bytes
based on the iter given that this is probably going to become more
common now that we're doing proper cloning?

> -	bip->bip_flags = bip_src->bip_flags & ~BIP_BLOCK_INTEGRITY;
> -
> +	bip->bip_flags = bip_src->bip_flags & ~(BIP_BLOCK_INTEGRITY |
> +						BIP_COPY_USER);

We're probably better off say what flags should be cloned and not
which ones should not.  Preferably with a new #define in bio.h.


