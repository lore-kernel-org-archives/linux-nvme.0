Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85F48C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 23:30:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5603E214D8
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 23:30:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UpC8Z5Xl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcaGfpMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5603E214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=y0FM4447yol1u+O5SZ8yKDvptnr5lrgtM4ai3O0/rCo=; b=UpC8Z5Xl82cOdt
	AzWPPiT92ugxXqzr8uS64xATivv1Z2sNq4Z9QDxwFAq3rDKse59SlWsU4W6DBBxuo0BuiYJY2XdUM
	90YzPSs2Bj4Y6+9fNrADvPD+ZsWN0DfitRoHfs+zHLyx2r74QOZXx6jJLIkoaWlFTFAhvSaTy21AG
	6bubwBROxD0h+Tv6yqcpf3zfsq2oN55h/hv3UBFUBD6h/PkKVJEG48rkECpRf8BxF7sbhvYaqkpMa
	Tkf0o+gRc/o5iwxaLHqmncu2/zDocvd/4WZ2ZbhyWJpckyO5FQ13S9sUuPDERUB3JP3AIxJH7rYlw
	KcnsnbshvswYUg+ZarNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifXuu-0005JY-HI; Thu, 12 Dec 2019 23:30:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifXur-0005JA-Sq
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 23:30:43 +0000
Received: from C02WT3WMHTD6 (unknown [8.36.226.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E75B0214AF;
 Thu, 12 Dec 2019 23:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576193441;
 bh=pjpMfUn/lTNY4Cod/Vg2CZVsJfbrjInnqZ2fsjB59As=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kcaGfpMcL0prbyZ9e2fYuAfyxAUBdpClctkVvt9lrX8qqsqtysdWo2CwjzOYauAY0
 ls+fQxEl15gEjr6+CaCv+mTXrYN0znBd1NbtnAJeAALaFw++ecB9cpBP78FJYREW58
 X7l6uAitVjvpJYjBoLpuUSbmYBtY3Y+LtN5aqtic=
Date: Thu, 12 Dec 2019 16:30:39 -0700
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCHv3 2/4] nvme/pci: Complete commands from primary handler
Message-ID: <20191212233039.GA69218@C02WT3WMHTD6>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-3-kbusch@kernel.org>
 <6d55a705-6a43-5b47-166c-5d2b458fd6a5@grimberg.me>
 <20191210202506.GA26810@redsun51.ssa.fujisawa.hgst.com>
 <c58e2cb5-e03c-c56f-8c67-a791ac1eb2c6@grimberg.me>
 <20191211173532.GB493@redsun51.ssa.fujisawa.hgst.com>
 <79442e8d-719a-7510-deea-cc23694fdec0@grimberg.me>
 <20191212010240.GA29574@redsun51.ssa.fujisawa.hgst.com>
 <20191212225552.GB24463@ming.t460p>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191212225552.GB24463@ming.t460p>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_153041_955745_FDB06F10 
X-CRM114-Status: GOOD (  10.70  )
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
Cc: bigeasy@linutronix.de, tglx@linutronix.de, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Dec 13, 2019 at 06:55:52AM +0800, Ming Lei wrote:
> On Thu, Dec 12, 2019 at 10:02:40AM +0900, Keith Busch wrote:
> > On Wed, Dec 11, 2019 at 04:40:47PM -0800, Sagi Grimberg wrote:
> > > > Perhaps we can cycle the effective_affinity through the smp_affinity?
> > > 
> > > Not sure I follow your thoughts.
> > 
> > The only way the nvme driver's interrupt handler can saturate a
> > cpu requires the smp_affinity have multiple online cpus set. The
> 
> As Sagi mentioned, there can be 24 drives, each drive can be 1:1
> mapping, so each CPU may have to handle interrupts from 24 drives/queues,
> then the CPU may become slower compared with the 24 hardware/queues.

If it's 1:1 queue:cpu, then it doesn't matter how many devices you
have. Processes can't submit commands on that cpu while that cpu
is servicing device interrupts, but the device can't send interrupts
if processes can't submit commands.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
