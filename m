Return-Path: <SRS0=l2Ft=BH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E11C433E3
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 09:33:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226AA20714
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jul 2020 09:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZZu7AfPX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NYig39eU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226AA20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=E5vrjJIh9gccWoDf5Em+XuK156pqvgvir6BvKALwdcc=; b=ZZu7AfPXnNINk37yXOwgHlcZG
	rguyxtp2Tnw0+zMA+655dTdPnpH5qGp9MPgUQ22Ce/9kA/TEikNIxWjLAqpDIZAslaqRD+Ltwj11z
	ZIVYqxkLJ1WpyJvH37ZOsBSFegJRnaskC5pA9IhYSXHd5tHUS1lu6SDcOb9b+4mRvMUaDyVvXusB0
	CswGcukSgsRUY8msN1PPmCvqDiQf5Cae/a0wB/3lv10gQR/avtPbW2mnbk8GRgnBMuMRxJbrhLnXV
	GgeZT9ppnSv8Et4YVBjSXThfGhQcKcf4dsc+UUxDMuLlbopaMMOT1hdN+hsYs6qV66cyrwtDkGcLS
	X32+COBRg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k0LzZ-000102-Ep; Tue, 28 Jul 2020 09:33:49 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k0LzX-0000zY-62
 for linux-nvme@lists.infradead.org; Tue, 28 Jul 2020 09:33:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595928826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dGU4qL4DU0btEF4z3eSCu70P6IJAwTZBKSCRVuLZFTQ=;
 b=NYig39eUF3gIfF6AeRbo7t9nG5Rj3wzy1/kw+yeTAYWyAndrXzJUAkhvpXOb566odUHne1
 dry3gdM1siWojRReO0RtgtgGH5E8zhudHA3IUP5CCjn4YCOfS+xbchcBKcnShOZbdpBe+E
 WCOi2KTppVg99w1SAciShYVSZbMtLII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-WHshVYmMO3SvupRBQkriyA-1; Tue, 28 Jul 2020 05:33:42 -0400
X-MC-Unique: WHshVYmMO3SvupRBQkriyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E5EB800597;
 Tue, 28 Jul 2020 09:33:40 +0000 (UTC)
Received: from T590 (ovpn-12-109.pek2.redhat.com [10.72.12.109])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EB1190E63;
 Tue, 28 Jul 2020 09:33:31 +0000 (UTC)
Date: Tue, 28 Jul 2020 17:33:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v5 1/2] blk-mq: add tagset quiesce interface
Message-ID: <20200728093326.GC1326626@T590>
References: <20200727231022.307602-1-sagi@grimberg.me>
 <20200727231022.307602-2-sagi@grimberg.me>
 <20200728071859.GA21629@lst.de> <20200728091633.GB1326626@T590>
 <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b1e7c2c5-dad5-778c-f397-6530766a0150@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200728_053347_258981_D6172ED7 
X-CRM114-Status: GOOD (  23.30  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Ming Lin <mlin@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 28, 2020 at 02:24:38AM -0700, Sagi Grimberg wrote:
> 
> > > I like the tagset based interface.  But the idea of doing a per-hctx
> > > allocation and wait doesn't seem very scalable.
> > > 
> > > Paul, do you have any good idea for an interface that waits on
> > > multiple srcu heads?  As far as I can tell we could just have a single
> > > global completion and counter, and each call_srcu would just just
> > > decrement it and then the final one would do the wakeup.  It would just
> > > be great to figure out a way to keep the struct rcu_synchronize and
> > > counter on stack to avoid an allocation.
> > > 
> > > But if we can't do with an on-stack object I'd much rather just embedd
> > > the rcu_head in the hw_ctx.
> > 
> > I think we can do that, please see the following patch which is against Sagi's V5:
> 
> I don't think you can send a single rcu_head to multiple call_srcu calls.

OK, then one variant is to put the rcu_head into blk_mq_hw_ctx, and put
rcu_synchronize into blk_mq_tag_set.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
