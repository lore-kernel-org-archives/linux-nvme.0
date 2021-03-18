Return-Path: <SRS0=ZogQ=IQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6E7C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 08:29:22 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 769C264F33
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Mar 2021 08:29:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 769C264F33
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/eTqx159SjzeKpoGoGM3Q232NYLN1JEtsthOwSuMRrY=; b=mfxLAVe5HBoQ+nSHbYRMSqxCzo
	bNpG7cIKIiARArJtB55KOrkcZWt0zo2qm8u7Hyp06uCSGg7Z7EhdoPcaVlCpdzN8jt0XIjKJgX3HZ
	PxXc68DldH221ikzbZheoXP75rOsskg0xvD0IohbBFt5vPIFx5X+p5+lGMtI0KsI/N83F2VMpG85b
	kbpAY/WuRF3e0vHKYCGpJ6O5GhOh/X2M8ofbKFUttL+6MMClKIvNTYuWZShFNFPHLfgEeKPsvqd1U
	Y8j+sg/ZWNuNwnglOq70USwjrg8P9renjh/+WoIU98pyQeHJK2LqNu12MjZhOECmhr0shGwrOzEwK
	N/o5ZqcA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lMo1e-004nVb-Q7; Thu, 18 Mar 2021 08:29:03 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMo1Q-004nQ2-Rl
 for linux-nvme@lists.infradead.org; Thu, 18 Mar 2021 08:28:59 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12I8S8fI005685
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 04:28:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=jKkXWW6bPzQEXgRE2iHaulCAXKP+Vl9/YiYxVhF0Uzc=;
 b=X4KMhhU7CAFICI7Nw3hX5Y3Aton7PHe0+5rckkzt8bg4pl6f5ifdllqppMK1tSXOlg2D
 gYHjtVDGpjyzHMgpLQIs1HgkRPcjzTSu/OG0nbuKbd5jdQ8HEzq+hdH9yTE+sLc6Fkf3
 aJYuRn+EDlc33CrlgsTPo1W3F8AvJc5Ehu4hKWhid3lg45Qd2lehSxiM90mtcahajrbC
 wuCi+MsLQ6lQAQW7EQazlKaLLZNkwAXqrisoXY/1a9HoBH2hj70G0QbDBkAocL/iv06U
 8XKhwv+4kqZ3HDWQzj23C0qVKSylC6WDkueAUuFtIVlR5IYXDnLbe0xetuxnWPe0Fwxa 5A== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 378se20hsc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 04:28:40 -0400
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12I8PuuJ068636
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 04:28:40 -0400
Received: from esaploutdur05.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 379bw4e166-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 18 Mar 2021 04:28:40 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.98
Received: from vd-idand.xiolab.lab.emc.com (HELO vd-grupie.xiolab.lab.emc.com)
 ([10.55.224.98])
 by esaploutdur05.us.dell.com with ESMTP; 18 Mar 2021 03:28:38 -0500
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Elad Grupi <elad.grupi@dell.com>
Subject: [PATCH] nvmet-tcp: fix a segmentation fault during io parsing error
Date: Thu, 18 Mar 2021 10:28:34 +0200
Message-Id: <20210318082834.16093-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-18_02:2021-03-17,
 2021-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxscore=0
 malwarescore=0 impostorscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103180063
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103180063
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210318_082849_548905_559A19A7 
X-CRM114-Status: GOOD (  20.86  )
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

Signed-off-by: Elad Grupi <elad.grupi@dell.com>
---
 drivers/nvme/target/tcp.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d658c6e8263a..2b5d0c9c4e38 100644
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
@@ -1107,7 +1118,9 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len) {
 		cmd->req.execute(&cmd->req);
-	}
+	} else if ((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
+			cmd->rbytes_done == cmd->req.transfer_len)
+		nvmet_tcp_queue_response(&cmd->req);
 
 	nvmet_prepare_receive_pdu(queue);
 	return 0;
@@ -1147,6 +1160,8 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
 	if (!(cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
 	    cmd->rbytes_done == cmd->req.transfer_len)
 		cmd->req.execute(&cmd->req);
+	else if ((cmd->flags & NVMET_TCP_F_INIT_FAILED))
+		nvmet_tcp_queue_response(&cmd->req);
 	ret = 0;
 out:
 	nvmet_prepare_receive_pdu(queue);
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
