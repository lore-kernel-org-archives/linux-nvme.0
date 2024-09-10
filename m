Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23B7EDE99F
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Zeq2PesrtbzjTC7JRrfk79PaBINzV2aiypmkWARdXU=; b=1NTAjUc92ITE6hywYXTJyXpBN+
	ytN1YuL/wTjK8P5zNJj4iUFDT0CCXztjw46twUtLWnJOnmmifEu6yo/HDJBOMSkxN26y42K3+0fxB
	9VIcHFCUjANRiQJQ4U+pka54BXTjNO15nfgPH0To64fPe1jQD9jSO0GdTDq9/KgDFBPnW2PCt/wNf
	9q61Vv484QhuzvJOZbY8sP2ktx3UDvRkEoVrqvRGn7RRhfdyb3C0E7sIGZtCpO8KY3dFJ9aRXfJGr
	EiF0fIU2jRXmQpGvnUtZcf7aglgisdpCZrbSRYjQhMlyqbw95hr550xTOiQMfD1odKPkDu4MrR1zy
	hvBv6R8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so36b-00000006DeM-1yTF;
	Tue, 10 Sep 2024 15:48:37 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so2zP-00000006AbQ-08Xa
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 15:41:12 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E429227AAE; Tue, 10 Sep 2024 17:41:06 +0200 (CEST)
Date: Tue, 10 Sep 2024 17:41:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 06/10] blk-integrity: simplify counting segments
Message-ID: <20240910154105.GF23805@lst.de>
References: <20240904152605.4055570-1-kbusch@meta.com> <20240904152605.4055570-7-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240904152605.4055570-7-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_084111_245375_D392514B 
X-CRM114-Status: GOOD (  23.05  )
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

On Wed, Sep 04, 2024 at 08:26:01AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The segments are already packed to the queue limits when adding them to
> the bio,

I can't really parse this.  I guess this talks about
bio_integrity_add_page trying to append the payload to the last
vector when possible?

> -int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
> +int blk_rq_count_integrity_segs(struct bio *bio)
>  {
> -	struct bio_vec iv, ivprv = { NULL };
>  	unsigned int segments = 0;
> -	unsigned int seg_size = 0;
> -	struct bvec_iter iter;
> -	int prev = 0;
> -
> -	bio_for_each_integrity_vec(iv, bio, iter) {
>  
> -		if (prev) {
> -			if (!biovec_phys_mergeable(q, &ivprv, &iv))
> -				goto new_segment;
> -			if (seg_size + iv.bv_len > queue_max_segment_size(q))
> -				goto new_segment;
> -
> -			seg_size += iv.bv_len;
> -		} else {
> -new_segment:
> -			segments++;
> -			seg_size = iv.bv_len;

Q: for the data path the caller submitted bio_vecs can be larger
than the max segment size, and given that the metadata API tries
to follow that in general, I'd assume we could also get metadata
segments larger than the segment size in theory, in which case
we'd need to split a bvec into multiple segments, similar to what
bvec_split_segs does.  Do we need similar handling for metadata?
Or are we going to say that metadata must e.g. always be smaller
than PAGE_SIZE as max_segment_sizse must be >= PAGE_SIZE?

> +	for_each_bio(bio)
> +		segments += bio->bi_integrity->bip_vcnt;

If a bio was cloned bip_vcnt isn't the correct value here,
we'll need to use the iter to count the segments.

>  	bio->bi_next = NULL;
> -	nr_integrity_segs = blk_rq_count_integrity_sg(q, bio);
> +	nr_integrity_segs = blk_rq_count_integrity_segs(bio);
>  	bio->bi_next = next;

And instead of playing the magic with the bio chain here, I'd have
a low-level helper to count the bio segments here.

>  
>  	if (req->nr_integrity_segments + nr_integrity_segs >
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3ed5181c75610..79cc66275f1cd 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2548,7 +2548,7 @@ static void blk_mq_bio_to_request(struct request *rq, struct bio *bio,
>  	blk_rq_bio_prep(rq, bio, nr_segs);
>  #if defined(CONFIG_BLK_DEV_INTEGRITY)
>  	if (bio->bi_opf & REQ_INTEGRITY)
> -		rq->nr_integrity_segments = blk_rq_count_integrity_sg(rq->q, bio);
> +		rq->nr_integrity_segments = blk_rq_count_integrity_segs(bio);

And here I'm actually pretty sure this is always a single bio and not
a chain either.


