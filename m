Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DF7C3DA6E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jan 2024 18:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9+XXnIme/BOBZ59ceOTp8PFyJrtWgcaBgPRe99cUreI=; b=yY/Y4yQ+hgIT2tkhBaOIFUpAye
	lfXmvv4xI9KoxzXTtSsew4gx4AAi4tL8mxCpb9bAdLrzUZPblSRXR5WmXGBSsXXYC3ND/0tYvmob/
	yMo3TFIXFFXOurpWwJL63FJ2khnG6qk1mWzWlCeZqy805uoRFGwT9Y7r7ggDX+GHiJimADvDeAiS+
	z7su+2O+r7dN6O8BFz3IiMAmU/6XbaMU0oD8ey+1d09QMyqWad/xTVImMqbP0q+oDTjmdnJ/vS1F2
	/E5/UJfiZfKCTKmJ9JLG2zJRoakTALF3BHFhWPsgemtZY+k5z2cgJ82WuDdABC0qs3jwmALnrucAC
	q/PeDreg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLool-00HXer-1f;
	Fri, 05 Jan 2024 18:21:15 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLooi-00HXeI-0e
	for linux-nvme@lists.infradead.org;
	Fri, 05 Jan 2024 18:21:13 +0000
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 405BuVxa027390
	for <linux-nvme@lists.infradead.org>; Fri, 5 Jan 2024 10:21:10 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=9+XXnIme/BOBZ59ceOTp8PFyJrtWgcaBgPRe99cUreI=;
 b=bib1fd0rTc1bbeRt9isw9HZBetckOvHXO3gm8hNp/HdhUFcjt9400jgJY3RQ00oO+7LL
 yMFfYHHY+QArrKmFrrI4nL6ZMkwfsTWu/poTRQiCdjyTCce/m1pg6WaQ96peRvzwWrzM
 VG7rsTIjVCNn7SGPN+CbEsKeJ1UZ6C6UeZYIeamrQoi5oigB7yyigh/vXVgGRi69P+Yb
 Mvap+m9bonHrcvrfsnGY3f1xVgNcAmSeRXLOBujiPxfVKMoGsqdgMUpFgAVlkRuv3hot
 vaBKn4QcsQgSNGo7kCTkTYwDwsVRYUUR88j+Rtjf8+MonG2sqh62BbVqFjOeKVlNDC/v ew== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3vechtkgmc-14
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 05 Jan 2024 10:21:09 -0800
Received: from twshared19681.14.frc2.facebook.com (2620:10d:c0a8:1b::2d) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 5 Jan 2024 10:20:48 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id ED2EB23DE7C45; Fri,  5 Jan 2024 10:20:21 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <axboe@kernel.dk>,
        <chaitanyak@nvidia.com>, <mgurtovoy@nvidia.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv3] nvme-pci: enhance timeout kernel log
Date: Fri, 5 Jan 2024 10:20:20 -0800
Message-ID: <20240105182020.2721350-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 2KQOmYLupYC6AWCLJjWeKxtwf1Ofqc4p
X-Proofpoint-ORIG-GUID: 2KQOmYLupYC6AWCLJjWeKxtwf1Ofqc4p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-05_08,2024-01-05_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240105_102112_445346_3BFAEF63 
X-CRM114-Status: GOOD (  14.40  )
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

Also print the command_id along side blk-mq's tag to help match commands
with protocol wire traces and firmware logs,

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
v2->v3: formatting updates and print out the command_id too

 drivers/nvme/host/pci.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f272026807419..698c6e497a22e 100644
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
@@ -1310,8 +1311,8 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
=20
 	if (blk_mq_rq_state(req) !=3D MQ_RQ_IN_FLIGHT) {
 		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, completion polled\n",
-			 req->tag, nvmeq->qid);
+			 "I/O tag %d (%04x) QID %d timeout, completion polled\n",
+			 req->tag, nvme_cid(req), nvmeq->qid);
 		return BLK_EH_DONE;
 	}
=20
@@ -1327,8 +1328,8 @@ static enum blk_eh_timer_return nvme_timeout(struct=
 request *req)
 		fallthrough;
 	case NVME_CTRL_DELETING:
 		dev_warn_ratelimited(dev->ctrl.device,
-			 "I/O %d QID %d timeout, disable controller\n",
-			 req->tag, nvmeq->qid);
+			 "I/O tag %d (%04x) QID %d timeout, disable controller\n",
+			 req->tag, nvme_cid(req), nvmeq->qid);
 		nvme_req(req)->flags |=3D NVME_REQ_CANCELLED;
 		nvme_dev_disable(dev, true);
 		return BLK_EH_DONE;
@@ -1343,10 +1344,13 @@ static enum blk_eh_timer_return nvme_timeout(stru=
ct request *req)
 	 * command was already aborted once before and still hasn't been
 	 * returned to the driver, or if this is the admin queue.
 	 */
+	opcode =3D nvme_req(req)->cmd->common.opcode;
 	if (!nvmeq->qid || iod->aborted) {
 		dev_warn(dev->ctrl.device,
-			 "I/O %d QID %d timeout, reset controller\n",
-			 req->tag, nvmeq->qid);
+			 "I/O tag %d (%04x) opcode %s %x QID %d timeout, reset controller\n",
+			 req->tag, nvme_cid(req),
+			 nvme_opcode_str(nvmeq->qid, opcode, 0), opcode,
+			 nvmeq->qid);
 		nvme_req(req)->flags |=3D NVME_REQ_CANCELLED;
 		goto disable;
 	}
@@ -1362,10 +1366,10 @@ static enum blk_eh_timer_return nvme_timeout(stru=
ct request *req)
 	cmd.abort.sqid =3D cpu_to_le16(nvmeq->qid);
=20
 	dev_warn(nvmeq->dev->ctrl.device,
-		"I/O %d (%s) QID %d timeout, aborting\n",
-		 req->tag,
-		 nvme_get_opcode_str(nvme_req(req)->cmd->common.opcode),
-		 nvmeq->qid);
+		 "I/O tag %d (%04x) opcode %s %x QID %d timeout, aborting req_op:%s(%u=
) size:%u\n",
+		 req->tag, nvme_cid(req), nvme_get_opcode_str(opcode), opcode,
+		 nvmeq->qid, blk_op_str(req_op(req)), req_op(req),
+		 blk_rq_bytes(req));
=20
 	abort_req =3D blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd)=
,
 					 BLK_MQ_REQ_NOWAIT);
--=20
2.34.1


