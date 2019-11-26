Return-Path: <SRS0=Q2qb=ZS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED93FC432C0
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 20:28:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCF720863
	for <linux-nvme@archiver.kernel.org>; Tue, 26 Nov 2019 20:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APYgqwWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCF720863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+OTFV37k4idkh8yW12iHWv3/Yx1T81GurOcDJCX3H2I=; b=APYgqwWzB0bMYa
	FXPkA/1AFCkAyl2yCHzxdBrYSL20xJrsbss8nAtMPN9Jnt9gnZTZo8KEY+y83L2JEYGaqe+97ZEq2
	OQdgqVQB+65xMZP5LmPGM4RNvFjbRqS1QfTryuxNkgbOZor9V5u0+nLbfzOrtUJORFzDVYbzoOrTc
	TWa0CB/zNAwMwqGra2lAIod5z1rjqYwzwj0Uw168UIhbV/Wt8l5Rscu9Ji2+E7/aVr4TK1XApKFjB
	+YoLOicDhyF2kHMdYQph/TdYZx1/ne5a5ayi6dp0zNDMkZyG1XmFmc+In25vymm0Bgx7tS/fTKd0y
	7cSMc8q4rcYsfP+L7TAA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iZhRd-00008a-VC; Tue, 26 Nov 2019 20:28:21 +0000
Received: from galois.linutronix.de ([2a0a:51c0:0:12e:550::1])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iZhRb-00007c-4D
 for linux-nvme@lists.infradead.org; Tue, 26 Nov 2019 20:28:20 +0000
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
 (envelope-from <bigeasy@linutronix.de>)
 id 1iZhRW-0005U9-4y; Tue, 26 Nov 2019 21:28:14 +0100
Date: Tue, 26 Nov 2019 21:28:14 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-nvme@lists.infradead.org
Subject: [RFC] nvme-pci does not disable interrupt-source in threaded mode
Message-ID: <20191126202814.vrfezzu6eon7tbf6@linutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191126_122819_308021_DBDAFEB0 
X-CRM114-Status: UNSURE (   7.99  )
X-CRM114-Notice: Please train this message.
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
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From drivers/nvme/host/pci.c:
| static int queue_request_irq(struct nvme_queue *nvmeq)
| {
|         struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
|         int nr = nvmeq->dev->ctrl.instance;
| 
|         if (use_threaded_interrupts) {
|                 return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
|                                 nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);

nvme_irq_check() checks if an interrupt is pending and does not disable
interrupt source if the interrupt is pending. It simply wakes the thread.
This works because the MSI-IRQ-controller is handled as edge and it does
not re-trigger. Should the IRQ fallback to non-MSI it would become LEVEL
and will keep the IRQ-line asserted so the threaded handler will no be reached.

One of these should be done:
- remove "use_threaded_interrupts" and rely simply on the "threadirqs"
  kernel command line.
- Let nvme_irq_check() disable the IRQ-source and nvme_irq() should
  enable it again once done.
- Pass IRQF_ONESHOT as irqflags.

Side note:
 msix_request_rcd_irq() (drivers/infiniband/hw/hfi1/msix.c) provides also
 both handlers and (according to the comment) receive_context_interrupt()
 disables the source before waking the thread. This one is fine and I
 did not find more users of pci_request_irq() providing both handlers.

Sebastian

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
