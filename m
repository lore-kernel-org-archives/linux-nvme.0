Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68DE5C25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qBybYhk+LOOMJWJE+kmZk7jo/rls1oxLKVTjtZ6NgzU=; b=Ch5nLemhLq/tnDcyojcZzZhZeA
	BRLadvAF4J7BXpqLvwhlVPCGztof+V3GeGZ8hyISZBrBzKkLBIvW5OoYtHm8Go/4ZLbr6T/VcRbNF
	YrOiYYUwzQicg9G9h0jT/iq85pKGe57c08aePxHYxB8JSsIEXXBkT6e/KHE9fKybNo70xB4u+n8FK
	vihFag4C4c/Lh8c6DX5vbDFCzaIi6lJbn6KWbmAQehHFl3aYc0gpTWJCfp7by+a1rHGVHMYc+I2eW
	2NpWYCKbUN3hamnw3xkQRexDVG/bRnO70b5FyObNOtri/qMU6YV00OBR2el4OW2JMdoPOO+v2qDkx
	Un9ByYOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9TtY-00000000hmi-04gs;
	Tue, 21 May 2024 18:07:28 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9TtU-00000000hm9-3HnK
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 18:07:26 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 44LI58M9002071
	for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 11:07:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=qBybYhk+LOOMJWJE+kmZk7jo/rls1oxLKVTjtZ6NgzU=;
 b=M6vE/yEewWHG0HdWzgxnw0CPt4YUjbeMhDL/2CCQ7ED/2JGmJWt8VMha/P32zDBgejx8
 0ZY6ZeeNFIdukIS1TSR2A80sOlcaCk2s+uDPLTnWZ/tfSeHAP7lK3P+I+ERP3ocLrZnO
 eOBFYAeA3+gnKAzx5dBTgJnK4A2BQ0gkKgnxqZ1bAQiJPmtEFhb00Mu7lDwqHaBdQrJI
 NsmKdRuFnnyfD+CRk3mFqoJxWQC5zgrtVOUdATG86tBhi1f0D2FYn1OxBJjjQ8V0IUO0
 RNx8fDB1kuqTgiXZ4xmIT1gBSSU6hZ3cNQSULwqqWV4qjJfvhwFCFE3Myu2+At2VUF7L bg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3y7ycp3q0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 11:07:18 -0700
Received: from twshared0252.08.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.11; Tue, 21 May 2024 18:07:17 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id 998022CC634A; Tue, 21 May 2024 11:07:13 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: <jmeneghi@redhat.com>, <nilay@linux.ibm.com>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCH] nvme-multipath: fix io accounting on failover
Date: Tue, 21 May 2024 11:07:12 -0700
Message-ID: <20240521180712.2423165-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: JF4jNlsgagSmQsThtDA6jChav9tunnSx
X-Proofpoint-ORIG-GUID: JF4jNlsgagSmQsThtDA6jChav9tunnSx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_110725_040856_92C87B1A 
X-CRM114-Status: GOOD (  16.12  )
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

There are io stats accounting that needs to be handled, so don't call
blk_mq_end_request() directly. Use the existing nvme_end_req() helper
that already handles everything.

Fixes: d4d957b53d91ee ("nvme-multipath: support io stats on the mpath dev=
ice")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c      | 2 +-
 drivers/nvme/host/multipath.c | 3 ++-
 drivers/nvme/host/nvme.h      | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79cdd34dfa18e..7706df2373494 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -422,7 +422,7 @@ static inline void __nvme_end_req(struct request *req=
)
 		nvme_mpath_end_request(req);
 }
=20
-static inline void nvme_end_req(struct request *req)
+void nvme_end_req(struct request *req)
 {
 	blk_status_t status =3D nvme_error_status(nvme_req(req)->status);
=20
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.=
c
index 9c1e135b8df3b..1bee176fd850e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -118,7 +118,8 @@ void nvme_failover_req(struct request *req)
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
=20
-	blk_mq_end_request(req, 0);
+	nvme_req(req)->status =3D 0;
+	nvme_end_req(req);
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
=20
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cacc56f4bbf44..fc31bd340a63a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -767,6 +767,7 @@ static inline bool nvme_state_terminal(struct nvme_ct=
rl *ctrl)
 	}
 }
=20
+void nvme_end_req(struct request *req);
 void nvme_complete_rq(struct request *req);
 void nvme_complete_batch_req(struct request *req);
=20
--=20
2.43.0


