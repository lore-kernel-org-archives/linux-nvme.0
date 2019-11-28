Return-Path: <SRS0=mBQh=ZU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8207DC432C0
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 03:59:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50EE7208E4
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Nov 2019 03:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JdmPHKhg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="brTGzT9U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50EE7208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z9pTSnD8WcJuIq6SaBj5kHPxvxkEHstSxQvEZI/5Buw=; b=JdmPHKhgcTa3RE
	J2SDVUBIf7/B7uPrO1jUwFTofiX9pnYksHpxMaFefKwG+BEcH4nTuJLbmAJQngQzvDp+Vo3UiLwF4
	gaxY+xb/kQ5Gh6ljbThtiP1kINZ6aD5yoH/RoqIqexMD2QWiXrJ0ID0N08nWr8HWnp9q8BYmYP/E9
	EktGtWq/ViGc1XrLBmuZkAS1WMTjC2Mk8U99SMCG0d+AxUhgBVFRAAIDHSh9QWeiFXUXwyck1jAM+
	xBWdeD74RBciegM8QH6zRHbIBxn0tr2id1tybeoa32c+tJWR3K1EFVybpEudqVz9E664kfXYm5LMD
	0xY5PyI4Onu8ATgd2bZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iaAxX-0003dP-Ak; Thu, 28 Nov 2019 03:59:15 +0000
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaAxV-0003cw-1B
 for linux-nvme@lists.infradead.org; Thu, 28 Nov 2019 03:59:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574913550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5mUEzvB7BE5+e+vLzcdYIQcW0pCfd/opQzCYrWthTxE=;
 b=brTGzT9UmKBFMGfaE6g2Zo4FeSVVkb7bMPFAFj2PwYSztj/MSZdQ4mRp77s/+m0/iV5VbS
 ky5J1a80sriyoTZkiN/Bjkm5CEIPO3/87bFFofxX0R/PLDWA9rjew0lWmtQfQomrEv30WY
 LGvBsM3+V5+3SBv+xJ3u1E5twOn4Xjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-sUuB7DpSNJ2ISCG5euzLOQ-1; Wed, 27 Nov 2019 22:59:07 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B2A9ADB20;
 Thu, 28 Nov 2019 03:59:05 +0000 (UTC)
Received: from ming.t460p (ovpn-8-21.pek2.redhat.com [10.72.8.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9CF6E608B9;
 Thu, 28 Nov 2019 03:58:58 +0000 (UTC)
Date: Thu, 28 Nov 2019 11:58:53 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/4] nvme/pci: Mask legacy and MSI in threaded handler
Message-ID: <20191128035853.GF3277@ming.t460p>
References: <20191127175824.1929-1-kbusch@kernel.org>
 <20191127175824.1929-3-kbusch@kernel.org>
 <20191128033956.GD3277@ming.t460p>
 <20191128034817.GC1738@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
In-Reply-To: <20191128034817.GC1738@redsun51.ssa.fujisawa.hgst.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: sUuB7DpSNJ2ISCG5euzLOQ-1
X-Mimecast-Spam-Score: 0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191127_195913_147063_F1697FDD 
X-CRM114-Status: GOOD (  14.08  )
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

On Thu, Nov 28, 2019 at 12:48:17PM +0900, Keith Busch wrote:
> On Thu, Nov 28, 2019 at 11:39:56AM +0800, Ming Lei wrote:
> > On Thu, Nov 28, 2019 at 02:58:22AM +0900, Keith Busch wrote:
> > > @@ -1502,6 +1524,11 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
> > >  	int nr = nvmeq->dev->ctrl.instance;
> > >  
> > >  	if (use_threaded_interrupts) {
> > > +		/* MSI and Legacy use the same NVMe IRQ masking */
> > > +		if (!pdev->msix_enabled)
> > > +			return pci_request_irq(pdev, nvmeq->cq_vector,
> > > +				nvme_irq_check_msi, nvme_irq_thread_msi,
> > > +				nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> > >  		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
> > >  				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
> > 
> > Just wondering why don't do that for misx_enabled, and according to
> > document of request_threaded_irq(), the handler is supposed to
> > disable the device's interrupt:
> 
> MSI-x is handled in patch 3/4. I just split the two since the mechanisms
> they use to mask interrupts are very different from each other.

Fine.

>  
> > 923aa4c378f9("PCI/MSI: Set IRQCHIP_ONESHOT_SAFE for PCI-MSI irqchips"),
> > then the question is that if interrupt mask is needed.
> 
> We don't want to use IRQF_ONESHOT for our MSI interrupts because that
> will write to the MSI mask config register, which is a costly non-posted
> transaction. The NVMe specific way uses much faster posted writes.

What I meant is that IRQF_ONESHOT isn't needed in case of IRQCHIP_ONESHOT_SAFE.

So it is reasonable to understand that interrupt mask isn't needed in the
hard interrupt handler in case of IRQCHIP_ONESHOT_SAFE. That is
basically what commit dc9b229a58dc("genirq: Allow irq chips to mark themself
oneshot safe") does.

Thanks,
Ming


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
