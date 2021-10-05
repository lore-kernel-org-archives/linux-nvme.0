Return-Path: <SRS0=bdbJ=OZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E771C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 02:31:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5FB60F5B
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Oct 2021 02:31:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1B5FB60F5B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/ChZX0z6u6BuiVmHRLXoNRzPcIzOV2G6VZ7sAKNSdy8=; b=eDZ4rn36rTD7rI
	/tI/kNyjn1GhQfcxbJ6rxvSrZzUCKpF2Is1UAjqIHtOzrznE7WWtEdrtC6jhsKe9FzXNVM4xElZ0c
	3MxU4tik/W/AMN2bBbKOlwfm9Fl/HOk00fg8DyY8VaNVHzaPlXZPtTu9Uni6ZXN3FqwG77Q4Ie7Ao
	N6uF+1ITTLvBM6myUx1b/GsbvncqJKL9+8ao47TSL81eNaN49or5vFTokmkZ0kjNmoq0lvh7LDfRl
	dEdcCDHsGBWq27VWIrNuLoJESeohUhWR72bL7Hwm0RiJuIAUa/hh5gUY5IxSxe4XearOpEPA23Yk8
	cfzB1DRf9LH1UEpfhzkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mXaEz-008iLH-9A; Tue, 05 Oct 2021 02:31:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mXaEv-008iKb-Ug
 for linux-nvme@lists.infradead.org; Tue, 05 Oct 2021 02:31:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633401092;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y7jJ6KHx8OrB8Mx5SJVvL7UsMt1KY18IEIlpK+BFivY=;
 b=dXOjH15KG/dHLSro+6/t0PIs3pwSionmcPLb3IKIF4GruIGr1UpIMeMeY8somQgTzqJH6y
 xq5IbW0VA4/x9aimKUoW+VvLC1n8QC5DmYQb8bDrv0qPo7faTalJHqeSy+6jrfFUdPhxgr
 fYL1UBnxV7sbuMs2QjxShvkYboZmNjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-EBiTeELeNvax-nm-USI9VQ-1; Mon, 04 Oct 2021 22:31:31 -0400
X-MC-Unique: EBiTeELeNvax-nm-USI9VQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C02EB8145E6;
 Tue,  5 Oct 2021 02:31:29 +0000 (UTC)
Received: from T590 (ovpn-8-16.pek2.redhat.com [10.72.8.16])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2181410013D7;
 Tue,  5 Oct 2021 02:31:24 +0000 (UTC)
Date: Tue, 5 Oct 2021 10:31:19 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH V2 5/5] blk-mq: support concurrent queue quiesce/unquiesce
Message-ID: <YVu49xcM1N//fvKR@T590>
References: <20210930125621.1161726-1-ming.lei@redhat.com>
 <20210930125621.1161726-6-ming.lei@redhat.com>
 <e3d6c61c-f7cf-dcb0-df2e-a8e9acf5aaaa@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e3d6c61c-f7cf-dcb0-df2e-a8e9acf5aaaa@acm.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211004_193134_087831_01A25F6E 
X-CRM114-Status: GOOD (  33.40  )
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

On Thu, Sep 30, 2021 at 08:56:29AM -0700, Bart Van Assche wrote:
> On 9/30/21 5:56 AM, Ming Lei wrote:
> > Turns out that blk_mq_freeze_queue() isn't stronger[1] than
> > blk_mq_quiesce_queue() because dispatch may still be in-progress after
> > queue is frozen, and in several cases, such as switching io scheduler,
> > updating nr_requests & wbt latency, we still need to quiesce queue as a
> > supplement of freezing queue.
> 
> Is there agreement about this? If not, how about leaving out the above from the
> patch description?

Yeah, actually the code has been merged, please see the related
functions: elevator_switch(), queue_wb_lat_store() and
blk_mq_update_nr_requests().

