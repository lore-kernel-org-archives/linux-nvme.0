Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6695C25B7E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Jun 2024 09:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=33nRyy8esXmDICnjqHn4xP5iUWtD5/AbljZ4Qu/0q8c=; b=3ejd7/dTI5zXsDzyh/ThwZwv3Q
	CVU+5oFxmp461n/1m2/JuRL7BHDviVA+z1TmUR4jIWNZsyldUIBEWzhMVI+bAQlf/G1HRaEojAkLB
	MTQTIVmIOLaePu/sHEPMYlHuR71WBE0jPvXWZqEOO8KVLqZRhJuACV8hVz05zG+Sc5pOmIIgCWuDW
	8H4xPYu3EO1r7SQRVrOe7uEeJqrA5wNNWJ9E0RUvI/aWhzL4inAi6AsTFTICVUu6KOHxXjUKdTJuv
	xohe+vtffVeyoCwFGjWgaflGSbNTQ+/Hm3mEj0fYPqj2Kzi616E2+VJATpSVhAifsXHkU9Pfa0sMJ
	jl/Z/tfg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEQGp-00000001oaI-29XV;
	Tue, 04 Jun 2024 09:15:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEQGm-00000001oXr-26by
	for linux-nvme@lists.infradead.org;
	Tue, 04 Jun 2024 09:15:53 +0000
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4548vafX020531;
	Tue, 4 Jun 2024 09:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : date : from : in-reply-to : message-id :
 mime-version : references : subject : to; s=pp1;
 bh=33nRyy8esXmDICnjqHn4xP5iUWtD5/AbljZ4Qu/0q8c=;
 b=Fb9jvgy+dCiFiRCJeViBYumt1t75okWtnhnpxEqstIn4UFyl6fzIayKVUlFA9drnehu1
 hKJYsUjOd/XQR1QHh0AEUwZPkYMHyOgYHQqZLLI0Wq0/HBz21PAhgNN4b1OqFG6282po
 KneERc5ZRahdN7Oq+okIH8ZByqPf6s2S4QZRfTT3EJec1WbcK/itfp5Rb29tZWQOEC8V
 fZHLpyOztHiVP8RO8h+vMldtF42jfWR6eVddeZu+LXFXP2rQKWANiSNMyUaBmP3wQBL1
 gTA09vCOw+CJE4tlkSJfCYvR2PPhUKHLeLrTfuV7spJUGMSiH0w9EfS5l3qLL/lars18 Kw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yhyv3g1gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 09:15:42 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4548AsaN008463;
	Tue, 4 Jun 2024 09:15:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygec0ncxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 09:15:41 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4549FaP040567140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 09:15:38 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 154A120040;
	Tue,  4 Jun 2024 09:15:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 472EE2004B;
	Tue,  4 Jun 2024 09:15:34 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.214])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Jun 2024 09:15:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
        gjoyce@linux.ibm.com, axboe@fb.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 1/1] nvme-pci : Fix EEH failure on ppc after subsystem reset
Date: Tue,  4 Jun 2024 14:40:04 +0530
Message-ID: <20240604091523.1422027-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240604091523.1422027-1-nilay@linux.ibm.com>
References: <20240604091523.1422027-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: keGGhx8HcjXlEUwn5LVpTjaYUa1EHhUK
X-Proofpoint-GUID: keGGhx8HcjXlEUwn5LVpTjaYUa1EHhUK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-04_03,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015
 mlxscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406040074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240604_021552_635392_C46DB522 
X-CRM114-Status: GOOD (  24.46  )
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

The NVMe subsystem reset command when executed may cause the loss of
the NVMe adapter communication with kernel. And the only way today
to recover the adapter is to either re-enumerate the pci bus or
hotplug NVMe disk or reboot OS.

The PPC architecture supports mechanism called EEH (enhanced error
handling) which allows pci bus errors to be cleared and a pci card to
be rebooted, without having to physically hotplug NVMe disk or reboot
the OS.

In the current implementation when user executes the nvme subsystem
reset command and if kernel loses the communication with NVMe adapter
then subsequent read/write to the PCIe config space of the device
would fail. Failing to read/write to PCI config space makes NVMe
driver assume the permanent loss of communication with the device and
so driver marks the NVMe controller dead and frees all resources
associate to that controller. As the NVMe controller goes dead, the
EEH recovery can't succeed.

This patch helps fix this issue so that after user executes subsystem
reset command if the communication with the NVMe adapter is lost and
EEH recovery is initiated then we allow the EEH recovery to forward
progress and gives the EEH thread a fair chance to recover the
adapter. If in case, the EEH thread couldn't recover the adapter
communication then it sets the pci channel state of the erring
adapter to "permanent failure" and removes the device.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/pci.c  | 21 ++++++++++++++++++---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5d150c62955..afb8419566a9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -562,6 +562,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
 		default:
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 102a9fb0c65f..f1bb8df20701 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2789,6 +2789,17 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
  out:
+	/*
+	 * If PCI recovery is ongoing then let it finish first
+	 */
+	if (pci_channel_offline(to_pci_dev(dev->dev))) {
+		if (nvme_ctrl_state(&dev->ctrl) == NVME_CTRL_RESETTING ||
+		    nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+			dev_warn(dev->ctrl.device,
+				"Let pci error recovery finish!\n");
+			return;
+		}
+	}
 	/*
 	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
 	 * may be holding this pci_dev's device lock.
@@ -3308,10 +3319,14 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
-		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
-			nvme_dev_disable(dev, true);
-			return PCI_ERS_RESULT_DISCONNECT;
+		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
+			if (!nvme_change_ctrl_state(&dev->ctrl,
+					NVME_CTRL_RESETTING)) {
+				nvme_dev_disable(dev, true);
+				return PCI_ERS_RESULT_DISCONNECT;
+			}
 		}
+		flush_work(&dev->ctrl.reset_work);
 		nvme_dev_disable(dev, false);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
-- 
2.45.1


