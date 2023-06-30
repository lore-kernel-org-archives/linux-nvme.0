Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF022EB64D7
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jun 2023 17:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dxNCWw9/XGjhsUhYX46Bc5zT8+5Ld3Ad2FZ9z+dbogQ=; b=JVmrmidYtPmOwG0gpJ7wXbQBiS
	byJbi1EdWa9rYeKbQCD7K+UAeEq2hTgxPII2OV5OlNIVznf0ESxZ3cjPHAACeLFtozEPQJxEbbDtu
	82jjZ+xZSvWr5ESVJjL5GZnqD+Ik1roqr0/XsE9tokbFwiBKOvWeI1Rw57/rJjICXN8wiQ+xopyAg
	isxoHJpPhVm5pFRHOCJ4OC4uhxQvgmgnwcENa/kffyaMkIv4HAR6PsGMkOPctVxpgalb/+jKkb4ep
	S87kE84ywljqNcdOnK37ldI0q7GxOXZ5rp43FvcBCLAy7XZc0NMJZPBQTD6u7W4eY/BSvtCIznK8p
	DnlgxZLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qFIDc-004DZf-2B;
	Fri, 30 Jun 2023 17:47:40 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qFIDZ-004DZA-2n
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jun 2023 17:47:39 +0000
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UHd75N010444
	for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 10:47:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=dxNCWw9/XGjhsUhYX46Bc5zT8+5Ld3Ad2FZ9z+dbogQ=;
 b=iK0ZJNQHoqNyhnhHRZoX69yxqr1Jk0ZGFavbYSbjl/+9icfQnwwiuz2sJxHSPPrbdIgC
 r1NM67Jm3rkOQZ2d5W5jF2ZFdfM7VzmkCHI6MblCuzvycAI7ZDfS/OVBEdglUj90/emm
 yFdz8lH7S/wlL7JHx52ZWbKdsvh/WtrRRIfIvyWyE/pBs0Yw5JR9K5LErt4uE2VMF7hf
 gCRxLLXE86nQMn3VU6pR8UNaYtH+32vqXIP0WAQh+Op+KbpOSONrsefjZ+u9fV3u6KDK
 YcFHIyLYOptwd+zMa1bNABjp6tq6qr1yeBxp4xkoO1QhMXv6p063Be/XLayup09LfQB3 3w== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rhv0vv3tb-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 30 Jun 2023 10:47:35 -0700
Received: from twshared37136.03.ash8.facebook.com (2620:10d:c0a8:1c::1b) by
 mail.thefacebook.com (2620:10d:c0a8:83::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 30 Jun 2023 10:47:33 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 94D011AE49CA2; Fri, 30 Jun 2023 10:47:23 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Ming Lei
	<ming.lei@redhat.com>
Subject: [PATCH] nvme: ensure disabling pairs with unquiesce
Date: Fri, 30 Jun 2023 10:47:06 -0700
Message-ID: <20230630174706.3807872-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: ra0qCQcPbd2bDXpyaSBg_B75_YWOxSdQ
X-Proofpoint-ORIG-GUID: ra0qCQcPbd2bDXpyaSBg_B75_YWOxSdQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_10,2023-06-30_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230630_104738_019764_DC4FB8F1 
X-CRM114-Status: GOOD (  17.18  )
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

From: Keith Busch <kbusch@kernel.org>

If any error handling that disables the controller fails to queue the
reset work, like if the state changed to disconnected inbetween, then
the failed teardown needs to unquiesce the queues since it's no longer
paired with reset_work.

Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c9224d39195e5..bf21bd08ee7ed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -108,6 +108,7 @@ MODULE_PARM_DESC(noacpi, "disable acpi bios quirks");
 struct nvme_dev;
 struct nvme_queue;
=20
+static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdow=
n);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static void nvme_delete_io_queues(struct nvme_dev *dev);
 static void nvme_update_attrs(struct nvme_dev *dev);
@@ -1298,9 +1299,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
 	 */
 	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
-		nvme_dev_disable(dev, false);
-		nvme_reset_ctrl(&dev->ctrl);
-		return BLK_EH_DONE;
+		goto disable;
 	}
=20
 	/*
@@ -1351,10 +1350,7 @@ static enum blk_eh_timer_return nvme_timeout(struc=
t request *req)
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_req(req)->flags |=3D NVME_REQ_CANCELLED;
-		nvme_dev_disable(dev, false);
-		nvme_reset_ctrl(&dev->ctrl);
-
-		return BLK_EH_DONE;
+		goto disable;
 	}
=20
 	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
@@ -1391,6 +1387,12 @@ static enum blk_eh_timer_return nvme_timeout(struc=
t request *req)
 	 * as the device then is in a faulty state.
 	 */
 	return BLK_EH_RESET_TIMER;
+
+disable:
+	if (!nvme_disable_prepare_reset(dev, false) &&
+	    nvme_try_sched_reset(&dev->ctrl))
+		nvme_unquiesce_io_queues(&dev->ctrl);
+	return BLK_EH_DONE;
 }
=20
 static void nvme_free_queue(struct nvme_queue *nvmeq)
@@ -3278,7 +3280,8 @@ static pci_ers_result_t nvme_error_detected(struct =
pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
-		nvme_dev_disable(dev, false);
+		if (nvme_disable_prepare_reset(dev, false))
+			return PCI_ERS_RESULT_DISCONNECT;
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
 		dev_warn(dev->ctrl.device,
@@ -3294,7 +3297,8 @@ static pci_ers_result_t nvme_slot_reset(struct pci_=
dev *pdev)
=20
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
-	nvme_reset_ctrl(&dev->ctrl);
+	if (!nvme_try_sched_reset(&dev->ctrl))
+		nvme_unquiesce_io_queues(&dev->ctrl);
 	return PCI_ERS_RESULT_RECOVERED;
 }
=20
--=20
2.34.1


