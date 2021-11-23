Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D1AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Nov 2021 00:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tHp1kJGVcSW77yxYlIZev6n0xAiadeeDY1Ct+JvYyXY=; b=DtzEJjE2rKlAxz1c6qBJECbVWC
	24U6imNHYXgJM1Ru0Ux0enJkrwTWKAkgKbpZcSEnBwM14Az+NxTomv7I4hI/adYMrQEBknvsnUqsg
	y51+HUc/D92+6rE6VY2m1qMycabueoRUYAdc3FQmYqNiDerUCqMPE270abQsRlu5IUD8fxvs9zI0i
	0ZTpGppaBEyaQoZAPASPTqlGxq+Ow2TdYEaG5CnJ9HYQB8nA4VufBZixQttqE4F7N+y/VDOjrVXcP
	LMk3b3l7eE5NH1/j580pIq/S3AxBC4jKRu2N4WQmLSpY7Xym4xcAMgypcuyagVvxQ/1jwInjoheYK
	r0zuusrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mpJMw-000VNW-L6; Tue, 23 Nov 2021 00:09:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mpJMt-000VLw-0N
 for linux-nvme@lists.infradead.org; Tue, 23 Nov 2021 00:09:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637626136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tHp1kJGVcSW77yxYlIZev6n0xAiadeeDY1Ct+JvYyXY=;
 b=P8Gyzsr+iY9aEgRjja4HDfKadGpfYn4ibcuHYhY/bJy4h+vLDpTIF6u/i687/vw5Vje8Wb
 cLG4ybthnWXMtuxqX8IOEMK9mgdZcwygyHmy+pbi5zUf9jIkpPSaEufqdPb/4ibpHicqqO
 kjwB5deu9CF8gTmFNc81tvoYXMCB3C8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-171-x8s2i858N3y578ezCmaDzA-1; Mon, 22 Nov 2021 19:08:51 -0500
X-MC-Unique: x8s2i858N3y578ezCmaDzA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7B7F1018721;
 Tue, 23 Nov 2021 00:08:49 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 799125F4EA;
 Tue, 23 Nov 2021 00:08:37 +0000 (UTC)
Date: Tue, 23 Nov 2021 08:08:31 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/5] blk-mq: rename hctx_lock & hctx_unlock
Message-ID: <YZww/1iBDbou1yQY@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-3-ming.lei@redhat.com>
 <ed13ee7f-a017-874a-cd28-e40b3aa6b4a7@grimberg.me>
 <YZuZCsCIyQrc+539@T590>
 <737e0543-9b7b-4872-082c-9ea51069d57f@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <737e0543-9b7b-4872-082c-9ea51069d57f@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_160903_147546_B4067F9A 
X-CRM114-Status: GOOD (  22.92  )
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

On Mon, Nov 22, 2021 at 03:50:14PM +0200, Sagi Grimberg wrote:
> 
> 
> On 11/22/21 3:20 PM, Ming Lei wrote:
> > On Mon, Nov 22, 2021 at 09:53:53AM +0200, Sagi Grimberg wrote:
> > > 
> > > > -static inline void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> > > > -	__releases(hctx->srcu)
> > > > +static inline void queue_unlock(struct request_queue *q, bool blocking,
> > > > +		int srcu_idx)
> > > > +	__releases(q->srcu)
> > > >    {
> > > > -	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> > > > +	if (!blocking)
> > > >    		rcu_read_unlock();
> > > >    	else
> > > > -		srcu_read_unlock(hctx->queue->srcu, srcu_idx);
> > > > +		srcu_read_unlock(q->srcu, srcu_idx);
> > > 
> > > Maybe instead of passing blocking bool just look at srcu_idx?
> > > 
> > > 	if (srcu_idx < 0)
> > > 		rcu_read_unlock();
> > > 	else
> > > 		srcu_read_unlock(q->srcu, srcu_idx);
> > 
> > This way needs to initialize srcu_idx in each callers.
> 
> Then look at q->has_srcu that Bart suggested?

Bart just suggested to rename q->alloc_srcu as q->has_srcu.

> 
> > 
> > > 
> > > Or look if the queue has srcu allocated?
> > > 
> > > 	if (!q->srcu)
> > > 		rcu_read_unlock();
> > > 	else
> > > 		srcu_read_unlock(q->srcu, srcu_idx);
> > 
> > This way is worse since q->srcu may involve one new cacheline fetch.
> > 
> > hctx->flags is always hot, so it is basically zero cost to check it.
> 
> Yea, but the interface is awkward that the caller tells the
> routine how it should lock/unlock...

If the two helpers are just blk-mq internal, I think it is fine to keep
this way with comment.

If driver needs the two exported, they should be often used in slow path, then
it is fine to refine the interface type.


Thanks,
Ming


