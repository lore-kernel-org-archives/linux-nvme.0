Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26F89CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xoLeEAPU+rYiwwwk1PCEwb3LJNiPJlqEEN3eaQEyN38=; b=cYlux/G3fmFBSsjlyk62cKRzct
	fWyBJAkShT/UzT2NgNVFIbGlT7Y1Sy7jn8kbvT4DiPmWvMzycxCRAjFZcQT6zNv4OgQ+U+CB3979W
	DEZgfixrBqeRoTngD1U3y1vaS1XHDB8fySkUD0qSgl620wBQx+P5SWq3v4POGLZRhjHtSFOEtTx7O
	g2x6/zFtGRmq7IaLFmI4xk6x6tbfBI5KVXDeH2z96z7Msig21HS0/IurnfW9UBwEJ+9dBvyMEgKtk
	2/eGK56TjXm0vlLBcOspMtdesfyHtHq4G4Z46hHCZPXrkDuNMGyFxehUZLINVggh6dEPHc/h1L3qS
	xkSYmqhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvC-00000007snt-30fx;
	Wed, 10 Jun 2026 14:28:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJv9-00000007siC-2QYn
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:44 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A3jqAf2494942;
	Wed, 10 Jun 2026 14:28:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xoLeEAPU+rYiwwwk1
	PCEwb3LJNiPJlqEEN3eaQEyN38=; b=M+NJxGh2jtW5HTohcqVo4YsSQsNHvoGtQ
	IMnTu2BMZRlJcERNd8gFPohITRo7dZUDOEBBqcBhIcWiOg2L1/qeH67ElgTSRMDO
	FiMxOZDh7J4boDbVYFXMG788BMKfZDfCl2TZXtRydgW74+AYxwR7H94ls2+2YMgd
	TU7rM6alt+vWJ7V15ByVJ2VHko1O1vbrUSX4BvjI0rw5qMLxqbBQhWwUR9sbKQRy
	a5wUp4CyS8MgdX/H1XpC28Ae2AgzYO9Ov+MSZsolSrjI3OFZmYWm8gHK100FWqK5
	OODk+HfCycmfiVp70a7K/I41IP/bJyLnTq0/0EKK+kWT7Ked/RW7A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6t12cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEJvqv011389;
	Wed, 10 Jun 2026 14:28:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4en0jyerwm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESVPc49152294
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5ED0320049;
	Wed, 10 Jun 2026 14:28:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 229B020040;
	Wed, 10 Jun 2026 14:28:29 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:28 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 09/15] nvme: add Clang context annotations for nvme_subsystems_lock
Date: Wed, 10 Jun 2026 19:57:29 +0530
Message-ID: <20260610142743.115898-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: V5S1f9j8jU8c7K1OHQAm8RcERm2L05Va
X-Proofpoint-GUID: xuKOXY1GdmM1ueJCZJgvE7LnameUPGSo
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a297494 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=11_6QMH_4uKYRTHt6XgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfXxoEZA0Q5ncuY
 yPcesLceLnfrqXyr2LAI8Zx5suxkahRg9njAJNp7wJIRi84F3rYMXo9RTztWxUN6uDnPpMeBGlM
 wuuk1FXQrX0Vuu/Ihwn3Wl+Tp8MUeY8MziXwQxLJJy/0ugljD9MW8Qr7xbR0CP0Ntc+QjtIa376
 5fgmFzSPMGHn3VLJB4OblxnFMqCPUDoJt2gFT6xn/Y7B4GDsmWJFoMJlpWniVlr64/hyuwDU0BQ
 QQyUJAmVv2c8d2WmoCftvDFCLWO8fHeE6N/GESBvL3xTO38UqSMtelmKC3jnJSTVLb3LLpzBUcz
 QxxIYbafkNonBZ5kRyXL7mrFY7JqjD2UbCTJQQxpSbOXmfDW8IYoEtyynKobWrumwUzAJRmyJqG
 H9Vd2faDxmIKkF4fFsJ5dKdDwcA3eeKaRt3+1b1D3TxTFtytGuqsd1Kx2oth8jdh6xzI5aZY2bw
 /epoh9E8KZyn3oWRHaA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072843_753521_5C409F06 
X-CRM114-Status: GOOD (  16.09  )
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
index a18c4abf7b38..409aff13c69d 100644
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
 
@@ -3249,7 +3251,12 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys->instance = -1;
 	guard(mutex_init)(&subsys->lock);
 	kref_init(&subsys->ref);
-	INIT_LIST_HEAD(&subsys->ctrls);
+	/*
+	 * Initializing subsys->ctrls list doesn't need to be protected
+	 * using @nvme_subsystems_lock. So suppress the Clang's warning
+	 * declaring context_unsafe.
+	 */
+	context_unsafe(INIT_LIST_HEAD(&subsys->ctrls));
 	INIT_LIST_HEAD(&subsys->nsheads);
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
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


