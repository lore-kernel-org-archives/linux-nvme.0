Return-Path: <SRS0=DVYa=NY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 948A0C432BE
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 08:54:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49DAE610C9
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Sep 2021 08:54:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 49DAE610C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=636Lsrsy25jN0Gve54qBhLILyT2y0s1sv4tJZpEOvGg=; b=2xcztCRBDTsUMR
	VxjPDl1fW75bDpCeeSokru/ALGdMQwoAr9pMNAdDNrHbMUeeovv9LtewtRVAelgTM63xdwexdI2Pp
	pD7Jlez4DX1BZczVq4L4Dkc9L/YXwZeavo4zImjWprPDNtp5rGrdWgwUbaEvUAKTyU65gkEL23Mmz
	6OOPLNTIiyjMHUl0kyITkCjayNfdxSUDab3x/ONuzzSDK91bylzRrzZRancf+TsOOVlyxhUvrI40S
	h30zyZzstN95AdGt5NzbJD60J9Hb65TT89Eq0QIQZ33lYE9Dje4Exq9TUp7PFVVL01LWDoaBF5oeL
	QxnjtmgrYWVwQe1MDGDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mLiTo-0090x7-Aa; Thu, 02 Sep 2021 08:53:52 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mLiTh-0090wj-Us
 for linux-nvme@lists.infradead.org; Thu, 02 Sep 2021 08:53:47 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1828cfKD004871
 for <linux-nvme@lists.infradead.org>; Thu, 2 Sep 2021 04:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=SUuSmV9fpNu5ZiDTn2Gn6Q9Cyyjo+mse0xlz/ggojxs=;
 b=YF9zb3VYsZkRsfXLn9n9/67S1toPpC5mRC//BjLeXsQDhX4BcGkukQGHKuaFvnhaGRgW
 I14XuitFrsRDP8hPeBuYKAlortRCXaNG/uRByERzLHNe1wjR7P5cIfmj2LpxOE2HxHuh
 gjeTs+nU6FjQYZoi7kie1MkKsZwIOl1M767DXLnfmcKDPKfuIzeNH4VdvVlU9z37BRZf
 zROcxEsFpHGmtIzTdDBzt8LVuAZ6bqOirtSqaAjSZPxwk9rmEvPomMdxW57lgXT+wjO5
 CvrVItKrKFUcdMF7u+bio1adOs9ZRgzGuBN9Rb3lxevSURME9BJIlVPwVCsitnZRoenn LA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 3atdy6jpsr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 02 Sep 2021 04:53:40 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 1828fNFn136257
 for <linux-nvme@lists.infradead.org>; Thu, 2 Sep 2021 04:53:39 -0400
Received: from esaploutdur06.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 3ate0gu0mn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 02 Sep 2021 04:53:39 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="88938399"
Received: from vd-amite.xiolab.lab.emc.com ([10.55.225.216])
 by esaploutdur06.us.dell.com with ESMTP; 02 Sep 2021 03:53:37 -0500
From: amit.engel@dell.com
To: sagi@grimberg.me, hch@infradead.org, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet: return Invalid Log Page status code for unsupported lid
Date: Thu,  2 Sep 2021 11:53:33 +0300
Message-Id: <20210902085333.32107-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-09-02_03:2021-09-01,
 2021-09-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 lowpriorityscore=0 phishscore=0
 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2108310000 definitions=main-2109020054
X-Proofpoint-GUID: X5m21KyoIe6VGkVGQ423Oaby6WqFEQhb
X-Proofpoint-ORIG-GUID: X5m21KyoIe6VGkVGQ423Oaby6WqFEQhb
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020054
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210902_015346_207429_731445F4 
X-CRM114-Status: GOOD (  18.14  )
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

In case of an invalid or not supported log page
return NVME_SC_INVALID_LOG_PAGE

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/discovery.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index aa6d84d8848e..5dcda2c87fdd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -339,7 +339,7 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
 	req->error_loc = offsetof(struct nvme_get_log_page_command, lid);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
+	nvmet_req_complete(req, NVME_SC_INVALID_LOG_PAGE | NVME_SC_DNR);
 }
 
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 7aa62bc6ae84..fdd52dbdd00f 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -176,9 +176,11 @@ static void nvmet_execute_disc_get_log_page(struct nvmet_req *req)
 		return;
 
 	if (req->cmd->get_log_page.lid != NVME_LOG_DISC) {
+		pr_err("unhandled get log page cmd with lid %#x from ctrlid %d\n"
+			req->cmd->get_log_page.lid, ctrl->cntlid);
 		req->error_loc =
 			offsetof(struct nvme_get_log_page_command, lid);
-		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		status = NVME_SC_INVALID_LOG_PAGE | NVME_SC_DNR;
 		goto out;
 	}
 
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
