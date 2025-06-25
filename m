Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FE6EC7115C
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Jun 2025 16:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cW/bqCI2U6Nr+BfbLBPc4iYIL1Ye+cPjzyXgxm/wFwE=; b=apcR6pk2tVi2+gkK954pUiMhlM
	ZEc1FJGoh4AxbcHyxfPHqt4cA3Wbp5PqylMdiiMLvKMBDrmNk4y59dtkTLLsOkpoMMsxhDU/7H6ta
	JTFBwR5gzdfbKma9y5bnknqks0DVtBLUerZ9wqtm0QP10wkf3Tl7yrvoOGRy7q/4CezqVFkNV1/8E
	/Ksp54KJ9FtVgvolcKf1WQ6AkOY+W0sqlBSC8vyP/3LMWwj7kKHd9R5uUR6U4dOIiMALcHPVBnU4g
	9nu+z+DZcmDZXCyOtLX9t6WlZuAxCjHjsrfk5R2aylWbk3NH0YrYafK7MJhiuXr4h6Jea0OyA8X9r
	u/Z0Jtaw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUT20-00000009J7g-2oLM;
	Wed, 25 Jun 2025 16:31:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUP1G-00000008aiz-1Qdu
	for linux-nvme@lists.infradead.org;
	Wed, 25 Jun 2025 12:14:28 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55PAwcbn000722;
	Wed, 25 Jun 2025 12:14:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=cW/bqCI2U6Nr+BfbLBPc4iYIL1Ye
	+cPjzyXgxm/wFwE=; b=UpFzlDHdR29WiUS1ZEUPeFj1pyeKYzQv/HAbQnM0zyu5
	or6XzCXeXsPyyOKBQHPAeUxwKcQQDnSxdlrcK9xDBPZYR+TPB/baBtC8SC9w/V9w
	eB+iENujO33A4IRZO/qcyxdkTNCmMu95PG2cJsiJEP2TBK80nBzaOTM5JJLfpsnm
	+3DGlxXoniAJYTuDN/QPCuV/7besoihSBY9jcgbTfW9G5eOBU4vbWV7+9/u+/akY
	1OeA3w8KVqgrdBXIYpc4xmrnxPCgY9oFUFB4jK8M89BHiGBWPeZtwzRPd+qb9G/0
	ZQR+kle/GGYp/eEV9S3d5Nh6/p6LWTbGWzrjvznJyg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dk63xxef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 12:14:15 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55P9fYZg006497;
	Wed, 25 Jun 2025 12:14:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82p98vv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 12:14:14 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55PCECoQ44892634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Jun 2025 12:14:12 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93BAD2004B;
	Wed, 25 Jun 2025 12:14:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E9C920040;
	Wed, 25 Jun 2025 12:14:07 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.76.241])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Jun 2025 12:14:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: yi.zhang@redhat.com, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        hare@suse.de, dwagner@suse.de, axboe@kernel.dk,
        shinichiro.kawasaki@wdc.com, gjoyce@ibm.com
Subject: [PATCHv2] nvme: correctly account for namespace head reference counter
Date: Wed, 25 Jun 2025 17:43:29 +0530
Message-ID: <20250625121404.733810-1-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI1MDA4NSBTYWx0ZWRfX0ET8c3uNwLyv XZ9OrCF7g0XmK8hS0eBP/a/ZZrtVp/+lFi30YLX8eUA4qsbzEfJUyUxHpx+sEwmn4hdWivfJE// /hh5i+9wu0lAFc5zHUimvpbt9ewtuDMfV26vX2VigDcUxbj3Ulrz/NdjYAiLnVULElF10FrwgYH
 4YL5jYHcVbr3rPnKwgbvISfmJe1LJOXFkavqzWmDb0dJVG9UMT2YXjx4gto+wVlF86GRzq1QXj9 1NMoeJjN9FsXm7oM4gbDO8gCI/TR2CHeAgXUkPX1z0L32YXeU1KwGIPZTjCBt2w0R9PfZDTW8H2 uD3RK09RLfT5RWvvS9zrI6tj/dlr1ZVbYAWCe1hgBapQyPsAQ0L8wpbndxvoheNWwodqY5gcOhx
 v3ps4Rc52AjqGt5x+6mmsWOBuOHLeL2DT6R/ufHTdIh5IJB2ZP4jnywXkHlsUC5X2d63b2lW
X-Proofpoint-ORIG-GUID: 0RzuvMLWpxnRhrmRhUIdIcFBYOfkpCPG
X-Proofpoint-GUID: 0RzuvMLWpxnRhrmRhUIdIcFBYOfkpCPG
X-Authority-Analysis: v=2.4 cv=BfvY0qt2 c=1 sm=1 tr=0 ts=685be817 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=9bsi7WVkUijA0EX-ZIEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-25_03,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 spamscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506250085
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250625_051426_849540_21C55082 
X-CRM114-Status: GOOD (  26.62  )
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

