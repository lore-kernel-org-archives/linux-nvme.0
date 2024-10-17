Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D24D2F7FA
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Oct 2024 07:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DyRBihzpLS9wDKI1mLC5JhBjkxxC3pBma7R+AbFyrtk=; b=MIn7+u4zgM1fVdHvfu3TCwtO/s
	S1Mc0nWky+SX1eOgMfMC3+149hovdBRuVC06IMNWNKYyom0QTl8jIFHq0TXddIgh5ZSQ6N25CAais
	rl45i1gbIJ+jWMsqinzvjt0N+7rXgPbDKiDXYbhP+N7mzSTz/cKRu18XD1mYlD3CttU2O2keFr8N0
	Y7stFwR0GkRnUmI8LMmcCSZXiHPXvEcGHk41MEV4KPnjKwubdA43X0aHFlj+ESi4ElpxGtJg/l+L9
	o3+ZVWN/cbeE9eI7DUSAYAPzyT9m0A5eiTxyDAj1KOaZKZL7tIsKgH2SPNZNE4ibPBtfp9nrVoXQ2
	eUL91sXQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LKc-0000000E2pP-3pbX;
	Thu, 17 Oct 2024 07:54:02 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t1LKa-0000000E2p3-1lKr
	for linux-nvme@lists.infradead.org;
	Thu, 17 Oct 2024 07:54:01 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 051CF227A87; Thu, 17 Oct 2024 09:53:55 +0200 (CEST)
Date: Thu, 17 Oct 2024 09:53:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
	martin.petersen@oracle.com, asml.silence@gmail.com,
	anuj1072538@gmail.com, krisman@suse.de, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, linux-scsi@vger.kernel.org,
	vishak.g@samsung.com
Subject: Re: [PATCH v4 02/11] block: copy back bounce buffer to user-space
 correctly in case of split
Message-ID: <20241017075354.GA25343@lst.de>
References: <20241016112912.63542-1-anuj20.g@samsung.com> <CGME20241016113736epcas5p3a03665bf0674e68a8f95bbd5f3607357@epcas5p3.samsung.com> <20241016112912.63542-3-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016112912.63542-3-anuj20.g@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241017_005400_630221_1A862535 
X-CRM114-Status: GOOD (  17.91  )
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

On Wed, Oct 16, 2024 at 04:59:03PM +0530, Anuj Gupta wrote:
> Copy back the bounce buffer to user-space in entirety when the parent
> bio completes.

This commit message is a bit sparse..

> --- a/block/bio-integrity.c
> +++ b/block/bio-integrity.c
> @@ -119,8 +119,8 @@ static void bio_integrity_unpin_bvec(struct bio_vec *bv, int nr_vecs,
>  static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
>  {
>  	unsigned short nr_vecs = bip->bip_max_vcnt - 1;
> -	struct bio_vec *copy = &bip->bip_vec[1];
> -	size_t bytes = bip->bip_iter.bi_size;
> +	struct bio_vec *copy = &bip->bip_vec[1], *bvec = &bip->bip_vec[0];
> +	size_t bytes = bvec->bv_len;
>  	struct iov_iter iter;
>  	int ret;

And while trying to understand what this code does I keep getting
confused by what bio_integrity_uncopy_user actually does.

And I think a bit part of that is the "creative" abuse of bip_vec
by the copy-based integrity code, where bip_vec[0] is the vector
passed to the block layer, and the rest contains the user buffer.

Maybe it's just me, but not stashing the user pages in the bvecs
but just stasing away the actual iov_iter would be much preferable
for this code?

Either way, back to the code.  The existing code uses
bip_iter.bi_size for sizing the copy, and that can be modified when
the bio is cloned (or at least by the rules for the bio data) be
modified by the driver.  So yes, switching away from that is
good and the change looks correct.  That being said, even if we
aren't going to fix up the logic as mentioned above instantly,
can we pick better names for the variables?

static void bio_integrity_uncopy_user(struct bio_integrity_payload *bip)
{
 	unsigned short orig_nr_vecs = bip->bip_max_vcnt - 1;
	struct bio_vec *orig_bvecs = &bip->bip_vec[1];
	struct bio_vec *bounce_bvec = &bip->bip_vec[0];
	size_t bytes = boune_bvec->bv_len;
 	struct iov_iter orig_iter;
	int ret;

	iov_iter_bvec(&orig_iter, ITER_DEST, orig_bvecs, orig_nr_vecs, bytes);
	ret = copy_to_iter(bvec_virt(bounce_bvec), bytes, &orig_iter);
	WARN_ON_ONCE(ret != bytes);

	bio_integrity_unpin_bvec(orig_bvecs, orig_nr_vecs, true);
}

?

Also please add a Fixes tag.

