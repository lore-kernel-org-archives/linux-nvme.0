Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F20BCD98DC
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uKMXemyXlrPeSRLTfDQqO5JMnL4MYblBHm2RBDITd+A=; b=a5qydwjpVBv54C08WXrPIbFI3I
	/P0DABWXEsAeqJIxq3WOGIEccvPi1Fmj+3jHarZiDjBPPANus0+muDgETFBrLUrPBxD6gjQepSyMX
	acZ55nFnKgBVsDVeGc4Mu+Q/oz4Vj2M1QSQ3nkOZ94+fBabMyRKNxysi+SkHlWzMeSoLRNGlVL9J/
	CGg0WNuKO/ciClyZtCGvH4OS6HFx6yMjMo6EudcA8zbX2yWjSicb7dZzhLGtk5DoTiBipM5E0glkl
	133xK3XVhLvLp/UeiB688zLpllGps8IQURP/uSkK3Z2n3NDHB8V6puY9prpODzRI5rPasJGCevcal
	tqWcN+9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhP-0000000D0o0-1Edd;
	Sun, 14 Jun 2026 13:16:27 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhM-0000000D0mo-44gM
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:26 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmTh43521865;
	Sun, 14 Jun 2026 13:16:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uKMXemyXlrPeSRLTf
	DQqO5JMnL4MYblBHm2RBDITd+A=; b=PCs+bgD5QvcGN9L4Q2lhiaSxSYmZNZd7q
	lIy7f/nJQEtfIIelQUuifIzNR24HzktXD3bs9TbbcElOhVGtucRkZs6kDnXUIqe2
	yDKjP4ZQWvEExzwWGnzOvY1KuLWO2MmaCWWtXcTFf36JXPqbfHeevW23CTOqQjmk
	lFNHmkPQWrz0yYrakFI7v0f/eY0EJxfkiRHjPU7KSQxKwCfAjufWz4mlQNOoRnHL
	Ls9yVCSplwyf6dJKi2VSeoPzBoTHfx7tzTN1tlMIbF+hA7eq6PxJGQsyHPqtdiMQ
	YPym/fx3nWdgkoSHqgUbTXqrRHhdfJCIOczCiqifBNb2vSejAWHOA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1u0b9ut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:16 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4eiq003170;
	Sun, 14 Jun 2026 13:16:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esk1gsk6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGCGA49611076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4286E20043;
	Sun, 14 Jun 2026 13:16:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AE4620040;
	Sun, 14 Jun 2026 13:16:09 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:09 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 07/17] nvme: add Clang context annotations for nvme_subsystem::lock
Date: Sun, 14 Jun 2026 18:45:22 +0530
Message-ID: <20260614131541.2017845-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 9HgWC8Hy5YI3wCc52a8EIP2O5vMpLlzs
X-Authority-Analysis: v=2.4 cv=XdK5Co55 c=1 sm=1 tr=0 ts=6a2ea9a1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Ww_8d8in9Fx9J81-FmEA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX8/2CUTFhOmD9
 Nw8jubFautCCIo2QNcULgQEJ5GX6Pfa4u+SNeyH8fkpmcaINWVy4aPztxvLVP4PSIBvbB+Y92qD
 QJaKiun/9WQEbDIr6ObtrB8SvL6cUjZmHcoVXXfh6bYW/RpJCfBoj56tc2fBnv5qCwy424/qCGv
 rHVgmInERuUyIV5TN3RotdOWZ24aoXlS5Ha23fYe7q47egHMNSyrvqnh0HaFDG//btwAz1L0SCG
 ZPHlTpH0Hp/3ZofOfX5qT2Mj69hNdyDhWYZfpW9RZNeTG2XKvRfPDtsDkkOFaXXvvFcrVKNNNck
 Al53Noebw8guQnvULGy6/LbemfY70fUVkBQav3gyCS4BBIFVHlTJMNF2Jc9W57d5StbnwYaQbHg
 VOUNHicp66NFgC4ZwzdWQ4IKVgCDRWZmyA9RCJdjadSEJCREP31RuPU+upNE5nqPXpJf7/1I3SC
 TszKZzACzN/8yX7vNIw==
X-Proofpoint-ORIG-GUID: ubZ0vlZB17av_EmKFzaa08hUFrxWdIF6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX2yuHrL479t1C
 KCWifykfVtA21WQd16nCg85SDf3xngFEcnwXXmbhJWT24XOp3bQtzhGIqBykGtzdHqCSJ3ZW2EM
 2y0HplZPhhttapKh6MvbCjNYTqlfE88=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061625_128694_7466EA73 
X-CRM114-Status: GOOD (  18.61  )
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
nvme_mpath_start_freeze(), nvme_find_ns_head(), nvme_alloc_ns_head()
and nvme_subsys_check_duplicate_ids() with __must_hold(&subsys->lock)
so that Clang's lock context analysis can validate the locking
requirements at compile time.

Also annotate nvme_subsystem::nsheads and
nvme_ns_head::delayed_removal_secs with __guarded_by(&subsys->lock),
as both are protected by the subsystem lock.

Replace mutex_init(&subsys->lock) with scoped_guard(mutex_init,
&subsys->lock) so that Clang's context analysis can observe the
synthetic acquisition and release of subsys->lock during initialization
of the guarded nvme_subsystem::nsheads list in nvme_init_subsystem().

The initialization of delayed_removal_secs in nvme_mpath_alloc_disk()
occurs before the namespace head is published and therefore does not
require synchronization. So annotate the delayed_removal_secs
initialization with context_unsafe() to suppress the corresponding
context analysis warning.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  7 +++++--
 drivers/nvme/host/multipath.c |  9 ++++++++-
 drivers/nvme/host/nvme.h      | 13 ++++++++-----
 3 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6153c3e0007..341753a4be85 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3247,10 +3247,10 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		return -ENOMEM;
 
 	subsys->instance = -1;
-	mutex_init(&subsys->lock);
+	scoped_guard(mutex_init, &subsys->lock)
+		INIT_LIST_HEAD(&subsys->nsheads);
 	kref_init(&subsys->ref);
 	INIT_LIST_HEAD(&subsys->ctrls);
-	INIT_LIST_HEAD(&subsys->nsheads);
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
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
@@ -3922,6 +3924,7 @@ static int nvme_add_ns_cdev(struct nvme_ns *ns)
 
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		struct nvme_ns_info *info)
+	__must_hold(&ctrl->subsys->lock)
 {
 	struct nvme_ns_head *head;
 	size_t size = sizeof(*head);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 94607c5d1a2b..e816d88ffeee 100644
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


