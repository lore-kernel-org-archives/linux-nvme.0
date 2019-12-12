Return-Path: <SRS0=hCdm=2C=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31991C43603
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 15:53:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0369822527
	for <linux-nvme@archiver.kernel.org>; Thu, 12 Dec 2019 15:53:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cdtaIUAI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oadawasc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0369822527
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/McgbbxOl3/SM6rqjhBTM3YER4Vxn8u6PbMGfpNBwJ0=; b=cdtaIUAIHDzA14
	hEkX9r0jHUCGQNb79Mg9Lf4NqaFPiiPAzs7USA5jvKd0dAWTRQeSHH5LBDqNfCho8sU98hkrvSC3C
	gAhXf95UbNKBwhwx2rJ3O32JvzpLELzxYJZzlmTDebBxdohCdYUQ7xOr54eoVvUmkLhdSrgoVM8Z9
	M+LqkAaZs3BH8Qyjy0wwXY6ll319McCzwv2LQ0PUkbkb4H40k8D+IJAryagpMm5O7psQDqGaf7+mJ
	lRktHC71Jl5/Ylr9G6Z0eK+QIlJcJbJF+IWA+EO/PVuaXc4osjopcEgrtbtdbjPR9N5aff6rKO3rQ
	DzDCGIeh70YnT0bBvpig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ifQmK-0005qW-7h; Thu, 12 Dec 2019 15:53:24 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ifQmH-0005qD-Nl
 for linux-nvme@lists.infradead.org; Thu, 12 Dec 2019 15:53:22 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8454A205C9;
 Thu, 12 Dec 2019 15:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1576166001;
 bh=79uIVUwkIBfnt5Xz5hSDCyfzmBkF5s5mlSTsr7SxyE8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=oadawascfwYtwyv5NP5K70QsdXUrY7dEesa7TEVaVwFSIp/lcqjTFGRQoXCHoZGd0
 BYCtf60/JA5GOZHwaNYqBjd5BFYyOZGxnqiif75mAe0/4E8U5sWQEGPDpdAklD0V2c
 /iMvS+gvdKstisF9MyWqJ4FImQ9V/YXO3NEEX16U=
Date: Fri, 13 Dec 2019 00:53:18 +0900
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCHv3 1/4] nvme/pci: Disable interrupts for threaded handler
Message-ID: <20191212155318.GA30611@redsun51.ssa.fujisawa.hgst.com>
References: <20191209175622.1964-1-kbusch@kernel.org>
 <20191209175622.1964-2-kbusch@kernel.org>
 <20191212090952.GB2399@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191212090952.GB2399@lst.de>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191212_075321_791493_00E47ED6 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: bigeasy@linutronix.de, tglx@linutronix.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, ming.lei@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Dec 12, 2019 at 10:09:52AM +0100, Christoph Hellwig wrote:
> On Tue, Dec 10, 2019 at 02:56:19AM +0900, Keith Busch wrote:
> > +	if (!to_pci_dev(nvmeq->dev->dev)->msix_enabled)
> > +		writel(1 << nvmeq->cq_vector, nvmeq->dev->bar + NVME_REG_INTMS);
> > +
> > +	disable_irq_nosync(irq);
> 
> Why do we need both the device-level disable and disable_irq_nosync
> for the non-MSI-X case here?

There's a race condition that needs to be handled here. We mask the
interrupt on the device, but the device may have sent an MSI at the
same time that the APIC hasn't seen yet, and that would retrigger
the interrupt handler. We need it to see irqd_irq_disabled() is true,
otherwise the nvme primary and thread may run at the same time, which
we don't want in order to poll the cq from both.

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
