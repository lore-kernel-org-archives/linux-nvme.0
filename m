Return-Path: <SRS0=peCB=2B=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7F1CC43603
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 17:35:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767F122527
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2019 17:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gkLqECT2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0QZsYvf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767F122527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dyHi/yKB15lWx2vqf1UucB9uCS6aewy9oZA2GDNgzzc=; b=gkLqECT2QmcGpA
	mg6mt1CSq8uSVanytq6Uc1pUsyTSkE7WWVTQtWMvy/cwAVkgfpHVqnfMFWTN6VcQ1D4WstkYhLmie
	4KSicf9e/LQPcj1rBKkC1rCFJKMjKvuS8hlfzei/AeIO5O/5fSK2Qp4axGY1+FsNuuXj8tPka18Uc
	u1JafGJy+S3VbToYmpLfdskoL0+dQQ8aaM7hI87bXZcGzDzy6ZlRsxsseKBTeTm2OzxUADw1nR2qz
	3ask54TXDWURWdDSkC1xM2ZcC2AnNpl8We1XNGnO5RuWhmWthJwL39SMbznGkVgPDLpGrbsyN5KUE
	HMvzu+hmslhKympEna9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1if5tm-0007ln-Ha; Wed, 11 Dec 2019 17:35:42 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1if5tj-0007l2-ID
 for linux-nvme@lists.infradead.org; Wed, 11 Dec 2019 17:35:40 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 052A4206C3;
 Wed, 11 Dec 2019 17:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576085738;
 bh=Zzm5lV3Vu36TptMzcIZVcJ6mmpLp0tpuG/p2OUIcgRc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k0QZsYvfRwnzVmYogfGYK59silZLhaGt2oA6Vbp3qx+xbR8kb1IebbriJ07leFT3o
 092slErU6ovF2v5RhmWAGhT5pj0Ta4LyqS5KW5BNCQSk5jyZpssThmsmsixgVRaK9R
 AoqEqIVMiYwAZaQ8BR2yb1JuS0XhFU3Pkn/WTnAQ=
Date: Thu, 12 Dec 2019 02:35:32 +0900
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCHv3 2/4] nvme/pci: Complete commands from primary handler
Message-ID: <20191211173532.GB493@redsun51.ssa.fujisawa.hgst.com>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-3-kbusch@kernel.org>
 <6d55a705-6a43-5b47-166c-5d2b458fd6a5@grimberg.me>
 <20191210202506.GA26810@redsun51.ssa.fujisawa.hgst.com>
 <c58e2cb5-e03c-c56f-8c67-a791ac1eb2c6@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c58e2cb5-e03c-c56f-8c67-a791ac1eb2c6@grimberg.me>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191211_093539_620617_99EB3520 
X-CRM114-Status: GOOD (  12.24  )
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
Cc: bigeasy@linutronix.de, tglx@linutronix.de, hch@lst.de,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Dec 10, 2019 at 01:14:19PM -0800, Sagi Grimberg wrote:
> > > If I have say 24 (or more) devices with a queue mapped to a cpu, and we
> > > happen to just reap in the primary handler for all devices, all the time,
> > > are we safe from cpu lockup?
> > 
> > I can't readily test that scenario, but I'm skeptical a workload
> > can keep the primary handler running without ever seeing it return
> > IRQ_WAKE_THREAD. If that is really a problem, we can mitigate it by
> > limiting the number of CQEs the primary handler may process.
> 
> Theoretically speaking, even if you limit to 1 cqe, the universe can
> align such that you will always reap in the primary handler right?

Perhaps theoretically, though testing the limits of reason.

> So if we have this optimization, perhaps something else in the irq
> infrastructure should take care of cpu lockup prevention?

Perhaps we can cycle the effective_affinity through the smp_affinity?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
