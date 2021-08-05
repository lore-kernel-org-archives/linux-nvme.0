Return-Path: <SRS0=eYGd=M4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA292C4338F
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 15:33:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82A3C60EE8
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Aug 2021 15:33:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 82A3C60EE8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+IIQBhv+/5wWDyyljdMb56PaIsiLNGjSGZoMxtjbznU=; b=BxSCn77YHBDblw
	5TvG2U0RuBBB/ki0Nk+cK94YNU4FHRzZr+SmuA/HfEfs83IpxWkQfBgQ6rYhbgLnOgK1YaZtIKbpD
	+uXJZqpLAcJ1INgwC4jUPz4xjaERfKwfP6gII3NsoOLmN4kQcp9zYyLf2mT+HiVUYhihc9XKpK9r1
	63FudVQEgSTJCFnm/YI7nh13aOuUXYr8wC/M/Voy3dhTqF0daFar7D88ljtBaHvVCiPPT8w/ZMWH7
	/b8V6TP9m1g+GtKaOJCF6cnS1OBYnvPWQkIAZVQGVvHneL/6iyju8z8ioHxSQk1Y6bRtch+z8hCHm
	+Z/4CkU+XgaLEHDounCw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mBfN1-00A4Or-MY; Thu, 05 Aug 2021 15:33:19 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mBfMz-00A4OM-32
 for linux-nvme@lists.infradead.org; Thu, 05 Aug 2021 15:33:18 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 175FWQJS008006
 for <linux-nvme@lists.infradead.org>; Thu, 5 Aug 2021 11:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=gANtHRqKkJ6essJl4BwtM50fTbiugX2eSvXHDaMBJqc=;
 b=LbyrOBsRXu0HZqwaf7oVEDn+qFw+J4/kSJ7q4WgJF0kVVaK6T4lIlA6Bm0i+ShdNOa1o
 mBObMEc/1AkZvQI29GyeOGTyAtOzANXWIR4NXSjTRb1CUVrBPvlZSaCAd1XUsqjhUG8A
 AqXVOe3kAqxe6hMRkkU2TSqWcma1Pm2skgOKq9/KIkPDyPeEjpM1K9c4hh7W0eOqnjXM
 sH4SNqiSrn7APirwRdWn+0a5q1sWJI0DTgJHrSx51Wm2eFUbS2l+8OaO/bsPtcY0x6Up
 KQI8gL3H8heA9L8OnvoyruBsTt40XBPK2YZkeRhUHvqloO1wdeGUTimtXZvLSNLlleD1 Yg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 3a7d5s7pmv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 05 Aug 2021 11:33:16 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 175FU1B6105084
 for <linux-nvme@lists.infradead.org>; Thu, 5 Aug 2021 11:33:16 -0400
Received: from esaploutdur01.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 3a847c3yp1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 05 Aug 2021 11:33:16 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="79778828"
Received: from vd-amite.xiolab.lab.emc.com ([10.55.225.216])
 by esaploutdur01.us.dell.com with ESMTP; 05 Aug 2021 10:33:13 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, sagi@grimberg.me, kbusch@kernel.org
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet: pass back cntlid on successful completion
Date: Thu,  5 Aug 2021 18:33:10 +0300
Message-Id: <20210805153310.30986-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.790
 definitions=2021-08-05_05:2021-08-05,
 2021-08-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0
 spamscore=0 bulkscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108050094
X-Proofpoint-GUID: tw_hfiZoMn944_fv9CiQ4fpMHNR21GKU
X-Proofpoint-ORIG-GUID: tw_hfiZoMn944_fv9CiQ4fpMHNR21GKU
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxlogscore=999
 adultscore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108050094
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210805_083317_226257_089916F3 
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
connect response dword 0 value is based on status code:
return cntlid for successful compeltion
return IPO and IATTR for connect invalid parameters

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/target/fabrics-cmd.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7d0f3523fdab..eaaf179bec82 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -120,6 +120,7 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	if (!sqsize) {
 		pr_warn("queue size zero!\n");
 		req->error_loc = offsetof(struct nvmf_connect_command, sqsize);
+		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(sqsize);
 		ret = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto err;
 	}
@@ -260,11 +261,12 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	}
 
 	status = nvmet_install_queue(ctrl, req);
-	if (status) {
-		/* pass back cntlid that had the issue of installing queue */
-		req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
+
+	if (status)
 		goto out_ctrl_put;
-	}
+
+	/* pass back cntlid for successful completion */
+	req->cqe->result.u16 = cpu_to_le16(ctrl->cntlid);
 
 	pr_debug("adding queue %d to ctrl %d.\n", qid, ctrl->cntlid);
 
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
