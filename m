Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5999C3ABC9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 May 2025 20:27:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uKGI+YJetDHhhKNcNzrcEIvBpvvn6/u4KDa4xPuYjkM=; b=OZLVqT47YyGMLrvnAXdfsDqv1P
	3EK0JpicliGewlLvEViVrWmQtwg7l4eKtJ6wl2U8JiPeO3xrQHmQhfVfpHFCZKwjtfUWq8DNW8kRV
	diXQHbDAWjL+6FKqu4Gkb/SYpxAZ+o8KNMgo6g60WKrS+oroC5cf42blaKczYcvodMpKUdhr3QRXP
	mSNTJEezi0+42Co8qTYUbv5Ts/DL0/V+4s23BQzkhlKdqUXC8fbOFq2pRGMYZw+PN1+gW2aB0a7D+
	Jvr7lM/b6/2k6Se+UGgJxGvFtfjr9v5PUXAKGJWgE7Pp0SMDd33swtyOxLKaEJlt0LYLs5nUji+PP
	XxrEASGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDUJe-00000004oWm-36a9;
	Fri, 09 May 2025 20:27:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uDRtc-00000004Uri-0ZUP
	for linux-nvme@lists.infradead.org;
	Fri, 09 May 2025 17:52:29 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 549A4ZGh026946;
	Fri, 9 May 2025 17:52:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uKGI+YJetDHhhKNcN
	zrcEIvBpvvn6/u4KDa4xPuYjkM=; b=Gy3A+sMaSUxuk/FiXjHl000Ig7bpsBOZ2
	Uq+xPPIoCVBTyCAV/6XhXozl5i8CSkq3cEfakCieNfvfi3fk+H5mLqw9NAtPXKfm
	gXnenk3xyiQ1EdxsxinMq6ADHuZp+U3A6pXq9FddVZaUIBvRAdhrKrrxVWy29zTN
	bXeNH7nYn8qetfDQHoWlRIkEe+9vPYLq96Z2XuJnQt0T1rKCVmTM4eU8EhpXYpb6
	8XRV0GKyrZcIXTS3WCzAmDgW4OItKA9lLGblSYGQELN0jWphzqloY1+xCdS3VBN0
	P5OV46f5GLfi33+q2ESOTgIdMr4PhGazpODZNCyWA4mEgktLZ9S9A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46hfmnabyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 17:52:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 549GDUjr014122;
	Fri, 9 May 2025 17:52:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46dypm4fuv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 May 2025 17:52:21 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 549HqJH557868580
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 May 2025 17:52:20 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D406F2013F;
	Fri,  9 May 2025 17:52:19 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDFB52013C;
	Fri,  9 May 2025 17:52:15 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.130.163])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 May 2025 17:52:15 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv4 3/3] nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk
Date: Fri,  9 May 2025 23:21:50 +0530
Message-ID: <20250509175158.2753396-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250509175158.2753396-1-nilay@linux.ibm.com>
References: <20250509175158.2753396-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RO6zH5i+ c=1 sm=1 tr=0 ts=681e40d6 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=3Nj66fidHWVfShYRhO0A:9
X-Proofpoint-GUID: q1TFgkk0jS4wXzawczDpAdhhv_pZSwbn
X-Proofpoint-ORIG-GUID: q1TFgkk0jS4wXzawczDpAdhhv_pZSwbn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDE3NSBTYWx0ZWRfXxUkGs35Edblk 1BS5/61Qh9WTFkHS9tOpQh/zyHKhKfEkuqALBileDX0OjZFasj+fP+388dpwyvL0c3rqrmMK1dh +Cq/LMfdnOEKT/6FiiwEauswqIPEJy1qFttnmnYYtbqF4SbAtI1/YpdALOov+TVAMPuLEK/Gt/d
 m52Q0loEg31ZrAwhm6ZJSJVXpnWZKCHOG8Q+XXh1VvYEStzaDvvDM+AQ0NNXJdL3kEgJrY8opFs r1ZWkQHROtEYKylu+arS9UlgxMHcM/O5t8hrxs7u7keWbN98knnROTpoC6ql4A4fXtnaTXKzu8G Hnn8sdKC6yS5tQCj9GkCz4gABOBAe6PrCcfr0X0V4VYk3T23aHy506I8sSpZj5Q3FdBUemySZuB
 bd3RR6jQLNgcf4K+rjHTb0Y6aABu9UR6FNnSNM4Y/dJSTOWhGwT+v2bPM8Yi4Wv7NkADvbr/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_06,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 mlxlogscore=904 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505090175
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250509_105228_178572_3D65BBB6 
X-CRM114-Status: GOOD (  17.09  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  4 ++--
 drivers/nvme/host/multipath.c | 16 ++++++++--------
 drivers/nvme/host/nvme.h      |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0b7139d0ea9f..3167454a2e5d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -668,7 +668,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	struct nvme_ns_head *head =
 		container_of(ref, struct nvme_ns_head, ref);
 
-	nvme_mpath_remove_disk(head);
+	nvme_mpath_put_disk(head);
 	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
@@ -4214,7 +4214,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	synchronize_srcu(&ns->ctrl->srcu);
 
 	if (last_path)
-		nvme_mpath_shutdown_disk(ns->head);
+		nvme_mpath_remove_disk(ns->head);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e85c8e258a4e..0e57cd7e595e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -698,15 +698,15 @@ static void nvme_remove_head_work(struct work_struct *work)
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
@@ -1284,9 +1284,9 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 #endif
 }
 
-void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
+void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
-	bool shutdown = false;
+	bool remove = false;
 
 	mutex_lock(&head->subsys->lock);
 	/*
@@ -1312,15 +1312,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
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
index f20076f6f06a..1de1b843afa5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -966,7 +966,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_sysfs_link(struct nvme_ns_head *ns);
 void nvme_mpath_remove_sysfs_link(struct nvme_ns *ns);
 void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid);
-void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+void nvme_mpath_put_disk(struct nvme_ns_head *head);
 int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_mpath_update(struct nvme_ctrl *ctrl);
@@ -975,7 +975,7 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
-void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
+void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
 
@@ -1025,7 +1025,7 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 static inline void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 {
 }
-static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
+static inline void nvme_mpath_put_disk(struct nvme_ns_head *head)
 {
 }
 static inline void nvme_mpath_add_sysfs_link(struct nvme_ns *ns)
@@ -1044,7 +1044,7 @@ static inline void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
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


