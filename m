Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD47C432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 08:41:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174BB2158A
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 08:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NlEjGY3w";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cb1vACVc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174BB2158A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GnKoFO8ExukETsxfTs+wXRaz6QRpwkUQRL1MzF081J8=; b=NlEjGY3w42c/Ui
	ATrtI2tlG75n+dS2cZIHt38IEF+qRHa0XmxhIN7qyVSz6X7Dzc+l1/2BWbr7OU3HNjxYWVaWXlc2Y
	fE22pWC61U03cC1XcJNNX+vHep0n2lfzdK05apSUIZweFpJI833JzdHr3Iwtt9wJtnvcoyUsy2yeh
	1UfgMDJ0bcT4wJ+NoJa1gfAYSW15Y5ifsSRDj2QV0BFxRQXKfYNq8A2HhGY5Xp8739tImVb7ar1Yl
	n5hw0t+pZLZOIOxMkCkk59xqxgpSUxJcEMp4Gw7k7bqjwE2ZL0+VnPIi7XHdb0MS+F1f34wUFi/+M
	4unM3/vlVFElWwI/JIwQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaFMy-0007op-Gn; Thu, 28 Nov 2019 08:41:48 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaFMu-0007oF-Lx
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 08:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574930502;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrFtyU8k8kdkSJ98Uqju+/VpgD6RkhdRd8RCszqLTQ4=;
 b=Cb1vACVcoctH9ohSkK0TFLA92eLCF+Nio49NseabS7oqsl6DwwJlKVax0rRd5rJHH7GVBJ
 kS7ei3AV90C8xd5CkUkMRhPdIpbYvR8qiS91RByeX7QrOcv9/wJB+niUAHpBM/QyU8SZPl
 Wekj9pmFdX0Xc9AQAEF7aV2kuLwhEmI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-lCl_NUQSPSOd5SmSq_3QYw-1; Thu, 28 Nov 2019 03:41:41 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9CC0E12CAC32;
 Thu, 28 Nov 2019 08:41:39 +0000 (UTC)
Received: from ming.t460p (ovpn-8-17.pek2.redhat.com [10.72.8.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 10F4B5D9E2;
 Thu, 28 Nov 2019 08:41:31 +0000 (UTC)
Date: Thu, 28 Nov 2019 16:41:26 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/4] nvme/pci: Mask legacy and MSI in threaded handler
Message-ID: <20191128084126.GB15549@ming.t460p>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-3-kbusch@kernel.org>
 <20191128033956.GD3277@ming.t460p>
 <20191128034817.GC1738@redsun51.ssa.fujisawa.hgst.com>
 <20191128035853.GF3277@ming.t460p>
 <20191128041404.GB1947@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20191128041404.GB1947@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: lCl_NUQSPSOd5SmSq_3QYw-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191128_004144_804821_0DFA936C 
X-CRM114-Status: GOOD (  15.38  )
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
Cc: sagi@grimberg.me, bigeasy@linutronix.de, linux-nvme@lists.infradead.org,
 helgaas@kernel.org, Thomas Gleixner <tglx@linutronix.de>, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Nov 28, 2019 at 01:14:04PM +0900, Keith Busch wrote:
> On Thu, Nov 28, 2019 at 11:58:53AM +0800, Ming Lei wrote:
> > On Thu, Nov 28, 2019 at 12:48:17PM +0900, Keith Busch wrote:
> > > On Thu, Nov 28, 2019 at 11:39:56AM +0800, Ming Lei wrote:
> > > > 923aa4c378f9("PCI/MSI: Set IRQCHIP_ONESHOT_SAFE for PCI-MSI irqchips"),
> > > > then the question is that if interrupt mask is needed.
> > > 
> > > We don't want to use IRQF_ONESHOT for our MSI interrupts because that
> > > will write to the MSI mask config register, which is a costly non-posted
> > > transaction. The NVMe specific way uses much faster posted writes.
> > 
> > What I meant is that IRQF_ONESHOT isn't needed in case of IRQCHIP_ONESHOT_SAFE.
> > 
> > So it is reasonable to understand that interrupt mask isn't needed in the
> > hard interrupt handler in case of IRQCHIP_ONESHOT_SAFE. That is
> > basically what commit dc9b229a58dc("genirq: Allow irq chips to mark themself
> > oneshot safe") does.
> 
> Hmm, it doesn't look like it's always safe. We have to stop the device
> from generating MSIs for new completions somehow while the threaded
> handler is running, otherwise those MSIs will be considered spurious
> when the thread never gets a chance to increment desc->threads_handled.
> 

I just observe hard interrupts triggered between start of nvme_irq_check()
and end of nvme_irq(). Yeah, there could be at most 36 interrupts comes during
the period on one machine, and most are <= 5.

So looks this patchset make sense, and also means that IRQCHIP_ONESHOT_SAFE
might be broken.


@interrupts_during_threaded:
[0, 1)           2074375 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@                       |
[1, 2)           3668018 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
[2, 3)           1508944 |@@@@@@@@@@@@@@@@@@@@@                               |
[3, 4)            554496 |@@@@@@@                                             |
[4, 5)            225761 |@@@                                                 |
[5, 6)             99354 |@                                                   |
[6, 7)             45127 |                                                    |
[7, 8)             20912 |                                                    |
[8, 9)              9940 |                                                    |
[9, 10)             4765 |                                                    |
[10, 11)            2458 |                                                    |
[11, 12)            1365 |                                                    |
[12, 13)             719 |                                                    |
[13, 14)             451 |                                                    |
[14, 15)             265 |                                                    |
[15, 16)             168 |                                                    |
[16, 17)             103 |                                                    |
[17, 18)              67 |                                                    |
[18, 19)              60 |                                                    |
[19, 20)              41 |                                                    |
[20, 21)              27 |                                                    |
[21, 22)              18 |                                                    |
[22, 23)              17 |                                                    |
[23, 24)               8 |                                                    |
[24, 25)               2 |                                                    |
[25, 26)               9 |                                                    |
[26, 27)               6 |                                                    |
[27, 28)               3 |                                                    |
[28, 29)               1 |                                                    |
[29, 30)               0 |                                                    |
[30, 31)               0 |                                                    |
[31, 32)               0 |                                                    |
[32, 33)               0 |                                                    |
[33, 34)               0 |                                                    |
[34, 35)               0 |                                                    |
[35, 36)               0 |                                                    |
[36, 37)               1 |                                                    |


Thanks,
Ming


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
