Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E90F9D0E2
	for <linux-nvme@archiver.kernel.org>; Tue, 14 Apr 2026 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:
	References:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:
	Subject:Date:From:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jvF6uC7bdNGQm0W9jbRIyFzsL28Md3OMKJaU0+s9ueM=; b=2h1cCy5Rbt7Q7ybkRGpM95updS
	JY2KqN1SiwliS6Y8tliwBA62dySQ+PTDgQ6PZIbqvJSc7bmPJ/kMG0ZOHRl24+iQO6W2INQYsMd9H
	pC79xwPTeCVjZ27ETZdtvNvFa1gvwwBJ7sdLtunbCwJPbbv0c0fg4ouiYnt8AH6gLo8ITDqD+yI2g
	z0VG5Hfn0JW17kuDzQXIyVO4b79RA2EX2rfa7za5fTzcvlNNMdMcBcwyor+uVMONUWaPdxA0y8RL8
	W8lq101h1s3ovM6erdEI7lvbsqiqQK1+sh1Mta8ygbl3A+arn0nnUwstHckSYkKvdn4Qf7A9EjP0X
	SzdBEGjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCgBX-0000000HZTa-3LaQ;
	Tue, 14 Apr 2026 16:00:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wCgBR-0000000HZQv-1nGG
	for linux-nvme@lists.infradead.org;
	Tue, 14 Apr 2026 16:00:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 94D76445AC;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4FE79C2BCF4;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776182412;
	bh=gd3NgVMSuig/iZb+VOgR9aExL4jhTOa1kJGPBkl+B4E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HmQ/RexuXS6e7g1wNo7tHtonuuuTo03+g/Eyd14XD5eKS7/6BkPKJn+oJSpPq0FXl
	 OEdP9Y3YsR3rjDovyfTcv2qBmZPDU2UHYAhczTL3zQhg/SYygxkUdghjCpnaByYIsD
	 /yWBMcSl5giCTOrr0OwehWFXla7fJCb6gA/S8TCivMNw6E4L3fqgqt34UpXztb94or
	 PBgbVm0c3+zdGdM1uTGJc8mYAOtD3xBKBRZomgc32mVZbulbtMVcmWXkune8SJEKoO
	 7PYT8aKtR68YsYsPC3miPfIF/Oy2SVPWfMaeGrz+7DM+d/bnLXSc+7GYIYeWi6kSBI
	 N1PmeiFW1pDHg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46739F9D0E2;
	Tue, 14 Apr 2026 16:00:12 +0000 (UTC)
From: Manivannan Sadhasivam via B4 Relay <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org>
Date: Tue, 14 Apr 2026 21:29:42 +0530
Subject: [PATCH 4/4] nvme-pci: Use pci_dev_suspend_retention_supported()
 API during suspend
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260414-l1ss-fix-v1-4-adbb4555b5ab@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2024;
 i=manivannan.sadhasivam@oss.qualcomm.com; h=from:subject:message-id;
 bh=9iqx3F1OL5ZbjTfr4VDbef+alvPRZcEaJTtZ6g6PO50=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBp3mSJFA22ZzG+uMhc8/mbge/1w0NhLM9MKpWXt
 fSvM3+00NGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCad5kiQAKCRBVnxHm/pHO
 9bdLB/9BO3ZBbEYnyiWy5OENKpCGj4kWk1d2BmauKwSbNLIdFFAwpmWDLWclzRaGeiY8Ewl95W/
 5QcaDR28JqbVG2Xb7m/MM4m/yPbrcrC/KQLrVfLSrlyU/SIHBG+ilclmFF5SBF2sHa4UoQBcgCQ
 PuMUkEXCjUvAyN7eaPRXnOKo6q0e+3t0hHoIQjqI67tG2V72hZDSlZ4hSOsitDyT6rJ8eZ6Z5nC
 g99zGFXbhMUJox8LCXtbGc+4rj5sakJ2AUUf2Mv+l8ony3usLJvWdJS8oLQUFxX1NetE9KqRFTF
 lKxN2gGnT1QBD0SYUW8s9tb9/GETQmHWQfmpt3ufgFaTTKfI
X-Developer-Key: i=manivannan.sadhasivam@oss.qualcomm.com; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008
X-Endpoint-Received: by B4 Relay for
 manivannan.sadhasivam@oss.qualcomm.com/default with auth_id=461
X-Original-From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260414_090013_540660_15DAFF18 
X-CRM114-Status: GOOD (  18.41  )
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

The pci_dev_suspend_retention_supported() API lets PCI client drivers
know if the platform can retain the device context during suspend. This
is decided based on several factors like:

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
index b78ba239c8ea..19010330469f 100644
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
+	if (!pci_dev_suspend_retention_supported(pdev) || !ctrl->npss ||
 	    !pcie_aspm_enabled(pdev) ||
 	    (ndev->ctrl.quirks & NVME_QUIRK_SIMPLE_SUSPEND))
 		return nvme_disable_prepare_reset(ndev, true);

-- 
2.51.0



