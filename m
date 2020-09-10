Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E2EC43461
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 01:53:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05555206DB
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 01:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="E4CWSG5z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="daj0b9E9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05555206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+Z+mKa0R2TmtrxmnEcvBsifY2uyzsVHsyLFcG550HSc=; b=E4CWSG5zQA1IRf3X/eUsMFqeK
	4ydyGnBJlEJjiEzRHrCeRC9l1U2gwxdxOWiw92zDvUHaEkCFw1f2FAksjkqCkNtklE6VEmcPcqvKR
	h3nbMJDZC3sm04nmU+Ix7HnbS0VMBV0YofHD9gqoxMfHika7SH9lNceu2Pfgl0toCKrJ6cj/1tvrk
	QETVgYfGQ+IatQbICuXd2ek6yZDNdUeIi1tib58OT9XUq7h9NS2Qzy1kGds2vMpIv/S57O4j5/+9T
	7fbskHGthP7fsMA2yF7Oxc7MbeOQB5f4aGS4C2nNDlrMKs3BEDMpAM8XKL5boQs3b2sw/bGCWvbdy
	802oB8pvQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGBmQ-0007Ez-14; Thu, 10 Sep 2020 01:53:42 +0000
Received: from us-smtp-2.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGBmN-0007EL-2Z
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 01:53:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599702818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xkl/3qn93V9jQLcA57G7oLd5+GXv7DnDeZEho2c0oXY=;
 b=daj0b9E9Kg+h+yFphYDFTxgjLYz39O7pX6VG81aUxUWU6pZkzvbCV38HiHVUL7Vnk+ahIj
 7AkkoI/USVHFm0AZIgNTWNjPWDoKaMDXdFqHhOzrFHBFAqxhBvtu6LuA8zbNOTVUScQcOc
 r1koRJqG9TBLpUezjMwg5OLBwxP+XZg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-xK6ARIEmPUGycx3vj_Y_mw-1; Wed, 09 Sep 2020 21:53:36 -0400
X-MC-Unique: xK6ARIEmPUGycx3vj_Y_mw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 546F91DE05;
 Thu, 10 Sep 2020 01:53:34 +0000 (UTC)
Received: from T590 (ovpn-12-146.pek2.redhat.com [10.72.12.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C912E1002D4E;
 Thu, 10 Sep 2020 01:53:25 +0000 (UTC)
Date: Thu, 10 Sep 2020 09:53:21 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200910015321.GA7420@T590>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
 <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200909_215339_183523_352E67F0 
X-CRM114-Status: GOOD (  20.80  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>, Chao Leng <lengchao@huawei.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 09, 2020 at 09:04:09AM -0700, Keith Busch wrote:
> On Wed, Sep 09, 2020 at 06:41:14PM +0800, Ming Lei wrote:
> >  void blk_mq_quiesce_queue(struct request_queue *q)
> >  {
> > -	struct blk_mq_hw_ctx *hctx;
> > -	unsigned int i;
> > -	bool rcu = false;
> > +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> > +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
> >  
> > -	__blk_mq_quiesce_queue_nowait(q);
> > +	if (!was_quiesced && blocking)
> > +		percpu_ref_kill(&q->dispatch_counter);
> >  
> > -	queue_for_each_hw_ctx(q, hctx, i) {
> > -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > -			synchronize_srcu(hctx->srcu);
> > -		else
> > -			rcu = true;
> > -	}
> > -	if (rcu)
> > +	if (blocking)
> > +		wait_event(q->mq_quiesce_wq,
> > +				percpu_ref_is_zero(&q->dispatch_counter));
> > +	else
> >  		synchronize_rcu();
> >  }
> 
> In the previous version, you had ensured no thread can unquiesce a queue
> while another is waiting for quiescence. Now that the locking is gone,
> a thread could unquiesce the queue before percpu_ref reaches zero, so
> the wait_event() may never complete on the resurrected percpu_ref.
> 
> I don't think any drivers do such a thing today, but it just looks like
> the implementation leaves open the possibility.

This driver can cause bigger trouble if it unquiesces its queue which is
being quiesced and still not done.

However, we can avoid that by the following delta change:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7669fe815cf9..5632727d71fa 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -225,9 +225,16 @@ static void __blk_mq_quiesce_queue(struct request_queue *q, bool wait)
 	if (!wait)
 		return;
 
+	/*
+	 * In case of F_BLOCKING, if driver unquiesces its queue which is being
+	 * quiesced and still not done, it can cause bigger trouble, and we simply
+	 * return & warn once for avoiding hang here.
+	 */
 	if (blocking)
 		wait_event(q->mq_quiesce_wq,
-				percpu_ref_is_zero(&q->dispatch_counter));
+				percpu_ref_is_zero(&q->dispatch_counter) ||
+				WARN_ON_ONCE(!percpu_ref_is_dying(
+						&q->dispatch_counter)));
 	else
 		synchronize_rcu();
 }

Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
