Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A50CC369DC
	for <linux-nvme@archiver.kernel.org>; Sun,  4 May 2025 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i/cIguIkAh41kLASfnwqnCXtXsPsMkU0pRHwNtTjsxM=; b=PaoFiVzvjVkWJUsAWnNPFDX39U
	HmzZ95GzcSKVgaNWGbYSMbjJlTwsx4qhxRtU72Z8VY2iFniEekgGVDCCm7k01zT/53wl2lc64YJqC
	GPQoqZ7P99+W6F5cvEa+oBLfrbg97VXwzXwCWQq9k/ef+AMfIB3BLdNiNYeivzKp3AbWFvvm/z3IK
	1nJwuRlHunVhS007zmbBvdzwWSbGeKYzNxsww7i3IbAEuS3jro+WyqXgR/0Z3gpSNkdYtkYqFxFCE
	FY4yIbrzOOxNiY7ZaRpVZc8avGuRPwJ6roGcKgXcW9+3cNWszZQPLADQ3AAc5BqeGiIZ9jT2YdHTE
	W3oLh/2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBdX8-00000005m7E-1v9r;
	Sun, 04 May 2025 17:53:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uBdUp-00000005lnz-0GHY
	for linux-nvme@lists.infradead.org;
	Sun, 04 May 2025 17:51:24 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5445Cvto013874;
	Sun, 4 May 2025 17:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=i/cIguIkAh41kLASf
	nwqnCXtXsPsMkU0pRHwNtTjsxM=; b=G7US0QKzW9mTvA1A+YPivLLYUwg7bjI/s
	5Ae5JAXCEPf5hirgcnzimPbsL8Eo1IYjSRaT/cCwz8yjBs8Mnoc47dPz7cf5qe1K
	GSqKyvH63p0eOj70ZJFseRIO8jyqBIiJ7LiQFAU7At0ZFWpXh3nwG489pvlVxClV
	ICwHyN6l7yuD8L0w/IDniniODHqO5mjIgJ48MTWflcS/UDspbN5nql7n+nDzGzFm
	ABCm103qFAWEuUDGSGlHLKj7txghF7aStZvP3jqYF13db8YDT2X5e6A/EP556N1J
	v6O3avH7jmjsOtpgIlKQCRZiPf4zVFRn21fTDS1tzIqUqUHXMiE9Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46dtqk2j99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 May 2025 17:51:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 544G7NHK001345;
	Sun, 4 May 2025 17:51:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dwft2wna-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 04 May 2025 17:51:13 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 544HpCnD26608290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 4 May 2025 17:51:12 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE42C20043;
	Sun,  4 May 2025 17:51:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE5B520040;
	Sun,  4 May 2025 17:51:07 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.80.251])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  4 May 2025 17:51:07 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, hare@suse.de,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv3 3/3] nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk
Date: Sun,  4 May 2025 23:20:41 +0530
Message-ID: <20250504175051.2208162-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250504175051.2208162-1-nilay@linux.ibm.com>
References: <20250504175051.2208162-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA0MDE2NiBTYWx0ZWRfX4MMksR57CLcM mucopQKt+trYH8M7NFi5I0jwe1TUxGhnJZkQtPNWJcTC9N9ulJEgrhbL0GL7rWC7hs/cL7hN4qL Ew8FfRc0e2QkELt0/GvlgqTfO2ehVTgr168WOs4SajtiH864s5XEN5SPRNRTKSPpbC7XLYMG3v4
 cW4CQZRoOij7BRwDLJXL61Sn2JmS6ZLQwjSY7eh4krbYW9LLHc+VYVgmxp8ENDwxzFnVtrSnOnO IXv14RlvxSj8SaoIa7FfxQQhnjZy2su9yeG0SRjroXgWYwvtmJH/nhhqAtO918Fct26t7U2QjSM zi02Kp8qNloKZTI800mlzTF2d3bYbJFp3s2Nx6UXw3CEe6TsZJ656hbRl5+fSeWoezH6t+M9ohX
 VzGeQRIWVcbFAkwUsKLRkDpz4GcqdkNiuRmRL4CEe2eyrB6CNGY2cIEAbfzMZbLn4S83byuQ
