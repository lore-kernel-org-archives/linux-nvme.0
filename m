Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F51C35274
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Dec 2023 22:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ItAC93mzPRbOsC5mapF9CZFbE5Zcp9/a8gPgJt/huzI=; b=ywyx3zfBlovZ3RtrbUAFmDTr1L
	4ad7qmohj9lJM6knPKwl5XwvWu1kKF6CsjfOxpJ4KFGRLEYWE2ci6vPNj4yVMwb0tKM20GdW/+wjf
	zMQtQjF3tRvhRDUTBMRvxzT8sEPvT94CGlEC8V6LH7upRy3DdQBRoWvdMCYSWwuLXY3/Q6w+5oLb5
	nw7bPUzJJt8Qq08Vig8Het2XPIX3PMAtdCeOtbhazKH8tc5Ep82g3NC0EzoNic7aEp/XZ6b3goUYQ
	9YNP8FuygtCSpwj4uTcubrCYztzqQtP8ODm/1cqPgMVsJjw4pXvEsZx05XvWV4271dgVp7CZok6T+
	UEaVxj3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rFMO0-00CFzW-2e;
	Mon, 18 Dec 2023 22:46:56 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rFMNx-00CFz5-0Y
	for linux-nvme@lists.infradead.org;
	Mon, 18 Dec 2023 22:46:54 +0000
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BIMLQRI013052
	for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 14:46:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=ItAC93mzPRbOsC5mapF9CZFbE5Zcp9/a8gPgJt/huzI=;
 b=Y+qbPdZWB86kHqWgGdq4zmcTofRrwN9G/nPTQvjYcILOe8Jc/ks0LD258vMgbACa1JP0
 GE7xF+qju38JuV/aZ6ivPS8YRLbW3HBEc+UlSCn4kQcaEG7NDn5TRcHAcE6wG4tfs1fZ
 ZeOHnQg7yMVZdDA7MITkb556PV7OF1TXNBRr7he0m2lsGVIwnrByS5LVfMjkPSVP4vI4
 f9gL9kZqwm/NpK5xWhI0Z3td36jw7lND5RsEg4Y/8r54pvKgDlIuiSokPCUVZ/6fa7zI
 vC/uoxVi952AKQuyIxb6Pe8HGc84p2/EXJCrTUE4yulL3leeG5XRXg4geCpswABChmLP pw== 
Received: from mail.thefacebook.com ([163.114.132.120])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3v2xt1r4af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 18 Dec 2023 14:46:51 -0800
Received: from twshared17205.35.frc1.facebook.com (2620:10d:c085:108::4) by
 mail.thefacebook.com (2620:10d:c085:21d::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 18 Dec 2023 14:46:49 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 879CB234981BF; Mon, 18 Dec 2023 14:46:35 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <axboe@kernel.dk>,
        <chaitanyak@nvidia.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2] nvme-pci: enhance timeout kernel log
Date: Mon, 18 Dec 2023 14:46:33 -0800
Message-ID: <20231218224633.2963811-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: evE6B0rtjg2AU_X2jX6ZsniuYR3i3F32
X-Proofpoint-ORIG-GUID: evE6B0rtjg2AU_X2jX6ZsniuYR3i3F32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-18_15,2023-12-14_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231218_144653_329310_8352C4FF 
X-CRM114-Status: GOOD (  14.18  )
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

Kernel configs don't necessarily have opcode decoding, and some opcodes
are not even decodable. It is still interesting for debugging SSD issues
to know what opcode is timing out, what request type it came from, and
the data size (if applicable).

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v1->v2:

  Even more verbose annotations in the messages (Jens and Chaitanya)

 drivers/nvme/host/pci.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 507bc149046dc..f71ec41489a73 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1284,6 +1284,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
 	struct request *abort_req;
 	struct nvme_command cmd =3D { };
 	u32 csts =3D readl(dev->bar + NVME_REG_CSTS);
+	u8 opcode;
=20
 	/* If PCI error recovery process is happening, we cannot reset or
 	 * the recovery mechanism will surely fail.
@@ -1310,7 +1311,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
=20
 	if (blk_mq_rq_state(req) !=3D MQ_RQ_IN_FLIGHT) {
 		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, completion polled\n",
+			 "I/O tag %d QID %d timeout, completion polled\n",
 			 req->tag, nvmeq->qid);
 		return BLK_EH_DONE;
 	}
@@ -1327,7 +1328,7 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
 		fallthrough;
 	case NVME_CTRL_DELETING:
 		dev_warn_ratelimited(dev->ctrl.device,
-			 "I/O %d QID %d timeout, disable controller\n",
+			 "I/O tag %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_req(req)->flags |=3D NVME_REQ_CANCELLED;
 		nvme_dev_disable(dev, true);
@@ -1343,10 +1344,12 @@ static enum blk_eh_timer_return nvme_timeout(stru=
ct request *req)
 	 * command was already aborted once before and still hasn't been
 	 * returned to the driver, or if this is the admin queue.
 	 */
+	opcode =3D nvme_req(req)->cmd->common.opcode;
 	if (!nvmeq->qid || iod->aborted) {
 		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, reset controller\n",
-			 req->tag, nvmeq->qid);
+			 "I/O tag %d (opcode:%s %d) QID %d timeout, reset controller\n",
+			 req->tag, nvme_opcode_str(nvmeq->qid, opcode, 0),
+			 opcode, nvmeq->qid);
 		nvme_req(req)->flags |=3D NVME_REQ_CANCELLED;
 		goto disable;
 	}
@@ -1362,10 +1365,9 @@ static enum blk_eh_timer_return nvme_timeout(struc=
t request *req)
 	cmd.abort.sqid =3D cpu_to_le16(nvmeq->qid);
=20
 	dev_warn(nvmeq->dev->ctrl.device,
-		"I/O %d (%s) QID %d timeout, aborting\n",
-		 req->tag,
-		 nvme_get_opcode_str(nvme_req(req)->cmd->common.opcode),
-		 nvmeq->qid);
+		 "I/O tag %d (opcode:%s %d) QID %d timeout, aborting req_op:%s(%u) siz=
e:%u\n",
+		 req->tag, nvme_get_opcode_str(opcode), opcode, nvmeq->qid,
+		 blk_op_str(req_op(req)), req_op(req), blk_rq_bytes(req));
=20
 	abort_req =3D blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd)=
,
 					 BLK_MQ_REQ_NOWAIT);
--=20
2.34.1


