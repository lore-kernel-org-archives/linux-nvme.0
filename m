Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 512C6CD8CA8
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 03:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I4emnqIqIdL6Z/thgfMcOzQbTKLZMtmRN7K6d6fNY9M=; b=bvM2nHwHFGg8zOLNKEJQc0b7z2
	2xfhHc6vkjouw5qqEFJ8bsWB7L2erdUVfiIyhH+tK80DYOBsVpPjiulftzEs0Mmxd+MGf13uWzsoS
	KzyP0RS2D8LZtQDGeltpohMfDT6DVrw8qCEfJ3cj4HYSMpvx0qkBvTFyeh/j0IkByDsCpzxOfUY4S
	P+h3PV/TMMUsCKyWbODJD7hdvn+cAbpcaA1vy+wcXvJvAzKnJUAhmIA6N0zk76fthPmJBAslzgEGm
	EwMoNgwWah/QruW6ov5Qx0FvEQldbfp5bd4yHvSfrThH8pFGjR1cIE+fCX3FaOKa4oQ17SOt/qFtx
	niKGEzzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX9S0-00000006jYL-1eAe;
	Wed, 10 Jun 2026 03:17:56 +0000
Received: from mailgw.kylinos.cn ([124.126.103.232])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wX9Rx-00000006jWx-3izo
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 03:17:55 +0000
X-UUID: f1f7e11c647a11f1aa26b74ffac11d73-20260610
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:532d9d4b-2e4b-44b9-bcba-6fffcb037931,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:f303d14455f77b0210d028143ca7a2b5,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|865|898,TC:nil,Content:0|1
	5|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
	:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f1f7e11c647a11f1aa26b74ffac11d73-20260610
X-User: liuxixin@kylinos.cn
Received: from [127.0.1.1] [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liuxixin@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 147462138; Wed, 10 Jun 2026 11:17:43 +0800
From: Xixin Liu <liuxixin@kylinos.cn>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, linux-kernel@vger.kernel.org, liuxixin@kylinos.cn
Subject: [PATCH v1 1/1] nvme-pci: tear down controller on ERS permanent failure
Date: Tue, 10 Jun 2026 10:55:00 +0800
Message-ID: <6a9c9c654d0a0000000000000000000000000000.1780449274.git.liuxixin@kylinos.cn>
In-Reply-To: <cover.nvme-ers-v1.1780449274.git.liuxixin@kylinos.cn>
References: <cover.nvme-ers-v1.1780449274.git.liuxixin@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: nvme-ers-resetting/send-local.py
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260609_201754_234233_244E782C 
X-CRM114-Status: UNSURE (   9.12  )
X-CRM114-Notice: Please train this message.
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

On pci_channel_io_frozen nvme-pci moves the controller to NVME_CTRL_RESETTING
and quiesces I/O.  If pcie_do_recovery() then fails and the core calls
error_detected(perm_failure), the driver only logged and returned DISCONNECT
without changing state.  sysfs state remained "resetting";
nvme_fail_nonready_command() returned BLK_STS_RESOURCE and new I/O blocked
indefinitely.

Reproduced with aer_inject Uncorrectable Fatal on a QEMU hotplug NVMe when
pci_bus_error_reset() failed (LnkCap.DLLLARC set, LnkSta.DLLLA not set
within 100 ms).  slot_reset was never called.

Add nvme_pci_ers_failed() with the same teardown sequence as reset_work
failure: DELETING, disable with shutdown, mark namespaces dead, then DEAD.

Signed-off-by: Xixin Liu <liuxixin@kylinos.cn>
---
 drivers/nvme/host/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cebe8c9e598c..6a9c9c654d0a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4032,6 +4032,16 @@ static const struct dev_pm_ops nvme_dev_pm_ops = {
 };
 #endif /* CONFIG_PM_SLEEP */
 
+static void nvme_pci_ers_failed(struct nvme_dev *dev)
+{
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
+	nvme_dev_disable(dev, true);
+	nvme_sync_queues(&dev->ctrl);
+	nvme_mark_namespaces_dead(&dev->ctrl);
+	nvme_unquiesce_io_queues(&dev->ctrl);
+	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
+}
+
 static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 						pci_channel_state_t state)
 {
@@ -4057,6 +4067,7 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
 			"failure state error detected, request disconnect\n");
+		nvme_pci_ers_failed(dev);
 		return PCI_ERS_RESULT_DISCONNECT;
 	}
 	return PCI_ERS_RESULT_NEED_RESET;
-- 
2.43.0


