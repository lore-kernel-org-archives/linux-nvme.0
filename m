Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCC9C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P3hoXiGGCUoiX8OcA+1xk35mTDh672yoXIZHZeg05Yk=; b=sHPOhHXsDuoN/kHr3nGzXrGtmL
	gpp+tKW3doVzGRE+e4xqPCEivIasIae51/apORj9a7oo9+wllPczggz5ET74aYvG01IeNRKwJmm5C
	dvcTcvzParm1ka8gDfSBxjR8MeQP/xnakbi4qRmjkPFKbHnLXz7VViR/ehXVNpLyn2annssfTQJtN
	wpfAcgNEwHjydROsj6kUTOCwQ6/d4lGQL6fQn9HP5tuE0kv8lj4Fl1b72GMp465jR+p6gVlD3s7L+
	z7X6Upxh3nIE1fbBhHGCDdlwytOmgxVXaqAQmiQAQpIl+0vWWA2IXW3gSh1VBMknzBkRRK6X8ju7V
	3gL/LmZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7G-0000000Ci3e-08eO;
	Mon, 06 Jul 2026 14:16:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7D-0000000Ci0R-0WS5
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:08 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BILoE318976;
	Mon, 6 Jul 2026 14:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P3hoXiGGCUoiX8OcA
	+1xk35mTDh672yoXIZHZeg05Yk=; b=BhXa1dI51zxM0TGlxNPBVnytjRICNvx5T
	qFnzhzfL8l54Bk+BYv357DsciUOn59OQQZp8j18HPr0QPbZ3W8+QxRihPBnfd04G
	aTU1lbtWDyzsH+EfBYRj2HhhprV6mjZ91ST9YZftqQUPanAUVYoVKByTzElgVoCb
	8oRtLQ5e15MhIrfngzbYf+ynfwD5D4z6Yn5Mv0nBytaUec6QFV78n/6rP/QDf3MH
	EiC1YdxZ6lP4stoHm9/e/6h20xDCTw7FJSbkwUVsoWstH/12l6vadWUkC+1AfzBO
	6SplVOzN3pSDqrA+sHwTp22yxo53mMaARqsj3+J69rfJnWtoxIEyw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqhqtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4iQi019263;
	Mon, 6 Jul 2026 14:15:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpx441-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFrtm51183972
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:53 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FF8420043;
	Mon,  6 Jul 2026 14:15:53 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C557220040;
	Mon,  6 Jul 2026 14:15:50 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:50 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 07/18] nvme: add context annotations for nvme_subsystem::lock
Date: Mon,  6 Jul 2026 19:44:09 +0530
Message-ID: <20260706141452.3008233-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX4r5YJ5BYtGKE
 4hfrcHNQvuY3eOMERSgzer+ueuPUYxM5kNCgwF8mHHhwrwzXzt+Lb2STCTDOTq5Zq/LHDOuHi53
 Ff5VCoaEJSa769L3ua1hkRcC4NP87kY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX0+d9F/0n7RHU
 8VKgiXkmtIjtuEJDoPLGhK+cNFyUdFgjh29C8rg58D/UNO2/sxYfugPWC0IN4V1ZosQaM4wJFbx
 OCV4tjgZtzcgqGAhOtsQ7xBsCLkgtJQ6FFkEdpvyjytwkaHgVsg8mgnfGZKO0okILLLTIsZV/Fb
 rS5vLx0zpiLrrD7xtcbVpFzid3NzDAiK8Y7d7P+AM0ryBdNBMKqS0kuNGvEALkyLWSWc0EBM9+h
 dKtFYjqE0Hsh/aPo5Rf2hxztFXgJau9vhw9XT1b2A1AbsjMOT+S5/wDPluj7uvKvQSYyu9CYX3Z
 8dpMDAhARG85IQpnp0mX+ZcDipLfu0AQv26hSLNWDQsZ8nMbvp/Yo/eOmSVSp/FBwUTBrfWqAt3
 CXaKubb0ouT1GgjLtgxrm+XAkqB1Eb06XO22ajUKHKui9k0ahkc3FzJnHinOmHJKz+pCfWYNYRQ
 lgaHUyOfkKRNHMP7RQQ==
X-Proofpoint-GUID: rJPBPgiHqCOtbyr0VtjeYjcv3b5VloDr
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4bb89e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=LT0K5aJLPkdXjCKmK-sA:9
X-Proofpoint-ORIG-GUID: 7CY9c3Vk2CNzqojOwlPmb0CET3uzoEkk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071607_171594_4010B90B 
X-CRM114-Status: GOOD (  16.53  )
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

Wrap the initialization of nvme_subsystem::nsheads with
context_unsafe(...) to suppress the context analysis warning emitted
for INIT_LIST_HEAD() during object initialization.

nvme_ns_head is allocated with kzalloc(), so explicitly initializing
nvme_ns_head::delayed_removal_secs to 0 in nvme_mpath_alloc_disk() is
redundant. Remove the redundant initialization, which also avoids a
false positive from Clang's context analysis.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  6 +++++-
 drivers/nvme/host/multipath.c |  1 -
 drivers/nvme/host/nvme.h      | 15 ++++++++++-----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6a095e1e44e..9cdde56c97bc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3286,7 +3286,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	mutex_init(&subsys->lock);
 	kref_init(&subsys->ref);
 	INIT_LIST_HEAD(&subsys->ctrls);
-	INIT_LIST_HEAD(&subsys->nsheads);
+	/* Initialize unpublished lock-guarded variable. */
+	context_unsafe(INIT_LIST_HEAD(&subsys->nsheads));
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
@@ -3845,6 +3846,7 @@ static const struct file_operations nvme_dev_fops = {
 
 static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		unsigned nsid)
+	__must_hold(&ctrl->subsys->lock)
 {
 	struct nvme_ns_head *h;
 
@@ -3867,6 +3869,7 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 
 static int nvme_subsys_check_duplicate_ids(struct nvme_subsystem *subsys,
 		struct nvme_ns_ids *ids)
+	__must_hold(&subsys->lock)
 {
 	bool has_uuid = !uuid_is_null(&ids->uuid);
 	bool has_nguid = memchr_inv(ids->nguid, 0, sizeof(ids->nguid));
@@ -3968,6 +3971,7 @@ static void nvme_add_ns_cdev(struct nvme_ns *ns)
 
 static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		struct nvme_ns_info *info)
+	__must_hold(&ctrl->subsys->lock)
 {
 	struct nvme_ns_head *head;
 	size_t size = sizeof(*head);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 67fd0752e894..765c3fac2823 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -736,7 +736,6 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
-	head->delayed_removal_secs = 0;
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 610c685e2263..602d567f3def 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -496,7 +496,8 @@ struct nvme_subsystem {
 	struct list_head	entry;
 	struct mutex		lock;
 	struct list_head	ctrls;
-	struct list_head	nsheads;
+	struct list_head	nsheads
+		__guarded_by(&lock);
 	char			subnqn[NVMF_NQN_SIZE];
 	char			serial[20];
 	char			model[40];
@@ -569,7 +570,8 @@ struct nvme_ns_head {
 	struct mutex		lock;
 	unsigned long		flags;
 	struct delayed_work	remove_work;
-	unsigned int		delayed_removal_secs;
+	unsigned int		delayed_removal_secs
+		__guarded_by(&subsys->lock);
 	atomic_long_t		io_requeue_no_usable_path_count;
 	atomic_long_t		io_fail_no_available_path_count;
 #define NVME_NSHEAD_DISK_LIVE		0
@@ -1041,9 +1043,12 @@ static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
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


