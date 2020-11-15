Return-Path: <SRS0=Y1qY=EV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DDCAC2D0E4
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2020 12:20:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE25D22384
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Nov 2020 12:20:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="W8Exd9iq";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="Jbj1UIbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE25D22384
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i2vXJ15NVtI0XEmwjSFR7ZHfOwLU8tKCCMvmCRUFBeU=; b=W8Exd9iqHFJe52UL1p+SjF/G7w
	BPEgva+nht/kWLocu2FXdX0RJqGhkzZdsk3AdF53vymQ4eFWeeVjkMAnp3/gOcffx0BMN3uvBzz31
	froKCD+8M9HL54exSwyhO1+jfpfDB4M4J28t0QPQywnUfoqi9Ct4I2TuvNAzWsqA9qjYn3H6jmTWk
	zptURBsq0sMSlkJ5ThQ5CGNVHI0GO9pJ2MhKBpTWWFL50Ie40YcFMK5p5BIE/4K6m2OiN5fkcIbUM
	FTxkwYTbBwkW+4LatFuZvA3ARU2QUzeih7+xFYEikC8llJLh1kzvub8gxacGGvaBNtlR64cD9W3JH
	XjQhprKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keH0k-0001zv-Ll; Sun, 15 Nov 2020 12:20:02 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1keH0i-0001zM-Ls
 for linux-nvme@lists.infradead.org; Sun, 15 Nov 2020 12:20:01 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AFCGfPJ011824
 for <linux-nvme@lists.infradead.org>; Sun, 15 Nov 2020 07:19:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=M1ygb1pbTG7BMIZ47QX2/j/hO1uL6hvL5XX36BmskgE=;
 b=Jbj1UIbpOdw0XZsxIoxW4OcacPED3nvNwDdJyH/jOF9PMmD+goqFMhkV8bweF2EWALDW
 GwNVXZk0OZmFSGw2mtBta8c1dRNeg8jcKD08QrNNP/act2yISllWhLTOwfPC+vV9qkre
 eoYRTEUJxWEcWdnsOpdeGPK0w3dAUwH5H9pel/qL5Ny7riiIhLrm3zvzLx+2XQq/Mu2s
 omVRvkuP8WIojTCHSbPjSs0gV/9KgHNehpBmXQk6he1bAcXUCkmvQA93Vn9RzT01pJwC
 OYHWjkFemf/MW75GHx1L/sdTyHnif1vsruNgJ1yVX/Zfy3UzBU+gkZo8hS1WBQ7BpWlv 2w== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 34tb93265r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Sun, 15 Nov 2020 07:19:56 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 0AFCHbvq088281
 for <linux-nvme@lists.infradead.org>; Sun, 15 Nov 2020 07:19:56 -0500
Received: from esaploutdur04.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 34twk03a5f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Sun, 15 Nov 2020 07:19:56 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.160.55
Received: from unknown (HELO arwen6.xiolab.lab.emc.com) ([10.55.160.55])
 by esaploutdur04.us.dell.com with ESMTP; 15 Nov 2020 06:19:54 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: remove unused ctrl->cqs
Date: Sun, 15 Nov 2020 14:19:51 +0200
Message-Id: <20201115121951.11302-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.16.2
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=2 clxscore=1011 priorityscore=1501 mlxlogscore=944
 phishscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011150077
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 adultscore=0
 suspectscore=2 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011150077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201115_072000_890034_8D5AF4FB 
X-CRM114-Status: GOOD (  18.97  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: elad.grupi@dell.com, amit.engel@dell.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit <amit.engel@dell.com>

remove unused cqs from nvmet_ctrl struct
this will reduce the allocated memory.

Signed-off-by: Amit <amit.engel@dell.com>
---
 drivers/nvme/target/core.c  | 15 ++-------------
 drivers/nvme/target/nvmet.h |  1 -
 2 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 957b39a82431..8ce4d59cc9e7 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -757,8 +757,6 @@ void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 {
 	cq->qid = qid;
 	cq->size = size;
-
-	ctrl->cqs[qid] = cq;
 }
 
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
@@ -1344,20 +1342,14 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (!ctrl->changed_ns_list)
 		goto out_free_ctrl;
 
-	ctrl->cqs = kcalloc(subsys->max_qid + 1,
-			sizeof(struct nvmet_cq *),
-			GFP_KERNEL);
-	if (!ctrl->cqs)
-		goto out_free_changed_ns_list;
-
 	ctrl->sqs = kcalloc(subsys->max_qid + 1,
 			sizeof(struct nvmet_sq *),
 			GFP_KERNEL);
 	if (!ctrl->sqs)
-		goto out_free_cqs;
+		goto out_free_changed_ns_list;
 
 	if (subsys->cntlid_min > subsys->cntlid_max)
-		goto out_free_cqs;
+		goto out_free_changed_ns_list;
 
 	ret = ida_simple_get(&cntlid_ida,
 			     subsys->cntlid_min, subsys->cntlid_max,
@@ -1395,8 +1387,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 out_free_sqs:
 	kfree(ctrl->sqs);
-out_free_cqs:
-	kfree(ctrl->cqs);
 out_free_changed_ns_list:
 	kfree(ctrl->changed_ns_list);
 out_free_ctrl:
@@ -1426,7 +1416,6 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_async_events_free(ctrl);
 	kfree(ctrl->sqs);
-	kfree(ctrl->cqs);
 	kfree(ctrl->changed_ns_list);
 	kfree(ctrl);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e89ec280e91a..592763732065 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -164,7 +164,6 @@ static inline struct nvmet_port *ana_groups_to_port(
 
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
-	struct nvmet_cq		**cqs;
 	struct nvmet_sq		**sqs;
 
 	bool			cmd_seen;
-- 
2.24.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
