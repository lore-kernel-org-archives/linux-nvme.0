Return-Path: <SRS0=L4Tp=I3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53F8C433C1
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Mar 2021 17:50:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2487360238
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Mar 2021 17:50:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2487360238
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6hjw1hMJZAv+q8AZ0WsT5vb5GdvUMpk7/MYlSXj0Iyk=; b=ajSymsrqLudJT5SF2F8fxaR1CY
	cC2MSN87fJAx/T8DeiszOZgjlAe79W3u4o5faZiOm52Wl5xJ0cP6nisrkfRqYqkeEiYI+nOYm5chP
	EIQwmYRjzaRMdw/ktHbMi/YvNiisxCKHS3tUvio7dTcedCkXpWCeIKhIhi29SNDe3UoVvEj5rvArD
	PbEWColktuS9i536OI9d33/5m2Lw/72ZfpttQnYgu7ZU1XeRmV83vLTwP2YAWbov36O7Yih6sMIv2
	FtJTVjofokktwvCFUr+i/JyuagF0++5TK7LgIx9mtapjvU37b+QW058LKHAiaPlZP5vBPH/o46l06
	ShlaVikg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lQw0x-000wAJ-SF; Mon, 29 Mar 2021 17:49:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQowi-000Zcp-Go
 for linux-nvme@desiato.infradead.org; Mon, 29 Mar 2021 10:16:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Message-Id:Date:Subject:Cc:To:From:
 Sender:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=LeAjstCpzXTVP3mNBeYl8IUEQFeAFnHbNrUKZuQKYtw=; b=a+9ASRmEy5dE9UkpvWCYoWxNU5
 TMz+E+uhUqis8ozg49Mq4FU1unedb70gZXFpolAcm8tKaem1yiLJZKp6MUl6I2JjL1mLwDggyQ2hD
 AzrXIO+25f35a0QxTqz34bw8XXdNmJkuCJNZNP8j6y94f8siQ+XZOzVN+FmX4aEc3MLRqVQkexfb2
 QNAosutSqLR0ktF/zp72E4Wg6KSjsPR/DLVjcMOCRwYSZmEhkOZTlg12XRdXgdT2RKia9HXNYJft0
 czUIdlKJ5BY0CbXXH0DfLaFGjoO5mOQ1fi+bOk1lgkBSoAG8EdvhzQbLq58cHiplIbwcBcN7IZp9y
 W5cRajBQ==;
Received: from [148.163.137.20] (helo=mx0b-00154904.pphosted.com)
 by casper.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lQS4U-00036X-Cz
 for linux-nvme@lists.infradead.org; Sun, 28 Mar 2021 09:51:06 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12S9lpic032297
 for <linux-nvme@lists.infradead.org>; Sun, 28 Mar 2021 05:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=LeAjstCpzXTVP3mNBeYl8IUEQFeAFnHbNrUKZuQKYtw=;
 b=IennBwjpmJJAkNvWDF+dlfXz+rX9SqliJZ1+2Vf1LymEMiPNXhibLCs7RseuggtQpg5V
 /pupdUsEotKeLP9G38MY9mLC2PVRmwxbPXJqS7gumMnNsLRd/FjoOX7ypqfNhJwVj8Nk
 7O+5CsE9VuWn58+iqOPLLPVBKeIXr3NYDVJbAVU0S4m+UDI8Nht/6dOnnN4LjdNjA/G/
 gLR+Ih8HZCYHTBEvOBcX7xOCi8ubTUfOyDiNity82UFyAykEq0V2fBFeKg5p/MZmXuRH
 aYi+ND8Y6dxi4hVRFR/7MRRl8HTGTnc2UhSaSXODuquamdmqj18HKGcGnxXqtaWPAXV5 Zg== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com with ESMTP id 37hwswhv4q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Sun, 28 Mar 2021 05:50:54 -0400
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12S9jWkD073158
 for <linux-nvme@lists.infradead.org>; Sun, 28 Mar 2021 05:50:53 -0400
Received: from esaploutdur04.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 37jhxej4ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Sun, 28 Mar 2021 05:50:53 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.98
Received: from vd-idand.xiolab.lab.emc.com (HELO vd-grupie.xiolab.lab.emc.com)
 ([10.55.224.98])
 by esaploutdur04.us.dell.com with ESMTP; 28 Mar 2021 04:50:51 -0500
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Elad Grupi <elad.grupi@dell.com>
Subject: [PATCH v3] nvmet-tcp: fix a segmentation fault during io parsing error
Date: Sun, 28 Mar 2021 12:50:47 +0300
Message-Id: <20210328095047.1135-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-28_05:2021-03-26,
 2021-03-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 priorityscore=1501 mlxscore=0 impostorscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 phishscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103280073
X-Proofpoint-GUID: vi3i0t0RzufcDUlWsq9wCxVpOAt_FKyk
X-Proofpoint-ORIG-GUID: vi3i0t0RzufcDUlWsq9wCxVpOAt_FKyk
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 adultscore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103280073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210328_105103_972457_917F4E14 
X-CRM114-Status: GOOD (  19.64  )
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
