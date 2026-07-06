Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA98AC43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tIFuTjcodOdaGUZwRxQfu/qh40lkRl9pjkyyGWTjXWo=; b=MTSb0MR2QzALFOzE9MK1RM9m1+
	r+NIreTOyfaotD7j8DNynzGizxz16mCEfi8EUd+5d+axpuqWNiW5uE0bXzr3FvXbLfSdAM6PHL/P1
	Crhuao5gAUxPIIHVKMpt2fWON6/vZQmQj/ZNLXgWwd04ceecLcjtsXHI79y/zZ6xPXMujj8oIv8jR
	eOXYhK6cAtTal5pO3XyJR/KRViY00gAhtHfZTh5gb30B8yyh2bKcwO+y6MT8AoQ+liopNsqUk0CpM
	PAwZCS1i2dFL2DEpfWYSJcDA3G4Zk78Vb+6cQq1S3FBccDAxMJsbp+VpPrOUEzaJSJpaWBdCFCslp
	TD2AOLcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7M-0000000CiAG-1yKo;
	Mon, 06 Jul 2026 14:16:16 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7J-0000000Ci6u-31JT
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:15 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BISK53447706;
	Mon, 6 Jul 2026 14:16:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=tIFuTjcodOdaGUZwR
	xQfu/qh40lkRl9pjkyyGWTjXWo=; b=o8e/8u6WAgJCHzoZW/c6omdez3gFZcJwZ
	Rl1AwM0AnWh1+tlBAkjrSp2aTDT9Wr8b0LeB9boZ43zIMNtzHcm9aqGQqtd3uofL
	vogiEkQn5WtCFHP0cAFkINZ59MzDD0qSqCJe1UnUTyI+v5hUF2rLuIysm9UnNUtN
	b1YKqvEB5SMk/V4t4+UfQMQr6Gv7tvNjnRgp1zDolSj3L3gqGqm2A9CPey0uSpSI
	MEeUUCrEKigXPDXZM0A/NwjKWTtcN7prkJA/CaeKudHGCFXYK4GwnAsVLKq4x9N6
	Acmk7EPIAQQv7vjjX8DegwPqIwN4iYYV/xQrw92aadU8I7W2HZcGQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6stsjass-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4s4H022988;
	Mon, 6 Jul 2026 14:16:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgjwx13-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EG0wk51184048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:16:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD4F120043;
	Mon,  6 Jul 2026 14:16:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDEBC20040;
	Mon,  6 Jul 2026 14:15:58 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:58 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 10/18] nvme: add context annotations for nvme_subsystems_lock
Date: Mon,  6 Jul 2026 19:44:12 +0530
Message-ID: <20260706141452.3008233-11-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Gdu2Z5C-K4AX0e4pLeVQOfaovlV5JJzw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX4gKdTmzmXGbJ
 Dcss89QPdoEk3JcCLAkCI0Z34Egpi7URg1gc0JVTQFAMxKwTYdjAiRP3X4xy7B6sPVlBpUriBQ9
 /L/xmb6eL9SMbX3Vg7PMWH4GUPmOhRs=
X-Authority-Analysis: v=2.4 cv=DKW/JSNb c=1 sm=1 tr=0 ts=6a4bb8a5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=11_6QMH_4uKYRTHt6XgA:9
X-Proofpoint-GUID: j0KbEAn89fevcNjRRTPHOKrV9lE7jUT4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXxlacoYjlp74W
 0RxustpXfvH4CyZ75YsrMsQZ2MLHkX/TharTPpFlEcYimq3TA5saFdQPfRpliNoM2MHt615/khR
 IqvO08rEkQ8qZun+IFhUH21SWEMjWrfuuHZKkql4B9J9T70CfxuEd0xjFTFrG1J+qjz4ctzqM41
 UBO0iq7KGlrZUhje+jFgVZYmPAorDOIGuKOgNK/dngFPjO3InfwEeH41TW9+6l02+C6gUopC5z1
 tWEzwY4ImknJu08KQFWgbgdZpvG4XjHrfexuyFHqIi7aOgWr68w1c8U4TNoMy3YHlnEJfFpYqBn
 8iYh5PLoMx3huKpgon36VxVliRsfUUev3R05d/8rNhIK/+RiQt/BfCYsEUXDdpmLldOsu9uvhCB
 +XzRCt8yEriGptkOQgMkPu/c2p76KNHkeVnnvnCDyyrOIaZTFfeN6MHTORlIzkVCN4B5xBqDNE2
 iInaJYDHbyGPVNrlr7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071613_880544_DA50AF4F 
X-CRM114-Status: GOOD (  16.34  )
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

The initialization of nvme_subsystem::ctrls in nvme_init_subsystem()
occurs before the subsystem is published and therefore does not require
protection by nvme_subsystems_lock. Annotate the initialization with
context_unsafe() to suppress the corresponding context analysis
warning.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c | 12 ++++++++----
 drivers/nvme/host/nvme.h |  9 ++++++---
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9cdde56c97bc..01346c46bfde 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -126,8 +126,8 @@ EXPORT_SYMBOL_GPL(nvme_reset_wq);
 struct workqueue_struct *nvme_delete_wq;
 EXPORT_SYMBOL_GPL(nvme_delete_wq);
 
-static LIST_HEAD(nvme_subsystems);
 DEFINE_MUTEX(nvme_subsystems_lock);
+static LIST_HEAD_GUARDED(nvme_subsystems, nvme_subsystems_lock);
 
 static DEFINE_IDA(nvme_instance_ida);
 static dev_t nvme_ctrl_base_chr_devt;
@@ -3200,6 +3200,7 @@ static void nvme_put_subsystem(struct nvme_subsystem *subsys)
 }
 
 static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
+	__must_hold(&nvme_subsystems_lock)
 {
 	struct nvme_subsystem *subsys;
 
@@ -3244,6 +3245,7 @@ static inline bool nvme_is_io_ctrl(struct nvme_ctrl *ctrl)
 
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+	__must_hold(&nvme_subsystems_lock)
 {
 	struct nvme_ctrl *tmp;
 
@@ -3285,9 +3287,11 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	subsys->instance = -1;
 	mutex_init(&subsys->lock);
 	kref_init(&subsys->ref);
-	INIT_LIST_HEAD(&subsys->ctrls);
-	/* Initialize unpublished lock-guarded variable. */
-	context_unsafe(INIT_LIST_HEAD(&subsys->nsheads));
+	/* Initialize unpublished lock-guarded variables. */
+	context_unsafe(
+		INIT_LIST_HEAD(&subsys->ctrls);
+		INIT_LIST_HEAD(&subsys->nsheads);
+	);
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 602d567f3def..607fa9664272 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -361,7 +361,8 @@ struct nvme_ctrl {
 	wait_queue_head_t state_wq;
 
 	struct nvme_subsystem *subsys;
-	struct list_head subsys_entry;
+	struct list_head subsys_entry
+		__guarded_by(&nvme_subsystems_lock);
 
 	struct opal_dev *opal_dev;
 
@@ -493,9 +494,11 @@ struct nvme_subsystem {
 	 * a separate refcount.
 	 */
 	struct kref		ref;
-	struct list_head	entry;
+	struct list_head	entry
+		__guarded_by(&nvme_subsystems_lock);
 	struct mutex		lock;
-	struct list_head	ctrls;
+	struct list_head	ctrls
+		__guarded_by(&nvme_subsystems_lock);
 	struct list_head	nsheads
 		__guarded_by(&lock);
 	char			subnqn[NVMF_NQN_SIZE];
-- 
2.53.0


