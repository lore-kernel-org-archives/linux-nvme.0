Return-Path: <SRS0=L4Tp=I3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C659DC433C1
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Mar 2021 23:58:34 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 631DB61878
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Mar 2021 23:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 631DB61878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6hjw1hMJZAv+q8AZ0WsT5vb5GdvUMpk7/MYlSXj0Iyk=; b=WlvT3g5UARqK/zPGZHbiYbqC9c
	vB9dHAVvKLF7VmeS51Wxw2fAj6p7Dm9Mf0U+dK+xstz5HyfBkWJnExidtDE1OqffWs8nZZqXd1RJG
	jQ6joiCb006o3MW4pPVchfyj2nZkczOsL0MC3CbHnwWzbtwbE6w3j67zyQaPbl34jNG1GaTu71BeJ
	JntReA5PYWo8xhgA2m0k/xrlhZTFRDVgQVB8uDbKSPLwAbEswqEs6UBRoCIr9LFVtu6oUKCcosOY4
	cRoiLMrjEq8voCBnkxZDvnQ6AAfZbg2pxfLE1netB+IJ8yv2c27q/EAP0NfctAyPYFCnkIPhvHwEl
	ezd8MEFw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lR1lv-002520-Ux; Mon, 29 Mar 2021 23:58:16 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQwD0-000y8p-97
 for linux-nvme@lists.infradead.org; Mon, 29 Mar 2021 18:02:30 +0000
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12THv3oR026608
 for <linux-nvme@lists.infradead.org>; Mon, 29 Mar 2021 14:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=LeAjstCpzXTVP3mNBeYl8IUEQFeAFnHbNrUKZuQKYtw=;
 b=PRoEwQ/bckrFz6IwaohoUGVDabbO08sQNMjSl3rBgsHjJkhjeQqJIoynPO/vaWKz51Uu
 7Jf92dSj7l7OAyz3F2kbo6HzcJfc5nImbgiWuRMhZz+MCWFAv86+TvT+S0eMlgsUt1zD
 1xoMFMDeKlnknLR7PWMzC3A9qvsuMgWBxVM1ZMQsYdPpsr+1/8C5EbV71PXbTWZhjIs+
 HZz0zWi0Zq0Qz5qWtMEmzll6xq1tSB906dRG7CAr4PEuigXJM/KaDmQ3RFXLius7ug0U
 yWjC1h7eAREj7AZP6H/NVM1kgIbQqPXJPqj8DvHIbIGsoQQXumx4aK5w5jpOu0vNJuqE BQ== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 37hyxadmh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 29 Mar 2021 14:01:31 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12TGDNhB088686
 for <linux-nvme@lists.infradead.org>; Mon, 29 Mar 2021 14:01:30 -0400
Received: from esaploutdur06.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 37jjc2bcjb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Mon, 29 Mar 2021 14:01:30 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.98
Received: from vd-idand.xiolab.lab.emc.com (HELO vd-grupie.xiolab.lab.emc.com)
 ([10.55.224.98])
 by esaploutdur06.us.dell.com with ESMTP; 29 Mar 2021 13:01:28 -0500
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Elad Grupi <elad.grupi@dell.com>
Subject: [PATCH v3] nvmet-tcp: fix a segmentation fault during io parsing error
Date: Mon, 29 Mar 2021 21:01:25 +0300
Message-Id: <20210329180125.3977-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-28_03:2021-03-26,
 2021-03-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103280024
X-Proofpoint-ORIG-GUID: CcomG5uaaacBJmNo7FtuPc9vWxYGSzq6
X-Proofpoint-GUID: CcomG5uaaacBJmNo7FtuPc9vWxYGSzq6
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103290133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210329_190227_563727_32CE70C2 
X-CRM114-Status: GOOD (  21.44  )
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
 drivers/nvme/target/tcp.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 70cc507d1565..41102fc09595 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -525,11 +525,34 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	struct nvmet_tcp_cmd *cmd =
 		container_of(req, struct nvmet_tcp_cmd, req);
 	struct nvmet_tcp_queue	*queue = cmd->queue;
+	struct nvme_sgl_desc *sgl;
+	u32 len;
+
+	if (unlikely(cmd == queue->cmd)) {
+		sgl = &cmd->req.cmd->common.dptr.sgl;
+		len = le32_to_cpu(sgl->length);
+
+		/*
+		 * Wait for inline data before processing the response.
+		 * Avoid using helpers, this might happen before
+		 * nvmet_req_init is completed.
+		 */
+		if (len && cmd->rcv_state == NVMET_TCP_RECV_PDU)
+			return;
+	}
 
 	llist_add(&cmd->lentry, &queue->resp_list);
 	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
 }
 
+static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
+{
+	if (unlikely(cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_tcp_queue_response(&cmd->req);
+	else
+		cmd->req.execute(&cmd->req);
+}
+
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
@@ -1103,10 +1126,8 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 		return 0;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len) {
-		cmd->req.execute(&cmd->req);
-	}
+	if (cmd->rbytes_done == cmd->req.transfer_len)
+		nvmet_tcp_execute_request(cmd);
 
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
@@ -1143,9 +1164,9 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 		goto out;
 	}
 
-	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
-	    cmd->rbytes_done == cmd->req.transfer_len)
-		cmd->req.execute(&cmd->req);
+	if (cmd->rbytes_done == cmd->req.transfer_len)
+		nvmet_tcp_execute_request(cmd);
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
