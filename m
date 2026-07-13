Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9BBC43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FR6j68Zkk2rMQiUg0dCwX5UmoEHpYnxTCiV0hVRmlE0=; b=IgTDDgnPYcn/bpz3DW3JJ/pStg
	tfUrtgaF+oLB9dOuYR8Nc0WciItlKuXdpnDngIvZ6Pxw2bhnhbYTcgzq3jrGVLYRXfVRxTk3uc4eH
	sz6utmVkK8VtvFF8nON0YDk8sRwYKf3w720hv9/60iBis4c3Ddu5YeymuTLSHXCC5I6gvSiay6hCv
	UMwVGSAHGtgD/aD/+3PwZA5d5XkFRpPcOZNs1INzDEsGbDJb9I53u9iaKEFWmcqhVU4+7x1NXbdhe
	BNcVbEtG2pvZRIfzNwa21QF/8tko2l2+9mr4jvJCgW1eXxH5J7IywbHpXhZFo2eeLu/1lVtE1GvC8
	Y/b7tXow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFt-000000094VS-3zMn;
	Mon, 13 Jul 2026 11:55:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFFo-000000094Qc-2lRg
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:23 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6fksm1731610;
	Mon, 13 Jul 2026 11:55:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=FR6j68Zkk2rMQiUg0
	dCwX5UmoEHpYnxTCiV0hVRmlE0=; b=BrTzR7PuYHLzyVwx1jJqUXSv78WnHsmHz
	JbvzVQPYJqPak7YpGXL6z4s9UzYywuKLmkoUiE2F/3rJGxryEExhsxey8ajsU1vS
	7Cr/QfeWeEqERmxCeCqphsa6CIXRnBG/xtIY92AD9N41JU1bV2gyDBDbCX2AJRat
	4YfJaxr2Fa2Y6uTTb3NKRdX7Ofk6jbEr9VdC3HTfqyjuVxPbq5OT/P/QWpmA7hJp
	+zTmZKEAPr6dWhkPcEuGAInhtbQEIemDXR7sNOLhZ4scS3XBvkyVkoDwoBOfF2B1
	8HCK4UOABI2ilExLmO5jol9QxEQjkDw9yyXphO2tZoFkuuqAQa3zw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbg403-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnilm023639;
	Mon, 13 Jul 2026 11:55:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nh5cvr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:12 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBt8XF40436034
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 107802004B;
	Mon, 13 Jul 2026 11:55:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4605020040;
	Mon, 13 Jul 2026 11:55:06 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:06 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 05/20] nvme: add context annotations for nvme_ns_head::srcu
Date: Mon, 13 Jul 2026 17:24:06 +0530
Message-ID: <20260713115444.465704-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a54d221 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=GpToc5QlgnibPQXIAUYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX1e4i3cNsHAgL
 1i1y6YYttne7DpN2Gtveti5vtGOSlN/SqldywRsh1etVyNyaM3Jz0jjj8blOhs2cYBBgIXgg0TL
 Af8hfxP1t+CIqzVnOLEx1+DxEijWJ83BDI6lIpWEc0g+C8T6630T5l6yafmapCWMRy74rvtg47D
 mOxIsoRz1y+4kunwoXCBYaUqHmQrQDnRUp35wpAIkWscP0hLajiigvt04KC93c1KYfHfjP4G/Ce
 8O2kjq+x+uNzrqiBiKyHwni2RlE/7WQOkDqIz6j2L6pWLhWkVqOreBAxYe2YscNG+4ndrGNxSu2
 CmTRv4UR4uPiiFxR1vcGmPOW3ohRzkbK7FZUb2psyPAMKBf9ANf+wV76DVqtsAvu/5tnDN4IVxk
 W7z2wt8B/CDjfmJZSE1qlJEV2iQWX7EPNgQT9vUJOqv8oukgC5yvywT8w9XDoR46wnvXzEe1i/Z
 htCLFDS5RjY/ybo3Rug==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX5bcazKp0i+g2
 gA8f3wWgXRDx9RZoJhuNss14Bp8m2cFchTNqWeVfNVVTozVsxoeRjr7wiFaWRxviBK5ADFiQTvM
 1pSoHTWxNR2z6qQQiu2TqqqodTDVVP0=
X-Proofpoint-GUID: 9h9neOdAzg5KahqyZgcpqIxHiS7EcUln
X-Proofpoint-ORIG-GUID: FMfV-NW6_1eENQyajYXOE5M-EC8QBAC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045520_819988_129B66CA 
X-CRM114-Status: GOOD (  16.84  )
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
protected data through srcu_dereference() or list APIs which iterate
through rcu protected list and therefore require the caller to hold
head->srcu. Annotate these helpers and nvme_find_path() with
__must_hold_shared(&head->srcu) so that Clang's lock context analysis
can verify the SRCU locking requirements across the call chain.

Also update nvme_ns_head_ctrl_ioctl() to use __releases_shared()
to match the shared SRCU read-side lock acquired through
srcu_read_lock().

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/ioctl.c     | 2 +-
 drivers/nvme/host/multipath.c | 6 ++++++
 drivers/nvme/host/nvme.h      | 3 ++-
 3 files changed, 9 insertions(+), 2 deletions(-)

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
index 9b9a657fa330..fd2c2a5b1e33 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -306,6 +306,7 @@ static bool nvme_path_is_disabled(struct nvme_ns *ns)
 }
 
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
+	__must_hold_shared(&head->srcu)
 {
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
@@ -348,6 +349,7 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 
 static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 		struct nvme_ns *ns)
+	__must_hold_shared(&head->srcu)
 {
 	ns = list_next_or_null_rcu(&head->list, &ns->siblings, struct nvme_ns,
 			siblings);
@@ -357,6 +359,7 @@ static struct nvme_ns *nvme_next_ns(struct nvme_ns_head *head,
 }
 
 static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
 	struct nvme_ns *ns, *found = NULL;
 	int node = numa_node_id();
@@ -405,6 +408,7 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 }
 
 static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
 	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
 	unsigned int min_depth_opt = UINT_MAX, min_depth_nonopt = UINT_MAX;
@@ -448,6 +452,7 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 }
 
 static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
 	int node = numa_node_id();
 	struct nvme_ns *ns;
@@ -473,6 +478,7 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 }
 
 static bool nvme_available_path(struct nvme_ns_head *head)
+	__must_hold_shared(&head->srcu)
 {
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


