Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF845C48285
	for <linux-nvme@archiver.kernel.org>; Wed, 31 Jan 2024 06:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ry8VwGeW1l0TJPzZG5dGf+7vXag9EsH6H13WgCnAcdE=; b=Gj/fdh3dylv7Yv2MzcrF1HDpz5
	jxpV1TGZFypohye1LL4bO5XTvcgc2kEOQDzBiPdSlx6djW9xh6VQAeASXmZMEIqHYFqiC4eN6iILp
	LWhJk3v9ca+eBs952UzhQEgFLukN+itBP3bDnTcb+NrX2lY1MjQxHosFxHPqhN5BpWuVpY55V1eaR
	7KToWOQo5Fy57c7QtYBYVHBOxw1faVA2WOqJRdhJZpetERXTN1A+CPqYkN+zZuWrEDVc2EmBJemp6
	kBDnDN7D/UlarM1u8PG8dfgLsRABU6OU1YfodjCdYjD19RR7SU6mGmlybk4cQ/GDOGWV7EBjS4OIB
	Sz8IsS1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3lq-00000001bx7-3DSq;
	Wed, 31 Jan 2024 06:08:26 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rV3ln-00000001bwd-1Kxn
	for linux-nvme@lists.infradead.org;
	Wed, 31 Jan 2024 06:08:24 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40V5scOK028268;
	Wed, 31 Jan 2024 06:08:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=ry8VwGeW1l0TJPzZG5dGf+7vXag9EsH6H13WgCnAcdE=;
 b=oZYeO9Jpd4UucA6sIJoIXHCdNOVibSm6ozXFb2FzqK6gKb9SsK+DQ9y2orVDY1yRDmzA
 tUKGjDRUxiu/IP2o7Qtml4psEKpDgIXtYksvb5abkPhorp4atrm6LIPFzUu2uNykIrpp
 nneLkr8JN81Jdi53xpNWcy/wZdy2KIzORcNycaSFnWSY3UqJzSpwx1RZgSc2+4Rrbwsj
 8na4B2Bktjs55gccXAbpqsWp82n2i/hLYnSrL1E+NzKdBhqblAw+mZ1D0utfyZTQEOu3
 u4Q2qvtb/iHGR5g1svneUSikx32QTlF4lLN8Sxu6a7+PQucpzWSiQ/exZOnyrjsuBUM6 2Q== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vyekvtdk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 06:08:03 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 40V4COka002195;
	Wed, 31 Jan 2024 06:08:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vwc5tbw6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 06:08:02 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 40V67xck25624910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 31 Jan 2024 06:07:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01ADB2004B;
	Wed, 31 Jan 2024 06:07:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F4FF20040;
	Wed, 31 Jan 2024 06:07:57 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.187])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 31 Jan 2024 06:07:57 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, gjoyce@linux.ibm.com, nilay@linux.ibm.com
Subject: [PATCH] nvme-pci: Fix EEH failure on ppc after subsystem reset
Date: Wed, 31 Jan 2024 11:35:53 +0530
Message-ID: <20240131060725.740426-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MP96xQeHqgzF5D6jxoHZg1Li1r2SsE5V
X-Proofpoint-GUID: MP96xQeHqgzF5D6jxoHZg1Li1r2SsE5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_02,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 malwarescore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401310045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_220823_613457_54E23CC7 
X-CRM114-Status: GOOD (  25.11  )
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

If the nvme subsyetm reset causes the loss of communication to the nvme
adapter then EEH could potnetially recover the adapter. The detection of
comminication loss to the adapter only happens when the nvme driver
attempts to read an MMIO register.

The nvme subsystem reset command writes 0x4E564D65 to NSSR register and
schedule adapter reset.In the case nvme subsystem reset caused the loss
of communication to the nvme adapter then either IO timeout event or
adapter reset handler could detect it. If IO timeout even could detect
loss of communication then EEH handler is able to recover the
communication to the adapter. This change was implemented in commit
651438bb0af5213 ("nvme-pci: Fix EEH failure on ppc"). However if the
adapter communication loss is detected in nvme reset work handler then
EEH is unable to successfully finish the adapter recovery.

