Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29341EB64DA
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jul 2023 15:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rP4nRN0mOoMSbqfgXev9oOJahv3KsYa9yWoUUX7fQBc=; b=4w2bGE2zvR8Nq+KLXve1ahgfCi
	tMj39utONruh5afUjXT0DxvT0PD8M8dm+4ZBtkjpkwNHNQQwQF8BGxRHtz7w2xQz9rJz5CiH7ldbo
	3V5aeQT0+BCwYiMQblDsWdbrWpOphKICzQybEledNxhDw9MCApiFspTJ+SJz4XBRpXBBzK9JeIWfY
	uXIOLCg6/E5HCieRrpN1t6qf/gSAHsjNceaR24PvMAgxhgNxeBS5Z+kYhXamOO/DDVNtndq+y3i5l
	VrIjTT+gtENiAlMnz1GXEawW905KwZTR4URsFosOY1/UAr+O1HQNFcQseW4tIxL4fDO0Mi+Wg+nt4
	nAK8IcZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbww-000O5B-0U;
	Wed, 12 Jul 2023 15:40:18 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qJbwt-000O4V-1C
	for linux-nvme@lists.infradead.org;
	Wed, 12 Jul 2023 15:40:16 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CDicYQ032000
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 08:40:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=rP4nRN0mOoMSbqfgXev9oOJahv3KsYa9yWoUUX7fQBc=;
 b=TOt7UAQV+Gno111GirxS94Y8iZiJ3KmGkyP3URIhRhjM+5y0SseT1r87fRWbjz25UwzK
 k9CQublES/xXojpBUT/h26eE+IL39bofYeGcDzsfa939kY2jiBnZuwooLFxukCyzM3Az
 8Si8O+QPys0B+gl8ZZsWssR+e1zoEIfbA57TymQcvF25HLn75yFgh0onne1thFK935yQ
 QBqcJ3N43I5E9hRdNHQfc7+g3oPUjnhua2D63d5MZ57DL3VNXd+s2lWgXWzBtkv/s4hV
 PY3xpmhgIz0QMU+NnBNb1wkv7gUawSSVC7vdoH/YP+GDGoCfgxg2aOG5mW5BD8ClOPn5 mQ== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3rsg8tnktp-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 12 Jul 2023 08:40:14 -0700
Received: from twshared34392.14.frc2.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Jul 2023 08:40:10 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 446791B7D9F18; Wed, 12 Jul 2023 08:40:05 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
        Ming Lei
	<ming.lei@redhat.com>
Subject: [PATCHv2] nvme: ensure disabling pairs with unquiesce
Date: Wed, 12 Jul 2023 08:40:04 -0700
Message-ID: <20230712154004.360561-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 5itEwuwswYbYzis7eleoXBMR-nNJ9sIg
X-Proofpoint-GUID: 5itEwuwswYbYzis7eleoXBMR-nNJ9sIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_11,2023-07-11_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230712_084015_417604_8A0FEC6E 
X-CRM114-Status: GOOD (  19.57  )
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
paired with reset_work. Just make sure that the controller can be put
into a resetting state prior to starting the disable so that no other
handling can change with the queue states while recovery is happening.

Reported-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Don't wait for a resetting state as that could deadlock. Just abort
  the disabling if the error handling can't set the state to resetting.

 drivers/nvme/host/pci.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8754b4a5c6844..8e7dbe0ab8904 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1298,9 +1298,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
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
@@ -1351,10 +1349,7 @@ static enum blk_eh_timer_return nvme_timeout(struc=
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
@@ -1391,6 +1386,15 @@ static enum blk_eh_timer_return nvme_timeout(struc=
t request *req)
 	 * as the device then is in a faulty state.
 	 */
 	return BLK_EH_RESET_TIMER;
+
+disable:
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+		return BLK_EH_DONE;
+
+	nvme_dev_disable(dev, false);
+	if (nvme_try_sched_reset(&dev->ctrl))
+		nvme_unquiesce_io_queues(&dev->ctrl);
+	return BLK_EH_DONE;
 }
=20
 static void nvme_free_queue(struct nvme_queue *nvmeq)
@@ -3278,6 +3282,10 @@ static pci_ers_result_t nvme_error_detected(struct=
 pci_dev *pdev,
 	case pci_channel_io_frozen:
 		dev_warn(dev->ctrl.device,
 			"frozen state error detected, reset controller\n");
+		if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+			nvme_dev_disable(dev, true);
+			return PCI_ERS_RESULT_DISCONNECT;
+		}
 		nvme_dev_disable(dev, false);
 		return PCI_ERS_RESULT_NEED_RESET;
 	case pci_channel_io_perm_failure:
@@ -3294,7 +3302,8 @@ static pci_ers_result_t nvme_slot_reset(struct pci_=
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


