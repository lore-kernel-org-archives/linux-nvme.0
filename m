Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0590BC624A4
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2026 15:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9R/sUtgW+K1VIkUfYorufvlypLPOldZ80y+U99Vlmxw=; b=DmOdw2Nf8HDaOx2dctr1TRU+Q/
	CGtCyaVq+jBUI2sVRbhgLFjNkfMI3TKOgeaON6Ps77ExYFx71oP2GVleMMEEHPz99imomNcaHgRbI
	N5//bEwUBzYlDtJmDSTm27oQR9Xw+0VhVu4FTVo9I2k0jkkO7zv6zo8RMcv9oPH+cKpiiQqzU7ybI
	5nHMoZvSdjpmS0eckbo1j/xdG607GKqW/+PdwhUnQFcoi/fX/2pVDgRzSc4e5jt/ZtubMBuh4UqaL
	6BJ29KNsOPPXAxovXKageyrzzDwcELVZN9EiFsxvlasXoU/n5LlfGYuCzruIt3SqO7LbxDc6FFMuZ
	10XpfL0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x13oe-00000009q6K-2R6Y;
	Mon, 31 Aug 2026 15:20:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x13oa-00000009q5B-3cdb
	for linux-nvme@lists.infradead.org;
	Mon, 31 Aug 2026 15:20:54 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VEZ9tR652812;
	Mon, 31 Aug 2026 15:20:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9R/sUtgW+K1VIkUfY
	orufvlypLPOldZ80y+U99Vlmxw=; b=tTzj01QBvEgjVHWEI2rK5teqgSbVi8v30
	U4SO/Z+O6X5bD3DthASWRzRHFR6riueQgeAEPCEquSYZ/P+f8Xh6M6TlU2+4m2oA
	HPjMtD+Crv11jlcwgrQuhddIYcb3qKEuQA8bpwD2s8rKMVvHzroToZrDo3VsK7vP
	HtaJJ0CiNF9K7T+Bu/1758xxqAsCvqQMCU4UCjHcnHuWB4+XrZ86EBu0HOcgAvOK
	t1n4Nq29jd3oH7m0bZRyK7pWube8RiiXYDhgovV2KayMQEJ3iXxqB0eqVpN9P4vj
	TK4L3F+u3vKpMdCiEYO+9dr7jgo6j8S+qwlRkCFdsOVbCC7XYzpkw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbq3r25cw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:20:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67VEuNUZ020152;
	Mon, 31 Aug 2026 15:20:44 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gcbyg6emy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 15:20:43 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67VFKdI445810158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 15:20:39 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F79F20043;
	Mon, 31 Aug 2026 15:20:39 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7676620040;
	Mon, 31 Aug 2026 15:20:32 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.22.126])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 15:20:32 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, sagi@grimberg.me, hch@lst.de, axboe@fb.com,
        john.g.garry@oracle.com, wenxiong@linux.ibm.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 1/2] nvme: keep transport module referenced while head node is open
Date: Mon, 31 Aug 2026 20:49:54 +0530
Message-ID: <20260831152006.819471-2-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831152006.819471-1-nilay@linux.ibm.com>
References: <20260831152006.819471-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=EIc2FVZC c=1 sm=1 tr=0 ts=6a959bcc cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=USrPIDZTmXtp3RMkDlYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfX1AtOTJHolwd5
 VGrMafcoCGn3DwGzkmzbKqz2RLJKmhxRvngdhL+MHNMNqSx8SD4ErWBQGFvDmT0qOeDiUcb+S4T
 /t2WntowyP1OZfwb1/IIp76J+Vhn0BgrVF9BxzEJd1e0wwlcaCmKVMbaxvhMnLkF4o81BBLvF3T
 w3vLIMgq5Sz8GdalUg4jPUS16fXjkU/JePow9e3ghG4xQw4NhpVfaqi7wBah04onlwm8WbYNkUu
 7QndLVHoPbQ/GmLWiwSsee8BeNcA2PlKZFku6THRSuPwp47RKjZoDusGifX5dTGYItyLOtnGdUm
 bV3dlF8FN6Q6VRA3yl3e5P3z79ZHZXJoVTN8Ws7LseN+77ZDYJzL8cEMshkIDfkrTkt9P6W1dm1
 uA69koqmeTy+hl6UXIkq+bGd/AHkhjyZEMHlRz2RCdb8vdhj92jygpzcbGHqlSB79aeI1eK/i4L
 oPmDkD0ZOjQZr4VeCZA==
