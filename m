Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73856CD98CC
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v2K6cV2bC77mIEf1+2OdFHyC7mP9JCyZUn7qBo0Afzc=; b=m5nZjvjEP2DR11kkDfS7HltuV3
	VoUagL5MDWFm5SQt5ihDDS57ESe0JgEp7fvSCYpKezUA8uKntory5ipp6CR9ObNwlfXuCgz7h/ppE
	HUQpc6zEvSDOoHmvW0LO0CAD4j8sEVJ46KGaF4uDtFKiuEbXagydnMIqawj1PBX2tpXZXbSdozpeT
	zx6r5r79oU+v75XplikbGca07YDZZbXGkAePlRDQMnk+Bchhed/s/nTSzge4Yfvq+OLqKnWj8he0o
	kv58HBr7AEjXo4ZrGXDkbqq6diBnxPacQThNvM7iuNxsI8xhq35hR3sJCMDHpqGzCXPQPSfIBIqgg
	dMgaK35w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvM-00000007t0G-3H9e;
	Wed, 10 Jun 2026 14:28:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvK-00000007swG-01ZM
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:55 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A7H8fH3134026;
	Wed, 10 Jun 2026 14:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v2K6cV2bC77mIEf1+
	2OdFHyC7mP9JCyZUn7qBo0Afzc=; b=KZLXnNS3KpEizzTDPhCkr/0cdaLtsq/sr
	CAOjOHVfjtBMR+idh/t1ZqwUWABf13Phk3kg86S2SOr8shQfitW43H3cczmn2u1B
	TAYtUWS/Wr6CMP0wjvvdnygxD4HTNyCPwbslAxPgmB3xzdaOMSZUTRg9c6JYM/Ev
	OfrQAx3po9GD21P/PlF2XbKHcx8KD4mQ9Lusw+hHToYirtcESZk2akjfHRYgv+wv
	HMBMfkAfLKAUAi6etme4qLHC/UQ5B5hWK5V1K+rYici54ez067oE54eMz47JG/z/
	AwZoWjhJdGmI8oI2ILijV98s2c1xb026l20P0dZmKMWzHrCylVkcQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95hhj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEK3w1011481;
	Wed, 10 Jun 2026 14:28:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyeryd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:45 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESf2E36176338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:42 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D66FA20049;
	Wed, 10 Jun 2026 14:28:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1D4B20040;
	Wed, 10 Jun 2026 14:28:39 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 13/15] nvme: add Clang context annotations in rdma.c
Date: Wed, 10 Jun 2026 19:57:33 +0530
Message-ID: <20260610142743.115898-14-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a29749e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=9sEHggDUngwRySfFrvUA:9
X-Proofpoint-ORIG-GUID: pgAiD_pBEtaMvDUGyFRmtlKHDgChHzz6
X-Proofpoint-GUID: kb0CATwgVO9g-lWtLZV9drlEl8iVBpYP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX1MlIpXvXQWsa
 FsttPBvcORRWBEgUqJRd4IA8+b66iGF+TE67beAgdxIS+LWRiUhPxw5PQmOfP8FL75ymOYxFYWo
 hutLixUm4xcD3o2rVnql2/tpanJhH0EaRXSjhL6RFwF+1WgvqtnYSyjy6vG5aBU81dDLzZXhr4H
 SV2ErNV4Olcrx/qX7FvEmzY2q/9JTDIS1+NRP34TMwtAw1BRU7xsdeXO7bH53tNboD6KnJFvm8m
 cGGrhMJHUszBWxzNntiMOItXp+Y/LdOmZ0Efx3dGwHz4ai8xGcJWmhO97K5BuXpkRTmsg2VSFdo
 S2ZIhwUTfBty+F/EUD6bMG+TKsImP78taSGmhhPcFUHBqHCM8rt4dTr9JAj6oEPIdsHaLFEQvSP
 zr7QELUQr0aT2LUxd9fpgfTBiU8J5CCzuRGPC7C9SX5L14DGB7Hz4EHJyVrfi3Zl0VSRI8R5+v7
 DMqOJ5UHItBkAhacaBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072854_051866_C52EC85B 
X-CRM114-Status: GOOD (  19.99  )
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

The device_list and nvme_rdma_device::entry are protected by
device_list_mutex. Annotate both with __guarded_by() so that Clang's
context analysis can validate accesses against the corresponding
locking requirements.

Similarly, nvme_rdma_ctrl_list and nvme_rdma_ctrl::list are protected
by nvme_rdma_ctrl_mutex. Annotate them with
__guarded_by(&nvme_rdma_ctrl_mutex).

It is safe to initialize nvme_rdma_ctrl::list while allocating the
controller object because the list entry has not yet been added to
nvme_rdma_ctrl_list. Annotate the initialization with
context_unsafe() to suppress the corresponding Clang warning.

After adding the above annotations, Clang reports the following
warning:

drivers/nvme/host/rdma.c:972:24: warning: passing pointer to variable 'list' requires holding mutex 'nvme_rdma_ctrl_mutex'
      [-Wthread-safety-pointer]
  972 |         if (list_empty(&ctrl->list))
      |                               ^

Fix the warning by performing the list_empty() check while holding
nvme_rdma_ctrl_mutex.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/rdma.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f77c960f7632..a50efe3709d8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -39,11 +39,17 @@
 #define NVME_RDMA_METADATA_SGL_SIZE \
 	(sizeof(struct scatterlist) * NVME_INLINE_METADATA_SG_CNT)
 
+static DEFINE_MUTEX(device_list_mutex);
+static __guarded_by(&device_list_mutex) LIST_HEAD(device_list);
+
+static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
+static __guarded_by(&nvme_rdma_ctrl_mutex) LIST_HEAD(nvme_rdma_ctrl_list);
+
 struct nvme_rdma_device {
 	struct ib_device	*dev;
 	struct ib_pd		*pd;
 	struct kref		ref;
-	struct list_head	entry;
+	struct list_head	entry __guarded_by(&device_list_mutex);
 	unsigned int		num_inline_segments;
 };
 
@@ -112,7 +118,7 @@ struct nvme_rdma_ctrl {
 
 	struct delayed_work	reconnect_work;
 
-	struct list_head	list;
+	struct list_head	list __guarded_by(&nvme_rdma_ctrl_mutex);
 
 	struct blk_mq_tag_set	admin_tag_set;
 	struct nvme_rdma_device	*device;
@@ -132,12 +138,6 @@ static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_rdma_ctrl, ctrl);
 }
 
-static LIST_HEAD(device_list);
-static DEFINE_MUTEX(device_list_mutex);
-
-static LIST_HEAD(nvme_rdma_ctrl_list);
-static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
-
 /*
  * Disabling this option makes small I/O goes faster, but is fundamentally
  * unsafe.  With it turned off we will have to register a global rkey that
@@ -969,10 +969,12 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	if (list_empty(&ctrl->list))
-		goto free_ctrl;
 
 	mutex_lock(&nvme_rdma_ctrl_mutex);
+	if (list_empty(&ctrl->list)) {
+		mutex_unlock(&nvme_rdma_ctrl_mutex);
+		goto free_ctrl;
+	}
 	list_del(&ctrl->list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
@@ -2252,7 +2254,10 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
-	INIT_LIST_HEAD(&ctrl->list);
+	/*
+	 * Safe to init list while allocating ctrl object.
+	 */
+	context_unsafe(INIT_LIST_HEAD(&ctrl->list));
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
-- 
2.53.0


