Return-Path: <SRS0=tys/=MU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E0DC4338F
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jul 2021 09:42:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E6E060F9C
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jul 2021 09:42:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0E6E060F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+EDZeT9FsWx1pqK++hljs26HMNG0k2w9VZFzmBvjUo0=; b=CXy3ZEJWNeVmU9
	y07Dyx/cyXbPkZGXbMkolq8YkboOrswrYiH8ftzp/RWYipQLyOfNuWutM6RKVDcj5CRfO6cH1A51a
	O2o0wD+5itNzlfaXbiNqvE7m297b7BPQHBJjJoKiQ9mHWH/6KZPwvTwxbUTltVblFLHPS4vJ5MdtB
	7Y1Vt9OxzX4xyCOH+NKAnVZYsIwhExOB/NqpCoN4at/qMo11r9J0BljuXMQPQfff/inh+lRxAKf9r
	TQjGR56UpLLCigVLP7EPzZeHmmPOtJJt22GfRjugfEa1dDBJZq+DSZR3BIc/4yenSosReQBasAbqT
	+VcLzWq2VojbZL+bdK3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m8g5Q-000DmN-5G; Wed, 28 Jul 2021 09:42:48 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m8g5N-000DlJ-6i
 for linux-nvme@lists.infradead.org; Wed, 28 Jul 2021 09:42:46 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16S9fhnx025480
 for <linux-nvme@lists.infradead.org>; Wed, 28 Jul 2021 05:42:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=hfLZGUrZtfhP/NHf6+tEqQuVAO8S2wf5Q7dKlK9tolQ=;
 b=Ey5GLwdMdO/B/ct+qa/TCDp64m9wKhSzVYRwj2zkdgAeTPx/lcBE3uoEzy080Dar5E+X
 Ym5u/gy7A8YI8MB3RpudCMfQ18YE3be9Sig+mpuktqVkUC2NKkQhxgg9bLZG2Xire6Ln
 dGne3j32w2oef8xVdsnXmF0HWbQPtwTfYaSt/ntIxSiIuE0qpY1HQgOQSs1tYuZD2VJy
 oh7IT69vf9qualozf3EX7Ldr2snx7IdGnKYH21fb/v3sJB23kM3roDkSOIqTBHKbu4oT
 3vJjo4BUI74mJGd9Hbrd3wEyNgR8p4TafQ1QXm492kJqHrbGqxz65hXeB5G1li9QC0k8 2w== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 3a235f6umd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 28 Jul 2021 05:42:41 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 16S9fJlB088756
 for <linux-nvme@lists.infradead.org>; Wed, 28 Jul 2021 05:42:41 -0400
Received: from esaploutdur06.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 3a235atbj8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 28 Jul 2021 05:42:41 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.160.107
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="78501397"
Received: from arwen1.xiolab.lab.emc.com ([10.55.160.107])
 by esaploutdur06.us.dell.com with ESMTP; 28 Jul 2021 04:42:41 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, sagi@grimberg.me
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet: check that host sqsize does not exceed ctrl MQES
Date: Wed, 28 Jul 2021 12:42:34 +0300
Message-Id: <20210728094234.119049-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-07-28_05:2021-07-27,
 2021-07-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 suspectscore=0
 adultscore=0 phishscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2107280055
X-Proofpoint-ORIG-GUID: A-wntD7iJpmx-czzgId9RQUIwQe3cNMQ
X-Proofpoint-GUID: A-wntD7iJpmx-czzgId9RQUIwQe3cNMQ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2107280055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210728_024245_465158_F90E0408 
X-CRM114-Status: GOOD (  14.91  )
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

Check that host sqsize is not greater-than
Maximum Queue Entries Supported (MQES) by the ctrl

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/fabrics-cmd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7d0f3523fdab..f30ffe99245f 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -109,6 +109,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	u16 qid = le16_to_cpu(c->qid);
 	u16 sqsize = le16_to_cpu(c->sqsize);
 	struct nvmet_ctrl *old;
+	u16 mqes = NVME_CAP_MQES(ctrl->cap);
 	u16 ret;
 
 	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
@@ -123,6 +124,13 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto err;
 	}
+	/* sqsize is not allowed to exceed Maximum Queue Entries Supported (MQES) */
+	if (sqsize > mqes) {
+		pr_warn("sqsize %u is larger than MQES supported %u cntlid %d\n",
+				sqsize, mqes, ctrl->cntlid);
+		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
+		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+	}
 
 	/* note: convert queue size from 0's-based value to 1's-based value */
 	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
