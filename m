Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB22CD98C5
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T/eOgbFqpnkUZh+jKNdHIkfR+XXtwqCoilqpb58FfkE=; b=ZM0/D+mbvBpXSucvH6/YAEESyj
	fZ6/sumkXmqmgDgMie6YnI/LLRwXRKOKDOCQtUl25M0/DJD7AuuJ6VVRD7a4OvldYXSy3+3PLjwhL
	aoAd7OpRzC+Cz1KoSjEZRv7K3yTsa677D1pUnOWHINrbff8OWsuJ+SQ4/9FCDHalWEx8k+zLXhsjl
	EpSSnlFfCsCTNmiroMPDQGLF+6d+3c5AN4Hf4j2G0/3HVvYHbZ7G5oLgzrC6ubYlvNek1WSQlaCAe
	rQ6BHVCBWtpS16L20neFq1G9g0M0JgNfLwWV9hwrvQXbhFeWARIRjQ/CFM4kNd91s8sfccswHq5Lk
	VQe1c9BA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhS-0000000D0qF-2XkV;
	Sun, 14 Jun 2026 13:16:30 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhP-0000000D0o4-3eAp
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:28 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmRYT3531299;
	Sun, 14 Jun 2026 13:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=T/eOgbFqpnkUZh+jK
	NdHIkfR+XXtwqCoilqpb58FfkE=; b=m9OKMJ3wMd2yZMM1NSY5xCNu9LIhzjpDo
	9O4AhE0DcD3YoYLUMcsyxnqsh9svnsVyKvkQ8fPGAMnDyYrZVbuKa+DMvTgnNL7s
	vjJJzSfumQx+derhU/KJqVOYSMsTgnDVyc4jJykvw6DNIRZ6fhJD8hD9u4V4RcH6
	378bh115t3YBdFvlxdUaWd9fJ4f7owbbeqcXGSpdiLGCvWzWRemmb6QAUE4IXbfX
	lPhXmfSKXx2iJQ1xIm0oVPpd9w+GcmfGlPcH+gUfUnuFiQ78zAZ0MguaS9zYuCXD
	ZkB+B7qnhbLUIQcRiMqNb08jsSg9RErNPqP//vdOWDz8Vu40rDjnQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h7us1a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4aBP008924;
	Sun, 14 Jun 2026 13:16:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpstfx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDFxgS17105242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:15:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A044B20043;
	Sun, 14 Jun 2026 13:15:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEB9C20040;
	Sun, 14 Jun 2026 13:15:56 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:15:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 03/17] nvme: add Clang context annotations for nvme_ns_head::srcu
Date: Sun, 14 Jun 2026 18:45:18 +0530
Message-ID: <20260614131541.2017845-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfXz9Yqsu9jE6ka
 pmB19lts3eURc67HnUbIh7yx+qhWvmcAjMr0SIchD4dia2F2qgXl9iD5OEvUaiEHtf4bM6iRx8r
 JF9Rh73CBRRlvVyYE6PAOIiKdJDrkbE=
X-Proofpoint-ORIG-GUID: Ap3v6ldgEq-kkIZQENlG46HSwCn6tHtS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX9K+TRTq8pZ8f
 XmSQjSbH380H59kSM6U/kuoRSCvEkJ6pXjlWUmZ4zZypvOr5p+NpRXyWESWVKpSz0ENUiOUwGk1
 48NlnxsGk8xAOZQ0GgHFKUuSLQjQqKuV1+rGam6gIQsZ1OToulVd6S/8zAMteFVpHpCq4h1BFPd
 oknMzea+PFkRY+gpMRz+aO0sRKhDcfpdI97aotdtV0rXknfDhEIPEsgXlhIqimLGWZjEAwoasNJ
 QKQMqIJZfjKS9/hSgu5aWyi/y8shTx9/1aFJUZEjt8YEPi8cMWAFg2PTQTfyd8gi3qWlGl8aQQ8
 6T9vomTWA6gkOEChTOCiWb3nzkSJHRRDIFWIcswa4PIhcIzuxEb3KvyVlYlHklapRmfKn4U5Y7q
 /wl1vkF2zK6fRlMnPTQPDgpE1VnWksn38XOlIh8Q7w8D792Cb7xwhr7vd++HpbYFX4BT6KSJezJ
 97RyzfmG/GRtidf+E9w==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a2ea994 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=GpToc5QlgnibPQXIAUYA:9
X-Proofpoint-GUID: MfOmzT1JF6cyMuoGJr1lgc0gdQYXsPCL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061627_908118_E541B12E 
X-CRM114-Status: GOOD (  14.42  )
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


