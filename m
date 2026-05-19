Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111C7CD5BA1
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 08:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+4+BIQtaVbRrD9EN7sQoNzwYlYpU9L2C/QiDkWHtigs=; b=OEeSJ2Q7AxRanEDFX7K3BmZ88a
	EHdIDDl27Hs2XQxJZ4BCB3HsG433CzvEmJozgmPx/Vm0NRdE68KGrQbPwLPdL2j53AVyvnP9bkNl9
	bMHf3S0r//L4WHmjkiQuf10U8OKtcREBrb5m7clPseMuEM3FKnKPaCP7c9V/qNIy7EG/HTCyW1PQS
	1Kjua9s6MWdxoNqBHj8EG9IHmC9HLrHm0054HFGrj22+WVgo6nEF3auBOdfpPZXadt+rf+4RvDzlp
	RO/hdYL9G36YRZkR4q0P4bak3nrcXX36J0ABEki+r6hZ3UfYq/cLEpY3p3vbffUW7jI4pWM3Ysovs
	MR0kAG7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFY6-00000000cc2-1Ur0;
	Tue, 19 May 2026 08:11:34 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPFY2-00000000cY5-3pAQ
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 08:11:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2ABB4445A1;
	Tue, 19 May 2026 08:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 021B7C2BCFD;
	Tue, 19 May 2026 08:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779178290;
	bh=3tNqJbphQxq8fgu1zbpz3ztOWC15zQBvAy+SBzQxjVE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=LfVMpFD6p6DnP17MHbaMZwfztPGfiES62LkobjtbpeuCznn0tl+97ssc1kgGFPF8S
	 /60caU5wCJ6eJS/MzKs1eR8OWa/5Q1DwPHgOsXOypVthX5LQ9VqzulhuxQRqk0twUe
	 RkhS54O7rBiAaZsTQac5KcN2D80wYVsZAb3YHZ6PM9pHbdMuyWox4fx0ZKmjSpZRgs
	 P0A0f0XzzJHlGHERrYunOXsFP4sqHufYkNzAPnQKSuIznYk6ASSz2rbnsRR376FkTl
	 e/5Qo43hajzA3rhnSzC72Z5sy3WbTjQ+Ubnlua+x7YBuAxyQkAqZfNdgdgmrY2oEhp
	 bIP0+8fCXWIdw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE578CD4851;
	Tue, 19 May 2026 08:11:29 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 19 May 2026 13:41:23 +0530
Subject: [PATCH v2 4/4] nvme-pci: Use pci_suspend_retains_context() API
 during suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-l1ss-fix-v2-4-b2c3a4bdeb15@oss.qualcomm.com>
References: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
In-Reply-To: <20260519-l1ss-fix-v2-0-b2c3a4bdeb15@oss.qualcomm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=wkzcjudTR2aJO1tfV1djFAQP7gK0vMlCmcPgSrxkr6g=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBqDBsv6tg+/ohQFmrGz4V+nYAOWjrvtBggaK5pP
 hOYsITqL6qJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCagwbLwAKCRBVnxHm/pHO
 9cgHB/9hVy3DtoD01/gYAs2Xvq1Fh82Tk3uM5j/reOXS4YtcDnH3ebdrlkaEcAUK/pUnsUBLMTm
 hx2k/cVOjoyo7IaYJg6epJRiWfULGYwMjvwRCYg+Gs2Nl8sUvOw6JyP8ZEVMXHjE3JbfjAtHhSZ
 /tbF9vEIp3s1e3HX8flKqnnE3Zm6KQ0U0tgU4cazJFSSwleo3ta3nMP/kceK5Mc/njnZHJo1MlX
 OWICXlX4PjD/KE2IYEt7lCDleFJA+0BItGwmbMiuOSF1wyAOOiXxECeZOEMyOj9a5NZ6oSJFf1r
 37bskjeEYIabTMt0JgsZ9OFPwf3A2pk6xE5OYewFC8OtfKPz
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_011130_998337_CD773212 
X-CRM114-Status: GOOD (  18.76  )
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
Reply-To: manivannan.sadhasivam@oss.qualcomm.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

The pci_suspend_retains_context() API lets PCI client drivers know if the
platform can retain the device context during suspend. This is decided
based on several factors like:

1. Firmware involvement at the end of suspend
2. Any platform limitation in waking from low power state (L1ss)

And this API might also get extended in the future to cover other platform
specific issues impacting the device low power mode during system suspend.

So use this API instead of checks like pm_suspend_via_firmware(). When this
API returns false, then assume that the platform cannot retain the context
and shutdown the controller. If it returns true, then assume that the
context will be retained and keep the device in low power mode.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index db5fc9bf6627..a6664983ce5d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3915,6 +3915,7 @@ static int nvme_suspend(struct device *dev)
 	 * use host managed nvme power settings for lowest idle power if
 	 * possible. This should have quicker resume latency than a full device
 	 * shutdown.  But if the firmware is involved after the suspend or the
+	 * platform has any limitation in waking from low power states or the
 	 * device does not support any non-default power states, shut down the
 	 * device fully.
 	 *
@@ -3923,7 +3924,7 @@ static int nvme_suspend(struct device *dev)
 	 * down, so as to allow the platform to achieve its minimum low-power
 	 * state (which may not be possible if the link is up).
 	 */
-	if (pm_suspend_via_firmware() || !ctrl->npss ||
+	if (!pci_suspend_retains_context(pdev) || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);

-- 
2.48.1



