Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AFAC4345F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Apr 2024 14:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=8o846C8dKZaDDb98Ma94pVMvcrPMgV5pt1nvVRkrgE0=; b=xVKaeF7e4hVAa+
	5/Gwrirvv1hsNJOY55oGoIyd4TEyDn1aPCvwrSpeoRP96TavfG2FnvxXwP1o9aTnxKf5d/MnDmwA5
	a34C6nmQwGtODRnbpjEDQI+cKDQEs1j/OJrEQ3QpS970ZaZ44XSgULP2lJHfjs+mOPnjnA7oj9/n0
	aG1ydZDhHbaidx3aW8XfX0B4AoizuyblaHEtDUGDHWN/wqXbLDz+OqxBWr0zJho+OGOJp/53srMDt
	kTZ7SDxgTfnWl4SWW62yG6Jo5QTJm4pahbVtGqAXQqDW78b42uywF6G/710jkl9dfcs9QGf7nzHHb
	kbhdwmSZtBGPPetBn64g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzzhP-00000008gNw-344v;
	Thu, 25 Apr 2024 14:03:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzzhN-00000008gMm-3cu6
	for linux-nvme@bombadil.infradead.org;
	Thu, 25 Apr 2024 14:03:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Transfer-Encoding
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=8o846C8dKZaDDb98Ma94pVMvcrPMgV5pt1nvVRkrgE0=; b=lTHt9PjZhMNOAKumq5cPrmjbOY
	Jke1vvODM5UK8m0LlOWOLSUxfPrTcEA+twW+pqdau1zRzyH2wtCnwg3wkLB5FgQBQ9F0sYopfQrQN
	+z5lnK9hVhIqs8G+WDjTCjGB3RhCA9JGZ78jwen0j95r4AMhUyWC5YvehjM0BPBzxpjxCwl1H7F2/
	DGl3dFSEk0ldfiSLPf4rCOTiyl43Xq2az9u13edrGM/QDybGoHYoopfIMSSVASU4nsRBSEOxxEZYh
	CF0i4p/S/T4zJPjVOP3KUwn3bBwBzwNK/ZBmKfdDmo549ud42dxf2d7r4zY040RCAD4CNRDXL6IVu
	jKFH9rwg==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rzzhF-0000000EvNb-0gB1
	for linux-nvme@lists.infradead.org;
	Thu, 25 Apr 2024 14:03:40 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43PE2Yii020055;
	Thu, 25 Apr 2024 14:03:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=8o846C8dKZaDDb98Ma94pVMvcrPMgV5pt1nvVRkrgE0=;
 b=tM8ALX8yuyDbOLpO19qoHfy8QPBE+xkTtIOeeaHFGKvmwHr409sZkHSyjN9BAwbwTdAI
 2zz4YGsYq6nCXLrBLTHe7m1/JlcrvIA/i3m6QfWnouNbnMzI4gobLD3xF4pQZHfXGCCS
 nuj3BjTDKLi+ljSXg4CZJb5Ca/ad7az4MMu6gWKQiCp1Zd7OF6Js8mfjRcMQwJPcb6a+
 0rZyxF/mU3Gcl1LGQEKZzo8uNtEvw/hQeCw25QIaW5JXWNojNHTZZV8ruLD9K0QtIQSX
 5fUE9hhma1afhJptiazumqyoDCCRP384ChrP7PSFtVAEwsCc1VQNT4aEKqdHZ2rQlvVc zg== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqrk8002w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 14:03:17 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43PDfAPe005328;
	Thu, 25 Apr 2024 14:03:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xmx3cru7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 14:03:16 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43PE3AtF50659650
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Apr 2024 14:03:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9F9C20043;
	Thu, 25 Apr 2024 14:03:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AC162004B;
	Thu, 25 Apr 2024 14:03:08 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.163])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 25 Apr 2024 14:03:08 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, hch@lst.de, gjoyce@linux.ibm.com,
        axboe@fb.com,
        Srimannarayana Murthy Maram <msmurthy@imap.linux.ibm.com>,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvme: cancel pending I/O if nvme controller is in terminal state
