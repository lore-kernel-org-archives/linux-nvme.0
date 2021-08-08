Return-Path: <SRS0=j25R=M7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9888C4338F
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Aug 2021 15:06:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 868FF6023E
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Aug 2021 15:06:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 868FF6023E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=IF/dwzfq9ip4XoYsWkEiTXBDCpo2bfxQWOFe63ZIJZM=; b=P7pyn5Wybn2w9c
	2GEYadStegaxqfn5C5dqthhhNlVUTSlfymYF8KHjQBb1Yt2HRENduhojd9ijZzjJtKBtC6Kg5vaHj
	DIK5z8Ugv7tbi8wdPO8QvSQVO5CMpMSvJKjlgPTX6+vjzsC+zx6R1G0shXTfcmRwmNZkXVefdw30S
	CG6h0YohJOtQfio8vSemlK4qeSptEk+12T7jiz1wlaDX5dUw6VL7Vr7q0R33FdRrROHvywXx6uuV5
	EjthrQN0PloRgDqSp1ZnCL+hi6YDohopSx388PyX0cidE5diKhJeTuKLYkZgzHa+k2osFcI3aM5FS
	wWwYVHAQOXMGFOrp5YsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mCkNd-00G0St-KV; Sun, 08 Aug 2021 15:06:25 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mCkNa-00G0SL-4i
 for linux-nvme@lists.infradead.org; Sun, 08 Aug 2021 15:06:23 +0000
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 178F3Uix003337
 for <linux-nvme@lists.infradead.org>; Sun, 8 Aug 2021 11:06:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=x6Qw4UBT3nXLPn5ovDcixE2RHnrfckjyljVfcM6O3OQ=;
 b=KH0/58+HVdnReLmwws4OEu7mAkea7sc785/I/9OZ7p9cGdYfZ4bJ+A+alVGQkrc6kppu
 liqnyyXxNjapTJkAXIE4guNJ6YF6mUyBVQmmuZIZA+a6iJxI/UIbBrmyG1FI0ODVKzGR
 604aXT5uxI5ovvoKnkkPxpvqyQ04qJITxEw9JpquBeb6ssB7ZTxxugXNJlyvNGZH+mqE
 1WpCXVBcoA8Anrp4VDYLBm0muL99iL03hdH7clEJ+BGshevFKVvhBS8drplvrPVOw+AE
 3x88yRKBWFe1GiiZjmC5SZVnOTKX3hrsRgOspTiLkGOwNRIFPHnEJ3T1D6BOTVNtcVah XA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 3a9nbf2f04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Sun, 08 Aug 2021 11:06:21 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 178F18P7178654
 for <linux-nvme@lists.infradead.org>; Sun, 8 Aug 2021 11:06:21 -0400
Received: from esaploutdur02.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 3aa7dfmjf6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Sun, 08 Aug 2021 11:06:21 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="82235498"
Received: from vd-amite.xiolab.lab.emc.com ([10.55.225.216])
 by esaploutdur02.us.dell.com with ESMTP; 08 Aug 2021 10:06:19 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet: avoid duplicate qid in connect cmd
Date: Sun,  8 Aug 2021 18:06:15 +0300
Message-Id: <20210808150615.22853-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-08-08_04:2021-08-06,
 2021-08-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 mlxlogscore=999 phishscore=0 adultscore=0 impostorscore=0 mlxscore=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108080094
X-Proofpoint-ORIG-GUID: gg1sbn1_JlDKt2f-66CUguoBL41dXuWy
X-Proofpoint-GUID: gg1sbn1_JlDKt2f-66CUguoBL41dXuWy
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 malwarescore=0
 mlxscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108080094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210808_080622_285029_1C788428 
X-CRM114-Status: GOOD (  17.60  )
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

According to NVMe specification,
if the host sends a connect cmd specifying a queue id
which has already been created, a status value of
NVME_SC_CMD_SEQ_ERROR is returned

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/core.c        |  1 +
 drivers/nvme/target/fabrics-cmd.c | 20 ++++++++++++++------
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ac7210a3ea1c..66d05eecc2a9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -802,6 +802,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
 		 * controller teardown as a result of a keep-alive expiration.
 		 */
 		ctrl->reset_tbkas = true;
+		sq->ctrl->sqs[sq->qid] = NULL;
 		nvmet_ctrl_put(ctrl);
 		sq->ctrl = NULL; /* allows reusing the queue later */
 	}
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7d0f3523fdab..70ba33a42da9 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -111,12 +111,6 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	struct nvmet_ctrl *old;
 	u16 ret;
 
-	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
-	if (old) {
-		pr_warn("queue already connected!\n");
-		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
-		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
-	}
 	if (!sqsize) {
 		pr_warn("queue size zero!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
@@ -124,6 +118,19 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		goto err;
 	}
 
+	if (ctrl->sqs[qid] != NULL) {
+		pr_warn("qid %u has already been created\n", qid);
+		req->error_loc = offsetof(struct nvmf_connect_command, qid);
+		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
+	}
+
+	old = cmpxchg(&req->sq->ctrl, NULL, ctrl);
+	if (old) {
+		pr_warn("queue already connected!\n");
+		req->error_loc = offsetof(struct nvmf_connect_command, opcode);
+		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
+	}
+
 	/* note: convert queue size from 0's-based value to 1's-based value */
 	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
 	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1);
@@ -138,6 +145,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		if (ret) {
 			pr_err("failed to install queue %d cntlid %d ret %x\n",
 				qid, ctrl->cntlid, ret);
+			ctrl->sqs[qid] = NULL;
 			goto err;
 		}
 	}
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
