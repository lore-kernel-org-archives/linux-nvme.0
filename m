Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77943C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Jul 2022 14:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ci9+hRJezweXnUdxfNXU0S2jAjRlYyWnCLRP1irvXYs=; b=qOmoQuwJ/MoHCcdk356wVUI52z
	41m6MS2Wb0regqX6FuTsiFHgkkYlh7QUp7Aj/H61wUkIyW+zC1sU0J7Ur0APVEj1vjmXIiATDHp8a
	kshOj9QNdNdM3/P0Ap41oy08eUdUJNBEf7s3xcQMIHx0rakt152j9y5qgm8lL9KxR4aom2NtZOmJn
	Xh2iWXXWsz7Mg494ZbiLITbpzMKK8FQHl42B8/OS0b1LEfuu7FnJ60s4gQDKQRGDdDApKF/oHGS8d
	hDJoH9T+9hBEVQEV+CVECTe+MmblazMx357ULN6FhwAHYC3ZtnnPg2DurDf+mm/SYGUUyiEOaPAJj
	vLdWgbtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBGhl-00BeVC-F4; Tue, 12 Jul 2022 14:17:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBGhj-00BeTe-0e
	for linux-nvme@lists.infradead.org; Tue, 12 Jul 2022 14:17:36 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5E70C6182C;
	Tue, 12 Jul 2022 14:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C733C341CD;
	Tue, 12 Jul 2022 14:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657635451;
	bh=4k4HRuM7gfop9Mz8eN6pF7c8Y7aZaQnTyFpt9VK42+g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VRPNWMYBMg/S8KALz1C0TbpcTHoDupuy9XwR4wVf5K9TGpU+JiAXJGIjbBBg6wYNE
	 +d+AFDvEGqZZsaSoFZShVTE/D1gR7lEad4QzeNoA95xIXjGpuxUKzcq7iXVIc3CVVK
	 Pg31zJbXodgWOUP2P1/sojB4ihv4hy5zWrX4gSoZ+bYZB4oyCe+3GGXYj1BG8dZ2T+
	 SnihCayMpZDPhwIvsWTLpPfn/VfbMRRWEAuEO2q9imBlhbX6XNlxeZydNC5SfRz4UC
	 bRVhmpXM3U2ZR10wRQmx5etcHfXkc4iCNyexPULuWVnFEstqjeQlPXaGM3e4JANZhZ
	 Ezy4vS3NJ/REA==
Date: Tue, 12 Jul 2022 08:17:28 -0600
From: Keith Busch <kbusch@kernel.org>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Christoph Hellwig <hch@lst.de>, Stefan Roese <sr@denx.de>,
	Matthew Rosato <mjrosato@linux.ibm.com>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] nvme-pci: fix hang during error recovery when the
 PCI device is isolated
Message-ID: <Ys2CeIqv//5ZGJTM@kbusch-mbp>
References: <20220712124453.2227362-1-schnelle@linux.ibm.com>
 <20220712124453.2227362-2-schnelle@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712124453.2227362-2-schnelle@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220712_071735_153459_BC9523BD 
X-CRM114-Status: GOOD (  25.01  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 12, 2022 at 02:44:53PM +0200, Niklas Schnelle wrote:
> On s390 and powerpc PCI devices are isolated when an error is detected
> and driver->err_handler->error_detected is called with an inaccessible
> PCI device and PCI channel state set to pci_channel_io_frozen
> (see Step 1 in Documentation/PCI/pci-error-recovery.rst).
> 
> In the case of NVMe devices nvme_error_detected() then calls
> nvme_dev_disable(dev, false) and requests a reset. After a successful
> reset the device is accessible again and nvme_slot_reset() resets the
> controller and queues nvme_reset_work() which then recovers the
> controller.
> 
> Since commit b98235d3a471 ("nvme-pci: harden drive presence detect in
> nvme_dev_disable()") however nvme_dev_disable() no longer freezes the
> queues if pci_device_is_present() returns false. This is the case for an
> isolated PCI device. In principle this makes sense as there are no
> accessible hardware queues to run. The problem though is that for
> a previously live reset controller with online queues nvme_reset_work()
> calls nvme_wait_freeze() which, without the freeze having been
> initiated, then hangs forever. Fix this by starting the freeze in
> nvme_slot_reset() which is the earliest point where we know the device
> should be accessible again.
> 
> Fixes: b98235d3a471 ("nvme-pci: harden drive presence detect in nvme_dev_disable()")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Oh, we've messed up the expected sequence. The mistaken assumption is a device
not present means we're about to unbind from it, but it could appear that way
just for normal error handling and reset, so we need to preserve the previous
handling.

The offending commit really just wants to avoid the register access (which we
shouldn't have to do, but hey, broken hardware...). So let's keep the sequence
the same as before and just skip the register read. Does this work for you?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fdfee3e590db..c40e82cee735 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
@@ -2690,9 +2772,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_device_is_present(pdev) && pci_is_enabled(pdev)) {
-		u32 csts = readl(dev->bar + NVME_REG_CSTS);
+	if (pci_is_enabled(pdev)) {
+		u32 csts = ~0;
 
+		if (pci_device_is_present(pdev))
+			csts = readl(dev->bar + NVME_REG_CSTS);
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
 		    dev->ctrl.state == NVME_CTRL_RESETTING) {
 			freeze = true;
--

