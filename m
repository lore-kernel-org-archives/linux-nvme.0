Return-Path: <SRS0=ia7R=ZO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23852C432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 10:25:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA21C20708
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Nov 2019 10:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pWInZdZW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XCUTPmxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA21C20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oxZ9nlKTZLJPXrcAFGqF9emsa6gD7qDmOiGDzAjVjpY=; b=pWInZdZW7NNAy1
	WKXi6yuOYa9HjwGKz5LrYAqKZ2P0PDcfGJEngoaog9FJsyvZENm58akXMypDQeQptoPICdY/qeuCO
	NahZ6xM96TEQRVm7iSEdwIB7mit/nVmkN0UXwFku/QeZXyXD5uiVyouJEy7yjQCcdL1yDSseBj6Y0
	We4Us8aFfQun7WwDU5kKH570NBMc2wQtCiAHeO6sjjuX3Haqplnj86wjh7ZAkgGu9Q2Z+T74D7k1r
	SoSgjHTm/xxMvMGRoIewsS4BGnNUTTVYzbPugkbxd3q1//r7ypbcXSxp08Dhx4FM9tQvj5aZFLsvb
	R/bI/yRS/vBOerGtjKKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iY68B-0006cY-W4; Fri, 22 Nov 2019 10:25:39 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iY689-0006aN-E8
 for linux-nvme@lists.infradead.org; Fri, 22 Nov 2019 10:25:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574418336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BKdSPD5HpWyrtN1JcI+eg46Kq2p2Ssam2hHZBYC7l3c=;
 b=XCUTPmxnBNDlo8niOuwUeZMeyOW1y4kTCbwf15t086TrhTnOaPA9Qa2INlnoQ3SRyo3B5C
 3kvgpJ2Y903eXanDkLaJ2j4Mb+pCFsqQLSqqosfrYfzxMRQlgN0xkrIvORI2Mxdab1AyHP
 W4nmJNpLBu3ef5XBAIJGgfr3KrCyv30=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-100-DBiJAfubOdS6znmlKJX8_A-1; Fri, 22 Nov 2019 05:25:32 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 44DE7107ACC5;
 Fri, 22 Nov 2019 10:25:31 +0000 (UTC)
Received: from ming.t460p (ovpn-8-23.pek2.redhat.com [10.72.8.23])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70B2F1036C85;
 Fri, 22 Nov 2019 10:25:22 +0000 (UTC)
Date: Fri, 22 Nov 2019 18:25:17 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH V3 0/2] nvme-pci: check CQ after batch submission for
 Microsoft device
Message-ID: <20191122102517.GA30001@ming.t460p>
References: <20191114025917.24634-1-ming.lei@redhat.com>
 <20191121031154.GJ24548@ming.t460p> <20191121061431.GA22886@lst.de>
 <20191121074643.GB4755@ming.t460p>
 <20191121154531.GB17852@redsun51.ssa.fujisawa.hgst.com>
 <20191122094457.GA23632@ming.t460p> <20191122095743.GA21087@lst.de>
MIME-Version: 1.0
In-Reply-To: <20191122095743.GA21087@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: DBiJAfubOdS6znmlKJX8_A-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191122_022537_547002_0E35FF72 
X-CRM114-Status: GOOD (  19.86  )
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Long Li <longli@microsoft.com>,
 linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
 Nadolski Edmund <edmund.nadolski@intel.com>, Keith Busch <kbusch@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Nov 22, 2019 at 10:57:43AM +0100, Christoph Hellwig wrote:
> On Fri, Nov 22, 2019 at 05:44:57PM +0800, Ming Lei wrote:
> > > Can this default coalescing setting be turned off with a "set feature"
> > > command?
> > > 
> > 
> > At default, 'get feature -f 0x8' shows zero, and nothing changes after
> > running 'set feature -f 0x8 -v 0'.
> > 
> > BTW, soft lockup from another Samsung NVMe can be fixed by this patch
> > too. I am confirming if the Samsung NVMe applies aggressive interrupt
> > coalescing too.
> 
> I think we are missing up a few things here, and just polling the
> completion queue from submission context isn't the right answer for
> either.
> 
> The aggressive interrupt coalescing and resulting long run times of
> the irq handler really just means we need to stop processing them from
> hard irq context at all.  NVMe already has support for threaded
> interrupts and we need to make that the default (and possibly even
> the only option).  At that point we can do a cond_resched() in this
> handler to avoid soft lockups.

I am pretty sure that threaded interrupt will cause performance drop a lot,
and Long has verified that.

> 
> The next problem is drivers with less completion queues than cpu cores,

IRQ matrix has balanced interrupt load among CPUs already. For example,
on Azure, 8 cpu cores can be mapped to one hctx, however, there are only
several CPUs which handles interrupts from at most two queues.

> as that will still overload the one cpu that the interrupt handler was
> assigned to.  A dumb fix would be a cpu mask for the threaded interrupt

Actually one CPU is fast enough to handle several drive's interrupt handling.
Also there is per-queue depth limit, and the interrupt flood issue in network
can't be serious on storage.

So far I only got three NVMe softlock tickets, two of them can be fixed by this
patch, and another one turns out a IOMMU lock issue. Are there other
NVMe softlock report?

At least Azure's NVMe applies aggressive interrupt coalescing, in which
the softlock is usually triggered by interrupt delay handling, then
there can be lots of requests to be handled in single interrupt handler
some times. It doesn't mean CPU is saturated, and it is just sort of
interrupt peak. And it is very specific with Azure's implementation.

Otherwise, this simple patch can't fix the issue.

> handler that can be used for round robin scheduling, but that probably
> won't help with getting good performance.  The other idea is to use
> "virtual" completion queues.  NVMe allows free form command ids, so
> we could OR an index for the relative cpu number inside this queue
> into the command id and and then create one interrupt thread for
> each of them.  Although I'd like to hear from Thomas on what he thinks
> of multiple threads per hardirq first.

As mentioned above, there isn't proof it is caused by interrupt loading
saturating the CPU, so not sure we need to re-invent a wheel.


Thanks,
Ming


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
