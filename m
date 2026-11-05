Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F175A606A31B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=y/DT9GCs;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=idmiSLvw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=k0DikrKQmRQ055t4AEpwuyj+2bQmDjXz+Z3aWAcSxpE=; b=y/DT9GCsVFfbw1BsfZuSMVTPNd
	7UBVlSiwZzOABpIffaByBskZPh1MWSOGS4EyQi5O3Y7hUroI+d8UVL8jSwLhVxXOfR0ZYq/i/sphe
	IiCNZC1i7KdV0pyc/ozWnsMcabljblSxz5EHCwoLwgiL6EBQv0mjUFeH1EcAwgGJDs/Ncmii6/7EE
	Z+JNuEVX8wmF4ALDRLvbTWGQ87gxYKUyCf8Sbdn6SYXWhWLfEbusgD9ziEXO/qbns4mPzWtd6cLEL
	ryCDe5ZskXS+OQ09WC0XZkigiFXXLCiOceCJ72V+vbejf8XcNqs869qF84UBH/kTcBKzmhpDrPV3z
	/XjJWXDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOwiV-00000008zDR-15QE;
	Thu, 05 Nov 2026 12:37:19 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOwiS-00000008zCg-434R
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 12:37:18 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AE8aG3449833;
	Thu, 5 Nov 2026 12:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=k0DikrKQmRQ055t4AEpwuyj+2bQmDjXz+Z3aWAcSx
	pE=; b=idmiSLvwZkRj2a2sX37aKgjJsRp6EI7XYW9I1x7Uvgs+QGnJ+9pBkluAQ
	LdzIsOh6Br47EcodFw0oX0OX4Gmn1shTwpMRjOFFkW2/E2RZbN3GCOVNilnrmgt+
	WxvMXduskYJgT4vbdnydbSNDnShAeJpo7OS5zNYo4T9GNKizPwq3bJQmQuGN+oCh
	IQOVQRKZE38p9aEkDZQIC2M5U06bHVLNEd5LC5BngzD/uz1xvrGf6ksvVJOpOC/r
	2WmoD7hNzmFF43lrclR90fNscE/mFBdww5UECLp/0zsf4YD3AnY2vfhFCv/6XoTX
	yrfeyCs3I+XnAkB9CEe17v0HqbVxg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7u3t5p8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:37:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5A4s4b1476777;
	Thu, 5 Nov 2026 12:37:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrka6ss6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 12:37:01 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5CavJw28115462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 12:36:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59B2A2005A;
	Thu,  5 Nov 2026 12:36:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DDAB2004E;
	Thu,  5 Nov 2026 12:36:53 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.54.50])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 12:36:53 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, chaitanyak@nvidia.com,
        gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org, shinichiro.kawasaki@wdc.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH] nvmet: cache passthru reference in __nvmet_req_complete()
Date: Thu,  5 Nov 2026 17:54:55 +0530
Message-ID: <20261105123642.2120548-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Zsp4uN7G c=1 sm=1 tr=0 ts=6aec786e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=JF9118EUAAAA:8 a=VnNF1IyMAAAA:8
 a=g3HCxRTuVJBXPMZTQd4A:9 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-ORIG-GUID: TFiVHyZCFa8hT2fIeqKU33BoQCAm86Fy
X-Proofpoint-GUID: TFiVHyZCFa8hT2fIeqKU33BoQCAm86Fy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA0OCBTYWx0ZWRfX6qhzZGFY1Qs+
 NI3bDdfQQ4SlF15YfmPjSdZbEcUc7fJtjoHKOQ/5+0QevwDsTiHp9UJ5Y4LCo2DDJTkoqIdgxT0
 q6imwwGqadZ4FwLewIpXMZXbVLydJ+sv2rpSo+3dm327hBb4syP9/xaIZCHsXOw8jxfoG/mQleW
 6A2S8gMO6iVjRbPesPoMxvmPVsw+Xt0nZIk5RQKbzHRDBwFsK69Rmp8rBea8Ueds1HwmzDUJ5qI
 Zb4R3HXoI7Oq1J7fManJ3zh8pBv//4j+WUyh/tFWtkqBIapeaKqLTATDsZhdccGDwzfCefmB+kY
 IqvGw8VECxey2djk2cP1nPfpdm0+Dby2x2pticsVz4x/WLzKw5p+MphH7bYJYX6f2UZcjdCM5SO
 tCoGfn4DQA6gsVIV2WbPJrOdOds8OdXXNcc63vQykq5rd/NmlFY5FtRTwzaKZV2fTFUF2JG+Dhd
 PVXGlpl6wOx32a1SJKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA0OCBTYWx0ZWRfX5VtksspjExuv
 gJ1xeBSQNPi8IDOCTlJQE5q4w4NLhEeiilXARMTLX4RQW8oeA0HFyNI6fucnDupOhRdQv1yR2oo
 ove2FZlznenQw0w1Hw9KgJwx4ZTPcv0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 impostorscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611050048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261105_043717_005251_6D807F70 
