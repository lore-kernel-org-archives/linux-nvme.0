Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6395C44507
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=10KeGQhgQdm8EqX8oHgi30BrTmqbiEtfTzFxYq7imyk=; b=H/M/qvXodHwtr2eNxKw5J3gmfw
	SssK90ghmVK9mMeJ9aiM4h3YVKy2LfXJLE7JC4cQOsPWNg4W4xkOW6dTVQlMorzcmdKzhrsS+ZqNi
	tAQxQdpIDVWy9G6C9ntE6gKNM19M8yBO4Gq7PkAvRzRxOTvBG0TUINAqcYlgn/wWhbrAG1OetdFti
	dVEu7VRYjYCazFGD4H2OdWj7KkfdDhKCw5kjJApv2D9cFMyNwgNRDxBTp617hD65lXj3NJcw2mkJg
	3VRYRIv9vFIKk7kRa5fnDP9RazJqWVUrYicp3qZ0a2OY5+5w29AKn9/7TCBrF9bui3pdz2LaDTzyj
	3BBLnNrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFG4-000000094i7-0c0i;
	Mon, 13 Jul 2026 11:55:36 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFG2-000000094du-0cwO
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:35 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fjFf1740312;
	Mon, 13 Jul 2026 11:55:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=10KeGQhgQdm8EqX8o
	Hgi30BrTmqbiEtfTzFxYq7imyk=; b=rau18VnYMgJTue2UBJU7X7S30Fu8AkZIz
	B3BEvbnEJjhMrZYm4mXHq+X1ZB6W+YcKU8Wf10xN3Mu7Hgyh/MQR/v625vKz8C5M
	LEFy2iWlGnk45vvuf44LHxDnCqSb59gIk/BEjpEE+ZskA0O5zn7sW9M35VqhBipG
	jXaALZAJipf0lSkpCObgiJj2P6WCZ8m7I/g/XbTJ4cLnmh22YUy5H4jjpmxlT8b2
	Su7KsS9A6a9x09H/MuJFqAaZzW3TIRSsMb9xa89MVxohVSQ8rK//3hF+CVm0loQH
	HBAub3bfXsx6P1xkTnRPkoRNMrTaMEWbm4fv0NbDlBGvuvnuPGfmw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt0fb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBncFL012349;
	Mon, 13 Jul 2026 11:55:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvwk5m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtLAW16646450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFDBA2004B;
	Mon, 13 Jul 2026 11:55:20 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F0CD20040;
	Mon, 13 Jul 2026 11:55:19 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 11/20] nvme: add context annotations for nvme_subsystem::lock
Date: Mon, 13 Jul 2026 17:24:12 +0530
Message-ID: <20260713115444.465704-12-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: W5VfR1l2pUHL2LTFnzNpw29C-LnStUlr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX8s9dhfk3JbLt
 mUGCL4sQPkLJi96ERz7KO6Xf1rwP2lmnOh6TNdlleobBap5p5+KWbA4AKfVXZ+z7NYB1AWK4gIl
 mQMrmttBBNrrhIa51Vq+ojAR9yvmatw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX3XSzda/6q14M
 Q+MSUYZYb+sMKjvEvlGMHJdb1mPX64MVgZ9yWiYAGHHGGQnn08IBB4++tMAeJv5DOktfKJEFNhy
 clvH2AVyeS9ynXL0QcgCN9NeKKs4xJ+Kxa0m0zDAqUyA71k/taEjAUo47/o6GSuklFYbyOt/bw2
 JmBNU/qeCkhOLV25r63GK6tisXcQhjn0KbXNfBnJZFuownbjFBDYJj59H8KlivuDDYph1yS+R3t
 nSl3EyhGHkrpC2uMnvL1iujif0Dfrw6VOSXquMqlOX2h9NPzOmWPWzUqFbjQh4TAPbk0/faw981
 mGowgZ3IAUoW0QIrgksXoXLwmjF51vJI9Vo3X9epZYYLF3rh4ypx4qK5nZA05CN6L5yU11I65z6
 yAUYR9i9A2BjAsXz2ARorDMqIPAWJ+OfMcxyKSb1ypgIIrPcm320OVSGf/o1hjqoBR/FqqCG/o6
 BRO4mXHGoHmNJ7UQYwg==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a54d22e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=8XytNyI1XRNVYq53IcYA:9
X-Proofpoint-GUID: Snb85HC2S5zro0m81QXsFEEYiB3HilX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045534_230561_AE39DF7A 
X-CRM114-Status: GOOD (  16.03  )
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

Annotate nvme_init_subsystem() with __context_unsafe(), as it
initializes these lock-protected members before the object is published,
suppressing a false positive from Clang's context analysis.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c |  4 ++++
 drivers/nvme/host/nvme.h | 15 ++++++++++-----
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d6a095e1e44e..f7a4cdb988f1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3274,6 +3274,7 @@ static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 }
 
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+	__context_unsafe(/* initialize unpublished/lock-guarded variables */)
 {
 	struct nvme_subsystem *subsys, *found;
 	int ret;
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


