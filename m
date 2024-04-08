Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D98CD128A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9hT6Xo0zh893cHuYQsx0P8EYkjIztutvFofjNunbKl8=; b=TTmLtv3EUI+Lo5rV2ggxzLF+Zo
	wZzRDr/hsStI4bS853pJH/D9wSnrdpgBHdDMBo7kkIPNmZ+2WNd1QebDKbEDftNVAM5xT60wf7wHf
	P7Y0AhOj5UA8wr4fvGHZ7u0B38wne/RiD/OzPFeJa6dzuAdas6w7/3OycNrZIJxKIImKLwnQFLsgj
	LWvu8BGfCyFeuVh8+MmHnb6dkOJUYP8ZRf9oyLD9DxSP4PsYgiDHkSoGusKVcKWEWMfoDwLBs5r8R
	F6v1cW9pOg+tIttm1B0f8TMB8sLoxH39f8wtPbFxaMw+A6xccdZiucaYO/d2hq+aRijQmQaEAoPXQ
	WgqVy+kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtmAl-0000000FFnV-0EAS;
	Mon, 08 Apr 2024 10:24:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtmAi-0000000FFiA-0Z9e
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 10:24:17 +0000
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4389vIbL024144;
	Mon, 8 Apr 2024 10:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=9hT6Xo0zh893cHuYQsx0P8EYkjIztutvFofjNunbKl8=;
 b=kaZjZVR67bknRXJW1/+RG5MEwEA4kuu4D8wEzP9WR2JZzwEKkFJiFpFVVCPjpQ6Impwe
 uJChZ4tx0YYRoZBJDsjwcHXZ80ZPIJ3BWjepF9xXYi4BAHGUnwUA094uD39C0fAc/yN0
 HX8js9XMVo3whd4FBgSaPzxXhsTyeeHLt9lUbT0fwzXt86GinEhOIwLASJF6hvyXmayZ
 hmkQhSpZnn5ycvfkvCbuGn5netzWShF87NehFYW/xjYznM8/WyIMcnoBU2BMLLYPH/+G
 HhQLFbegc0GN8acqIprLyvwDShHUV4waQGVXVDjsqjOOP36eM294UlKa91Fy747m9ab4 BA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xceda01sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:24:01 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4388H5Ts022573;
	Mon, 8 Apr 2024 10:24:00 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xbhqnqh9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 10:24:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 438ANugE35782996
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Apr 2024 10:23:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 384CB20043;
	Mon,  8 Apr 2024 10:23:56 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B21E2004B;
	Mon,  8 Apr 2024 10:23:54 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.231])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  8 Apr 2024 10:23:54 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, axboe@fb.com,
        hch@lst.de, gjoyce@ibm.com, Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme-pci: Fix EEH failure on ppc after subsystem reset
Date: Mon,  8 Apr 2024 15:53:07 +0530
Message-ID: <20240408102329.442335-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IsKYWhfj9_mCg8HgV8lswmaPCTLMYXIN
X-Proofpoint-ORIG-GUID: IsKYWhfj9_mCg8HgV8lswmaPCTLMYXIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_08,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404080080
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240408_032416_243302_C2965444 
X-CRM114-Status: GOOD (  26.08  )
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
adapter reset handler could detect it. If IO timeout event could detect
loss of communication then EEH handler is able to recover the communication
to the adapter. This change was implemented in commit 651438bb0af5
("nvme-pci: Fix EEH failure on ppc"). However if the adapter communication
loss is detected during nvme reset work then EEH is unable to successfully
finish the adapter recovery.

This patch ensures that,
- nvme reset work can observer pci channel is offline (at-least on the
  paltfrom which supports EEH recovery) after a failed MMIO read and
  contains reset work forward progress and marking controller state to
  DEAD. Thus we give a fair chance to EEH handler to recover the nvme
  adapter.

- if pci channel "frozen" error is detected while controller is already
  in the RESETTING state then don't try (re-)setting controller state to
  RESETTING which would otherwise obviously fail and we may prematurely
  breaks out of the EEH recovery handling.

- if pci channel "frozen" error is detected while reset work is in progress
  then wait until reset work is finished before proceeding with nvme dev
  disable. This would ensure that the reset work doesn't race with the
  pci error handler code and both error handler and reset work forward
  progress without blocking.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
Changes from v1:
  - Allow a controller to reset from a connecting state (Keith)
  - Fix race condition between reset work and pci error handler 
    code which may contain reset work and EEH recovery from 
	forward progress (Keith)

 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/pci.c  | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 27281a9a8951..b3fe1a02c171 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -557,6 +557,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		switch (old_state) {
 		case NVME_CTRL_NEW:
 		case NVME_CTRL_LIVE:
+		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
 		default:
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685..553bf0ec5f5c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2776,6 +2776,16 @@ static void nvme_reset_work(struct work_struct *work)
  out_unlock:
 	mutex_unlock(&dev->shutdown_lock);
  out:
+	/*
+	 * If PCI recovery is ongoing then let it finish first
+	 */
+	if (pci_channel_offline(to_pci_dev(dev->dev))) {
+		if (nvme_ctrl_state(&dev->ctrl) == NVME_CTRL_RESETTING ||
+			nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+			dev_warn(dev->ctrl.device, "Let pci error recovery finish!\n");
+			return;
+		}
+	}
 	/*
 	 * Set state to deleting now to avoid blocking nvme_wait_reset(), which
 	 * may be holding this pci_dev's device lock.
@@ -3295,10 +3305,13 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
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
+		flush_work(&dev->ctrl.reset_work);
 		nvme_dev_disable(dev, false);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
-- 
2.44.0


