Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1DF2C43602
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9FNiS+qHee7s48IvuXeYqE5WIkzPeBsrCCmNUvAAqbI=; b=KV6QxvxjB/3LBKjE5cxt7Vwg7W
	JQLRuWBCFfg4ldhzOT2QZUJN4YuzX87hc9nUBgvB9f+Bg9H+nHiqewVpYjM7ielA3/Ew3GLtyiIqI
	uGqP6RU+zWZ9WAsgNq9HiZ28UCQ3doFsZxkFbA58Lfd3sinz2JFIr9ES/CgUEWj6SYFphsRzP1Pl8
	sa9x1DlD+FPeRHuYoJFYCz0sHD/8NUmZ52QMivM6REeCwL5WIurGoI4C3TYaynST0iFL4FogvR5Uu
	Sma6q9p7KPDza+deQjRSIld83SWIV7s4biMAAxb5tplib34AGpVdsF93xjjhsvMJSIDFWlrTrHZg7
	SnPQebvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk70-0000000ChqQ-1Smb;
	Mon, 06 Jul 2026 14:15:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk6x-0000000Chog-0W2s
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:15:52 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIHBd4094075;
	Mon, 6 Jul 2026 14:15:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9FNiS+qHee7s48Ivu
	XeYqE5WIkzPeBsrCCmNUvAAqbI=; b=flb8gMXdMpDpOaOCznwCcdDJz7b3yZnqb
	nu/mx/x178hU4S9UA6teZkBd47YHDOCdF0IJ3iBxJdVf47tozwdCrvi1w1EhD4j8
	Uk95OIDxhujkBz73eG0SXxr80aWckbxaD0Z+PMMZoDUe54drvwq1+LKK5o60KiuD
	lzxkDOky6J0eh7WCuB2ULshxwnG5X7L3OXQXKoK3zOwOUQWWiLvl87/+RFlYxBhv
	r/HwkUj9/3tFkVoEqm/KNZqFUmvRA0ZXZAQ1AKbC3odu7FEBKOMq0uqoE0UpYdh0
	06I0gj4GN941JsfR9T/aFKdFlQz95Ku690E7bokoBX8rp0FL1OOAA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4hsrj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4jkt001438;
	Mon, 6 Jul 2026 14:15:41 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvx2ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:15:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EFbQk29164284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:15:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DF63620043;
	Mon,  6 Jul 2026 14:15:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F191520040;
	Mon,  6 Jul 2026 14:15:34 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:15:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 03/18] nvme: add context annotations for nvme_ns_head::srcu
Date: Mon,  6 Jul 2026 19:44:05 +0530
Message-ID: <20260706141452.3008233-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: cue9HKu7L_4rUONqBC2jLsTFOS08U8_M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX0gzIXiKJfN02
 gzG4oWNzCcQLKjsmuVouS0c/AJ07K1vQksAMt47MTXMcx8jmi3OulJ276f6Q7Ga+sEkokdOEpn+
 fgLaFxoaFiB/vGtNSDsNJINSgKU8TVaUkrOrWdNvGmxO6cHOn0ODIp3F9sw7UMEyVX4DaIpMiZC
 29baGRKtZklo/lISenq/bAO4XQnaJX/ZEzDc2smVECewjqJhxdN6/HDl/RJ4JTEVPly0XwhWAhj
 BTssh3GwvWiRo7L/9UeBMESXQbqG2lLwtGm/rKo5Tdbwssd8IOI3HDFydBeadYCRkOvoMCzrouf
 xig/GnNqkY/FUFtzaW7WcovGpQPa+HMX+B03ALWMRgkz2n5CigyODPhaDE2LBJPMUhe0RrHSnZR
 g0/68T7tFbHsLlIYErE2pgNt6/BvxGsTEjqc/SJ35l3rtrxVoLY5Xr4G/py0UXD+GnMHoHaaBUs
 ydHyR6RFc4eJAZe4UbA==
X-Proofpoint-ORIG-GUID: M6YMZ5RBe0iHUXiCD6VUpFhosfKfPuLl
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bb88e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=GpToc5QlgnibPQXIAUYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX1eGSg8p5SnU8
 pd2axyAoBSxMtk8H2sm8WF8MAkVr29FLpP/S0/kpbhHh/68QFWqOnOp0Go3rOHF+yEz+XHKZ/aq
 zgd+2Lz2c+AEIcn6JGvPR+tM1qdP+pk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071551_345373_F8F7EF22 
X-CRM114-Status: GOOD (  16.59  )
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

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/ioctl.c     | 2 +-
 drivers/nvme/host/multipath.c | 4 ++++
 drivers/nvme/host/nvme.h      | 3 ++-
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 664216eece4a..406e09a79c89 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -692,7 +692,7 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 		void __user *argp, struct nvme_ns_head *head, int srcu_idx,
 		bool open_for_write)
-	__releases(&head->srcu)
+	__releases_shared(&head->srcu)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330..e4ec5d5e2df1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -306,6 +306,7 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 }
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
+	__must_hold_shared(&head->srcu)
 {
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
@@ -357,6 +358,7 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 }
 
 static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
 	struct nvme_ns *ns, *found = NULL;
 	int node = numa_node_id();
@@ -405,6 +407,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 }
 
 static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
 	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
 	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
@@ -448,6 +451,7 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 }
 
 static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
 	int node = numa_node_id();
 	struct nvme_ns *ns;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fba2d7674623..b7c3ba9c0fc1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1032,7 +1032,8 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
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


