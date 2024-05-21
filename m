Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB19C25B74
	for <linux-nvme@archiver.kernel.org>; Tue, 21 May 2024 17:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=z2mwhugT22raAJxp3zuPAyWKpj8CWISwoxKLNbVZqsA=; b=MU5V/orEkyiSAds3qunSVVyMrX
	aNJvoNGhFBrfBxCuJhxg8bvw9V6K7BNej+J8ORzTZgERPhs9DTb5C9AVNvpMA9xIwrrQbYdqOlK26
	8t8L9HHmpIwzZAl5feGk+Hcn0JHLQ68LbtV9kJMw7R2Q6vVqWSLUJ8otVDuPJWGk7bkOwZ42HggTU
	oeUDUd0UqaKhuHQxQWX1aTywArmB6rvibGwb1mtKhMBz8tCGwGo5Y1Bpo4OZ59Id2gbXOBh6+88b0
	sPCnvRmohwbbCsg0GJCL9RLaZqra4ApfiylzqrKrLx0NNqU9N0vl5IYu8C1s1CCSQzuJtimDPhm6X
	Uv07KvZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Sw7-00000000aK4-16Oa;
	Tue, 21 May 2024 17:06:03 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30] helo=mx0a-00082601.pphosted.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9Sw4-00000000aJE-0u0s
	for linux-nvme@lists.infradead.org;
	Tue, 21 May 2024 17:06:01 +0000
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 44LAqFHn002091
	for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 10:05:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=z2mwhugT22raAJxp3zuPAyWKpj8CWISwoxKLNbVZqsA=;
 b=nnPTmF2Y5WY0tIEohiq7FYe3bUti3DOtDGhZaCoM06fZizsJ/C69D/RsGnqAMEArsIQx
 8+qJ8LH+RYtiIGNN6yzrl/2y4EayfkJPj06Ci1Y388jW10DjwZVmUGas63qAU01WDl0k
 MdpVwF/HX1N3ukFAgjXqcc4noFUASFcWfE1h/FdMzsoMK6/u9Uf19ur0oV0kZ3G0GL0h
 GUlMrIxFyuuoZkNFEKUhs3SMcqYVNl3XLgjDYyQAWdnxm2B8pOYXXGlX/Z+ecO/f2hRC
 ApdKPTZm/7ukCQA8gJGGLo+326kHlGH1MkZCVfRb2e3RcP7OG3xlar90Hjz6FcJnQSqn rA== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 3y7ycp37d3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Tue, 21 May 2024 10:05:55 -0700
Received: from twshared1277.06.ash9.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:82::b) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 21 May 2024 17:05:54 +0000
Received: by devbig032.nao3.facebook.com (Postfix, from userid 544533)
	id AF6E82CBFF49; Tue, 21 May 2024 10:05:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <hch@lst.de>, <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>
CC: <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: fix multipath batched completion accounting
Date: Tue, 21 May 2024 10:05:37 -0700
Message-ID: <20240521170537.2029233-1-kbusch@meta.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: epWRUBpvl7Ce7sy5oxj58KQ_Up_EKdfY
X-Proofpoint-ORIG-GUID: epWRUBpvl7Ce7sy5oxj58KQ_Up_EKdfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240521_100600_469966_B614A48D 
X-CRM114-Status: GOOD (  15.37  )
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

Batched completions were missing the io stats accounting and bio trace
events. Move the common code to a helper and call it from the batched
and non-batched functions.

Fixes: d4d957b53d91ee ("nvme-multipath: support io stats on the mpath dev=
ice")
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 954f850f113a1..79cdd34dfa18e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -414,6 +414,14 @@ static inline void nvme_end_req_zoned(struct request=
 *req)
 	}
 }
=20
+static inline void __nvme_end_req(struct request *req)
+{
+	nvme_end_req_zoned(req);
+	nvme_trace_bio_complete(req);
+	if (req->cmd_flags & REQ_NVME_MPATH)
+		nvme_mpath_end_request(req);
+}
+
 static inline void nvme_end_req(struct request *req)
 {
 	blk_status_t status =3D nvme_error_status(nvme_req(req)->status);
@@ -424,10 +432,7 @@ static inline void nvme_end_req(struct request *req)
 		else
 			nvme_log_error(req);
 	}
-	nvme_end_req_zoned(req);
-	nvme_trace_bio_complete(req);
-	if (req->cmd_flags & REQ_NVME_MPATH)
-		nvme_mpath_end_request(req);
+	__nvme_end_req(req);
 	blk_mq_end_request(req, status);
 }
=20
@@ -476,7 +481,7 @@ void nvme_complete_batch_req(struct request *req)
 {
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
-	nvme_end_req_zoned(req);
+	__nvme_end_req(req);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_batch_req);
=20
--=20
2.43.0


