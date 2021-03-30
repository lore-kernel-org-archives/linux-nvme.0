Return-Path: <SRS0=nD3g=I4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159A2C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 17:24:33 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACC6861985
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Mar 2021 17:24:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACC6861985
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zIT3kYoolnR2ActY0z2lqVZDpB4YbvqMy4fhNPqrFg4=; b=TE+nR/l31ZUOL8H/kuUma8mLO3
	256eT/7l+/sGbMwbdNP5FT+nEAXTniA60UbA2r/3NCrr6Ps3HpUl6DAVgQiiGn9WrsK6qZbgq+aB1
	arAwZ4Sake7ro9iVgCAAwD3f9Chh+UY8cqmrrJrXBc46TT0VMkEGQIGJCqib4/p734jUFznU3CVex
	1oslQw9oXxahkA6rEO99FFSaf7kGrhJCnrcN3HnuNqKDqGqvWn7LxBPDb5i8RyGSmwo130YSjOeUf
	mz9NEFUO00yLMsw9B1T5ImCbQLfUD5szp1oFY29hrMxThziwdujDYygdCcqL9D7ojlzjDo4UYJ8N1
	QSMVHp6w==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRI6H-004RJG-HI; Tue, 30 Mar 2021 17:24:21 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRI6A-004RGr-IE
 for linux-nvme@lists.infradead.org; Tue, 30 Mar 2021 17:24:17 +0000
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12UHMExD015615
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 13:24:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=jZLdb+NcEQdrg43ifPEjKBlURM18B3z4lyDFYXBxMM8=;
 b=OVek7uxhhBazwpxsSI5QowL6bkkD7Y1+RmLXJzqQuxhpxsrW+LMAXyGzJx3kE/JEjnMz
 bvu4qGoV2hhkH51s6AN6o2nVsocbOS00AGaJy7jxzr2PmNwvBM3SW8FO8YstPzUoQ/zB
 Zty5tnWg5XnKkJwgpxgWM3lu0cEODMaGz+yaqgSEP2XEQHmncIUYesdPJhPKCWCIqPMK
 QCfp5HTNgWuQvBRvNL0/ifaTj0LU1AyFEpkZRxQRR5xoT415fUU8QlzVD90XVpQMmNmF
 /RlWHdF+OeTzx7shqwvhVwhQiuf76WkFHwCcTCNSqMWheTNEMIvn7GJ9cq8jUl+UJ3se OA== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 37kh2rw1rd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 13:24:12 -0400
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 12UHLHEj168678
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 13:24:12 -0400
Received: from esaploutdur06.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 37jj2q3x1d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Tue, 30 Mar 2021 13:24:12 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.98
Received: from vd-idand.xiolab.lab.emc.com (HELO vd-grupie.xiolab.lab.emc.com)
 ([10.55.224.98])
 by esaploutdur06.us.dell.com with ESMTP; 30 Mar 2021 12:24:11 -0500
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Elad Grupi <elad.grupi@dell.com>
Subject: [PATCH v4] nvmet-tcp: fix a segmentation fault during io parsing error
Date: Tue, 30 Mar 2021 20:24:07 +0300
Message-Id: <20210330172407.22936-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369, 18.0.761
 definitions=2021-03-30_08:2021-03-30,
 2021-03-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0
 impostorscore=0 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103250000 definitions=main-2103300125
X-Proofpoint-GUID: JFsdeI_DZF-XQO6rHrpCSzE7g5AmbJDt
X-Proofpoint-ORIG-GUID: JFsdeI_DZF-XQO6rHrpCSzE7g5AmbJDt
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 mlxlogscore=999 adultscore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103250000
 definitions=main-2103300125
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210330_182415_404927_FAD468B0 
X-CRM114-Status: GOOD (  21.54  )
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
 drivers/nvme/target/tcp.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 70cc507d1565..d159ff426630 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -38,7 +38,8 @@ enum nvmet_tcp_send_state {
 	NVMET_TCP_SEND_DATA,
 	NVMET_TCP_SEND_R2T,
 	NVMET_TCP_SEND_DDGST,
-	NVMET_TCP_SEND_RESPONSE
+	NVMET_TCP_SEND_RESPONSE,
+	NVMET_TCP_SEND_POSTPONED
 };
 
 enum nvmet_tcp_recv_state {
@@ -530,6 +531,14 @@ static void nvmet_tcp_queue_response(struct nvmet_req *req)
 	queue_work_on(queue_cpu(queue), nvmet_tcp_wq, &cmd->queue->io_work);
 }
 
+static void nvmet_tcp_execute_request(struct nvmet_tcp_cmd *cmd)
+{
+	if (unlikely(cmd->state == NVMET_TCP_SEND_POSTPONED))
+		nvmet_tcp_queue_response(&cmd->req);
+	else
+		cmd->req.execute(&cmd->req);
+}
+
 static int nvmet_try_send_data_pdu(struct nvmet_tcp_cmd *cmd)
 {
 	u8 hdgst = nvmet_tcp_hdgst_len(cmd->queue);
@@ -702,6 +711,18 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 			return 0;
 	}
 
+	if (unlikely((cmd->flags & NVMET_TCP_F_INIT_FAILED) &&
+			nvmet_tcp_has_data_in(cmd) &&
+			nvmet_tcp_has_inline_data(cmd))) {
+		/*
+		 * wait for inline data before processing the response
+		 * so the iov will not be freed
+		 */
+		cmd->state = NVMET_TCP_SEND_POSTPONED;
+		queue->snd_cmd = NULL;
+		goto done_send;
+	}
+
 	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
 		ret = nvmet_try_send_data_pdu(cmd);
 		if (ret <= 0)
@@ -960,7 +981,7 @@ static int nvmet_tcp_done_recv_pdu(struct nvmet_tcp_queue *queue)
 			le32_to_cpu(req->cmd->common.dptr.sgl.length));
 
 		nvmet_tcp_handle_req_failure(queue, queue->cmd, req);
-		return -EAGAIN;
+		return 0;
 	}
 
 	ret = nvmet_tcp_map_data(queue->cmd);
@@ -1103,10 +1124,8 @@ static int nvmet_tcp_try_recv_data(struct nvmet_tcp_queue *queue)
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
@@ -1143,9 +1162,9 @@ static int nvmet_tcp_try_recv_ddgst(struct nvmet_tcp_queue *queue)
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
