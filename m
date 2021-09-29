Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB282C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 15:45:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50272614C8
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 15:45:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 50272614C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Y6PrdWOjCw33/IKTzws83iWAaU98d/zNTAB1pYFlCV0=; b=t3V+mVlLn1BqHd
	/o8l+N7bi8nUyykAtLu8MjGDyifuAO4urLamZzuKF4sTiNZ6/8mRIG2TGtwyhZmfFVH4Ofas5j3Qq
	U2HjFBSM+kLshY0+zaQJn/5XPrvPO0xovqqlGNO/hnPVOXMRiPnjiTNs2x4K1gTqWSSrTqzCc+Nl0
	H8wPrYk8+eVt96jA3TusePRT8qXhbFqW3zFMHpAVc/cmSFy+gI9i9fXZTIXCXOxdo7P6oA7qsXs12
	bWa+BZ3rTYlUGWCVlNltjGPvkjgyI0KPVeqCEPSU/e6GOyjnlFiwvjVsvZ3VBE5NvBiAKFATW5x9y
	d0VQ3v8qu3mKzgrz6t8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVbkw-00Bbuk-QK; Wed, 29 Sep 2021 15:44:26 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVbku-00BbuE-MQ
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 15:44:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632930263;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LR3ObdM1X37e6OfSRn8U+lGYCyvoYCCHleB0Zqxpw04=;
 b=VP8NTOhCZ+HU+Q2qAm8mLxXEKvju4dAHysleRcH5vetkP8pYWNvDX36bFxfH8JVGL8Elhw
 rAz+p6VmDwK/WJZJ5Ig2CQQs/K9CmuubbGpNU0qujX12ibGrwpjhhzTnDivNGqW04Ng6i+
 4VP9mgXjgXDAEj/D0oWtvFIcdD31rn0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562-ooXitBhVPKK49Q_IGM_U2A-1; Wed, 29 Sep 2021 11:44:20 -0400
X-MC-Unique: ooXitBhVPKK49Q_IGM_U2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F388801B3D;
 Wed, 29 Sep 2021 15:44:19 +0000 (UTC)
Received: from T590 (ovpn-8-25.pek2.redhat.com [10.72.8.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 512855C1B4;
 Wed, 29 Sep 2021 15:44:14 +0000 (UTC)
Date: Wed, 29 Sep 2021 23:44:08 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 5/5] blk-mq: support nested blk_mq_quiesce_queue()
Message-ID: <YVSJyIxfFQ+KSNi4@T590>
References: <20210929041559.701102-1-ming.lei@redhat.com>
 <20210929041559.701102-6-ming.lei@redhat.com>
 <54b636d5-ede6-a700-4d02-4712db679234@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54b636d5-ede6-a700-4d02-4712db679234@grimberg.me>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210929_084424_831766_180E1D8C 
X-CRM114-Status: GOOD (  23.84  )
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

On Wed, Sep 29, 2021 at 02:53:27PM +0300, Sagi Grimberg wrote:
> 
> 
> On 9/29/21 7:15 AM, Ming Lei wrote:
> > Turns out that blk_mq_freeze_queue() isn't stronger[1] than
> > blk_mq_quiesce_queue() because dispatch may still be in-progress after
> > queue is frozen, and in several cases, such as switching io scheduler,
> > updating nr_requests & wbt latency, we still need to quiesce queue as a
> > supplement of freezing queue.
> > 
> > As we need to extend uses of blk_mq_quiesce_queue(), it is inevitable
> > for us to need support nested quiesce, especailly we can't let
> > unquiesce happen when there is quiesce originated from other contexts.
> 
> The serialization need is clear, but why is the nesting required?

I guess the serialization is what my nesting meant:

1) code path1:

- quiesce
- do something
- unquiesce

2) code path2:
- quiesce
- do something
- unquiesce

What the patch tries to implement is that the actual unquiesce action has
to be done in the last or outermost unquiesce of the two code paths.

Not sure if serialization is a good term here, maybe I should use words of
concurrent quiesce, or other better one? Nesting is really supported
by this patch, such as code path2 may be part of 'do something' in code
path1. Meantime serialization among quiesce and unquiesce is supported
too.

> In other words what is the harm is running the hw queue every time
> we unquiesce?

running hw queue in each unquiesce doesn't matter, what matters is that
the QUIESCE flag has to be cleared in the outermost or the last unquiesce.
But if QUIESCE isn't set, it isn't useless to run hw queue in unquiesce.

 

Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
