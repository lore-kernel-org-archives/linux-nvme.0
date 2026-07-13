Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEF41C44501
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KzKjfiOm8C5ofWaZarKqIxzGPOR4iEIRQYAY15MYzQY=; b=MEc3ejde40Q193Qwi6oxcqaXne
	ylHtqZ4sgxCVn1TyCz1R1WU5geF3srYxvvzwQPSLUmakQKTkv9SbME+bN/HeWUK/Z52N7WobyD/5v
	nkiRn3lK8ucs7HGWfhbPMRcHzCZJyUpfVjK7JDHqnfHjuN6KQwvs7Jhr+20sVpCJ1gO9OqPCOzveI
	04PpqKyU1JGRJYmwbRxdM6fOeVlKRPKYgS3JUBpJvm178H9/RVAudg9k08Vhz7/KA/1ttZstJbKWX
	xI4CTgjuTjQMkAUjDvy9cH6z4YgCyjCxB5km5XYDhfkFWl8ocKnAQp7NKDBbDblBQGF4Jz9aOf1kk
	R9s8a+aQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGG-0000000954S-1Znp;
	Mon, 13 Jul 2026 11:55:48 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGD-000000094we-06of
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:46 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6g4Oa1672462;
	Mon, 13 Jul 2026 11:55:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=KzKjfiOm8C5ofWaZa
	rKqIxzGPOR4iEIRQYAY15MYzQY=; b=hewz5+fT+OMbgHO8R1QPmN5O+H0nhlZQz
	GDou0e7qDpwfz6n9KoUj3TLLivVOVE5E7EMxJQG2re1GmDmXrQcgRhUWPE52m63B
	HHQcTORRMNgs2viVIn9YhuF4b8ioXFjyceLUz3yz8ZHfsVWoqbdpeA+JCJ+e1MHB
	TsFd9PavbGyhqh6alqMa7qVSnrW5sB/k0Cnma0bJMOVTXtwa64xYIpFybCCzo9pa
	OsiVgPkZYQgpGY6kfJKSdwZ9cqt5BNvJ1m8jyq+bMmJ6cZXNv0IXMji2kGdu0QsV
	i4UarNEKHb/XhBpXOtox2E0tk6L3SM2XUoCvBRMN4a9NpMFjaFdxQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a01xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnmjY010489;
	Mon, 13 Jul 2026 11:55:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxw6ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtV1547514042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DB1B20043;
	Mon, 13 Jul 2026 11:55:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C381820040;
	Mon, 13 Jul 2026 11:55:29 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 16/20] nvme: add context annotations in rdma.c
Date: Mon, 13 Jul 2026 17:24:17 +0530
Message-ID: <20260713115444.465704-17-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX2jEEL09yJV9+
 w1fZ4FWsss/7IESoM6ywqBmVcBv5ALXXHDaECm1t1oGQQq7+7h2GvTFFzL5Aa3wHyGof/niFF9P
 9OE25ITFzUwJz44Wduv1foCxgQovKDE=
X-Proofpoint-GUID: yD715B-JWCZfBBU4FZln2IYfqh3UiHsT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX1SiqEpFJRmZA
 zumfHSgotWBqqcRXMfgCEsmYZkzD5y8Qm530KF4h0rB4qaV/rjBA9VOjttbDIaW0ynjLKI1MkiU
 V7ecHa6StDzZPBn3WnaUj4w24vb/LwzeAhK3KXETkaFQ2UVQ/0APwqv3HZFm5bOPNd0SBwVr6OO
 lTcJvf3rasmhlawgZP/LqxZbVFAhRWgkoAuIGVG99n+TXJZ9FUvvyaRteKLyggULZWcMr7hwdcU
 C1hjeo1EkxoWCHSiddCr5RLI7SqBEEncy5lEa+MCKJvgPezinfr5qJN01fRD6F+OowaWftna/5D
 sjIIqmiZMvBYCAcmk/+PzhR3X5kTqAdKaVo8JQdcCM/x21zqefs2xBQUiL8cjFTfBBZf71LBPmH
 psOI9iAvT8QrS/IED3zC2RQ0gHmiSZLvWlYioDr6u6stKvLBxzYLsCx/ti9F7LpMbrqZVc8fmam
 +TbiDSpXyAOOy5FD2JQ==
X-Proofpoint-ORIG-GUID: wCU4fWLMGx79F85VaNsK021DQGIizjhE
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a54d238 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=pOGEuHxQbtI5uFpJoR8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045545_185681_5097530A 
X-CRM114-Status: GOOD (  18.44  )
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

device_list and nvme_rdma_device::entry are protected by
device_list_mutex. Define device_list using
LIST_HEAD_GUARDED(device_list, device_list_mutex) and annotate
nvme_rdma_device::entry with __guarded_by(&device_list_mutex) so that
Clang's context analysis can validate accesses against the corresponding
locking requirements.

Similarly, nvme_rdma_ctrl_list and nvme_rdma_ctrl::list are
protected by nvme_rdma_ctrl_mutex. Define nvme_rdma_ctrl_list using
LIST_HEAD_GUARDED(nvme_rdma_ctrl_list, nvme_rdma_ctrl_mutex) and
annotate nvme_rdma_ctrl::list with __guarded_by(&nvme_rdma_ctrl_mutex).

It is safe to initialize nvme_rdma_ctrl::list while allocating the
controller object because the list entry has not yet been added to
nvme_rdma_ctrl_list. Annotate the initialization with context_unsafe()
to suppress the corresponding Clang context analysis warning.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/rdma.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..bf392035037a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -39,11 +39,18 @@
 #define NVME_RDMA_METADATA_SGL_SIZE \
 	(sizeof(struct scatterlist) * NVME_INLINE_METADATA_SG_CNT)
 
+static DEFINE_MUTEX(device_list_mutex);
+static LIST_HEAD_GUARDED(device_list, device_list_mutex);
+
+static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
+static LIST_HEAD_GUARDED(nvme_rdma_ctrl_list, nvme_rdma_ctrl_mutex);
+
 struct nvme_rdma_device {
 	struct ib_device	*dev;
 	struct ib_pd		*pd;
 	struct kref		ref;
-	struct list_head	entry;
+	struct list_head	entry
+		__guarded_by(&device_list_mutex);
 	unsigned int		num_inline_segments;
 };
 
@@ -112,7 +119,8 @@ struct nvme_rdma_ctrl {
 
 	struct delayed_work	reconnect_work;
 
-	struct list_head	list;
+	struct list_head	list
+		__guarded_by(&nvme_rdma_ctrl_mutex);
 
 	struct blk_mq_tag_set	admin_tag_set;
 	struct nvme_rdma_device	*device;
@@ -132,12 +140,6 @@ static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
 	return container_of(ctrl, struct nvme_rdma_ctrl, ctrl);
 }
 
-static LIST_HEAD(device_list);
-static DEFINE_MUTEX(device_list_mutex);
-
-static LIST_HEAD(nvme_rdma_ctrl_list);
-static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
-
 /*
  * Disabling this option makes small I/O goes faster, but is fundamentally
  * unsafe.  With it turned off we will have to register a global rkey that
@@ -2254,7 +2256,10 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 	if (!ctrl)
 		return ERR_PTR(-ENOMEM);
 	ctrl->ctrl.opts = opts;
-	INIT_LIST_HEAD(&ctrl->list);
+	/*
+	 * Safe to init list while allocating ctrl object.
+	 */
+	context_unsafe(INIT_LIST_HEAD(&ctrl->list));
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
 		opts->trsvcid =
-- 
2.53.0


