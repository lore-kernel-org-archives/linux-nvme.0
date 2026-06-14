Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83AC9CD98DA
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=R1AHzkDFF8Y8P/hX6sp5cbMFGMW9LA9KyVhFOizkJ5g=; b=uQEbn6MFGf3tMsupLMyEzAikFH
	pGHkYYOcNy6ORtxfNbFL2ZKVxUAbNiqy+brAvRi1lY+CqzQq1vWNiGBOYpE6hPBsZx2+zSKEIQb2c
	ORwR17UGCvc1GHk4dIaPBYnbicNoY99o/GKuX5StT/pubR1SY4W+KtxcRWZqC5hNNYCe2cbZoy+gt
	0EQQ6rE+9BPodE2guO4H1AYn4IW4q77gmOU4jbIQTf5mxHwDc+3qF/3e2Q8HA6BbqYWnkdZNOgdWV
	XxlT/J9jC5SHJ2VZH4L56JorcS+MoJTu8zPqOP7fIcm1t/21YAwCGpS4XurbrV79tdiuUKA8UqhdG
	f3IZXsRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhW-0000000D0tV-0Mm2;
	Sun, 14 Jun 2026 13:16:34 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhS-0000000D0q6-3fWh
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:32 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmffo3504404;
	Sun, 14 Jun 2026 13:16:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=R1AHzkDFF8Y8P/hX6
	sp5cbMFGMW9LA9KyVhFOizkJ5g=; b=M4OH11Y3JMaBjdfHuNJob8qMYdEdw6K57
	JAgSfF/uF8DeAy70UyzBRTJZI8hUQg39Vec/vQr3n5cah5WL2nVOL1oZ6uO7+KcE
	Xs6qpkD8ESmP9gHT6hvNn6zJmixJOXlD2WQha+iuvUb7ap2cJgZ075Vdu5ZLznEN
	jMIbDCbTecwSY4w0p9eQAxiPt6YIsqyXy6E+L1l4E7hCyRWJ/L2/2ZyzxJahhF16
	+A52qp83vC/jY2ptrVjs7xxduKlzLQUjyPHJ/6AgQSxKzhAWnUT1ms+nfEzealkq
	xZMGUKwQi5c9PHsT2q1o7s8OrkBMPPJnFxYNtBKgfGG+5Uqgln/KA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v239vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:23 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4d3I013224;
	Sun, 14 Jun 2026 13:16:22 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhjsn08-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGICT50856350
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 731CD20043;
	Sun, 14 Jun 2026 13:16:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B278920040;
	Sun, 14 Jun 2026 13:16:15 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 09/17] nvme: add Clang context annotations for nvme_subsystems_lock
Date: Sun, 14 Jun 2026 18:45:24 +0530
Message-ID: <20260614131541.2017845-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX7NqglASxShpI
 WEtyWLupFP6/9FAP8EHALawjJM8HRiR/vOumhd0UyMz9Fp8vjwZG5/HpcC4qOqx969kvDtGMU+5
 r3h0eQiKDYWdJN4Hf5Cfj5GCSOl8Zp0=
X-Proofpoint-GUID: LwaMT5VgeffYjVWN45Y_9hDdha5BP6LN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX5Ooh8O/Z2wh9
 ge5Zw1avOz1/kY3bq6THCsDBKmWkztHJFoj+rlORtnaKmJJiVOwnWwnVE3xJ5ZDRH02oMgKa1Ou
 ZeeIjEbRO4/JzbyB8HZG/Bbu9C0Hl6JVZsFOWLz1KPlqYXyjN9OFnIkTzmYw5JOwDqW9othdNIE
 XVoUNzgVLUnOiRStGbRBQPoA0gdu0JWXe3Waj1l3vD7kR5m4DdmjvGFgXIM6BM7Ao/dUdzpFFmy
 arVBMrDrxY29nkmIXjCdtRw4Eyvc3oVsUNFQTQOFusr5UGTqrT7ZDqgR8xL2Gg611MAmqv8OpuX
 6wP3UgHYJwwM2y9dvzKHEM1vcx5lA+YJE21bA78X21rQNCcdY0Y+xC4m0vmmi9yxJBJ16k6meJx
 FjJCySkffxtwobCIdw3WgfsZlqO8EgDgIsZKQE7eW0+4/zQ6jjxgr+/4EinMCNFphYzenWyXx3L
 g3bdzZdKFa5nVsDDMuA==
