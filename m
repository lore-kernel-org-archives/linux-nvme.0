Return-Path: <SRS0=6Pwq=ZV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2DEC432C0
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2019 17:05:57 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B2D215A5
	for <linux-nvme@archiver.kernel.org>; Fri, 29 Nov 2019 17:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="k2ALX5Qz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B2D215A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=261lFO+ke3QvWQMWHRbn4DYYhTdUjhqkSHZapNvRd5U=; b=k2ALX5QzWp1qsp
	YryfRWN69nXwP+ZNpOucVLLEau/tmKaf5HoYqmQQP6C68cG1Ovw8jx7MO07RjncKGYDWVSFYoLM8y
	l7lYeVDyZu9b3gcwLhj9XxfRC57cj4XI/7C4ymqB4T3NL/DgmFMYA8e3e0W526t9UI6F/ShIQE8W1
	VsVj5LplGUevXeTFhQ20FvAhk+40FRI60AHVO69f5J1QTj3ULD3CORwOXSA1v1pSlLAWJ8e3cdBz2
	GdZPA7mZaeM58oBT6ovukiwwl34G56MiuHRnPEV7owCobTyeBvIljd/HrJJukAzriN7wKEwV+FoPe
	JYrLOegCunvqMWPjM8fg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iajiM-00062y-Ry; Fri, 29 Nov 2019 17:05:54 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iajiH-00061n-AG
 for linux-nvme@lists.infradead.org; Fri, 29 Nov 2019 17:05:53 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1iajiD-0002UP-SF; Fri, 29 Nov 2019 18:05:45 +0100
Date: Fri, 29 Nov 2019 18:05:45 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 0/4] nvme: Threaded interrupt handling improvements
Message-ID: <20191129170545.axnykbrabigzcghs@linutronix.de>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191129094640.6fq6wcxmfi4fwnlw@linutronix.de>
 <20191129162719.GA47681@C02WT3WMHTD6.lpcnextlight.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191129162719.GA47681@C02WT3WMHTD6.lpcnextlight.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191129_090551_735801_4EFB2C2F 
X-CRM114-Status: GOOD (  12.25  )
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
Cc: ming.lei@redhat.com, helgaas@kernel.org, hch@lst.de,
 linux-nvme@lists.infradead.org, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 2019-11-29 09:27:19 [-0700], Keith Busch wrote:
> On Fri, Nov 29, 2019 at 10:46:40AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2019-11-28 02:58:20 [+0900], Keith Busch wrote:
> > > Threaded interrupts allow the device to continue sending interrupt
> > > messages while the driver is handling the previous notification. This
> > > can cause a significant amount of CPU cycles unnecessarily spent in hard
> > > irq context, and potentially triggers spurious interrupt detection to
> > > disable the nvme interrupt.
> > 
> > Thank you for looking into this.
> > To be clear: the "spurious interrupt detector" won't do a thing if you
> > never return IRQ_NONE. As long as you return IRQ_HANDLED, everything is
> > fine.
> 
> That's not entirely accurate. We have to return IRQ_WAKE_THREAD
> from the hardirq handler, which gets converted to IRQ_NONE if
> desc->threads_handled hasn't changed and considered spurious. If
> the threaded handler runs sufficiently long, desc->threads_handled
> won't get updated frequently enough, so this series fixes that for
> nvme by masking the interrupt in the device, preventing future hard
> irq callbacks.

Ach okay. But I wouldn't consider it as a "bug" if your threaded handler
returns IRQ_HANDLED and requires a longer period of time. Thsi seems
fine to me.
The SDHCI driver has a case where the interrupt thread waits for another
interrupt (from its primary handler) in order to make progress.

Sebastian

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
