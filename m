Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 263CFC3ABD9
	for <linux-nvme@archiver.kernel.org>; Wed, 14 May 2025 13:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Oz99IvS+avs9UmV57c0EZVrt4lCrFPHRfUsTWoqqIQU=; b=ayCxKjLb3SLmJA53uGplH4mTxx
	fTDbxgnBT0/I8HPIiJtXO62isXe454hmP4D3Pzm3xmm244MWDJXuJZ8r+Xs2JHJaCRJtydmZYmHha
	my29Hxg/xSU/mhyXz/lRNlmx0kbR5N7+6+/F8gA1noHhYsV91AUcWv9vYCfgGRc7nWgIs9Z2XslmL
	j9tL+hLc00aMmLECqj8UhF64U7hUaG7+lKFZRi1gRX2EMbPwA+7BkAQowMfMPatYd3dzyKcJBPaSc
	mpH4B6QYgWsD27elW5j+BH3DAkoerCusPx4TUnLBN4kpToN3poa3c6q13G8xTemTzrg9oVSQghiuO
	tnG9atGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFCZK-0000000FJiX-0kyZ;
	Wed, 14 May 2025 13:54:46 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uFBm7-0000000F9hN-3LK2
	for linux-nvme@lists.infradead.org;
	Wed, 14 May 2025 13:03:56 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54E6IlE8026915;
	Wed, 14 May 2025 13:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Oz99IvS+avs9UmV57
	c0EZVrt4lCrFPHRfUsTWoqqIQU=; b=Ox65s0G5zJbvUuYbvxAD7Qjra7wI63I2J
	za8UZ815SBp+F8MFu2ki5eFUY6eoYoDRjmuooOROjYGiu5qj2Rl9eF+940ezq4lr
	tHBY7ayD6ZEh7ZxWxklS9jgHhxxGbL+mG8/YfC1z57P+zrKv0eBEVeDen/eQQyXo
	SP7OgxLOTvubcppc+o9ZcJKZP0aGeMuy0dMiRuwmaVccw4md95KMFU2tVbi0Gkae
	zH7Qc3Jzgmwvlqt1+mNnYnfNkmGpZ5ybq7KtcauePI882IrRqMvtjTKDmke6yJGG
	ydQH3N18InIBXGO01w8u0R5qsm9w3EAniZbgDj/dGflbZdDF1jduw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46mnst1ubq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54E9nox2024322;
	Wed, 14 May 2025 13:03:46 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfs48r4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 13:03:46 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 54ED3ilx44630404
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 13:03:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 491C120040;
	Wed, 14 May 2025 13:03:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1801920043;
	Wed, 14 May 2025 13:03:40 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.67.82.218])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 May 2025 13:03:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, hare@suse.de, kbusch@kernel.org, sagi@grimberg.me,
        jmeneghi@redhat.com, axboe@kernel.dk, martin.petersen@oracle.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv5 3/3] nvme: rename nvme_mpath_shutdown_disk to nvme_mpath_remove_disk
Date: Wed, 14 May 2025 18:33:17 +0530
Message-ID: <20250514130322.393656-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514130322.393656-1-nilay@linux.ibm.com>
References: <20250514130322.393656-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GU22r6UspbBKTZwyPtr3joIPK0Ch7_FZ
X-Authority-Analysis: v=2.4 cv=V+590fni c=1 sm=1 tr=0 ts=682494b3 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=3Nj66fidHWVfShYRhO0A:9
X-Proofpoint-ORIG-GUID: GU22r6UspbBKTZwyPtr3joIPK0Ch7_FZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDExMSBTYWx0ZWRfX2D2b2wXFVknH ZSKrMvr+yoIvS1u/NJPnZpDRSWVU9NRg24Iw7rZe5T8a/jI6VvfVnlvXVPh+e9iMCddVx1s82uE rDxiAEczjUkp4sATCB/rO7Z/MwxxoCi+xHfaJ9cpX4BOAl/hwhEi01SPzhDcD4VdWrZm1maA8GK
 GuEZQpisjFX8xuLjZJ5Qhdx2WBDOA9kSTEyxWQdwKN6bG/5P89dldbMhCYDP0MgQnNHVjLXRqgU v8nMWYLGBUI4nlHuogqwG4zfEMBXFxhS/T76ZMFTK7HTBc4l3l6nabUdmJksFPCi+RJv3c0EnD6 LDw296hvRD4R9iAzU0n76XGzSfkq60OGmr+Qf9Goi6yzgFLpYpJvzdKKLdTyn8Aj/8w5Qd2V6iF
 Yi7Kl1M0XXeXKfuTNrNBfXTJMRQeyVnKFtN1nQBl0TI/Qg4FAQvy6tjV5MSVlcN/i89zShxp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 mlxlogscore=907 lowpriorityscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 phishscore=0 adultscore=0 clxscore=1015
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505140111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250514_060355_840336_3BE71DB0 
X-CRM114-Status: GOOD (  17.38  )
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
index 6d11f8b19633..cdb806b2c89c 100644
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
index 0453d272c638..4725e6620096 100644
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
@@ -1286,9 +1286,9 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, __le32 anagrpid)
 #endif
 }
 
-void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
+void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
-	bool shutdown = false;
+	bool remove = false;
 
 	mutex_lock(&head->subsys->lock);
 	/*
@@ -1314,15 +1314,15 @@ void nvme_mpath_shutdown_disk(struct nvme_ns_head *head)
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


