Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14CE8C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 12 May 2022 14:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fapy0UzsV2+71SQNFiB4udMttlhpXoFXgY5ze6Kye/Q=; b=iT48X5S+i6bO3Dlu4cFJxXjDFM
	T+6l0S6sEmtBXIZ9AzGw6pkKLt8uM6vr1vjCYuva80yqB7XebJlXfdsVeVIIOfM5bKLCG7NWA8TqU
	QjR5HeP30aVJQjeKzXmapHV7g7EjM0FGG6+lf6MX29MENuByRMLXsex7RY0nWZpNB9iRzVeyeldGU
	kBZnsAjIrdX6BhbIotBgw0QoJx25/Hm2h7D57VF5UPqzmWCLkyFlTZmr9hFrhwf7rcyl+xQSVDTyI
	oVw7Q6d9YAirHnUBdqXBIcJ0jIts71Ko7NQ6RtJfFNkNfZPQiYptkL88ZVs5yFVubsMJB3KtifRBm
	51XlKDfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1np9Sb-00CF8v-8Z; Thu, 12 May 2022 14:06:33 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1np9SX-00CF6j-CH
 for linux-nvme@lists.infradead.org; Thu, 12 May 2022 14:06:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652364387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fapy0UzsV2+71SQNFiB4udMttlhpXoFXgY5ze6Kye/Q=;
 b=JEcrYAuHkLwfcxgjzy2d7wWlgNUkLaNNDtoihLJHzJO/ilxPrpXQmRjjGEN1LAtyG5txP7
 WJYlqr48Mm17b/I3Rd3venY2ssy06iXGR4JxPbwZzDGzfJEFghOp/BuhFncmUyo52NXsYz
 ymYxvvaFoEc+aTQRzKAKBElfjjxJi9A=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-PtHoMGhoPWWXSmIe7LPpsg-1; Thu, 12 May 2022 10:06:24 -0400
X-MC-Unique: PtHoMGhoPWWXSmIe7LPpsg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7193D3C92FD8;
 Thu, 12 May 2022 14:06:19 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CCFDF5742E1;
 Thu, 12 May 2022 14:06:12 +0000 (UTC)
Date: Thu, 12 May 2022 22:06:07 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 asml.silence@gmail.com, mcgrof@kernel.org, shr@fb.com,
 joshiiitr@gmail.com, gost.dev@samsung.com
Subject: Re: [PATCH v5 2/6] block: wire-up support for passthrough plugging
Message-ID: <Yn0UT8/ymJPy2hBu@T590>
References: <20220511054750.20432-1-joshi.k@samsung.com>
 <CGME20220511055310epcas5p46650f5b6fe963279f686b8f50a98a286@epcas5p4.samsung.com>
 <20220511054750.20432-3-joshi.k@samsung.com>
 <YnyaRB+u1x6nIVp1@T590> <20220512114623.GA11657@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512114623.GA11657@test-zns>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220512_070629_533127_47180E7C 
X-CRM114-Status: GOOD (  33.38  )
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

On Thu, May 12, 2022 at 05:20:47PM +0530, Anuj Gupta wrote:
> On Thu, May 12, 2022 at 01:25:24PM +0800, Ming Lei wrote:
> > Hello,
> > 
> > On Wed, May 11, 2022 at 11:17:46AM +0530, Kanchan Joshi wrote:
> > > From: Jens Axboe <axboe@kernel.dk>
> > > 
> > > Add support for plugging in passthrough path. When plugging is enabled, the
> > > requests are added to a plug instead of getting dispatched to the driver.
> > > And when the plug is finished, the whole batch gets dispatched via
> > > ->queue_rqs which turns out to be more efficient. Otherwise dispatching
> > > used to happen via ->queue_rq, one request at a time.
> > > 
> > > Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  block/blk-mq.c | 73 +++++++++++++++++++++++++++-----------------------
> > >  1 file changed, 39 insertions(+), 34 deletions(-)
> > > 
> > > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > > index 84d749511f55..2cf011b57cf9 100644
> > > --- a/block/blk-mq.c
> > > +++ b/block/blk-mq.c
> > > @@ -2340,6 +2340,40 @@ void __blk_mq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
> > >  	blk_mq_hctx_mark_pending(hctx, ctx);
> > >  }
> > >  
> > > +/*
> > > + * Allow 2x BLK_MAX_REQUEST_COUNT requests on plug queue for multiple
> > > + * queues. This is important for md arrays to benefit from merging
> > > + * requests.
> > > + */
> > > +static inline unsigned short blk_plug_max_rq_count(struct blk_plug *plug)
> > > +{
> > > +	if (plug->multiple_queues)
> > > +		return BLK_MAX_REQUEST_COUNT * 2;
> > > +	return BLK_MAX_REQUEST_COUNT;
> > > +}
> > > +
> > > +static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
> > > +{
> > > +	struct request *last = rq_list_peek(&plug->mq_list);
> > > +
> > > +	if (!plug->rq_count) {
> > > +		trace_block_plug(rq->q);
> > > +	} else if (plug->rq_count >= blk_plug_max_rq_count(plug) ||
> > > +		   (!blk_queue_nomerges(rq->q) &&
> > > +		    blk_rq_bytes(last) >= BLK_PLUG_FLUSH_SIZE)) {
> > > +		blk_mq_flush_plug_list(plug, false);
> > > +		trace_block_plug(rq->q);
> > > +	}
> > > +
> > > +	if (!plug->multiple_queues && last && last->q != rq->q)
> > > +		plug->multiple_queues = true;
> > > +	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
> > > +		plug->has_elevator = true;
> > > +	rq->rq_next = NULL;
> > > +	rq_list_add(&plug->mq_list, rq);
> > > +	plug->rq_count++;
> > > +}
> > > +
> > >  /**
> > >   * blk_mq_request_bypass_insert - Insert a request at dispatch list.
> > >   * @rq: Pointer to request to be inserted.
> > > @@ -2353,7 +2387,12 @@ void blk_mq_request_bypass_insert(struct request *rq, bool at_head,
> > >  				  bool run_queue)
> > >  {
> > >  	struct blk_mq_hw_ctx *hctx = rq->mq_hctx;
> > > +	struct blk_plug *plug = current->plug;
> > >  
> > > +	if (plug) {
> > > +		blk_add_rq_to_plug(plug, rq);
> > > +		return;
> > > +	}
> > 
> > This way may cause nested plugging, and breaks xfstests generic/131.
> > Also may cause io hang since request can't be polled before flushing
> > plug in blk_execute_rq().
> >
> Hi Ming,
> Could you please share your test setup.
> I tried test 131 with xfs and it passed.
> 
> I followed these steps:
> 1) mkfs.xfs -f /dev/nvme0n1
> 2) mount /dev/nvme0n1 /mnt/test
> 3) ./check tests/generic/131

It is triggered when I run xfstests over UBD & xfs:

https://github.com/ming1/linux/tree/my_for-5.18-ubd-devel_v2
https://github.com/ming1/ubdsrv/tree/devel-v2



Thanks,
Ming


