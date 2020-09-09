Return-Path: <SRS0=XP6N=CS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8F1C433E2
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 01:17:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4A8A216C4
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Sep 2020 01:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kKOr6y3E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bASAmzBl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4A8A216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=L4bBktVJiVfTPJ28c/NbV3ZHCJQ0W7zJ6c0VDyxwb+M=; b=kKOr6y3EWvPfxtd6EcGPHagw7
	Zz9IFWterOjM2zaM4q3P1d+TmLudSwKy0vyu72O5IzV+CWFw8Zfn1TkDDXm9k0X98Y//cxnntPXNg
	O3DWDa6Qv2brIS2A4DwrBUsXnC/C/3++D4D8KvT3cgyEZNLjY+Qy2gSOMMA4bFI3UW+vRKRp8PDmh
	UkpLw+vflPoz35GKlcUYaMtmGbNm20WlRy+VMzi+Gc1oHmTZRXO+lIW3GVS4rvVdIyPrZ9GXxbLbr
	gUGhMxDMEdeLLOI2tAnuodLmPjFgTgWpY7gDCn11yvECR8g5LO6Rxb+zoNcDFDDAIzPh95Ce/W+5c
	caEJ+WfHQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kFojM-0004QD-1g; Wed, 09 Sep 2020 01:17:00 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kFojK-0004Pg-12
 for linux-nvme@lists.infradead.org; Wed, 09 Sep 2020 01:16:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599614217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i8mv0FVtNHbd9zXlKvA6wXb9TbJe9plomVS4MYmguXw=;
 b=bASAmzBl3g9mSMEnB5cJRsnmdOprsCdaJP8izoiGC4hDIlNddfH1Yy10gr+RgGY9gU100x
 +IbprD/BULq2ASOx3tOQdZVx1GJ+Xt4LULpS4uCW7nwEGnFxMXyiJv8d9ES1ATa8BlEMe8
 MeuFzz5gEB/AjfisAYTtT5Sek7frWO0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-464-UZ-XJF2-NnWRoDA0VNN-ug-1; Tue, 08 Sep 2020 21:16:54 -0400
X-MC-Unique: UZ-XJF2-NnWRoDA0VNN-ug-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27300100558D;
 Wed,  9 Sep 2020 01:16:53 +0000 (UTC)
Received: from T590 (ovpn-12-76.pek2.redhat.com [10.72.12.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 122673A40;
 Wed,  9 Sep 2020 01:16:45 +0000 (UTC)
Date: Wed, 9 Sep 2020 09:16:41 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 1/4] blk-mq: serialize queue quiesce and unquiesce by
 mutex
Message-ID: <20200909011641.GA1465199@T590>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-2-ming.lei@redhat.com>
 <8e040e37-d1df-ea5f-8a63-f4067d092b72@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8e040e37-d1df-ea5f-8a63-f4067d092b72@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200908_211658_195811_FBDDB803 
X-CRM114-Status: GOOD (  14.57  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Sep 08, 2020 at 10:54:14AM -0700, Bart Van Assche wrote:
> On 2020-09-08 01:15, Ming Lei wrote:
> >  void blk_mq_unquiesce_queue(struct request_queue *q)
> >  {
> > +	mutex_lock(&q->mq_quiesce_lock);
> > +
> >  	blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);
> >  
> >  	/* dispatch requests which are inserted during quiescing */
> >  	blk_mq_run_hw_queues(q, true);
> > +
> > +	mutex_unlock(&q->mq_quiesce_lock);
> >  }
> Has the sunvdc driver been retested? It calls blk_mq_unquiesce_queue()
> with a spinlock held. As you know calling mutex_lock() while holding a
> spinlock is not allowed.

I am wondering if sunvdc is still being actively used, the similar lock issue
has been existed since 7996a8b5511a ("blk-mq: fix hang caused by
freeze/unfreeze sequence") which is committed in May 2019.

+       spin_lock_irq(&port->vio.lock);
+       port->drain = 0;
+       blk_mq_unquiesce_queue(q);
+       blk_mq_unfreeze_queue(q);

mutex_lock is added to blk_mq_unfreeze_queue(q) since commit 7996a8b5511a.

Not see such report actually.

> There may be other drivers than the sunvdc driver that do this.

Most calls of blk_mq_unquiesce_queue are easily to be audited because
blk_mq_quiesce_queue is used in same callsite.

I will take a close look at this thing before posting next version.

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