X-Authority-Analysis: v=2.4 cv=FaY3xI+6 c=1 sm=1 tr=0 ts=6817a912 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=3Nj66fidHWVfShYRhO0A:9
X-Proofpoint-GUID: GpUs7sGXKQ0i90SO4rV-6_h6x6c358bl
X-Proofpoint-ORIG-GUID: GpUs7sGXKQ0i90SO4rV-6_h6x6c358bl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-04_07,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0 mlxlogscore=923
 priorityscore=1501 phishscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505040166
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250504_105123_113702_A9131119 
X-CRM114-Status: GOOD (  16.65  )
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

In the NVMe context, the term "shutdown" has a specific technical
meaning. To avoid confusion, this commit renames the nvme_mpath_
shutdown_disk function to nvme_mpath_remove_disk to better reflect
its purpose (i.e. removing the disk from the system). However,
nvme_mpath_remove_disk was already in use, and its functionality
is related to releasing or putting the head node disk. To resolve
this naming conflict and improve clarity, the existing nvme_mpath_
remove_disk function is also renamed to nvme_mpath_put_disk.

This renaming improves code readability and better aligns function
names with their actual roles.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  4 ++--
 drivers/nvme/host/multipath.c | 16 ++++++++--------
 drivers/nvme/host/nvme.h      |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0f6b01f10c70..254e6a7249a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -664,7 +664,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	nvme_mpath_remove_disk(head);
+	nvme_mpath_put_disk(head);
 	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
@@ -4033,7 +4033,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	synchronize_srcu(&ns->ctrl->srcu);
 
 	if (last_path)
-		nvme_mpath_shutdown_disk(ns->head);
+		nvme_mpath_remove_disk(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index bc115b79eb13..ca6562d5c17a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -705,15 +705,15 @@ static void nvme_remove_head_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head = container_of(to_delayed_work(work),
 			struct nvme_ns_head, remove_work);
-	bool shutdown = false;
+	bool remove = false;
 
 	mutex_lock(&head->subsys->lock);
 	if (list_empty(&head->list)) {
 		list_del_init(&head->entry);
-		shutdown = true;
+		remove = true;
 	}
 	mutex_unlock(&head->subsys->lock);
-	if (shutdown)
+	if (remove)
 		nvme_remove_head(head);
 
 	module_put(THIS_MODULE);
@@ -1291,9 +1291,9 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 #endif
 }
 
-void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
+void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
-	bool shutdown = false;
+	bool remove = false;
 
 	mutex_lock(&head->subsys->lock);
 	/*
@@ -1319,15 +1319,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
 				head->delayed_removal_secs * HZ);
 	} else {
 		list_del_init(&head->entry);
-		shutdown = true;
+		remove = true;
 	}
 out:
 	mutex_unlock(&head->subsys->lock);
-	if (shutdown)
+	if (remove)
 		nvme_remove_head(head);
 }
 
-void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+void nvme_mpath_put_disk(struct nvme_ns_head *head)
 {
 	if (!head->disk)
 		return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b2d02425dc3c..490fdee867a9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -964,7 +964,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_sysfs_link(struct nvme_ns_head *ns);
 void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns);
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
-void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_put_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_mpath_update(struct nvme_ctrl *ctrl);
@@ -973,7 +973,7 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
-void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
+void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
 
@@ -1027,7 +1027,7 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 static inline void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
 }
-static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+static inline void nvme_mpath_put_disk(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_mpath_add_sysfs_link(struct nvme_ns *ns)
@@ -1046,7 +1046,7 @@ static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 static inline void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 {
 }
-static inline void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
+static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_trace_bio_complete(struct request *req)
-- 
2.49.0


