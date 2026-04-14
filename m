Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C01F9D0DA
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ro20QNH6//2M2l5kPm83Ye5jZ6m5FlXZo4HEbqDIcKQ=; b=opkmCk8UqfaFVvhrAzPiuhzapi
	4u7ce3qbO6UzifhzjrIjHu8LYPkQm7LmDBlcATk8wzp9Wd1lLPjFZNiaxL6lzd4GWwFWWHCt4P47Z
	qeYF57OR/GF7mIEiJGerrnpAJdL3ArKZGVKfpqI4o/LF29yCIFzRN1bHMLC4+fZ17MX1B8WQd0dpG
	PATIXlZKDRKobgbFJp0+J2CEJPJJlKB9MD2oJlec6eLr4iws7RZpDNWOgpw1d4DYZlzjyodr4NsdO
	MwA2vtLNEcdZP4CZl4uzZ4sOCZpZz1D1A2ueOFus2dm+eO9ToFcua+6CbyqBxJq3jRcri1Df3YVYI
	0B92iYNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCgBX-0000000HZSq-25Xr;
	Tue, 14 Apr 2026 16:00:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCgBR-0000000HZQr-1mOB
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 16:00:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 71D9B44596;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 334C1C2BCB8;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776182412;
	bh=HWMbqwedOoMw8lw/15aldB8uIf8M+iftPYa/bgkZ12o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AkS2pQfuVfK9IaoAzE3tAiWiZ57wZP3rJXnVYe7dQ5Yojf5adoXNCU5xnXgnTwy5L
	 D7UDBJyXFVqcyAmWaLgSIMkaICr+Qm8mFKy8Fk5NuLUq0j/ZEaIJaMvITkqsxhW1wz
	 58590VHwI1AqGHgMm5shcPzo8u4axLZwou6yL26RRQ8pYAQUrW3e7yaLOE5bapapgj
	 yphgvcIQKO5flR6JNasMcq67OOpR8gqikhus6PTlUoDHqlCZ6L3QU3smArEkfx0Rsb
	 luhAX+M8cY5zwukxca11Fm2j1keVNTX+RGGzc0fWvkfBrjCn26tJJQCxubUgZyj/Uw
	 DVnFUIXZbYW4w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C80F9D0D3;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 14 Apr 2026 21:29:40 +0530
Subject: [PATCH 2/4] PCI: Indicate context lost if L1ss exit is broken
 during resume from system suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-l1ss-fix-v1-2-adbb4555b5ab@oss.qualcomm.com>
References: <20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com>
In-Reply-To: <20260414-l1ss-fix-v1-0-adbb4555b5ab@oss.qualcomm.com>
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
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3305;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=LyQjngZpjyM7atFii62PC/2oWcdYdOsG7s31euB1g4g=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp3mSJmlZhEN3RfjDf/GEGFtsvDX0Ll8oF+/ind
 omQnGB3tZqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCad5kiQAKCRBVnxHm/pHO
 9ZQPB/0TFauDo1bNl4OhfXKRCke7aoRExVdAT6cGff+51gC9NlEDUehXTYuzKL5aDTHYH3ze3Ev
 ff8UzBeyFVUlIkHbaYlWYXMsWfgsT9c+cFuKXMqflurzV6GJZWp6wfJGoEl91gbonS6TDmLwITa
 Auq6bnsaVRZULioqu2rI37EFXRDXcAZLL6CGooAg7SHcTBHs+08DXbUHuneegTd82hf+KOD81uY
 CoGr1SLR5WAn4VwxhvlFNQTPH5oPDwNj9kbNQrNtT/tLV1wUrSNbhtArNOVdkPJDGtFuRx35Muz
 OoYeVIpwIXc6uVTS5uNg88zL70+ulUzFTKjvoG118XKUHMag
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_090013_528155_765772D1 
X-CRM114-Status: GOOD (  20.62  )
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

The PCIe spec v7.0, sec 5.5.3.3.1, states that for exiting L1.2 due to an
endpoint asserting CLKREQ# signal, the refclk must be turned on no earlier
than TL10_REFCLK_ON, and within the latency advertised in the LTR message.
This same behavior applies to L1.1 as well.

On some platforms like Qcom, these requirements are satisfied during OS
runtime, but not while resuming from the system suspend. This happens
because the PCIe RC driver may remove all resource votes and turns off the
PHY during suspend to maximize power savings while keeping the link in
L1ss.

Consequently, when the endpoint asserts CLKREQ# to wake up, the OS must
first resume and the RC driver must restore the PHY and enable the refclk.
This recovery process exceeds the L1ss exit latency time. And this latency
violation results in an L1ss exit timeout, followed by Link Down (LDn). If
the endpoint device is used to host the RootFS, it will result in an OS
crash. For other endpoints, it may result in a complete device
reset/recovery.

So to indicate this platform limitation to the client drivers, introduce a
new flag 'pci_host_bridge::broken_l1ss_resume' and check it in the
pci_dev_suspend_retention_supported() API. If the flag is set by the RC
driver, the API will return 'false' indicating the client drivers that the
device context may not be retained and the drivers must be prepared for
context loss.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/pci.c   | 11 +++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 211616467a77..e871cccf24ae 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2911,6 +2911,8 @@ void pci_config_pm_runtime_put(struct pci_dev *pdev)
  */
 bool pci_dev_suspend_retention_supported(struct pci_dev *pdev)
 {
+	struct pci_host_bridge *bridge = pci_find_host_bridge(pdev->bus);
+
 	/*
 	 * If the platform firmware (like ACPI) is involved at the end of system
 	 * suspend, device context may not be retained.
@@ -2918,6 +2920,15 @@ bool pci_dev_suspend_retention_supported(struct pci_dev *pdev)
 	if (pm_suspend_via_firmware())
 		return false;
 
+	/*
+	 * Some host bridges power off the PHY to enter deep low-power modes
+	 * during system suspend. Exiting L1 PM Substates from this condition
+	 * violates strict timing requirements and results in Link Down (LDn).
+	 * On such platforms, the endpoint must be prepared for context loss.
+	 */
+	if (bridge && bridge->broken_l1ss_resume)
+		return false;
+
 	/* Assume that the context is retained by default */
 	return true;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d9bc7ad4eaa4..860d8a774b51 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -658,6 +658,8 @@ struct pci_host_bridge {
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 	unsigned int	size_windows:1;		/* Enable root bus sizing */
 	unsigned int	msi_domain:1;		/* Bridge wants MSI domain */
+	unsigned int	broken_l1ss_resume:1;	/* Resuming from L1ss during
+						   system suspend is broken */
 
 	/* Resource alignment requirements */
 	resource_size_t (*align_resource)(struct pci_dev *dev,

-- 
2.51.0