Date: Thu, 25 Apr 2024 19:33:00 +0530
Message-ID: <20240425140303.1599437-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pqFgOBiQBav7S8ADu2GfiQSwWtsfD78r
X-Proofpoint-ORIG-GUID: pqFgOBiQBav7S8ADu2GfiQSwWtsfD78r
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_14,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 phishscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404250102
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240425_150334_168007_756F3BBE 
X-CRM114-Status: GOOD (  20.63  )
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

While I/O is running, if the pci bus error occurs then
in-flight I/O can not complete. Worst, if at this time,
user (logically) hot-unplug the nvme disk then the
nvme_remove() code path can't forward progress until
in-flight I/O is cancelled. So these sequence of events
may potentially hang hot-unplug code path indefinitely.
This patch helps cancel the pending/in-flight I/O from the
nvme request timeout handler in case the nvme controller
is in the terminal (DEAD/DELETING/DELETING_NOIO) state and
that helps nvme_remove() code path forward progress and
finish successfully.

Link: https://lore.kernel.org/all/199be893-5dfa-41e5-b6f2-40ac90ebccc4@linux.ibm.com/
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 21 ---------------------
 drivers/nvme/host/nvme.h | 21 +++++++++++++++++++++
 drivers/nvme/host/pci.c  |  8 +++++++-
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 27281a9a8951..2ce63474eb47 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -628,27 +628,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
 
-/*
- * Returns true for sink states that can't ever transition back to live.
- */
-static bool nvme_state_terminal(struct nvme_ctrl *ctrl)
-{
-	switch (nvme_ctrl_state(ctrl)) {
-	case NVME_CTRL_NEW:
-	case NVME_CTRL_LIVE:
-	case NVME_CTRL_RESETTING:
-	case NVME_CTRL_CONNECTING:
-		return false;
-	case NVME_CTRL_DELETING:
-	case NVME_CTRL_DELETING_NOIO:
-	case NVME_CTRL_DEAD:
-		return true;
-	default:
-		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
-		return true;
-	}
-}
-
 /*
  * Waits for the controller state to be resetting, or returns false if it is
  * not possible to ever transition to that state.
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d0ed64dc7380..b564c5f1450c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -741,6 +741,27 @@ static inline bool nvme_is_aen_req(u16 qid, __u16 command_id)
 		nvme_tag_from_cid(command_id) >= NVME_AQ_BLK_MQ_DEPTH;
 }
 
+/*
+ * Returns true for sink states that can't ever transition back to live.
+ */
+static inline bool nvme_state_terminal(struct nvme_ctrl *ctrl)
+{
+	switch (nvme_ctrl_state(ctrl)) {
+	case NVME_CTRL_NEW:
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_CONNECTING:
+		return false;
+	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETING_NOIO:
+	case NVME_CTRL_DEAD:
+		return true;
+	default:
+		WARN_ONCE(1, "Unhandled ctrl state:%d", ctrl->state);
+		return true;
+	}
+}
+
 void nvme_complete_rq(struct request *req);
 void nvme_complete_batch_req(struct request *req);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8e0bb9692685..e393f6947ce4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1286,6 +1286,9 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	u32 csts = readl(dev->bar + NVME_REG_CSTS);
 	u8 opcode;
 
+	if (nvme_state_terminal(&dev->ctrl))
+		goto disable;
+
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
 	 */
@@ -1390,8 +1393,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 	return BLK_EH_RESET_TIMER;
 
 disable:
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+		if (nvme_state_terminal(&dev->ctrl))
+			nvme_dev_disable(dev, true);
 		return BLK_EH_DONE;
+	}
 
 	nvme_dev_disable(dev, false);
 	if (nvme_try_sched_reset(&dev->ctrl))
-- 
2.44.0


