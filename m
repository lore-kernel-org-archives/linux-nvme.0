Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B76CFC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Nov 2021 02:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BwYQSMaKGhnVjdlg6/XWIcbt1mryEgoJl23wrK4HkPE=; b=hSjvUYeESCO2IXHOvP6j5tzKvn
	qKfyvvQMwCr4jp7bXWOluSV0n78ecAGXadaDv/TR8yKGnui2su0ZDkfULUD3APSE09N+ZUoUkM2L4
	VWJXD7RNZGEO1gBLneEhTv2p5/KbiJELIIOOvHyjEybEaI7LZAwRcFA7QDwXygHKqj78Zslhc/Yfq
	dkjYaSY1G5Qx1SZ/SK9yw9y4ev8hLUTOoRaGFwOW8jz6Z8/jmvQDGbriHRgeN7Pp+OFmfg6Sbc+7o
	sc4BAKnNY0MGM8M3jEzWWhUCD+bDBJ1M5lxSJQBPqy6WdtSb9GB54VJJXIOS1aeIzJfihk8znXDhH
	AlWBlSkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mrsyF-003Mao-QG; Tue, 30 Nov 2021 02:34:15 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mrsyD-003MZ9-BX
 for linux-nvme@lists.infradead.org; Tue, 30 Nov 2021 02:34:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638239650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BwYQSMaKGhnVjdlg6/XWIcbt1mryEgoJl23wrK4HkPE=;
 b=LDKY1AKWVZL8bgtM1Iwu6Q0o/6PGO92pIiMP88X8rodC/csn7W9Wg57NLUGUDdWC03gy3+
 /eRJ2I0P9YyUS+W5A1bN0yOcSQUNXwpqy6B+U7q9216O7ODUYsMjT1y8BGOij68x8+XqK8
 mPPugSnsxtWn9XI3bz6OO/TSLop9vnU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-164-N5HmpV_gOPu2964hsrRfPg-1; Mon, 29 Nov 2021 21:34:08 -0500
X-MC-Unique: N5HmpV_gOPu2964hsrRfPg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 370F183DD22;
 Tue, 30 Nov 2021 02:34:07 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67DA610016FE;
 Tue, 30 Nov 2021 02:33:13 +0000 (UTC)
Date: Tue, 30 Nov 2021 10:33:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 3/5] blk-mq: add helper of blk_mq_global_quiesce_wait()
Message-ID: <YaWNZF3ZYWPQBSbk@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-4-ming.lei@redhat.com>
 <8f6b6452-9abb-fd89-0262-9fb9d00d42a5@grimberg.me>
 <YZuagPbZJ6CjiUNi@T590>
 <38b9661e-c5b8-ae18-f2ab-b30f9d3e7115@grimberg.me>
 <YZwzEBtFug6JEmMZ@T590>
 <a3ea006a-738b-af69-4dd5-f33444e3559d@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ea006a-738b-af69-4dd5-f33444e3559d@grimberg.me>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211129_183413_518033_CC600125 
X-CRM114-Status: GOOD (  27.54  )
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

On Tue, Nov 23, 2021 at 11:00:45AM +0200, Sagi Grimberg wrote:
> 
> > > > > > Add helper of blk_mq_global_quiesce_wait() for supporting to quiesce
> > > > > > queues in parallel, then we can just wait once if global quiesce wait
> > > > > > is allowed.
> > > > > 
> > > > > blk_mq_global_quiesce_wait() is a poor name... global is scope-less and
> > > > > obviously it has a scope.
> > > > 
> > > > How about blk_mq_shared_quiesce_wait()? or any suggestion?
> > > 
> > > Shared between what?
> > 
> > All request queues in one host-wide, both scsi and nvme has such
> > requirement.
> > 
> > > 
> > > Maybe if the queue has a non-blocking tagset, it can have a "quiesced"
> > > flag that is cleared in unquiesce? then the callers can just continue
> > > to iterate but will only wait the rcu grace period once.
> > 
> > Yeah, that is what these patches try to implement.
> 
> I was suggesting to "hide" it in the interface.
> Maybe something like:
> --
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 8799fa73ef34..627b631db1f9 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -263,14 +263,18 @@ void blk_mq_wait_quiesce_done(struct request_queue *q)
>         unsigned int i;
>         bool rcu = false;
> 
> +       if (!q->has_srcu && q->quiesced)
> +               return;
>         queue_for_each_hw_ctx(q, hctx, i) {
>                 if (hctx->flags & BLK_MQ_F_BLOCKING)
>                         synchronize_srcu(hctx->srcu);
>                 else
>                         rcu = true;
>         }
> -       if (rcu)
> +       if (rcu) {
>                 synchronize_rcu();
> +               q->quiesced = true;
> +       }
>  }
>  EXPORT_SYMBOL_GPL(blk_mq_wait_quiesce_done);
> 
> @@ -308,6 +312,7 @@ void blk_mq_unquiesce_queue(struct request_queue *q)
>         } else if (!--q->quiesce_depth) {
>                 blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
>                 run_queue = true;
> +               q->quiesced = false;

Different request queues are passed to blk_mq_wait_quiesce_done() during
the iteration, so marking 'quiesced' doesn't make any difference here.


Thanks,
Ming


