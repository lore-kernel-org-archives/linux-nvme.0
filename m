Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D31C4CD98C5
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jWOrgkP/ElG4P/CWAk3mG0Vv2fs1yZGM6tdDgK4E5Hc=; b=VKDN2JkH1hrvaxXs2v/rGncFqk
	yDH93Z/GZagoyFXh83rRLRUg4K10zcqabUmyM8uAncQg+pb1/GNPkIgplM79OfsOHnUs/1DGoE4tH
	DSi7DedIz8ks8FvP0ihtt2bvyQXErx4dTz7qqGYRN03VCrClx85sjHIltHGYyg+0w6zw93XgF4cl9
	SPZ2QyEX2BnTUczzilkZwVgxwNARrIMKQNXKTDZRnMoMXHkumf7Mz8WYsZdFIfkKv4FA5PjPXAgrx
	KRJN05EO3Swcyghnv9+Df9zPUst+pAg8FTN0ByqsJP72nIMULQ3MdpYOdT9jRevcAC+fkvejIA+fg
	ijQDs5RA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhh-0000000D17b-2JPv;
	Sun, 14 Jun 2026 13:16:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhe-0000000D13U-3eAx
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:44 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmDHJ3477529;
	Sun, 14 Jun 2026 13:16:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jWOrgkP/ElG4P/CWA
	k3mG0Vv2fs1yZGM6tdDgK4E5Hc=; b=URObehy3qOa10+joOrE6U31AuhiPZxmnP
	oZr9889SXFyOVkgC/I8VsC4L3HN49MJy7O+HJsYG1daD1+/5dmGlcIgyUPyHdkEF
	+0OZCJ9BWGGdyWDtzdQaAaDVTKEd20fCXENSW8nAQq3fUHRZVUzKSOK2Jug85Xqt
	wd9gqPYPEqFyDJOHqlIJUZsRvsB/k92nlel1B9fd2jVDEPEsmLtSkL4Yr4FS5ExO
	GRkXyUSQcPQ8GSDQzrrrjxvJ1ZYC9bWulqnIQyfGQv+ye87u3afYK0o60Q9ywrQ1
	Ub1LlVq0Tz6SGzF3gJ3rnOpK5EY149nn2VFDVNmO1Gw+aBoYPRcdw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nbm72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:35 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4brU018158;
	Sun, 14 Jun 2026 13:16:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvsrjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGULJ39780676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:30 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2CE4E2004E;
	Sun, 14 Jun 2026 13:16:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1AEF20040;
	Sun, 14 Jun 2026 13:16:27 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:27 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 13/17] nvme: add Clang context annotations in rdma.c
Date: Sun, 14 Jun 2026 18:45:28 +0530
Message-ID: <20260614131541.2017845-14-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2ea9b3 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=HV4-gxy7KN9BB8ERQHUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX29d4SlsO2dTI
 ZZQvfq2X54fJ/zNiuF7h1C7AR5M9NS4wxxMeD/lFk+aZrgLu7qLGXIJ6kZ5xDyF/wgamQxqBFg2
 99hEU9IMwx3ky0cInmC2NfIEZW4B+xVg7AqIQGu4ZvHMAMpAYHeA0YiEstMnWidx97ZY9j5ushr
 qlpR0EeaeWx5lg2x2oHSl8bkq+0ijzjx/7cI8s7Gc0SqQhuR/44e01YFmv0wko2OOR5vZejCWKA
 V6NWEYWrG7zs+/XRX+/jNZTBQLMq5Ddmmf2UxYa/v9HDqV7MFl8ijNL5VJcOROKzPoA+gm9Anwu
 laG4myMQYuCpZ3ynRJ4ZVH4TEaLSK3/93H8bsK7+2VAqPL29l6Urao2JMWiwLUrB9y62SfcPaD/
 2f89C3zNY0623klT7JmuKvT++XPnDPf+PGu7FnVKnls+NZJcKlsIYW3qsizjihw+u38wFw44CHa
 bRqzvtWWwsaztmcOHxQ==
X-Proofpoint-GUID: dldA4TksDR92whVsgAGAJX67PvTrQCld
X-Proofpoint-ORIG-GUID: 64aQQ4m8KjPZPIO4aRCnUFJMJEJER-oi
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfXwQvjo1J2XOgu
 dyXijXm9Zn78AdgruHgUFbAfo+8UHkDjXyFFqr1KgBz0RcJIkEie+S2oDjJZjJ8g5nknN3kuBbS
 +BWbsVeYjrayH+Gw4a2EaPTwEocUkow=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061643_405619_BE4A5F4A 
X-CRM114-Status: GOOD (  16.49  )
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

The device_list and nvme_rdma_device::entry are protected by
device_list_mutex. Annotate both with __guarded_by() so that Clang's
context analysis can validate accesses against the corresponding
locking requirements.

Similarly, nvme_rdma_ctrl_list and nvme_rdma_ctrl::list are protected
by nvme_rdma_ctrl_mutex. Annotate them with
__guarded_by(&nvme_rdma_ctrl_mutex).

It is safe to initialize nvme_rdma_ctrl::list while allocating the
controller object because the list entry has not yet been added to
nvme_rdma_ctrl_list. Annotate the initialization with
context_unsafe() to suppress the corresponding Clang warning.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/rdma.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f77c960f7632..2c55f05f7550 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -39,11 +39,17 @@
 #define NVME_RDMA_METADATA_SGL_SIZE \
 	(sizeof(struct scatterlist) * NVME_INLINE_METADATA_SG_CNT)
 
+static DEFINE_MUTEX(device_list_mutex);
+static __guarded_by(&device_list_mutex) LIST_HEAD(device_list);
+
+static DEFINE_MUTEX(nvme_rdma_ctrl_mutex);
+static __guarded_by(&nvme_rdma_ctrl_mutex) LIST_HEAD(nvme_rdma_ctrl_list);
+
 struct nvme_rdma_device {
 	struct ib_device	*dev;
 	struct ib_pd		*pd;
 	struct kref		ref;
-	struct list_head	entry;
+	struct list_head	entry __guarded_by(&device_list_mutex);
 	unsigned int		num_inline_segments;
 };
 
@@ -112,7 +118,7 @@ struct nvme_rdma_ctrl {
 
 	struct delayed_work	reconnect_work;
 
-	struct list_head	list;
+	struct list_head	list __guarded_by(&nvme_rdma_ctrl_mutex);
 
 	struct blk_mq_tag_set	admin_tag_set;
 	struct nvme_rdma_device	*device;
@@ -132,12 +138,6 @@ static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
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
@@ -2252,7 +2252,10 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
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


