Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D722C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 01:29:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9279F600EF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 01:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9279F600EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=2MdbdTVvPZU/2r0PiwqdLyjgVtWBnAKxet5ejWJJzRg=; b=Dw2uiDqOjcQLKHH/aU7hYV4cg
	G/+PdhHGfJftuF7OHi+YCsP4zsD/FmMusx2mfr5yJzKwMCo3K8Dfnlu1Gb/+fCH9BBkr1+W/9N2yC
	FMhFFPYuPrcf4hEUQXIP8ORX0hBFdDZPMm9fAxSVDVxTvt8fN3YNfWqrWbYeLLzAbCQWkvSs5XbHH
	0dFfv1JdwSMwrOSDGvSuK8GEvYlP5J3CrzVSHKHZl7HReXs8dlyBHNAIe9KGuqWQtHzcQLSYunBAF
	wNWGDgCX0sc7G9Via/MLGDsH8pyip61TKNbRMIfkZNg+Qp4Y1yo6rco1BEHyuDC+ibqAoBaj2lzDN
	xBmsihRAw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXDHz-000NCf-7H; Fri, 16 Apr 2021 01:28:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXDHu-000NCQ-2m
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 01:28:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=q0cmPSdk62RM6Rohe8F7GfXinQJD6JbYRfgxZ7IYSgE=; b=Aih2HFO/CJ2htgLeTlnvCcMWg+
 Rb57Fm4/6+S9QuFnkTeDhk+nhSWwcnj+KUrWQ4uIIfuPM9gyElOL2m7rkEzxCkIjkZ3Xm6nupaYr0
 HOa/OdXVQlpWnTebRcNJOy26Et9YNtAoyjizajOATyS0CPC4hR9GVNVhL2F0pOiCZHc29Dn53EqCH
 sZc2LWamUzJUcHNg2rkk3o4f5vA1lgMJSi/4CIFHUHn0dRGhl1corb1oxKLGMNiF87OeXgM5ejk41
 EvUNcCJkRvJnMECY/MY0EYjMsWtrpXUW3c4MZfidJMD2MRYn8EwN+Gc+3LskrXOlw3d9AGWXG3cU5
 /Tjn7koA==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXDHr-0091BQ-5G
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 01:28:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618536525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0cmPSdk62RM6Rohe8F7GfXinQJD6JbYRfgxZ7IYSgE=;
 b=SJz79c4heZbclg5dDITOmIyA7SkyCzsmB3v8k7yxKN1EkPZWUKFKejif4S4mu2VPmKz2k9
 42PmNKz/3sOJnBYaRTy+gNmL47VxWeuyXZ0szmTQp1LwDPmChSl0G4CFewNKi2+tp+1MZW
 HMXs+3r+212zdatuuD42q6wgZBPhxes=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-14-5I-xjjtWONmT-Z8kJwOWdw-1; Thu, 15 Apr 2021 21:28:41 -0400
X-MC-Unique: 5I-xjjtWONmT-Z8kJwOWdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 45F9F1883520;
 Fri, 16 Apr 2021 01:28:40 +0000 (UTC)
Received: from T590 (ovpn-12-36.pek2.redhat.com [10.72.12.36])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E718D59457;
 Fri, 16 Apr 2021 01:28:26 +0000 (UTC)
Date: Fri, 16 Apr 2021 09:28:22 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-raid@vger.kernel.org,
 Mike Snitzer <snitzer@redhat.com>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, Jeffle Xu <jefflexu@linux.alibaba.com>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [dm-devel] [RFC PATCH 2/2] block: support to freeze bio based
 request queue
Message-ID: <YHjoNg/Z7KQ+4+YX@T590>
References: <20210415103310.1513841-1-ming.lei@redhat.com>
 <20210415103310.1513841-3-ming.lei@redhat.com>
 <af8f41f4-74e8-450d-fa63-6feb6b745222@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <af8f41f4-74e8-450d-fa63-6feb6b745222@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_182847_295336_CDEFE21E 
X-CRM114-Status: GOOD (  23.55  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Apr 15, 2021 at 01:16:42PM -0700, Bart Van Assche wrote:
> On 4/15/21 3:33 AM, Ming Lei wrote:
> > 1) grab two queue usage refcount for blk-mq before submitting blk-mq
> > bio, one is for bio, anther is for request;
>                        ^^^^^^
>                        another?
> 
> > diff --git a/block/blk-core.c b/block/blk-core.c
> > index 09f774e7413d..f71e4b433030 100644
> > --- a/block/blk-core.c
> > +++ b/block/blk-core.c
> > @@ -431,12 +431,13 @@ EXPORT_SYMBOL(blk_cleanup_queue);
> >  int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags)
> >  {
> >  	const bool pm = flags & BLK_MQ_REQ_PM;
> > +	const unsigned int nr = (flags & BLK_MQ_REQ_DOUBLE_REF) ? 2 : 1;
> 
> Please leave out the parentheses from around the condition in the above
> and in other ternary expressions. The ternary operator has a very low
> precedence so adding parentheses around the condition in a ternary
> operator is almost never necessary.
> 
> > @@ -480,8 +481,18 @@ static inline int bio_queue_enter(struct bio *bio)
> >  	struct request_queue *q = bio->bi_bdev->bd_disk->queue;
> >  	bool nowait = bio->bi_opf & REQ_NOWAIT;
> >  	int ret;
> > +	blk_mq_req_flags_t flags = nowait ? BLK_MQ_REQ_NOWAIT : 0;
> > +	bool reffed = bio_flagged(bio, BIO_QUEUE_REFFED);
> >  
> > -	ret = blk_queue_enter(q, nowait ? BLK_MQ_REQ_NOWAIT : 0);
> > +	if (!reffed)
> > +		bio_set_flag(bio, BIO_QUEUE_REFFED);
> > +
> > +	/*
> > +	 * Grab two queue references for blk-mq, one is for bio, and
> > +	 * another is for blk-mq request.
> > +	 */
> > +	ret = blk_queue_enter(q, q->mq_ops && !reffed ?
> > +			(flags | BLK_MQ_REQ_DOUBLE_REF) : flags);
> 
> Consider rewriting the above code as follows to make it easier to read:
> 
> 	if (q->mq_ops && !reffed)
> 		flags |= BLK_MQ_REQ_DOUBLE_REF;
> 	ret = blk_queue_enter(q, flags);
> 
> Please also expand the comment above this code. The comment only
> explains the reffed == false case but not the reffed == true case. I
> assume that the reffed == true case applies to stacked bio-based drivers?

'reffed == true' means we have got one queue usage count already for
this bio, so only need to grab one usage count for blk-mq request.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
