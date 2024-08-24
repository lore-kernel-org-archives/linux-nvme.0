Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FA4C52D6F
	for <linux-nvme@archiver.kernel.org>; Sat, 24 Aug 2024 08:44:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zD7F0UCVQzIQCDnUzzRs/SAY/B+SBPiig9SDHGpcUv0=; b=GpbfdO80qyjJ4eNqMuC3DrTth9
	e9MBcdLt3JSq/0mQXMHytSxpwdxxXJ2Yh6qDz6qfU1KA33+Cx7kq7rRkl8Z7RlcSAWVIvm4KPT3St
	ryBMobKc/kSkaatFJfi3X1dzriGX+2I58cBKoxBMEcCLMqpjgUIs0hIb2madlp1h22Nb3L6gt1Knd
	NTawsf7QwnQFN96BCf62BtZ3o22wxCU/q/Lo4bCE5KxxIUgFXrmE1sA1d11NmHYSkTUzMFtxcgRRt
	Gvw+pD2D2hpQFQn0Myl1gvlyD/BDWDhJZK5LxFHfnJkISzTLDiFukuiBRerrY+G87yIY2JsakAcQ7
	EbKv+8Ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmNx-00000001sJT-29Us;
	Sat, 24 Aug 2024 08:44:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shmNu-00000001sIj-167S
	for linux-nvme@lists.infradead.org;
	Sat, 24 Aug 2024 08:44:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4148A227A87; Sat, 24 Aug 2024 10:44:30 +0200 (CEST)
Date: Sat, 24 Aug 2024 10:44:30 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com, krisman@suse.de,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	linux-scsi@vger.kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH v3 08/10] block: add support to pass user meta buffer
Message-ID: <20240824084430.GG8805@lst.de>
References: <20240823103811.2421-1-anuj20.g@samsung.com> <CGME20240823104634epcas5p4ef1af26cc7146b4e8b7a4a1844ffe476@epcas5p4.samsung.com> <20240823103811.2421-10-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240823103811.2421-10-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240824_014434_526988_294E4476 
X-CRM114-Status: GOOD (  24.44  )
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

On Fri, Aug 23, 2024 at 04:08:09PM +0530, Anuj Gupta wrote:
> From: Kanchan Joshi <joshi.k@samsung.com>
> 
> If iocb contains the meta, extract that and prepare the bip.

If an iocb contains metadata, ...

> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -154,6 +154,9 @@ static void blkdev_bio_end_io(struct bio *bio)
>  		}
>  	}
>  
> +	if (bio_integrity(bio) && (dio->iocb->ki_flags & IOCB_HAS_META))
> +		bio_integrity_unmap_user(bio);

How could bio_integrity() be true here without the iocb flag?

> +		if (!is_sync && unlikely(iocb->ki_flags & IOCB_HAS_META)) {

unlikely is actively harmful here, as the code is likely if you use
the feature..

> +			ret = bio_integrity_map_iter(bio, iocb->private);
> +			if (unlikely(ret)) {
> +				bio_release_pages(bio, false);
> +				bio_clear_flag(bio, BIO_REFFED);
> +				bio_put(bio);
> +				blk_finish_plug(&plug);
> +				return ret;
> +			}

This duplicates the error handling done just above.  Please add a
goto label to de-duplicate it.

> +	if (unlikely(iocb->ki_flags & IOCB_HAS_META)) {
> +		ret = bio_integrity_map_iter(bio, iocb->private);
> +		WRITE_ONCE(iocb->private, NULL);
> +		if (unlikely(ret)) {
> +			bio_put(bio);
> +			return ret;

This probably also wants an out_bio_put label even if the duplication
is minimal so far.

You probably also want a WARN_ON for the iocb meta flag in
__blkdev_direct_IO_simple so that we don't get caught off guard
if someone adds a synchronous path using PI.

> diff --git a/block/t10-pi.c b/block/t10-pi.c
> index e7052a728966..cb7bc4a88380 100644
> --- a/block/t10-pi.c
> +++ b/block/t10-pi.c
> @@ -139,6 +139,8 @@ static void t10_pi_type1_prepare(struct request *rq)
>  		/* Already remapped? */
>  		if (bip->bip_flags & BIP_MAPPED_INTEGRITY)
>  			break;
> +		if (bip->bip_flags & BIP_INTEGRITY_USER)
> +			break;

This is wrong.  When submitting metadata on a partition the ref tag
does need to be remapped.  Please also add a tests that tests submitting
metadata on a partition so that we have a regression test for this.

> +	BIP_INTEGRITY_USER      = 1 << 9, /* Integrity payload is user
> +					   * address
> +					   */

.. and with the above fix this flag should not be needed.

>  };
>  
>  struct bio_integrity_payload {
> @@ -24,6 +27,7 @@ struct bio_integrity_payload {
>  	unsigned short		bip_vcnt;	/* # of integrity bio_vecs */
>  	unsigned short		bip_max_vcnt;	/* integrity bio_vec slots */
>  	unsigned short		bip_flags;	/* control flags */
> +	u16			app_tag;

Please document the field even if it seems obvious.


