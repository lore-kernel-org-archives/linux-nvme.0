Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14DBEDE9A0
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Sep 2024 16:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5Eu7qetuZj8I1bdm27blXGZyRXk+nvJs++YDmKTdOII=; b=DVmsBuHJHkV9Bnn37QeyvMfP6G
	+zwD0N3g3z5DzulTr/aIrsjFhn5nZ/Qzvhn97CKSdYlLFNLMUUXKzkfitoB5ZGETO9T4uiRrsJV4L
	i5hzNWGXBBzuEB31AMnPgYqKIcvqhgzjT1qMqjF0EUcPZK5lre101oc52jBJsqtFlcb9EExpzLsKx
	tehtpr8pVw5BnWGjKaycRKPiedkwwzGQzIlJz4NnKPkvzciawUP5WQbjy1PRI+0f0AEmR8kr1MGTH
	YFFXxWiB686EAGMxG9bo7GTNd1NgQE9czKWS2k6ESB8KfHqdLqYhTgARL+sZMDwRDzIY1ZQKSRooX
	Vlmq4stw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3NZ-00000006HGl-30OR;
	Tue, 10 Sep 2024 16:06:09 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1so3NX-00000006HFe-0Hqv
	for linux-nvme@lists.infradead.org;
	Tue, 10 Sep 2024 16:06:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BE946A43342;
	Tue, 10 Sep 2024 16:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8A4C4CEC4;
	Tue, 10 Sep 2024 16:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725984366;
	bh=4ZbPlr+ijnXw+2VrkoF92h4BvdrZTgVjqAHEdVR1GBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L7NSQc4oJTB+s+nRW2AEwEJN7twPs4bVyJ7Nk8DbfY1y3RoNIpmBgJdaiWOyxjROI
	 TD8maMv+llxmdvkemUTn7MkFTt8TwZuWJlkmB0ibzfTYn8nkApiNL1G4O3ScmUqXiN
	 g2mOz0mdaHR81zKYb6BSNrC4xosV8pG+fgfmWV9eS7baCHAokYsDI/8BB5YP/K4cF6
	 ezRXOV7+/ewVs6Zus2zuBENZFxj3yoJ5wtcPp20JQNmrbqebnaPveeVBuW6wWGJwLa
	 2rIwSF/ggXghG7avXI2CfTg7/2zVLVU8mW/WE+WjALasJAjqy68OrQUzmQCnVfG8Cc
	 vz2eE95QriuOQ==
Date: Tue, 10 Sep 2024 10:06:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
	martin.petersen@oracle.com, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
	sagi@grimberg.me
Subject: Re: [PATCHv3 06/10] blk-integrity: simplify counting segments
Message-ID: <ZuBua91J2X5Yt-72@kbusch-mbp>
References: <20240904152605.4055570-1-kbusch@meta.com>
 <20240904152605.4055570-7-kbusch@meta.com>
 <20240910154105.GF23805@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910154105.GF23805@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240910_090607_261311_945DE6A2 
X-CRM114-Status: GOOD (  25.69  )
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

On Tue, Sep 10, 2024 at 05:41:05PM +0200, Christoph Hellwig wrote:
> On Wed, Sep 04, 2024 at 08:26:01AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The segments are already packed to the queue limits when adding them to
> > the bio,
> 
> I can't really parse this.  I guess this talks about
> bio_integrity_add_page trying to append the payload to the last
> vector when possible?

Exactly. bio_integrity_add_page will use the queue's limits to decide if
it can combine pages into one vector, so appending pages through that
interface will always result in the most compact bip vector.

This patch doesn't combine merged bio's but that's unlikely to have
mergable segments.
 
> > -int blk_rq_count_integrity_sg(struct request_queue *q, struct bio *bio)
> > +int blk_rq_count_integrity_segs(struct bio *bio)
> >  {
> > -	struct bio_vec iv, ivprv = { NULL };
> >  	unsigned int segments = 0;
> > -	unsigned int seg_size = 0;
> > -	struct bvec_iter iter;
> > -	int prev = 0;
> > -
> > -	bio_for_each_integrity_vec(iv, bio, iter) {
> >  
> > -		if (prev) {
> > -			if (!biovec_phys_mergeable(q, &ivprv, &iv))
> > -				goto new_segment;
> > -			if (seg_size + iv.bv_len > queue_max_segment_size(q))
> > -				goto new_segment;
> > -
> > -			seg_size += iv.bv_len;
> > -		} else {
> > -new_segment:
> > -			segments++;
> > -			seg_size = iv.bv_len;
> 
> Q: for the data path the caller submitted bio_vecs can be larger
> than the max segment size, and given that the metadata API tries
> to follow that in general, I'd assume we could also get metadata
> segments larger than the segment size in theory, in which case
> we'd need to split a bvec into multiple segments, similar to what
> bvec_split_segs does.  Do we need similar handling for metadata?
> Or are we going to say that metadata must e.g. always be smaller
> than PAGE_SIZE as max_segment_sizse must be >= PAGE_SIZE?

The common use cases don't add integrity data until after the bio is
already split in __bio_split_to_limits(), and it won't be split again
after integrity is added via bio_integrity_prep(). The common path
always adds integrity in a single segment, so it's always valid.

There are just a few other users that set their own bio integrity before
submitting (the nvme and scsi target drivers), and I think both can
break from possible bio splitting, but I haven't been able to test
those. 
 
> > +	for_each_bio(bio)
> > +		segments += bio->bi_integrity->bip_vcnt;
> 
> If a bio was cloned bip_vcnt isn't the correct value here,
> we'll need to use the iter to count the segments.

Darn. The common use case doesn't have integrity added until just before
it's dispatched, so the integrity cloning doesn't normally happen for
that case.

Let's just drop patches 6 and 7 from consideration for now. They are a
bit too optimistic, and doesn't really fix anything anyway.

