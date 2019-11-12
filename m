Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B502C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 09:57:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85BD20679
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 09:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TbUWOURj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2U1NwoU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85BD20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1N2sEkGcWgOJCmR/ioAGscNJNZwrEmmOrc0fvkX9A4k=; b=TbUWOURjoBNPKe
	p+steuprfm18YLSC/8nP/zGMroP3kwFmq31r4Tu16o/g1mcgglhFTqX3PrxElBEH8h4HD2hKtGjLX
	0l1+n/XADcKVvUGcTnyDWu06XCrYNQwO2jJPAy2E9BHK3AVlLTnZ1YMWjAuE9Sc5an3xcPZ8PiKcR
	OBYGzRSCQsUcQJoqZJKm+ULlgzjTZQLiLCeCtk5VrNQEHlvVc4IGSiwOTCytQQ1jkeNsyhOMoeL/6
	f/yWii3b31L9DbB/34XeWLSQ6hTTWW7uLX8tMqOCXc8Fp1t0t7624Kyy+75jAB8yyoxs3qoQPM53Q
	2xYjD3AtUpiNBmJFoMbg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUSv7-0006Ck-5H; Tue, 12 Nov 2019 09:57:09 +0000
Received: from us-smtp-1.mimecast.com ([207.211.31.81]
 helo=us-smtp-delivery-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUSv3-0006CA-7I
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 09:57:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573552624;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6KApUkJs5EBcWKdLWVz726Vb2OBNOPY6Y641S40/4dk=;
 b=i2U1NwoUn0Fh6nkv+/cKed7mZt4x38q4bApZ5jQy/h7fbVxMyhFOrg1TP0sM+5GB/77j1r
 gKz3gAFir+yk3a4MFMQFkBwJEyaJKAcpLJM60lJpRFzV07+EsdKrm2zLDphB89A0XN6Mli
 nmxLpN1EK3n4Ds8MlzcaRGKSkcagvCA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-bwp5oRNmNAqHTeiganKIXw-1; Tue, 12 Nov 2019 04:57:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 20FBA477;
 Tue, 12 Nov 2019 09:57:00 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AC8985DF2C;
 Tue, 12 Nov 2019 09:56:53 +0000 (UTC)
Date: Tue, 12 Nov 2019 17:56:49 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 2/2] nvme-pci: poll IO after batch submission for
 multi-mapping queue
Message-ID: <20191112095649.GE15079@ming.t460p>
References: <20191108035508.26395-1-ming.lei@redhat.com>
 <20191108035508.26395-3-ming.lei@redhat.com>
 <82fb330e-a507-999a-69f3-947f13bbaae1@grimberg.me>
MIME-Version: 1.0
In-Reply-To: <82fb330e-a507-999a-69f3-947f13bbaae1@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: bwp5oRNmNAqHTeiganKIXw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_015705_343440_1669BC65 
X-CRM114-Status: GOOD (  22.76  )
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
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Long Li <longli@microsoft.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Mon, Nov 11, 2019 at 05:44:10PM -0800, Sagi Grimberg wrote:
> 
> > f9dde187fa92("nvme-pci: remove cq check after submission") removes
> > cq check after submission, this change actually causes performance
> > regression on some NVMe drive in which single nvmeq handles requests
> > originated from more than one blk-mq sw queues(call it multi-mapping
> > queue).
> > 
> > Actually polling IO after submission can handle IO more efficiently,
> > especially for multi-mapping queue:
> > 
> > 1) the poll itself is very cheap, and lockless check on cq is enough,
> > see nvme_cqe_pending(). Especially the check can be done after batch
> > submission is done.
> > 
> > 2) when IO completion is observed via the poll in submission, the requst
> > may be completed without interrupt involved, or the interrupt handler
> > overload can be decreased.
> > 
> > 3) when single sw queue is submiting IOs to this hw queue, if IOs completion
> > is observed via this poll, the IO can be completed locally, which is
> > cheaper than remote completion.
> > 
> > Follows test result done on Azure L80sv2 guest with NVMe drive(
> > Microsoft Corporation Device b111). This guest has 80 CPUs and 10
> > numa nodes, and each NVMe drive supports 8 hw queues.
> 
> I think that the cpu lockup is a different problem, and we should
> separate this patch from that problem..

Why?

Most of CPU lockup is a performance issue in essence. In theory,
improvement in IO path could alleviate the soft lockup. 

> 
> > 
> > 1) test script:
> > fio --bs=4k --ioengine=libaio --iodepth=64 --filename=/dev/nvme0n1 \
> > 	--iodepth_batch_submit=16 --iodepth_batch_complete_min=16 \
> > 	--direct=1 --runtime=30 --numjobs=1 --rw=randread \
> > 	--name=test --group_reporting --gtod_reduce=1
> > 
> > 2) test result:
> >       | v5.3       | v5.3 with this patchset
> > -------------------------------------------
> > IOPS | 130K       | 424K
> > 
> > Given IO is handled more efficiently in this way, the original report
> > of CPU lockup[1] on Hyper-V can't be observed any more after this patch
> > is applied. This issue is usually triggered when running IO from all
> > CPUs concurrently.
> > 
> 
> This is just adding code that we already removed but in a more
> convoluted way...

That commit removing the code actually causes regression for Azure
NVMe.

> 
> The correct place that should optimize the polling is aio/io_uring and
> not the driver locally IMO. Adding blk_poll to aio_getevents like
> io_uring would be a lot better I think..

This poll is actually one-shot poll, and I shouldn't call it poll, and
it should have been called as 'check cq'.

I believe it has been tried for supporting aio poll before, seems not
successful.

> 
> > I also run test on Optane(32 hw queues) in big machine(96 cores, 2 numa
> > nodes), small improvement is observed on running the above fio over two
> > NVMe drive with batch 1.
> 
> Given that you add shared lock and atomic ops in the data path you are
> bound to hurt some latency oriented workloads in some way..

The spin_trylock_irqsave() is just called in case that nvme_cqe_pending() is
true. My test on Optane doesn't show that latency is hurt.

However, I just found the Azure's NVMe is a bit special, in which
the 'Interrupt Coalescing' Feature register shows zero. But IO interrupt is
often triggered when there are many commands completed by drive.

For example in fio test(4k, randread aio, single job), when IOPS is
110K, interrupts per second is just 13~14K. When running heavy IO, the
interrupts per second can just reach 40~50K at most. And for normal nvme
drive, if 'Interrupt Coalescing' isn't used, most of times one interrupt
just complete one request in the rand IO test.

That said Azure's implementation must apply aggressive interrupt coalescing
even though the register doesn't claim it.

That seems the root cause of soft lockup for Azure since lots of requests
may be handled in one interrupt event, especially when interrupt event is
delay-handled by CPU. Then it can explain why this patch improves Azure
NVNe so much in single job fio.

But for other drives with N:1 mapping, the soft lockup risk still exists.


thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
