Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BD0C4345F
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Apr 2024 04:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UKp3++ga9pwOFwfl9SX2I6VDxPYriu1Ld2SUETczxGc=; b=wi8DKLEuWwpsSvyNzj5rbHJKuT
	e1HGcdD5/vIa1qBXYQiNx/m+rdHFOORuRQBk4wwNDHla0nsiQBrFoEEi8iVmcxGjx9LcW6bknDygF
	tUXebJbvjnOChZfZqrEqH1UOgFMeiWh2aW+BtutJV4w9TCK9s25iWqSJJOUVZrCqppAPyFbG7Wwmf
	cM4UEkIbUoFFugjanvgevMpBTyo4uGa0e6yFpkPI3DWIXSR+W0Vhz5ZuiG3ZuLdkk3s6v4h/QKWkf
	ClNGmd4WmnTqS4b1lfT1C/HFlH6fhfHSI1h9FZTN6kX9oW52MPwMPX9koOzRsBncXvxEim0UN2wlY
	xg5Ngfiw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwaVs-0000000ApRu-2543;
	Tue, 16 Apr 2024 04:33:44 +0000
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rwaVn-0000000ApPY-3WNL
	for linux-nvme@lists.infradead.org;
	Tue, 16 Apr 2024 04:33:41 +0000
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 967B740B81;
	Tue, 16 Apr 2024 04:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1713242017;
	bh=UKp3++ga9pwOFwfl9SX2I6VDxPYriu1Ld2SUETczxGc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=HVSM+zjoih8kwdzAuFBkJV2cPYIwRhYPOwAILzUUKOxOs2S6WamM4+DSseiYTl7Ub
	 sjM/XvtIglSMtgEcAtxZK1BphiT80MMW8qckz+uDLyip/Dfna435NZYLQsXGuABpDw
	 45FO5eBgstUKt2atiemkYGev6LytrI7FsR2B2GH3y4ePFdbFcUjmlDOb7AW6KB+jia
	 tCm8E28ZtJKTf7LNAi0rpIp8pGVEsCvnfRg1uBWJrIkJ+nUxXOVWGLPYhdEjXUKtGX
	 6R5A/VxDwA4OA7Tw93nBLNnIZ8bUhThFtiLXRVwpkwKmI7lrsYrFOxX1WvGjXkKUp/
	 85JVXVLr39SWg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: bhelgaas@google.com
Cc: mahesh@linux.ibm.com,
	oohall@gmail.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	bagasdotme@gmail.com,
	regressions@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	kch@nvidia.com,
	hch@lst.de,
	gloriouseggroll@gmail.com,
	kbusch@kernel.org,
	sagi@grimberg.me,
	hare@suse.de,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v8 3/3] PCI/DPC: Disable DPC service on suspend
Date: Tue, 16 Apr 2024 12:32:25 +0800
Message-Id: <20240416043225.1462548-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
References: <20240416043225.1462548-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240415_213340_029457_3CB6C455 
X-CRM114-Status: GOOD (  17.97  )
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

When the power rail gets cut off, the hardware can create some electric
noise on the link that triggers AER. If IRQ is shared between AER with
PME, such AER noise will cause a spurious wakeup on system suspend.

When the power rail gets back, the firmware of the device resets itself
and can create unexpected behavior like sending PTM messages. If DPC is
enabled, the DPC reset happens before driver's resume routine. The DPC
reset usually fails because the device is not in the right state, and
the resume also fails because the device is being reset by hardware. If
the scenario happens to device like NVMe, it means the whole system
resume fails.

As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
Management", TLP and DLLP transmission are disabled for a Link in L2/L3
Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
the power will be turned off during suspend process, disable DPC service
and re-enable it during the resume process. This should not affect the
basic functionality.

Furthermore, since DPC depends on AER to function, and AER is disabled
in previous patch, also disable DPC here.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295
Link: https://bugzilla.kernel.org/show_bug.cgi?id=218090
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v8:
 - Wording.
 - Add more bug reports.

v7:
 - Wording.
 - Disable DPC completely (again) if power will be turned off

v6:
v5:
 - Wording.

v4:
v3:
 - No change.

v2:
 - Only disable DPC IRQ.
 - No more check on PME IRQ#.

 drivers/pci/pcie/dpc.c | 57 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a668820696dc..7682ac4d6a89 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/suspend.h>
 
 #include "portdrv.h"
 #include "../pci.h"
@@ -412,13 +413,34 @@ void pci_dpc_init(struct pci_dev *pdev)
 	}
 }
 
+static void dpc_enable(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~PCI_EXP_DPC_CTL_EN_MASK;
+	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+}
+
+static void dpc_disable(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+}
+
 #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
 static int dpc_probe(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
 	struct device *device = &dev->device;
 	int status;
-	u16 ctl, cap;
+	u16 cap;
 
 	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
@@ -433,11 +455,7 @@ static int dpc_probe(struct pcie_device *dev)
 	}
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
-
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~PCI_EXP_DPC_CTL_EN_MASK;
-	ctl |= PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+	dpc_enable(dev);
 
 	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
@@ -450,14 +468,29 @@ static int dpc_probe(struct pcie_device *dev)
 	return status;
 }
 
-static void dpc_remove(struct pcie_device *dev)
+static int dpc_suspend(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
-	u16 ctl;
 
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+	if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
+		dpc_disable(dev);
+
+	return 0;
+}
+
+static int dpc_resume(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+
+	if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
+		dpc_enable(dev);
+
+	return 0;
+}
+
+static void dpc_remove(struct pcie_device *dev)
+{
+	dpc_disable(dev);
 }
 
 static struct pcie_port_service_driver dpcdriver = {
@@ -465,6 +498,8 @@ static struct pcie_port_service_driver dpcdriver = {
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
+	.suspend	= dpc_suspend,
+	.resume		= dpc_resume,
 	.remove		= dpc_remove,
 };
 
-- 
2.34.1


