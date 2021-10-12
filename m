Return-Path: <SRS0=8G/6=PA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E077C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 396526052B
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Oct 2021 15:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 396526052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WpIdcLjcvinXBbbKGS1sAzEaJLSRCDv5UQ1/jMu78cw=; b=byya+TJJ1veIJe
	F6XzffZ4VgzrkREpGrr1XxZbZ7NJBC9sFr4Ruga8ftcGFLMQ7Xx/ExxOQeDyxssQVGJ7+jdglYr5W
	N+ldnwQLOedE/xK/SXxPYxIYczISeXT79NkEFldB8wWocxRjjdlsfU5TJqVwJeNYGEmVCRaOGp1PN
	slJbT3pkpmJR2Te//kJUtqcYjcx4Mk22mcS1681bWtVC8nomqn7KGPXNE3fMO+m1r8/bfDQX1tyhr
	wZRCHfXAeNevUGwFZquSK/G71I0MYDqI9lq4mzc6zF3QWpWh5xEfvci2FeqSphMpztBu3JS4Cw7wX
	peuZhBKIM3omWeTq77CQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maJN1-00DIGL-T6; Tue, 12 Oct 2021 15:07:11 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maJMz-00DIFF-4E
 for linux-nvme@lists.infradead.org; Tue, 12 Oct 2021 15:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634051227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jXSeKkVlYOYMFbXldE+ZY1oBqyx/jHfPT9bwC8eSB9I=;
 b=GnkxLJCLlKkFPd4hnCTJzmYQrQ0Mlimn71OFaj0+vDL+k9txag/Io7+7MhMooJTnSqdmxw
 /L0rbtcn3cXV4mdigx3RGkv8aG+SrZFNPvlzZpr/FL3WzOekm8/oFvt88H9gCIhkNEob5G
 du5oDRCFv/2Pck3d8pPz4Y0znNCgrmc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-SY_I9Pu1M9WRGHWECdziKg-1; Tue, 12 Oct 2021 11:07:02 -0400
X-MC-Unique: SY_I9Pu1M9WRGHWECdziKg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C29BA19067E4;
 Tue, 12 Oct 2021 15:07:00 +0000 (UTC)
Received: from T590 (ovpn-8-34.pek2.redhat.com [10.72.8.34])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4248F5D6A8;
 Tue, 12 Oct 2021 15:06:55 +0000 (UTC)
Date: Tue, 12 Oct 2021 23:06:51 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Chaitanya Kulkarni <chaitanyak@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH V3 6/6] blk-mq: support concurrent queue quiesce/unquiesce
Message-ID: <YWWki6An1sOpx3rV@T590>
References: <20211009034713.1489183-1-ming.lei@redhat.com>
 <20211009034713.1489183-7-ming.lei@redhat.com>
 <20211012103010.GA29640@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211012103010.GA29640@lst.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211012_080709_283366_A9876BA7 
X-CRM114-Status: GOOD (  15.68  )
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

On Tue, Oct 12, 2021 at 12:30:10PM +0200, Christoph Hellwig wrote:
> On Sat, Oct 09, 2021 at 11:47:13AM +0800, Ming Lei wrote:
> > +	spin_lock_irqsave(&q->queue_lock, flags);
> > +	if (!q->quiesce_depth++)
> > +		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);
> 
> We can get rid of the QUEUE_FLAG_QUIESCED flag now and just look
> at ->quiesce_depth directly.

I'd rather not to do that given we need to check QUEUE_FLAG_QUIESCED in fast
path.

> 
> > +	spin_lock_irqsave(&q->queue_lock, flags);
> > +	WARN_ON_ONCE(q->quiesce_depth <= 0);
> > +	if (q->quiesce_depth > 0 && !--q->quiesce_depth) {
> 
> 	if (WARN_ON_ONCE(q->quiesce_depth <= 0))
> 		; /* oops */
> 	else if (!--q->quiesce_depth)
> 		run_queue = true;

OK.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