X-Proofpoint-GUID: TSEMC9W7sPm73dEOLJ1xvsD3Hfdqonlp
X-Proofpoint-ORIG-GUID: TSEMC9W7sPm73dEOLJ1xvsD3Hfdqonlp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzMCBTYWx0ZWRfXxcF7nehDLreZ
 OFqaek1Iugngz8JLaUp51p+I6jq2deaeRdmQTF8ZDr16TwVNGpegSBx8zpKgbvh43XKmpre2IsM
 ahfoT29fOJArH4MBychllWuDJctsm0g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260831_082052_915293_8676EAEF 
X-CRM114-Status: GOOD (  22.43  )
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

When a user opens an NVMe multipath head node, we take a reference to
the head node, but this does not prevent the transport module backing
its paths from being unloaded. This can result in the multipath head
remaining open while its underlying transport module is unloaded.

Fix this by taking a reference to the transport module for each active
path when the multipath head node is opened. Keep track of the number
of active head node openers so that dynamically added paths acquire the
same number of transport module references.

Similarly, when a path is removed while the head node is open, release
the transport module reference once for each active head node opener.
When the head node is closed, release the transport module reference
held for each remaining active path.

This ensures that a transport module cannot be unloaded while it is
still referenced by an open multipath head node.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  6 ++++++
 drivers/nvme/host/multipath.c | 37 +++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      | 32 ++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1322c678f4eb..fdf760c57e02 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4173,6 +4173,9 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 
 	list_add_tail_rcu(&ns->siblings, &head->list);
 	ns->head = head;
+	ret = nvme_module_get(ns, head->nr_openers);
+	if (ret)
+		goto out_err_module_get;
 	mutex_unlock(&ctrl->subsys->lock);
 
 #ifdef CONFIG_NVME_MULTIPATH
@@ -4181,6 +4184,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 #endif
 	return 0;
 
+out_err_module_get:
+	list_del_rcu(&ns->siblings);
 out_put_ns_head:
 	nvme_put_ns_head(head);
 out_unlock:
@@ -4370,6 +4375,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 			list_del_init(&ns->head->entry);
 		last_path = true;
 	}
+	nvme_module_put(ns, ns->head->nr_openers);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	/* guarantee not available in head->list */
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..822cd0d23e1d 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -579,14 +579,47 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 
 static int nvme_ns_head_open(struct gendisk *disk, blk_mode_t mode)
 {
-	if (!nvme_tryget_ns_head(disk->private_data))
+	struct nvme_ns_head *head = disk->private_data;
+	struct nvme_subsystem *subsys = head->subsys;
+	struct nvme_ns *ns;
+	int ret;
+
+	if (!nvme_tryget_ns_head(head))
 		return -ENXIO;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ns, &head->list, siblings) {
+		ret = nvme_module_get(ns, 1);
+		if (ret)
+			goto out_unwind;
+	}
+	head->nr_openers++;
+	mutex_unlock(&subsys->lock);
+
 	return 0;
+
+out_unwind:
+	list_for_each_entry_continue_reverse(ns, &head->list, siblings)
+		nvme_module_put(ns, 1);
+	mutex_unlock(&subsys->lock);
+
+	nvme_put_ns_head(head);
+	return ret;
 }
 
 static void nvme_ns_head_release(struct gendisk *disk)
 {
-	nvme_put_ns_head(disk->private_data);
+	struct nvme_ns_head *head = disk->private_data;
+	struct nvme_subsystem *subsys = head->subsys;
+	struct nvme_ns *ns;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ns, &head->list, siblings)
+		nvme_module_put(ns, 1);
+	head->nr_openers--;
+	mutex_unlock(&subsys->lock);
+
+	nvme_put_ns_head(head);
 }
 
 static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75e5d5a8a77c..db08f4618f92 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -569,6 +569,8 @@ struct nvme_ns_head {
 
 	struct gendisk		*disk;
 
+	unsigned int		nr_openers;
+
 	u16			nr_plids;
 	u16			*plids;
 #ifdef CONFIG_NVME_MULTIPATH
@@ -1109,6 +1111,28 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
 		return true;
 	return false;
 }
+
+static inline int nvme_module_get(struct nvme_ns *ns, unsigned int count)
+{
+	unsigned int i;
+
+	for (i = 0; i < count; i++) {
+		if (!try_module_get(ns->ctrl->ops->module))
+			goto out_unwind;
+	}
+
+	return 0;
+out_unwind:
+	while (i--)
+		module_put(ns->ctrl->ops->module);
+	return -ENXIO;
+}
+
+static inline void nvme_module_put(struct nvme_ns *ns, unsigned int count)
+{
+	while (count--)
+		module_put(ns->ctrl->ops->module);
+}
 #else
 #define multipath false
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
@@ -1199,6 +1223,14 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
 {
 	return false;
+}
+static inline int nvme_module_get(struct nvme_ns *ns, unsigned int count)
+{
+	return 0;
+}
+static inline void nvme_module_put(struct nvme_ns *ns, unsigned int count)
+{
+
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
-- 
2.53.0