X-CRM114-Status: GOOD (  18.15  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

__nvmet_req_complete() releases the passthru reference held while
processing a passthru request. However, it currently does so after
calling ops->queue_response().

Once ops->queue_response() is called, the transport may complete and
recycle the request on another CPU. If the request is reused, its
req->p.ref_held field may be reset to false before
__nvmet_req_complete() checks it in nvmet_put_passthru_ref().
Consequently, the passthru reference may not be released, leaving
wait_for_completion(&passthru->disable_done) in
__nvmet_passthru_ctrl_disable() blocked indefinitely.

Fix this by caching the passthru pointer at the beginning of
__nvmet_req_complete(), while the request is still valid, and use
the cached pointer to release the reference after queuing the
response. This also changes nvmet_put_passthru_ref() to accept
the passthru pointer directly instead of accessing it through
the request.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Closes: https://lore.kernel.org/all/auhpmq499RVE9YpC@shinmob/
Fixes: 5e12d81874a1 ("nvmet: fix use-after-free in passthru I/O hotpath")
Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/target/core.c  |  4 +++-
 drivers/nvme/target/nvmet.h | 24 +++++++++++++++++-------
 2 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index eadab017c70b..b8bcb5bf6be6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -806,6 +806,7 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
 	struct nvmet_ns *ns = req->ns;
 	struct nvmet_pr_per_ctrl_ref *pc_ref = req->pc_ref;
+	struct nvmet_passthru *passthru = nvmet_passthru_ref_held(req);
 
 	if (!req->sq->sqhd_disabled)
 		nvmet_update_sq_head(req);
@@ -824,7 +825,8 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 	if (ns)
 		nvmet_put_namespace(ns);
 
-	nvmet_put_passthru_ref(req);
+	if (passthru)
+		nvmet_put_passthru_ref(passthru);
 }
 
 void nvmet_req_complete(struct nvmet_req *req, u16 status)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3cd58e813aa7..2c2460ef5e2b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -832,6 +832,15 @@ static inline struct nvmet_passthru *nvmet_subsys_passthru(
 	return subsys->passthru;
 }
 
+static inline struct nvmet_passthru *nvmet_passthru_ref_held(
+		struct nvmet_req *req)
+{
+	if (req->p.ref_held)
+		return nvmet_req_subsys(req)->passthru;
+
+	return NULL;
+}
+
 static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
 {
 	if (!percpu_ref_tryget_live(&nvmet_req_subsys(req)->passthru->ref))
@@ -841,13 +850,9 @@ static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
 	return true;
 }
 
-static inline void nvmet_put_passthru_ref(struct nvmet_req *req)
+static inline void nvmet_put_passthru_ref(struct nvmet_passthru *passthru)
 {
-	if (!req->p.ref_held)
-		return;
-
-	req->p.ref_held = false;
-	percpu_ref_put(&nvmet_req_subsys(req)->passthru->ref);
+	percpu_ref_put(&passthru->ref);
 }
 #else /* CONFIG_NVME_TARGET_PASSTHRU */
 static inline void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys)
@@ -873,11 +878,16 @@ static inline struct nvmet_passthru *nvmet_subsys_passthru(
 {
 	return NULL;
 }
+static inline struct nvmet_passthru *nvmet_passthru_ref_held(
+		struct nvmet_req *req)
+{
+	return NULL;
+}
 static inline bool nvmet_get_passthru_ref(struct nvmet_req *req)
 {
 	return false;
 }
-static inline void nvmet_put_passthru_ref(struct nvmet_req *req)
+static inline void nvmet_put_passthru_ref(struct nvmet_passthru *passthru)
 {
 }
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */

base-commit: c64d9b2c1f4fd1d8fa52dab37b48428a99c4d58d
-- 
2.53.0