The blktests nvme/058 menifests an issue where the NVMe subsystem
kobject entry remains stale in sysfs, causing a failure during
subsequent NVMe module reloads[1]. Specifically, when attempting to
register a new NVMe subsystem, the driver encounters a kobejct name
collision because a stale kobject still exists. Though, please note
that nvme/058 doesn't report any failure and test case passes and
it's only during subsequent NVMe module reloads, the stale nvme sub-
system kobject entry in sysfs causes the observed symptom[1].

This issue stems from an imbalance in the get/put usage of the namespace
head (nshead) reference counter. The nshead holds a reference to the
associated NVMe subsystem. If the nshead reference is not properly
released, it prevents the cleanup of the subsystem's kobject, leaving
nvme subsystem stale entry behind in sysfs.

During the failre case, the last namespace path referencing a nshead
is removed, but the nshead reference was not released. This occurs
because the release logic currently only puts the nshead reference
when its state is LIVE. However, in configurations where ANA (Asymmetric
Namespace Access) is enabled, a namespace may be associated with an ANA
state that is neither optimized nor non-optimized. In this case, the
nshead may never transition to LIVE, and the corresponding nshead
reference is then never dropped. In fact nvme/058 associates some of
nvme namespaces to an inaccessible ANA state and with that nshead is
created but it's state is not transitioned to LIVE. So the current
logic would then causes nshead reference to be leaked for non-LIVE
states.

Another scenario, during namespace allocation, the driver first
allocates a nshead and then issues an Identify Namespace command. If
this command fails — which can happen in tests like nvme/058 that
rapidly enables and disables namespaces — we must release the reference
to the newly allocated nshead. However this reference release is
currently missing in the failure, causing a nshead reference leak.

To fix this, we now unconditionally release the nshead reference when
the last nvme path referencing to the nshead is removed, regardless of
the head’s state. Also during idnetify namespace failure case we now
properly release the nshead refernce. So this ensures proper cleanup
of the nshead, and consequently, the NVMe subsystem and its associated
kobject.

This change prevents stale kobject entries from lingering in sysfs and
eliminates the module reload failures observed just after running
nvme/058.

[1] https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/

Reported-by: yi.zhang@redhat.com
Closes: https://lore.kernel.org/all/CAHj4cs8fOBS-eSjsd5LUBzy7faKXJtgLkCN+mDy_-ezCLLLq+Q@mail.gmail.com/
Fixes: 62188639ec16 ("nvme-multipath: introduce delayed removal of the multipath head node")
Tested-by: yi.zhang@redhat.com
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
changes from v1:
    - Avoid double free of nshead when multipath is not configured.
Link to V1: https://lore.kernel.org/all/c2e2aa93-9213-4322-a95d-27447f8b08de@linux.ibm.com/t/#u    
---
 drivers/nvme/host/core.c      | 16 +++++++++++++++-
 drivers/nvme/host/multipath.c |  5 ++++-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 92697f98c601..1b09c19e483a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4089,6 +4089,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	struct nvme_ns *ns;
 	struct gendisk *disk;
 	int node = ctrl->numa_node;
+	bool last_path = false;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -4181,9 +4182,22 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
-	if (list_empty(&ns->head->list))
+	if (list_empty(&ns->head->list)) {
 		list_del_init(&ns->head->entry);
+		/*
+		 * If multipath is not configured, we still create a namespace
+		 * head (nshead), but head->disk is not initialized in that case.
+		 * As a result, only a single reference to nshead is held (via
+		 * kref_init()) when it is created. Therefore, ensure that we
+		 * do not release the reference to nshead twice if head->disk
+		 * is not present.
+		 */
+		if (ns->head->disk)
+			last_path = true;
+	}
 	mutex_unlock(&ctrl->subsys->lock);
+	if (last_path)
+		nvme_put_ns_head(ns->head);
 	nvme_put_ns_head(ns->head);
  out_cleanup_disk:
 	put_disk(disk);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e040e467f9fa..c7644631bb1a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -690,8 +690,8 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		synchronize_srcu(&head->srcu);
 		del_gendisk(head->disk);
-		nvme_put_ns_head(head);
 	}
+	nvme_put_ns_head(head);
 }
 
 static void nvme_remove_head_work(struct work_struct *work)
@@ -1291,6 +1291,9 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 {
 	bool remove = false;
 
+	if (!head->disk)
+		return;
+
 	mutex_lock(&head->subsys->lock);
 	/*
 	 * We are called when all paths have been removed, and at that point
-- 
2.49.0


