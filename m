Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75494CD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o8iCFW0E8VrfrKnzBxzFu3BM2Tbz6hmQWT0X6cfUVl0=; b=q7cFkMDMwsRoElfEcwlaMd3Vzq
	J6sKhcxmVFHhrgOvx5XNBjzEODEKMi3ITQRzHDWkKiG06LVsVDbksfYHqna6YQ8jPh0adlRVtLNtB
	IBDMZqp5I0Jq7tRae2rGXT+lpHAp1SJFj23vx5OCeQGIPs7CxPozdRMS19Pw19IMtUI/ZByToLq/i
	KmqLS8SPpP7AlJFgpB7R1HJoof2vi+nZu8H7Uh9/ynXCGmdwm3dQBGUzYcDpEitztpk/jXq0ktUMn
	WXE9T0YzfQe+WbckWEw67S5zRRWs3TJdlvOur6Me7WchUz6qH5RNXBQmQOeQcMTciBJwMmfJ7VJNl
	MNvOdXgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJv8-00000007sgM-03Vt;
	Wed, 10 Jun 2026 14:28:42 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJv5-00000007sdH-2uRf
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:40 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A91mvu3910616;
	Wed, 10 Jun 2026 14:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=o8iCFW0E8VrfrKnzB
	xzFu3BM2Tbz6hmQWT0X6cfUVl0=; b=ajP+EJ56z/ATbuo+58PPoPgQIlCxTKziu
	VVNGfkW+z2Tu8vSd6sg4NXzv0RbDdXc/g7jibQyM01vFUxyFndWg8Qq029/8h7UM
	o4trlCL4plAJTXrMOXr47zTzroUSnJwQ0FypM2KU4RhD9tbx2qc/GG98UI5Gj17Q
	+Ydc96ArLu9EF0e0i2bU/jrn7AhlxcBGxBTzvRnZ92hGFJox1sEmuyQSN6F+pJvG
	35LHzpH/M9AQjY2nvdFSDg7aJ7iih6RjrzuAaJ+IExXOMfh9cPVdopQCQA0N9XR3
	x6msoKoOiY+m/R5X5nwW41eEjXBnA3fdptU/cV5FCloC3jvafBWCg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6t12bx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AE4loG009730;
	Wed, 10 Jun 2026 14:28:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w74ep-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESQHR50135422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C09F20049;
	Wed, 10 Jun 2026 14:28:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F29BD20040;
	Wed, 10 Jun 2026 14:28:23 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:23 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 07/15] nvme: add Clang context annotations for nvme_subsystem::lock
Date: Wed, 10 Jun 2026 19:57:27 +0530
Message-ID: <20260610142743.115898-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: hKeprMFWLrtJ0-4zvApgo4bJJhYJWii8
X-Proofpoint-GUID: W4xVdOHeh2mc_IWpug3PBYyOUdiVE3fM
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a29748f cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Ww_8d8in9Fx9J81-FmEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX0ZA9KRV8FMrx
 rfySluMES9VXqVb2/T8aA5iYMDHP+KY8GddSy4FAPQa+y4P7XVRWRv2MxkmP4Al/OnOgHfa+CY3
 MmdSfGIicHKD5BZgVXtc4xA4yh5TpIDb9s7bMxtHnkM7d6ahlENxIdP5x2Mr9iGYUyTWJHmRe5+
 YHSyqy0+dbJkievqVkdyAVJtAGc4ThKVCt6C9udtmwA1agYPOKFN0Qc9RMjivFf8JgbPuZBwp9v
 U3ZMNTG1ZKlzw1gUfg82Z/uPZ94yG/0CAP2DAd4tE9fe2oqedyXF/+opkmamBqc1c77W20o4ccl
 7AJuvxfsxgdBSNPm6O6E45+J0XF8NwXV+r6PlpTl7wY5VvblVJugI7Nd66IRomrbtbEEulspZ4D
 bbHreV0/vyDKugxTw93cd1SwT/zJ2cRUaBw+s783UP14ZAHP9ODb3qCAOirVXcxrBJ5cDLOY2zu
 ApoH38AmxTfwFGxirTQ==
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
X-CRM114-CacheID: sfid-20260610_072839_914689_122A994A 
X-CRM114-Status: GOOD (  19.31  )
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

