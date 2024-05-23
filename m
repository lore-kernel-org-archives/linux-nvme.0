Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF5DC25B75
	for <linux-nvme@archiver.kernel.org>; Thu, 23 May 2024 15:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rlprbK58nwyOmwVZuXr7wxf2tJsNU+Mc3YyYZDX1w9A=; b=ouTPx7KxRtwPaHnGwd/lzab/7E
	rNJLyiubB0Pvk5j8MGAYq3EIi+yqa/+TTf68fERmjh6gG+9P0KUhwR+NkIHvReqdq89DuGosyT1C6
	odU37AIleSWZwwtPMu2pttuQnqANlSi2RTH7EhVe5LwACGUSzjmAoR7/AUIMvqyylar3DVsHymtmP
	aPQKBv3DATRs7rGuLiHNNzGODDgrrzIpoxdbceuCfYMtMLU/uMqTyRqfLv5pSWZ3oJPIX7bDK8FZ5
	emP+Oliod49Eq+9Srr217ZBf6XU7HC3jm+U4hFOd7cDKJurP2hYYP2/Qd9msCN+QKTWLhZ7FTox5Y
	p0AZKSfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAA6H-00000006bw0-0MfJ;
	Thu, 23 May 2024 15:11:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sAA6E-00000006bvC-0Jn7
	for linux-nvme@lists.infradead.org;
	Thu, 23 May 2024 15:11:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716477081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rlprbK58nwyOmwVZuXr7wxf2tJsNU+Mc3YyYZDX1w9A=;
	b=T2nHpH7QXDNBegCthEMyWvfXVQKnAE72tB5bPdhIqK6YSi/w4NTnTQMXjr/Bb9as3P/9i6
	ddzKH94k8LEFwsxutP2hXsppq3QSXnsyJSSQjhQ84NtzRA3mIl7FFMFRpmf+TO6S56pc3E
	Et7yg6mBMwg+l5Mg58ZChax/yt6rOI8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-tdPq2P7SNYqQ3h5KviEWVw-1; Thu,
 23 May 2024 11:11:17 -0400
X-MC-Unique: tdPq2P7SNYqQ3h5KviEWVw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0B757380212E;
	Thu, 23 May 2024 15:11:17 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown [10.11.5.21])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 037DD401405;
	Thu, 23 May 2024 15:11:17 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix, from userid 12668)
	id E2FF630C1C33; Thu, 23 May 2024 15:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id DFC1D3FB4F;
	Thu, 23 May 2024 17:11:16 +0200 (CEST)
Date: Thu, 23 May 2024 17:11:16 +0200 (CEST)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
    Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@kernel.org>, 
    Milan Broz <gmazyland@gmail.com>, linux-block@vger.kernel.org, 
    dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v2] block: change rq_integrity_vec to respect the
 iterator
In-Reply-To: <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
Message-ID: <798720bc-bc69-1e1c-8436-474e8a9fb0e8@redhat.com>
References: <f85e3824-5545-f541-c96d-4352585288a@redhat.com> <c366231-e146-5a2b-1d8a-5936fb2047ca@redhat.com> <8522af2f-fb97-4d0b-9e38-868c572da18a@kernel.dk> <7060a917-6537-4334-4961-601a182bca54@redhat.com>
 <b1ca89ae-1500-4c3c-bd8a-74e081aa8dd3@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240523_081122_334741_BFDC2547 
X-CRM114-Status: GOOD (  22.37  )
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



On Thu, 23 May 2024, Jens Axboe wrote:

> On 5/23/24 8:58 AM, Mikulas Patocka wrote:

> > Here I'm resending the patch with the function rq_integrity_vec removed if 
> > CONFIG_BLK_DEV_INTEGRITY is not defined.
> 
> That looks better - but can you please just post a full new series,
> that's a lot easier to deal with and look at than adding a v2 of one
> patch in the thread.

OK, I'll post both patches.

> > @@ -853,16 +855,20 @@ static blk_status_t nvme_prep_rq(struct
> >  			goto out_free_cmd;
> >  	}
> >  
> > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> >  	if (blk_integrity_rq(req)) {
> >  		ret = nvme_map_metadata(dev, req, &iod->cmd);
> >  		if (ret)
> >  			goto out_unmap_data;
> >  	}
> > +#endif
> 
> 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) && blk_integrity_rq(req)) {
> 
> ?

That wouldn't work, because the calls to rq_integrity_vec need to be 
eliminated by the preprocessor.

Should I change rq_integrity_vec to this? Then, we could get rid of the 
ifdefs and let the optimizer remove all calls to rq_integrity_vec.
static inline struct bio_vec rq_integrity_vec(struct request *rq)
{
	struct bio_vec bv = { };
	return bv;
}

> > @@ -962,12 +968,14 @@ static __always_inline void nvme_pci_unm
> >  	struct nvme_queue *nvmeq = req->mq_hctx->driver_data;
> >  	struct nvme_dev *dev = nvmeq->dev;
> >  
> > +#ifdef CONFIG_BLK_DEV_INTEGRITY
> >  	if (blk_integrity_rq(req)) {
> >  	        struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> 
> Ditto
> 
> > Index: linux-2.6/include/linux/blk-integrity.h
> > ===================================================================
> > --- linux-2.6.orig/include/linux/blk-integrity.h
> > +++ linux-2.6/include/linux/blk-integrity.h
> > @@ -109,11 +109,11 @@ static inline bool blk_integrity_rq(stru
> >   * Return the first bvec that contains integrity data.  Only drivers that are
> >   * limited to a single integrity segment should use this helper.
> >   */
> > -static inline struct bio_vec *rq_integrity_vec(struct request *rq)
> > +static inline struct bio_vec rq_integrity_vec(struct request *rq)
> >  {
> > -	if (WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1))
> > -		return NULL;
> > -	return rq->bio->bi_integrity->bip_vec;
> > +	WARN_ON_ONCE(queue_max_integrity_segments(rq->q) > 1);
> > +	return mp_bvec_iter_bvec(rq->bio->bi_integrity->bip_vec,
> > +				 rq->bio->bi_integrity->bip_iter);
> >  }
> 
> Not clear why the return on integrity segments > 1 is removed?

Because we can't return NULL. But I can leave it there, print a warning 
and return the first vector.

Mikulas

> -- 
> Jens Axboe
> 


