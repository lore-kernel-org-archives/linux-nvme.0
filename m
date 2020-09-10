Return-Path: <SRS0=5LEM=CT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4DDC43461
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 08:04:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F4DA206B8
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2020 08:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BoKyGpKC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B7AUs+v7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F4DA206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cFr3QfDB3QNT4F0FZJ6BPc2qa5kBDRz3MYBDPGJuWW8=; b=BoKyGpKC7zXzzGbAl/UiQM02t
	aIKgf6FEv8Zr8XTzuu/oUGqj7x1qtRgfRgt+tOLrKhlS9z/z2/FP/bLNoLI2U52kOFBV8Cyg0+n0N
	LZza++zhT/zCusZR6FABClLK+3olb6MB4vdSsbI9kYm3JZCXjOchXuzWXbx0wtaAxA17YlIaMtRbm
	QMxBlYwsnU/BuSSwCpBX+oiYrWe2Kb3RX07EMqiIyjfaUn9w7itLdnoY7Wjw1A3boOpn6ZN0NRqo2
	m/RBw8mquJg7sGCisazLaEVq+2BCb5DuzpmXkOJgJ07nsxENSp0h9POe4u40MjNgywozMWHjG3HAG
	2Bkp25Rfg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kGHYm-00076g-61; Thu, 10 Sep 2020 08:04:00 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kGHYj-00075h-HP
 for linux-nvme@lists.infradead.org; Thu, 10 Sep 2020 08:03:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599725037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SoH5gZb9aZEHYWTTPdo+ibKytr1EsY2lWTBxjA404Zo=;
 b=B7AUs+v7S6751woIU8AEGgnKdb+hZQg3+dwjAXtOPf4HXmc3PDzA6AiD01AqyqsxOT6ats
 +Motb4kyRtpSngoVe1opUF4W7r84seLXAIT7GC1T0slkGqzUdFOmkLQ4WGdf/JDaO2xtkv
 Pu23PwpJ7Tazdx64d9WSa6M4/d4YMDI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-DC3XShtrNyeuG1BVu56zSQ-1; Thu, 10 Sep 2020 04:03:53 -0400
X-MC-Unique: DC3XShtrNyeuG1BVu56zSQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2B17580ED92;
 Thu, 10 Sep 2020 08:03:51 +0000 (UTC)
Received: from T590 (ovpn-12-146.pek2.redhat.com [10.72.12.146])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DAEC7E8F1;
 Thu, 10 Sep 2020 08:03:42 +0000 (UTC)
Date: Thu, 10 Sep 2020 16:03:37 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH V4 2/4] blk-mq: implement queue quiesce via percpu_ref
 for BLK_MQ_F_BLOCKING
Message-ID: <20200910080337.GC31286@T590>
References: <20200909104116.1674592-1-ming.lei@redhat.com>
 <20200909104116.1674592-3-ming.lei@redhat.com>
 <20200909160409.GA3356175@dhcp-10-100-145-180.wdl.wdc.com>
 <dae73b2c-c191-c8a6-4287-838ab4962467@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <dae73b2c-c191-c8a6-4287-838ab4962467@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200910_040357_637952_B50F3712 
X-CRM114-Status: GOOD (  18.37  )
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
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 09, 2020 at 01:53:30PM -0700, Sagi Grimberg wrote:
> 
> > >   void blk_mq_quiesce_queue(struct request_queue *q)
> > >   {
> > > -	struct blk_mq_hw_ctx *hctx;
> > > -	unsigned int i;
> > > -	bool rcu = false;
> > > +	bool blocking = !!(q->tag_set->flags & BLK_MQ_F_BLOCKING);
> > > +	bool was_quiesced =__blk_mq_quiesce_queue_nowait(q);
> > > -	__blk_mq_quiesce_queue_nowait(q);
> > > +	if (!was_quiesced && blocking)
> > > +		percpu_ref_kill(&q->dispatch_counter);
> > > -	queue_for_each_hw_ctx(q, hctx, i) {
> > > -		if (hctx->flags & BLK_MQ_F_BLOCKING)
> > > -			synchronize_srcu(hctx->srcu);
> > > -		else
> > > -			rcu = true;
> > > -	}
> > > -	if (rcu)
> > > +	if (blocking)
> > > +		wait_event(q->mq_quiesce_wq,
> > > +				percpu_ref_is_zero(&q->dispatch_counter));
> > > +	else
> > >   		synchronize_rcu();
> > >   }
> > 
> > In the previous version, you had ensured no thread can unquiesce a queue
> > while another is waiting for quiescence. Now that the locking is gone,
> > a thread could unquiesce the queue before percpu_ref reaches zero, so
> > the wait_event() may never complete on the resurrected percpu_ref.
> 
> Yea, where did that go?

The mutex is removed because:

1) As Bart mentioned, blk_mq_quiesce_queue() may be called in context
which doesn't allow sleep.

2) Both percpu_ref_kill() and percpu_ref_resurrect() have been protected by
one global spinlock, so both two can be run concurrently.

3) warning may be triggered when percpu_ref_kill() is run on one DEAD
percpu-refcount, or when percpu_ref_resurrect() is run on one live
percpu-refcount. We can avoid the warning with test_and_{clear|test}_bit
exactly by running the actual quiesce/unquiesce action only once.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
