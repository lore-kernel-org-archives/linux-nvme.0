Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AB4ACD98C6
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/eOgbFqpnkUZh+jKNdHIkfR+XXtwqCoilqpb58FfkE=; b=EiZ3Odx0nPgI0QzzENXhGOzAYb
	Ac2JMd0Qm+CWq+1bDraovoKYmxLAv/t/fzr25or4ap8VhfyPTB7RdfnZQL29cETczhDRwfyYzM8lg
	u9aY1QIubrsU86IKG+U5E2girmS4kL7/h35p/Y4VUzdhIfALY/bMPbqletTI7R/n7B94u/ky9Ys5H
	WUtUX3FkrHW8B4d+zgHLIkw/C8o4W2ZlHDrPzzPAAS8btHfPJZBkEkRIckX28l4A9S8hiEu1MCoiU
	SX4T0b3uia82FCUtI7K9BWRg1MXvY4rssYW8z9hkXXUNVfcxxposinwhekZb2q8KgYJp5ZMP6HzQY
	0sKeOt8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJux-00000007sVp-47cU;
	Wed, 10 Jun 2026 14:28:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJuu-00000007sTg-2I3w
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:29 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A84n0Y3480113;
	Wed, 10 Jun 2026 14:28:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T/eOgbFqpnkUZh+jK
	NdHIkfR+XXtwqCoilqpb58FfkE=; b=piWooAGtc3MEKN9al1ELzDrSrGU1iTKwR
	y/qi5XTWACdE+OYliqo/I/NlzP2njK54TiG0XG2kom93lC5qZNwVMl/4r9k9OAGH
	LFk6FnsSx46tqWaJLEP3shITMnV6GzRbWZHpnYP720O04g9kti86usnbbAHl+yVy
	ApKk/BYGQ10UETJhsgmnAf/QBBUYidddmnqHrePxtfL9XkblKYo0e/VaHgqNmAVJ
	3Quym2JaCsfr9OKKg6+POVV9E9sFTlSxPZplTnLKZDYKykd6X7r2ZGqCOf4UmiOo
	N2pp0ZPp6utFTqMKQu0GtzYYG6jdgtEV6NQxloStR6UmJa0saupUw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6t12aw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEJqu2009340;
	Wed, 10 Jun 2026 14:28:19 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych6wge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESFAT48497040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0DEF20049;
	Wed, 10 Jun 2026 14:28:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73E9B20040;
	Wed, 10 Jun 2026 14:28:13 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:13 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 03/15] nvme: add Clang context annotations for nvme_ns_head::srcu
Date: Wed, 10 Jun 2026 19:57:23 +0530
Message-ID: <20260610142743.115898-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: s0GJy7xyv0lKULkO8mxvR5zcsvfB7NrJ
X-Proofpoint-GUID: 2v3l8pRJqRcAQPA4EClnd07Wm0b3vrCp
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a297484 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=GpToc5QlgnibPQXIAUYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfXx/8GWns9msrW
 5wKOw5eGy+JtCUepRd47UFlbKhJ5VBl119HAh7nOVzWlevTLgoiKIqGtRNItfa9VkhnkGbcZ+Ys
 PT4jZSX+Bd20v3PYZBKdO92JU/zLgQZDDvpoWHUdfF8uZ+nmIxAPc4xVgRmaWeP6933LbtZMnZX
 kGHcFvKn6RVNhN8inM8sSVSpZYgEvKoXtBICbq3kONKGaTWei8f8C8EFyBacEt42Adq5itgRnVO
 /IcOPYWCuzLwppeTRIo+0PhUuwG9R8r7fIVA1N62yZGAbEwEmgP6FtXCsqxB1DSotpGrfmnudQ4
 R7Vnd61qbiQfVLlYD5BNdilyAmU4NkNId6jujVym0Va7n5RWhes1XsVtCGVQ9vCoFBJP6YOFv7B
 YdhxCJs6m3cyVjnLIe0rpGCmvtbvaJCu4YyOy5rgZVV56Ea9CKb3lV70FJhr78OMXSR1PVdujHd
 3V7RTx9YyID4qqoubTQ==
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
X-CRM114-CacheID: sfid-20260610_072828_702427_041CAB72 
X-CRM114-Status: GOOD (  15.76  )
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

Add Clang lock context annotations for helpers that operate under
head->srcu read-side protection.

The path selection helpers invoked by nvme_find_path() access SRCU-
protected data through srcu_dereference() and therefore require the
caller to hold head->srcu. Annotate these helpers and nvme_find_path()
with __must_hold_shared(&head->srcu) so that Clang's lock context
analysis can verify the SRCU locking requirements across the call chain.

Also update nvme_ns_head_ctrl_ioctl() to use __releases_shared()
to match the shared SRCU read-side lock acquired through
srcu_read_lock().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/ioctl.c     | 2 +-
 drivers/nvme/host/multipath.c | 4 ++++
 drivers/nvme/host/nvme.h      | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 08889b20e5d8..42fa36ae5d9b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -683,7 +683,7 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
 		bool open_for_write)
-	__releases(&head->srcu)
+	__releases_shared(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..a275c03e7c59 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -292,6 +292,7 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 }
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
+	__must_hold_shared(&head->srcu)
 {
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
@@ -343,6 +344,7 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 }
 
 static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
 	struct nvme_ns *ns, *found = NULL;
 	int node = numa_node_id();
@@ -391,6 +393,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 }
 
 static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
 	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
 	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
@@ -434,6 +437,7 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 }
 
 static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
 	int node = numa_node_id();
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3b6754ec2edd..6bea0947eeb0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1017,7 +1017,8 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
 extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
-struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
+struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu);
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
-- 
2.53.0


