Return-Path: <SRS0=zNYX=IX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BE9C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 22:50:36 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6771361A41
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Mar 2021 22:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6771361A41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cbU3KJ8MjFNmujJZhpgTegKfbXVtgWG8DliuT9oWuYE=; b=LLoXfrkIuElYNgij+9GrOhAWKK
	xch3aM6q0eEpOq8zzNgwoYtlZEVc2vEIFG8I7IPR4igtkp+UEo04Xw/BOXaxhe00HPTao0oAIbbye
	YWp0fBBE/Or7IbyGFwcxWHAkCG01bsSGgTRLn7RUR2dn3ndvf2tt5ZQti/WvJAxf6TgKWcs/40/+Q
	QK/SMu2w3hC3Mjij8aduRjkXeWH/JgAgZIWqT241Z7zJqrX1GQR5G07P9USE6bg1k2JsSMOPXVduq
	LsSQyPusBmiV0urAkNCATn5c4qLmn6ThKjXPFgwn66Ba96bs01T/O1XslpGjpVJsUikng1MUKsgKM
	lcoAIonQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lPYnx-002JLi-Hk; Thu, 25 Mar 2021 22:50:17 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lPYnr-002JL8-VD
 for linux-nvme@lists.infradead.org; Thu, 25 Mar 2021 22:50:14 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12PMmDK9000507
 for <linux-nvme@lists.infradead.org>; Thu, 25 Mar 2021 18:50:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=cZLWL1/tZ4/LHdIPlize62EvOMZ6z+Dd9zCxT0mQFx8=;
 b=HBaqtYdl6cHRSC5wzIvtPxvXvNwxBPXjICnx1O7Gq+xGD77UhW4DRouqLMXwbyRahGbZ
 decpj96eVVWypy2AoWM3dr8O5cXiyWqOLFHttCZRpAAzfvg9NTa0IdUG+IM8EaoYYtAI
 4UK7A9lH/I9ZUKrPOUtOAt/gyze6foOo/u2Xt9Ry4Q2IREIL5iyaxIRyJo0iCT62gAUU
 rG+Lzr2XTce5O3MnAhIJmZGGZxc7QFzh0+sBC/KifQpiMcA9V8LkXx2ZS5cj6U2OS1TA
 hLrXkbz+nPQcPSmza9cS6jyeioWyzrSr7vJQOIxhdl7evpP/cukSEJGFXyDEKCZYf17d KQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 37h12h0h38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 25 Mar 2021 18:50:06 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12PMdJXA149153
 for <linux-nvme@lists.infradead.org>; Thu, 25 Mar 2021 18:50:05 -0400
Received: from esaploutdur02.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 37h1461xhy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 25 Mar 2021 18:50:05 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.98
Received: from vd-idand.xiolab.lab.emc.com (HELO vd-grupie.xiolab.lab.emc.com)
 ([10.55.224.98])
 by esaploutdur02.us.dell.com with ESMTP; 25 Mar 2021 17:49:56 -0500
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Elad Grupi <elad.grupi@dell.com>
Subject: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing error
Date: Fri, 26 Mar 2021 00:49:52 +0200
Message-Id: <20210325224952.18311-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-25_10:2021-03-25,
 2021-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 adultscore=0
 clxscore=1015 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103250167
X-Proofpoint-GUID: 3Tb467xAXNjhFj38ngdNCqLqVbZcNO8I
X-Proofpoint-ORIG-GUID: 3Tb467xAXNjhFj38ngdNCqLqVbZcNO8I
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103250168
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210325_225012_432198_B116CB0F 
X-CRM114-Status: GOOD (  23.57  )
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
 drivers/nvme/target/tcp.c | 42 +++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 70cc507d1565..f10fa2b5aaeb 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -154,6 +154,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static const struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
+static void nvmet_tcp_queue_response(struct nvmet_req *req);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -526,6 +527,12 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
 
+	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
+			nvmet_tcp_has_inline_data(cmd))) {
+		/* fail the cmd when we finish processing the inline data */
+		return;
+	}
+
 	llist_add(&cmd->lentry, &queue->resp_list);
 	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
 }
@@ -702,6 +709,17 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
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
@@ -1103,9 +1121,14 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		return 0;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len) {
-		cmd->req.execute(&cmd->req);
+	if (cmd->rbytes_done == cmd->req.transfer_len) {
+		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+			nvmet_tcp_queue_response(&cmd->req);
+		else {
+			if (unlikely(cmd == &queue->connect))
+				nvmet_tcp_executing_connect_cmd(queue);
+			cmd->req.execute(&cmd->req);
+		}
 	}
 
 	nvmet_prepare_receive_pdu(queue);
@@ -1143,9 +1166,16 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len)
-		cmd->req.execute(&cmd->req);
+	if (cmd->rbytes_done == cmd->req.transfer_len) {
+		if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+			nvmet_tcp_queue_response(&cmd->req);
+		else {
+			if (unlikely(cmd == &queue->connect))
+				nvmet_tcp_executing_connect_cmd(queue);
+			cmd->req.execute(&cmd->req);
+		}
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
