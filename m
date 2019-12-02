Return-Path: <SRS0=f1uU=ZY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47E4C432C3
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:21:19 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75C1E2084B
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2019 22:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="jc9o1ihv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQysH2pa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75C1E2084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6OrRZvy54jCUtXXrrUs+LWrWLF08Dn6y6ZDMqe76fW8=; b=jc9o1ihvQkct6w
	ES9anqiIjfgiilmpGUHo2mtwCXWgdyjlGJXHOK1uGpru2DKZfv9pchjUj/kPLsZ0DPqiNDSfGrufJ
	HERS8rvOTTOj+7CT9lPGbrmNaatlGnM3OuOS56ZlviE+b5SWKAtaSfBFj6IxGyJXfYIwg4vRYdkwV
	AeMnDOQV46idW+mhdEiO2vjEPqBKRFybLhWBjokRYeG7v1wDNdiPEuTo7+5FW/4ItKdQDbYEO5VJq
	4x+WaGt8XEAP1XJTESNGUOFHHMwHBdTnB7RRfS9j0rrfno9Ua9rkh0eVFW60j4/F1UQCX3uWoz788
	vMSesnlNt7j0q2eYF2dg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1ibu4D-0006JD-Pj; Mon, 02 Dec 2019 22:21:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ibu4B-0006Ib-VA
 for linux-nvme@lists.infradead.org; Mon, 02 Dec 2019 22:21:17 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 510DD20718;
 Mon,  2 Dec 2019 22:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1575325275;
 bh=BluBM9ctxUUNj+cUKgTQg2bioS/chTfIna2dPhLJ3KM=;
 h=From:To:Cc:Subject:Date:From;
 b=RQysH2paihOPa85EJQFSNpi5IrrkbCmvouZYF7sywrEYj+eR6nbvOOzpq3ioqWsDP
 AtV9bW7J0YzgBT126xi5ZKHK/aw6P5nyUDHln0moCdPz49dqazigUV05PFkk5WZ1mi
 NnOXBSgXajQugKhTyZfIsEK6KtDnuy3eebDq/8tA=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org
Subject: [PATCHv2 0/2] 
Date: Tue,  3 Dec 2019 07:20:56 +0900
Message-Id: <20191202222058.2096-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191202_142116_023428_8082C65E 
X-CRM114-Status: GOOD (  10.02  )
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
Cc: sagi@grimberg.me, bigeasy@linutronix.de, ming.lei@redhat.com,
 helgaas@kernel.org, Keith Busch <kbusch@kernel.org>, tglx@linutronix.de,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe devices had been able to continue sending interrupt messages while
the driver is handling the previous notification when threaded interrupts
are used. This can cause unnecessary CPU cycles spent in hard irq context,
and potentially triggers spurious interrupt detection if the threaded
handler runs sufficiently long: returning IRQ_WAKE_THREAD from the
primrary handler doesn't observe any changes to irq desc->thread_handled.

Use the appropriate masking for the interrupt type based on the NVMe
specification recommendations (see NVMe 1.4 section 7.5.1.1 for more
information) so that the primary handler does not get unnecessarily
triggered.

v1 -> v2:

  Don't split the nvme callbacks for MSI and MSI-x. Just check the type
  in the callback when selecting the masking method, and combine this
  in a single patch.

  Drop the more experiemental patches. That series will be posted
  separately.

Keith Busch (2):
  PCI/MSI: Export __pci_msix_desc_mask_irq
  nvme/pci: Mask device interrupts for threaded handlers

 drivers/nvme/host/pci.c | 28 ++++++++++++++++++++++++----
 drivers/pci/msi.c       |  1 +
 2 files changed, 25 insertions(+), 4 deletions(-)

-- 
2.21.0


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
