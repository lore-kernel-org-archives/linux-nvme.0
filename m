Return-Path: <SRS0=qSen=Z3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_SPACE_BRACKET,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A28C43603
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 13:23:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4219C20659
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Dec 2019 13:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BvkvtCeb";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dell.com header.i=@dell.com header.b="kUMTZBJL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4219C20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=Dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=9rJHD5QTrRlCXxaQ8BP7OrS+JJItXbb9+12evJlw5EM=; b=Bvk
	vtCeb7LezoF5nVnskzqGnsC/9UPs5HgChNG9LDU6SoTssvSx7lUZ0gO1sCmYH6QFv0WlMCIxY6VYa
	Y+FOSPXPt4EvKon4/zsQm3WagSN3uNdK8Gr3VBbQ4s+ankTKttvOP287Fp30xAGIew4Kaz8/QsdcG
	Eku+EtK1mnFL5NN4+lH5C5EAN/8brIv/u1dU9lZJ/VPISR5FAKAHaHIjGLodyjiInlMfgMbVk0pOH
	vnDeoXKCmyc8zVvNRLLhNzPNF73JYPoSkwIlwXjgjddYrM4B3Mamgfmk3ZHQZiWMLcSQp30oN+b+O
	z2CoO0pB1byPrh1I7UkTlzT2dAwsxUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1icr61-00032t-7l; Thu, 05 Dec 2019 13:23:05 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1icr5z-00032S-1U
 for linux-nvme@lists.infradead.org; Thu, 05 Dec 2019 13:23:04 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB5DFYtS026181; Thu, 5 Dec 2019 08:22:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=RpPqRlVfbA/xfnifPZxwnC7K28mxksZf9Tz4KyMqN9I=;
 b=kUMTZBJLR3nG8Q+DramkwCuO0VwO+H4CizdbdD/zuK6j62JlkmMLKQStegX41VZO6suW
 yreo4baglB00DcHko7LCExtypFI/pql5PFM7irb/bdCJKC/kgyXlPxPho2Do0KzsBhrH
 ONN3CnSM+nbkEWstCfvJ8omDCnSnctGWSI37Q8hCU3k6kYVaaY5LMbNQYapK1KQ9kOfa
 vohHzdJkWt2dtqUEC2lhLjyHZFwdGJ+mjYTUtESfqauucmDrdC+z7mz5xyNQT7KYlIlI
 RBsfgeGNomO1VQI9ME57NXPxLcxFvVX2IkZgwkVFog2oBYa7Sks8/CmWC6mwt7Ikz+yi QQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 2wpbecnnp8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Dec 2019 08:22:52 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 xB5DJ5RH074874; Thu, 5 Dec 2019 08:22:52 -0500
Received: from mailuogwdur.emc.com (mailuogwdur-nat.lss.emc.com
 [128.221.224.79] (may be forged))
 by mx0a-00154901.pphosted.com with ESMTP id 2wpmv9a19v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 05 Dec 2019 08:22:51 -0500
Received: from emc.com (localhost [127.0.0.1])
 by mailuogwprd52.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id xB5DModC011021; Thu, 5 Dec 2019 08:22:50 -0500
Received: from maildlpprd56.lss.emc.com ([maildlpprd56.lss.emc.com
 [10.106.48.160]]) by mailuogwprd52.lss.emc.com with ESMTP id xB5DMCwL010004 ; 
 Thu, 5 Dec 2019 08:22:36 -0500
Received: from mailsyshubprd07.lss.emc.com (mailhub.lss.emc.com
 [10.253.24.63]) by maildlpprd56.lss.emc.com (RSA Interceptor);
 Thu, 5 Dec 2019 08:14:46 -0500
Received: from vd-amite.xiolab.lab.emc.com (vd-amite.xiolab.lab.emc.com
 [10.64.137.6])
 by mailsyshubprd07.lss.emc.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.0) with
 ESMTP id xB5DEeim027634; Thu, 5 Dec 2019 08:14:41 -0500
From: Amit <Amit.Engel@Dell.com>
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: Fix req->data_len size in case of
 nvme_admin_get_features cmd, fid 0x81
Date: Thu,  5 Dec 2019 15:14:38 +0200
Message-Id: <20191205131438.63321-1-amit.engel@emc.com>
X-Mailer: git-send-email 2.16.5
X-RSA-Classifications: public
X-Sentrion-Hostname: mailuogwprd52.lss.emc.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_03:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=857 spamscore=0 clxscore=1015 phishscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050112
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 bulkscore=0
 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=924 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912050112
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191205_052303_202126_E877B784 
X-CRM114-Status: GOOD (  13.95  )
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
Cc: amit.engel@dell.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <amit.engel@dell.com>

In feature id 0x81 NVME_FEAT_HOST_ID, nvmet_copy_to_sgl is called
req->data_len shall hold a non-zero value which is
'sizeof(req->sq->ctrl->hostid)'

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/admin-cmd.c | 11 ++++++++++-
 drivers/nvme/target/nvmet.h     |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 56c21b501185..f09d5fdc995f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -24,6 +24,15 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 	return len;
 }
 
+u32 nvmet_feature_data_len(struct nvmet_req *req)
+{
+	u8 feature = req->cmd->common.cdw10 & 0xff;
+
+	if (feature == NVME_FEAT_HOST_ID)
+		return sizeof(req->sq->ctrl->hostid);
+	return 0;
+}
+
 u64 nvmet_get_log_page_offset(struct nvme_command *cmd)
 {
 	return le64_to_cpu(cmd->get_log_page.lpo);
@@ -778,7 +787,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
-	if (!nvmet_check_data_len(req, 0))
+	if (!nvmet_check_data_len(req, nvmet_feature_data_len(req))
 		return;
 
 	switch (cdw10 & 0xff) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 46df45e837c9..6422489d96cd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -434,6 +434,8 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len);
 u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 u64 nvmet_get_log_page_offset(struct nvme_command *cmd);
 
+u32 nvmet_feature_data_len(struct nvmet_req *req);
+
 extern struct list_head *nvmet_ports;
 void nvmet_port_disc_changed(struct nvmet_port *port,
 		struct nvmet_subsys *subsys);
-- 
2.16.5


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