> 
> > As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
> > for us to need support nested quiesce, especially we can't let
> > unquiesce happen when there is quiesce originated from other contexts.
> > 
> > This patch introduces q->mq_quiesce_depth to deal concurrent quiesce,
> > and we only unquiesce queue when it is the last/outer-most one of all
> > contexts.
> > 
> > One kernel panic issue has been reported[2] when running stress test on
> > dm-mpath's updating nr_requests and suspending queue, and the similar
> > issue should exist on almost all drivers which use quiesce/unquiesce.
> > 
> > [1] https://marc.info/?l=linux-block&m=150993988115872&w=2
> > [2] https://listman.redhat.com/archives/dm-devel/2021-September/msg00189.html
> 
> Please share the call stack of the kernel oops fixed by [2] since that
> call stack is not in the patch description.

OK, it is something like the following:

[  145.453672] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-2.fc30 04/01/2014
[  145.454104] RIP: 0010:dm_softirq_done+0x46/0x220 [dm_mod]
[  145.454536] Code: 85 ed 0f 84 40 01 00 00 44 0f b6 b7 70 01 00 00 4c 8b a5 18 01 00 00 45 89 f5 f6 47 1d 04 75 57 49 8b 7c 24 08 48 85 ff 74 4d <48> 8b 47 08 48 8b 40 58 48 85 c0 74 40 49 8d 4c 24 50 44 89 f2 48
[  145.455423] RSP: 0000:ffffa88600003ef8 EFLAGS: 00010282
[  145.455865] RAX: ffffffffc03fbd10 RBX: ffff979144c00010 RCX: dead000000000200
[  145.456321] RDX: ffffa88600003f30 RSI: ffff979144c00068 RDI: ffffa88600d01040
[  145.456764] RBP: ffff979150eb7990 R08: ffff9791bbc27de0 R09: 0000000000000100
[  145.457205] R10: 0000000000000068 R11: 000000000000004c R12: ffff979144c00138
[  145.457647] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000010
[  145.458080] FS:  00007f57e5d13180(0000) GS:ffff9791bbc00000(0000) knlGS:0000000000000000
[  145.458516] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  145.458945] CR2: ffffa88600d01048 CR3: 0000000106cf8003 CR4: 0000000000370ef0
[  145.459382] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  145.459815] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  145.460250] Call Trace:
[  145.460779]  <IRQ>
[  145.461453]  blk_done_softirq+0xa1/0xd0
[  145.462138]  __do_softirq+0xd7/0x2d6
[  145.462814]  irq_exit+0xf7/0x100
[  145.463480]  do_IRQ+0x7f/0xd0
[  145.464131]  common_interrupt+0xf/0xf
[  145.464797]  </IRQ>

> 
> > diff --git a/block/blk-mq.c b/block/blk-mq.c
> > index 21bf4c3f0825..10f8a3d4e3a1 100644
> > --- a/block/blk-mq.c
> > +++ b/block/blk-mq.c
> > @@ -209,7 +209,12 @@ EXPORT_SYMBOL_GPL(blk_mq_unfreeze_queue);
> >    */
> >   void blk_mq_quiesce_queue_nowait(struct request_queue *q)
> >   {
> > -	blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&q->queue_lock, flags);
> > +	if (!q->quiesce_depth++)
> > +		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> > +	spin_unlock_irqrestore(&q->queue_lock, flags);
> >   }
> >   EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);
> 
> Consider using == 0 instead of ! to check whether or not quiesce_depth is
> zero to improve code readability.

Fine.

> 
> > @@ -250,10 +255,19 @@ EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue);
> >    */
> >   void blk_mq_unquiesce_queue(struct request_queue *q)
> >   {
> > -	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> > +	unsigned long flags;
> > +	bool run_queue = false;
> > +
> > +	spin_lock_irqsave(&q->queue_lock, flags);
> > +	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {
> > +		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> > +		run_queue = true;
> > +	}
> > +	spin_unlock_irqrestore(&q->queue_lock, flags);
> >   	/* dispatch requests which are inserted during quiescing */
> > -	blk_mq_run_hw_queues(q, true);
> > +	if (run_queue)
> > +		blk_mq_run_hw_queues(q, true);
> >   }
> 
> So calling with blk_mq_unquiesce_queue() q->quiesce_depth <= 0 is ignored
> quietly? How about triggering a kernel warning for that condition?

OK.


Thanks, 
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
