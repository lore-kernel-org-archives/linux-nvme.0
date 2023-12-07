Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62354C4167B
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 18:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bqQFSvyUWXYW1E5gzj7Qoid7o0VGPA7l3L/hQoIspC8=; b=foLxcoBOraHPzMlLtyi9z3gwSS
	rP/4Z9em/JGNqIQr+mKZ+ilucCoipVI688707jWHPF206cxsudiPEg7DxZU5Kj62ZIx2gW3dkXaWV
	3XMx7v/0Qulqe4jJ5Do7R2UlmHaBhIPe3DzaOmLK+OOsntWUjb/fPtgKCiaMTaG/6K6qwWwbKA0ZF
	jVvau/xe44MPYgDGeJem3TfR/J4KV8lWxdbp+J/4Oi7CpwYJ2+vnG05SWidMPEK+i+2z/vDZi6nTK
	NncfvrMgApQnlGtJ9oVcraG1socpxvusj4uWQkczJ9m5Q3PmYT0B1E7wYkkGaZ7soS4+jMloNuO2J
	Bumi8fcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBJBU-00Dee9-1D;
	Thu, 07 Dec 2023 18:33:16 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBJBR-00DedL-0y
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 18:33:15 +0000
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 3B7ENND0009351
	for <linux-nvme@lists.infradead.org>; Thu, 7 Dec 2023 10:33:05 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=bqQFSvyUWXYW1E5gzj7Qoid7o0VGPA7l3L/hQoIspC8=;
 b=cc0CvBVp12qzsEZpAPG7wfjl7Vre/WqjyZ9uL7L+PvPJQucRadg/+3fIHykzqIFYLclE
 CgoR43Z1ICFL0aWmtYW6zxIZkN+fXY7hHwkQA9LyDzr34yOzlZ0iJJyrX8zzw1exs4Ij
 tscF8NhD/xdFAAgXe+5xbP47H/pD6LVARPRISktmvUm23HleZ/ipRocgJe+NCSDmVMiU
 Gngh3a1k8JWX/YF3TGsAF61tFt62/aIM59hP/kyyIUuTF7nfMx+qNvZ1pgjBxnZhXdDL
 sV3tOiBo83tbQY+tEvoBk0laj4GFVgrvOh2MaHtjIzRhwB1C06w3jWkSFS7VOEl8Bbme gg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 3uufrra1da-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 07 Dec 2023 10:33:05 -0800
Received: from twshared51573.38.frc1.facebook.com (2620:10d:c0a8:1c::11) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 7 Dec 2023 10:33:04 -0800
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 5473722C2073E; Thu,  7 Dec 2023 10:32:51 -0800 (PST)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>
CC: <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme-pci: enhance timeout kernel log
Date: Thu, 7 Dec 2023 10:32:50 -0800
Message-ID: <20231207183250.2947699-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: dBqfmx9Hhp94i9SD8xK5bEhseRBVZZpB
X-Proofpoint-ORIG-GUID: dBqfmx9Hhp94i9SD8xK5bEhseRBVZZpB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_15,2023-12-07_01,2023-05-22_02
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_103313_785724_763A013D 
X-CRM114-Status: GOOD (  13.14  )
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
 drivers/nvme/host/pci.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fad4cccce745c..49771919b01f1 100644
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
@@ -1361,11 +1362,11 @@ static enum blk_eh_timer_return nvme_timeout(stru=
ct request *req)
 	cmd.abort.cid =3D nvme_cid(req);
 	cmd.abort.sqid =3D cpu_to_le16(nvmeq->qid);
=20
+	opcode =3D nvme_req(req)->cmd->common.opcode,
 	dev_warn(nvmeq->dev->ctrl.device,
-		"I/O %d (%s) QID %d timeout, aborting\n",
-		 req->tag,
-		 nvme_get_opcode_str(nvme_req(req)->cmd->common.opcode),
-		 nvmeq->qid);
+		 "I/O %d (%s %d) QID %d timeout, aborting req_op:%u size:%u\n",
+		 req->tag, nvme_get_opcode_str(opcode), opcode, nvmeq->qid,
+		 req_op(req), blk_rq_bytes(req));
=20
 	abort_req =3D blk_mq_alloc_request(dev->ctrl.admin_q, nvme_req_op(&cmd)=
,
 					 BLK_MQ_REQ_NOWAIT);
--=20
2.34.1


