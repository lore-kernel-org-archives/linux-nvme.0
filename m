Return-Path: <SRS0=jxE6=IY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0FCAC433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 18:00:17 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AD861A2D
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Mar 2021 18:00:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AD861A2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DOP1hpLB1bEJnENdkIHAyz4grW+lVbwvxlBhvL/zZBQ=; b=R46JTvah7WLcYrhsrbigDulDDf
	ES/2CzN+rOTKQPe/VbC9uL5Vqaz1ENwusYf2VqonRnIzPS1/ijhVTCdbcVGwCrRlFU4oKu9CyMmCe
	y//vam+0Kvu3eKQUDl8W+CfK/i4APaiN8hvVY8lf937gK86ObJuswCT0UJkLf2rS2A5+MGN2AeFKT
	RLl7Af+H6vhvk1HqhncmZmE/BK2WfOG26fFR7VKwvZfI0g+jX4mb7yz80YHempLMc6UQdEqJDLMom
	mlssMuDlAiZt5XMNnrisDLfEVDMztrNlz06uCsZucaEpTJtRZ/zStm18hXm1+4pR1b0Dyz0vuvuj/
	v5Q7DStA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPqkU-00467X-Vx; Fri, 26 Mar 2021 17:59:55 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPqkQ-00466P-3h
 for linux-nvme@lists.infradead.org; Fri, 26 Mar 2021 17:59:53 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12QHvIuo021114
 for <linux-nvme@lists.infradead.org>; Fri, 26 Mar 2021 13:59:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=HdXYBZ8kJxO/l4IKteUv6CJAsFsG3tV4phHjj9aaUC0=;
 b=MjVwaNRO+oHPY+uklgEKH1QQGtqW5z0b4Q8iQtnrRJhK1jOo075y7lV/1oWhcDllyGe2
 ugM0cxxTyOmau3hfGClBbnvcH0fwoE1UlLQ7e+e+ggbZmMmZPjrAPFBx0NdIn0J4yZRw
 701/KQv9IxQMboT7+Ol4XIW2+Wbj33W+mjCw+Ii7UP6SXNyr2Q1eBhxGhnoZYsDaiuT5
 pTCJnWfcr5/WIscXW1RbFlOB56ysHRSFeklWAvGtvP9yBZlpmjbtz+gmUQiJH6aYM36Z
 y0/VbS0PkyYxCMICX2J9eX//i4ZJI2MFndanR9+pHmaFf1MEhtWLRJtOjI1vMSqzC734 sA== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 37h135bnfg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Fri, 26 Mar 2021 13:59:47 -0400
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12QHtSJ9048697
 for <linux-nvme@lists.infradead.org>; Fri, 26 Mar 2021 13:59:47 -0400
Received: from esaploutdur02.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 37h14d6e3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Fri, 26 Mar 2021 13:59:47 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.98
Received: from vd-idand.xiolab.lab.emc.com (HELO vd-grupie.xiolab.lab.emc.com)
 ([10.55.224.98])
 by esaploutdur02.us.dell.com with ESMTP; 26 Mar 2021 12:59:45 -0500
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Elad Grupi <elad.grupi@dell.com>
Subject: [PATCH v2] nvmet-tcp: fix a segmentation fault during io parsing error
Date: Fri, 26 Mar 2021 20:59:41 +0300
Message-Id: <20210326175941.22734-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-26_08:2021-03-26,
 2021-03-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 mlxscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103260133
X-Proofpoint-ORIG-GUID: c-LxhwWcGdlcF7VdObi4Dzcl45pAuHxQ
X-Proofpoint-GUID: c-LxhwWcGdlcF7VdObi4Dzcl45pAuHxQ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103260134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210326_175950_611354_575B4D9C 
X-CRM114-Status: GOOD (  20.63  )
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

From: Elad Grupi <elad.grupi@dell.com>

In case there is an io that contains inline data and it goes to
parsing error flow, command response will free command and iov
before clearing the data on the socket buffer.
This will delay the command response until receive flow is completed.

Fixes: 872d26a391da ("nvmet-tcp: add NVMe over TCP target driver")
Signed-off-by: Elad Grupi <elad.grupi@dell.com>
---
 drivers/nvme/target/tcp.c | 29 +++++++++++++++++++++++------
 1 file changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 70cc507d1565..3bc0caa47873 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -702,6 +702,17 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 			return 0;
 	}
 
+	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
+			nvmet_tcp_has_data_in(cmd) &&
+			nvmet_tcp_has_inline_data(cmd))) {
+		/*
+		 * wait for inline data before processing the response
+		 * so the iov will not be freed
+		 */
+		queue->snd_cmd = NULL;
+		goto done_send;
+	}
+
 	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
 		ret = nvmet_try_send_data_pdu(cmd);
 		if (ret <= 0)
@@ -1103,9 +1114,11 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		return 0;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len) {
-		cmd->req.execute(&cmd->req);
+	if (cmd->rbytes_done == cmd->req.transfer_len) {
+		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+			nvmet_tcp_queue_response(&cmd->req);
+		else
+			cmd->req.execute(&cmd->req);
 	}
 
 	nvmet_prepare_receive_pdu(queue);
@@ -1143,9 +1156,13 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len)
-		cmd->req.execute(&cmd->req);
+	if (cmd->rbytes_done == cmd->req.transfer_len) {
+		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+			nvmet_tcp_queue_response(&cmd->req);
+		else
+			cmd->req.execute(&cmd->req);
+	}
+
 	ret = 0;
 out:
 	nvmet_prepare_receive_pdu(queue);
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
