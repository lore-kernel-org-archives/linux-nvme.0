Return-Path: <SRS0=Tecl=W7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C4AC3A5A8
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 18:02:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AE3422CEA
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Sep 2019 18:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FtSxPGm6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AE3422CEA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7nPQBD22iSWUIl8aFn7gOYz+PZav0JYZ25w8WWkJ4hE=; b=FtSxPGm6lxqdS1
	RnFV9OzdUSf6PU6n9i4FxWORosl2kvCNQtfT+3/RaTsQpPCF24/C+ndRjiFwxeKRxY92NiYz/EqYX
	9eB0a3SDyVI898poRYg+IlvuAfJRQUkcBq6L43F7n1h44HFGuQguIf1pe0rpoU46sklrUi9gS3PZm
	vivqLqHaBgnhMzLAlOJZubOLpJhvdVRhTkbcxess9/GxDqLboHsiWkDf2ygKz/KVvCvrKA+4M6nKf
	ODLMnJnv0fb8osNs+upsiEt5K3xxNpmmoiZoT4TubXohHIYjuu/zg1qhlIsJy2N10Ni2DaPcJ6cmA
	8OyL9HNeb+vpHQNnAkTQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5Zbn-0004rO-8X; Wed, 04 Sep 2019 18:02:19 +0000
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i5Zbi-0004qX-Oq; Wed, 04 Sep 2019 18:02:14 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 32C2D3060BF;
 Wed,  4 Sep 2019 20:01:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id CD686201265AF; Wed,  4 Sep 2019 20:02:11 +0200 (CEST)
Date: Wed, 4 Sep 2019 20:02:11 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 1/4] softirq: implement IRQ flood detection mechanism
Message-ID: <20190904180211.GX2332@hirez.programming.kicks-ass.net>
References: <alpine.DEB.2.21.1908281605190.23149@nanos.tec.linutronix.de>
 <20190903033001.GB23861@ming.t460p>
 <299fb6b5-d414-2e71-1dd2-9d6e34ee1c79@linaro.org>
 <20190903063125.GA21022@ming.t460p>
 <6b88719c-782a-4a63-db9f-bf62734a7874@linaro.org>
 <20190903072848.GA22170@ming.t460p>
 <dd96def4-1121-afbe-2431-9e516a06850c@linaro.org>
 <6f3b6557-1767-8c80-f786-1ea667179b39@acm.org>
 <2a8bd278-5384-d82f-c09b-4fce236d2d95@linaro.org>
 <de16de12-fa1a-666c-ea19-fea5d096c1ca@acm.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de16de12-fa1a-666c-ea19-fea5d096c1ca@acm.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: Jens Axboe <axboe@fb.com>, Hannes Reinecke <hare@suse.com>,
 John Garry <john.garry@huawei.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-scsi@vger.kernel.org, Long Li <longli@microsoft.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 LKML <linux-kernel@vger.kernel.org>, linux-nvme@lists.infradead.org,
 Ming Lei <ming.lei@redhat.com>, Keith Busch <keith.busch@intel.com>,
 Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Wed, Sep 04, 2019 at 10:38:59AM -0700, Bart Van Assche wrote:
> On 9/4/19 10:31 AM, Daniel Lezcano wrote:
> > On 04/09/2019 19:07, Bart Van Assche wrote:
> > > Only if CONFIG_IRQ_TIME_ACCOUNTING has been enabled. However, I don't
> > > know any Linux distro that enables that option. That's probably because
> > > that option introduces two rdtsc() calls in each interrupt. Given the
> > > overhead introduced by this option, I don't think this is the solution
> > > Ming is looking for.
> > 
> > Was this overhead reported somewhere ?
>  I think it is widely known that rdtsc is a relatively slow x86 instruction.
> So I expect that using that instruction will cause a measurable overhead if
> it is called frequently enough. I'm not aware of any publicly available
> measurement data however.

https://www.agner.org/optimize/instruction_tables.pdf

RDTSC, Ryzen: ~36
RDTSC, Skylake: ~20

Sadly those same tables don't list the cost of actual exceptions or even
IRET :/

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