Several helpers access or traverse data structures protected by
nvme_subsystem::lock and therefore require callers to hold the lock.
Annotate nvme_mpath_unfreeze(), nvme_mpath_wait_freeze(),
nvme_mpath_start_freeze(), nvme_find_ns_head(), and
nvme_subsys_check_duplicate_ids() with __must_hold(&subsys->lock) so
that Clang's lock context analysis can validate the locking requirements
at compile time.

Also annotate nvme_subsystem::nsheads and
nvme_ns_head::delayed_removal_secs with __guarded_by(&subsys->lock),
as both are protected by the subsystem lock.

Replace mutex_init(&subsys->lock) with guard(mutex_init)() so that
Clang's context analysis can observe the synthetic acquisition and
release of subsys->lock during initialization of the guarded
nvme_subsystem::nsheads list in nvme_init_subsystem().

The initialization of delayed_removal_secs in nvme_mpath_alloc_disk()
occurs before the namespace head is published and therefore does not
require synchronization. So annotate the delayed_removal_secs
initialization with context_unsafe() to suppress the corresponding
context analysis warning.

While we add above annotation, one notable finding was:

drivers/nvme/host/core.c:3967:45: warning: passing pointer to variable 'nsheads' requires holding mutex '&nvme_subsystem::lock' [-Wthread-safety-pointer]
 3967 |         list_add_tail(&head->entry, &ctrl->subsys->nsheads);
      |                                                    ^

So fixed it by acquiring nvme_subsystem::lock while updating
ctrl->subsys->nsheads.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  6 +++++-
 drivers/nvme/host/multipath.c |  9 ++++++++-
 drivers/nvme/host/nvme.h      | 13 ++++++++-----
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6153c3e0007..a18c4abf7b38 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3247,7 +3247,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		return -ENOMEM;
 
 	subsys->instance = -1;
-	mutex_init(&subsys->lock);
+	guard(mutex_init)(&subsys->lock);
 	kref_init(&subsys->ref);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->nsheads);
@@ -3809,6 +3809,7 @@ static const struct file_operations nvme_dev_fops = {
 
 static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		unsigned nsid)
+	__must_hold(&ctrl->subsys->lock)
 {
 	struct nvme_ns_head *h;
 
@@ -3831,6 +3832,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 
 static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 		struct nvme_ns_ids *ids)
+	__must_hold(&subsys->lock)
 {
 	bool has_uuid = !uuid_is_null(&ids->uuid);
 	bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
@@ -3962,7 +3964,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	if (ret)
 		goto out_cleanup_srcu;
 
+	mutex_lock(&ctrl->subsys->lock);
 	list_add_tail(&head->entry, &ctrl->subsys->nsheads);
+	mutex_unlock(&ctrl->subsys->lock);
 
 	kref_get(&ctrl->subsys->ref);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index ef072588eca0..29e7e5178a5a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -719,7 +719,14 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
-	head->delayed_removal_secs = 0;
+	/*
+	 * The namespace head is not yet visible to other threads, so
+	 * initializing delayed_removal_secs does not require holding
+	 * subsys->lock. So suppress Clang's context analyzer warning by
+	 * annotating initialization of delayed_removal_secs using
+	 * context_unsafe.
+	 */
+	context_unsafe(head->delayed_removal_secs = 0);
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 41f42f1aee09..be1467bfae28 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -490,7 +490,7 @@ struct nvme_subsystem {
 	struct list_head	entry;
 	struct mutex		lock;
 	struct list_head	ctrls;
-	struct list_head	nsheads;
+	struct list_head	nsheads __guarded_by(&lock);
 	char			subnqn[NVMF_NQN_SIZE];
 	char			serial[20];
 	char			model[40];
@@ -562,7 +562,7 @@ struct nvme_ns_head {
 	struct mutex		lock;
 	unsigned long		flags;
 	struct delayed_work	remove_work;
-	unsigned int		delayed_removal_secs;
+	unsigned int		delayed_removal_secs __guarded_by(&subsys->lock);
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu_guarded	*current_path[];
@@ -1025,9 +1025,12 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 	return ctrl->ana_log_buf != NULL;
 }
 
-void nvme_mpath_unfreeze(struct nvme_subsystem *subsys);
-void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
-void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
+void nvme_mpath_unfreeze(struct nvme_subsystem *subsys)
+	__must_hold(&subsys->lock);
+void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys)
+	__must_hold(&subsys->lock);
+void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
+	__must_hold(&subsys->lock);
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
-- 
2.53.0