This patch ensures that,
- nvme driver reset handler would observer pci channel was offline after
  a failed MMIO read and avoids marking the controller state to DEAD and
  thus gives a fair chance to EEH handler to recover the nvme adapter.

- if nvme controller is already in RESETTNG state and pci channel frozen
  error is detected then  nvme driver pci-error-handler code sends the
  correct error code (PCI_ERS_RESULT_NEED_RESET) back to the EEH handler
  so that EEH handler could proceed with the pci slot reset.

[  131.415601] EEH: Recovering PHB#40-PE#10000
[  131.415619] EEH: PE location: N/A, PHB location: N/A
[  131.415623] EEH: Frozen PHB#40-PE#10000 detected
[  131.415627] EEH: Call Trace:
[  131.415629] EEH: [c000000000051078] __eeh_send_failure_event+0x7c/0x15c
[  131.415782] EEH: [c000000000049bdc] eeh_dev_check_failure.part.0+0x27c/0x6b0
[  131.415789] EEH: [c000000000cb665c] nvme_pci_reg_read32+0x78/0x9c
[  131.415802] EEH: [c000000000ca07f8] nvme_wait_ready+0xa8/0x18c
[  131.415814] EEH: [c000000000cb7070] nvme_dev_disable+0x368/0x40c
[  131.415823] EEH: [c000000000cb9970] nvme_reset_work+0x198/0x348
[  131.415830] EEH: [c00000000017b76c] process_one_work+0x1f0/0x4f4
[  131.415841] EEH: [c00000000017be2c] worker_thread+0x3bc/0x590
[  131.415846] EEH: [c00000000018a46c] kthread+0x138/0x140
[  131.415854] EEH: [c00000000000dd58] start_kernel_thread+0x14/0x18
[  131.415864] EEH: This PCI device has failed 1 times in the last hour
[  131.415874] EEH: Notify device drivers to shutdown
[  131.415882] EEH: Beginning: 'error_detected(IO frozen)'
[  131.415888] PCI 0040:01:00.0#10000: EEH: Invoking nvme->error_detected
[  131.415891] nvme nvme1: frozen state error detected, reset controller
[  131.515358] nvme 0040:01:00.0: enabling device (0000 -> 0002)
[  131.515778] nvme nvme1: Disabling device after reset failure: -19
[  131.555336] PCI 0040:01:00.0#10000: EEH: nvme driver reports: 'disconnect'
[  131.555343] EEH: Finished:'error_detected(IO frozen)'
[  131.555371] EEH: Unable to recover from failure from PHB#40-PE#10000.
[  131.555371] Please try reseating or replacing it

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c1d6357ec98a..a6ba46e727ba 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2776,6 +2776,14 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
  out:
+	/*
+	 * If PCI recovery is ongoing then let it finish first
+	 */
+	if (pci_channel_offline(to_pci_dev(dev->dev))) {
+		dev_warn(dev->ctrl.device, "PCI recovery is ongoing so let it finish\n");
+		return;
+	}
+
 	/*
 	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
 	 * may be holding this pci_dev's device lock.
@@ -3295,9 +3303,11 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
-		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
-			nvme_dev_disable(dev, true);
-			return PCI_ERS_RESULT_DISCONNECT;
+		if (nvme_ctrl_state(&dev->ctrl) != NVME_CTRL_RESETTING) {
+			if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+				nvme_dev_disable(dev, true);
+				return PCI_ERS_RESULT_DISCONNECT;
+			}
 		}
 		nvme_dev_disable(dev, false);
 		return PCI_ERS_RESULT_NEED_RESET;
-- 
2.43.0


