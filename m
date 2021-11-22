Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78145C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 13:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+lF/w7tD9pxUXDtV6yAcEsR2+KOGUo37EC26aybNgIE=; b=X0YUtFzIr4LAPozjNPLY9sHgl/
	0JuF0lAOydYPzgqT5QQgX590U7ckJoiCIj3NdJU00cH8M85p6mO3LDyiTSMW5QEvGMOXJZ/tu0Ydw
	oY9hlZ+jQVwgZV74BEro6SLEriCyKBcjFDSTDBk/8k4VWt5fi5m36hP9nP7GmV2nW2kqKsJWaNljX
	k5jrW71V5CFtNVgWn0hnpkWiRaZfwwqSQqKHygKbjhsRxXvM/dQP8oAOzw4Sf5sc40NrWr/7pBYXQ
	XN8XJjpndAXereBBU7Mk0/6N/FgiHnrINC7Kbu4er2aW6tMe7Bi/DmYAzlTpehFql7oS7Z299JOe4
	5ujWoAOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp9Fq-00GckK-BL; Mon, 22 Nov 2021 13:21:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp9Fn-00Gcj5-30
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 13:21:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637587261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+lF/w7tD9pxUXDtV6yAcEsR2+KOGUo37EC26aybNgIE=;
 b=Z1N4bC3P0lGJ3aiu8ufZ4aClvYBJEXxddjzXGZkklYX7qA3pmBIQfxdUFDSYseXhpEqVs5
 jgMZgO4Pqxk7HS0KSG/kjynMiSf2fGinECUPN6Twk9MIoEfnLQ9Ea9hfhZIWfTNLkmpHX3
 x5kZpGjIT+rDbVf3q9KBGJVdXKXqweI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-Y6l1Z9kiOSyzdEGWU2bqxQ-1; Mon, 22 Nov 2021 08:20:43 -0500
X-MC-Unique: Y6l1Z9kiOSyzdEGWU2bqxQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D04EA40C6;
 Mon, 22 Nov 2021 13:20:42 +0000 (UTC)
Received: from T590 (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5A92F5B826;
 Mon, 22 Nov 2021 13:20:14 +0000 (UTC)
Date: Mon, 22 Nov 2021 21:20:10 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/5] blk-mq: rename hctx_lock & hctx_unlock
Message-ID: <YZuZCsCIyQrc+539@T590>
References: <20211119021849.2259254-1-ming.lei@redhat.com>
 <20211119021849.2259254-3-ming.lei@redhat.com>
 <ed13ee7f-a017-874a-cd28-e40b3aa6b4a7@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed13ee7f-a017-874a-cd28-e40b3aa6b4a7@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_052103_226241_8C1C3184 
X-CRM114-Status: GOOD (  15.96  )
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

On Mon, Nov 22, 2021 at 09:53:53AM +0200, Sagi Grimberg wrote:
> 
> > -static inline void hctx_unlock(struct blk_mq_hw_ctx *hctx, int srcu_idx)
> > -	__releases(hctx->srcu)
> > +static inline void queue_unlock(struct request_queue *q, bool blocking,
> > +		int srcu_idx)
> > +	__releases(q->srcu)
> >   {
> > -	if (!(hctx->flags & BLK_MQ_F_BLOCKING))
> > +	if (!blocking)
> >   		rcu_read_unlock();
> >   	else
> > -		srcu_read_unlock(hctx->queue->srcu, srcu_idx);
> > +		srcu_read_unlock(q->srcu, srcu_idx);
> 
> Maybe instead of passing blocking bool just look at srcu_idx?
> 
> 	if (srcu_idx < 0)
> 		rcu_read_unlock();
> 	else
> 		srcu_read_unlock(q->srcu, srcu_idx);

This way needs to initialize srcu_idx in each callers.

> 
> Or look if the queue has srcu allocated?
> 
> 	if (!q->srcu)
> 		rcu_read_unlock();
> 	else
> 		srcu_read_unlock(q->srcu, srcu_idx);

This way is worse since q->srcu may involve one new cacheline fetch.

hctx->flags is always hot, so it is basically zero cost to check it.


Thanks,
Ming


