Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6872FC71135
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Jun 2025 04:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=07mu1H2Fz6+UQ8LWJqAXuVs0XQYIbPBJGblMDKiU/bE=; b=182VsGmIsvCQrdA0dLJzAg0ykK
	swIhTQDG+IXIfipwUfcjX8LDXmwrffB5daieeISRsECiY85vSXkjGNhzpXeMvZJ6dgkjclp76tL39
	JR7Ap1WII6NjzJkC7grekCD1+zA0PC3g6cl1vw3tENMtgAgcswXsB/Mf4K1+LKfAHprAAODiJgMvX
	92rx6c5JAb7ZtWZl/BIFc9iSJQin/39ZzbZaPnmD66IPOfCecNC55Euh0bIPLGK/IsnHa2GnqZseO
	85vEHOHbskjDPZs4GVBY9hUG0YP6az8QpEOv1XyusqQefOOfl1vq5YG2Syfixp/WGznvFIPkkgNtO
	c3g+yGIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPwTP-0000000FLBZ-2c5t;
	Fri, 13 Jun 2025 04:57:03 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPwTN-0000000FLBA-1hhz
	for linux-nvme@lists.infradead.org;
	Fri, 13 Jun 2025 04:57:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749790618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07mu1H2Fz6+UQ8LWJqAXuVs0XQYIbPBJGblMDKiU/bE=;
	b=Ao0Nm1nhTkETnKyzvsTisU1GDQ88k5o1uqOEGXhycvsoJEI/gD9zfsEBkdzX25I0TzHW9n
	K7I1fTFqwcEBBhuiC2PlCovacPCT19KGodiV+FDpVSp2cx18KDvc64/oCN11HMHYku2MPa
	910+QvzrVkTiDkU8s36RP9suVbwWoBw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-QZcifxZZPGqh1SdGkHd1Rg-1; Fri,
 13 Jun 2025 00:56:54 -0400
X-MC-Unique: QZcifxZZPGqh1SdGkHd1Rg-1
X-Mimecast-MFC-AGG-ID: QZcifxZZPGqh1SdGkHd1Rg_1749790612
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A80519560AD;
	Fri, 13 Jun 2025 04:56:51 +0000 (UTC)
Received: from fedora (unknown [10.72.116.73])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C8B56195E340;
	Fri, 13 Jun 2025 04:56:45 +0000 (UTC)
Date: Fri, 13 Jun 2025 12:56:40 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	linux-block <linux-block@vger.kernel.org>,
	Hannes Reinecke <hare@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	"hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH 1/2] nvme-tcp: avoid race between nvme scan and reset
Message-ID: <aEuviL5O2kD70Sij@fedora>
References: <20250602043522.55787-1-shinichiro.kawasaki@wdc.com>
 <20250602043522.55787-2-shinichiro.kawasaki@wdc.com>
 <910b31ba-1982-4365-961e-435f5e7611b2@grimberg.me>
 <86e241dd-9065-4cf0-9c35-8b7502ab2d8a@grimberg.me>
 <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6pt5u3fg3qts4jekun5ory5lr2jtfbibd76phqviheulpjqjtq@m3arkh44nrs2>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250612_215701_518218_A6F68C4B 
X-CRM114-Status: GOOD (  32.58  )
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

On Wed, Jun 04, 2025 at 11:17:05AM +0000, Shinichiro Kawasaki wrote:
> Cc+: Ming,
> 
> Hi Sagi, thanks for the background explanation and the suggestion.
> 
> On Jun 04, 2025 / 10:10, Sagi Grimberg wrote:
> ...
> > > This is a problem. We are flushing a work that is IO bound, which can
> > > take a long time to complete.
> > > Up until now, we have deliberately avoided introducing dependency
> > > between reset forward progress
> > > and scan work IO to completely finish.
> > > 
> > > I would like to keep it this way.
> > > 
> > > BTW, this is not TCP specific.
> 
> I see. The blktests test case nvme/063 is dedicated to tcp transport, so that's
> why it was reported for the TCP transport.
> 
> > 
> > blk_mq_unquiesce_queue is still very much safe to call as many times as we
> > want.
> > The only thing that comes in the way is this pesky WARN. How about we make
> > it go away and have
> > a debug print instead?
> > 
> > My preference would be to allow nvme to unquiesce queues that were not
> > previously quiesced (just
> > like it historically was) instead of having to block a controller reset
> > until the scan_work is completed (which
> > is admin I/O dependent, and may get stuck until admin timeout, which can be
> > changed by the user for 60
> > minutes or something arbitrarily long btw).
> > 
> > How about something like this patch instead:
> > --
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index c2697db59109..74f3ad16e812 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -327,8 +327,10 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
> >         bool run_queue = false;
> > 
> >         spin_lock_irqsave(&q->queue_lock, flags);
> > -       if (WARN_ON_ONCE(q->quiesce_depth <= 0)) {
> > -               ;
> > +       if (q->quiesce_depth <= 0) {
> > +               printk(KERN_DEBUG
> > +                       "dev %s: unquiescing a non-quiesced queue,
> > expected?\n",
> > +                       q->disk ? q->disk->disk_name : "?", );
> >         } else if (!--q->quiesce_depth) {
> >                 blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> >                 run_queue = true;
> > --
> 
> The WARN was introduced with the commit e70feb8b3e68 ("blk-mq: support
> concurrent queue quiesce/unquiesce") that Ming authored. Ming, may I
> ask your comment on the suggestion by Sagi?

I think it is bad to use one standard block layer API in this unbalanced way,
that is why WARN_ON_ONCE() is added. We shouldn't encourage driver to use
APIs in this way.

Question is why nvme have to unquiesce one non-quiesced queue?



Thanks,
Ming