X-Proofpoint-ORIG-GUID: aRb5DBNyMEzQZ2ahEpXvTB81UMWJt1cd
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a2ea9a7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=11_6QMH_4uKYRTHt6XgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061631_035074_2F1D92CF 
X-CRM114-Status: GOOD (  14.94  )
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

The global nvme_subsystems list, nvme_subsystem::entry,
nvme_subsystem::ctrls, and nvme_ctrl::subsys_entry are protected by
nvme_subsystems_lock. Annotate these objects with
__guarded_by(&nvme_subsystems_lock) so that Clang's context analysis
can validate accesses to them.

__nvme_find_get_subsystem() and nvme_validate_cntlid() traverse the
global subsystem list and subsystem controller list and therefore
require callers to hold nvme_subsystems_lock. Annotate both helpers
with __must_hold(&nvme_subsystems_lock).

The initialization of subsys->ctrls in nvme_init_subsystem() occurs
before the subsystem is published and therefore does not require
protection by nvme_subsystems_lock. Annotate the initialization with
context_unsafe() to suppress the corresponding context analysis
warning.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 11 +++++++++--
 drivers/nvme/host/nvme.h |  6 +++---
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 341753a4be85..89abf94639ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -126,7 +126,7 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static LIST_HEAD(nvme_subsystems);
+static __guarded_by(&nvme_subsystems_lock) LIST_HEAD(nvme_subsystems);
 DEFINE_MUTEX(nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
@@ -3164,6 +3164,7 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys)
 }
 
 static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
+	__must_hold(&nvme_subsystems_lock)
 {
 	struct nvme_subsystem *subsys;
 
@@ -3208,6 +3209,7 @@ static inline bool nvme_is_io_ctrl(struct nvme_ctrl *ctrl)
 
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+	__must_hold(&nvme_subsystems_lock)
 {
 	struct nvme_ctrl *tmp;
 
@@ -3250,7 +3252,12 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	scoped_guard(mutex_init, &subsys->lock)
 		INIT_LIST_HEAD(&subsys->nsheads);
 	kref_init(&subsys->ref);
-	INIT_LIST_HEAD(&subsys->ctrls);
+	/*
+	 * Initializing subsys->ctrls list doesn't need to be protected
+	 * using @nvme_subsystems_lock. So suppress the Clang's warning
+	 * declaring context_unsafe.
+	 */
+	context_unsafe(INIT_LIST_HEAD(&subsys->ctrls));
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index be1467bfae28..837e279bdf01 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -361,7 +361,7 @@ struct nvme_ctrl {
 	wait_queue_head_t state_wq;
 
 	struct nvme_subsystem *subsys;
-	struct list_head subsys_entry;
+	struct list_head subsys_entry __guarded_by(&nvme_subsystems_lock);
 
 	struct opal_dev *opal_dev;
 
@@ -487,9 +487,9 @@ struct nvme_subsystem {
 	 * a separate refcount.
 	 */
 	struct kref		ref;
-	struct list_head	entry;
+	struct list_head	entry __guarded_by(&nvme_subsystems_lock);
 	struct mutex		lock;
-	struct list_head	ctrls;
+	struct list_head	ctrls __guarded_by(&nvme_subsystems_lock);
 	struct list_head	nsheads __guarded_by(&lock);
 	char			subnqn[NVMF_NQN_SIZE];
 	char			serial[20];
-- 
2.53.0


