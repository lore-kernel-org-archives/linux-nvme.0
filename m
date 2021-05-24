Return-Path: <SRS0=b1+/=KT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A55C04FF3
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 17:48:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79A3D613F6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 May 2021 17:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79A3D613F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=XuTbDdskl4FtDP0nj4PI/k3F0k7xYrhfTRa6/YjiTYc=; b=yCKGrNpAm9FkHo
	XS885bZMD2C0AIpNMk7Y/Y1UIjnxdafK2TLR+RjivPpfuckZUq29BXrenzFrtALCy3kbQ7d4H67dB
	tvAKNb4+bq2xfnbqgWWAPI2X7RCgdAzYAC1d1PGM7ZMYNevrC3uwSyddNx5G7z2PWV4dle7wttcRw
	vcU8xXOYm3svoOWsPw0WCnatqqTH3RnTfE/X9+TemkkO65enuRFANpND0Tt47fYn9QDv8qio7f0G5
	UtzkAPj+lPsLYFTeHDrFDHIgY3sbeJpHIC0XUjdR/VyXtFxKSnYTuxys3gEAphqpOrTK/TobvMHpu
	CYl4mlVYtQdJrWqFJj8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1llEgM-001L2P-9R; Mon, 24 May 2021 17:48:02 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ll8hX-000rzP-Mb
 for linux-nvme@lists.infradead.org; Mon, 24 May 2021 11:24:53 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14OBM5UT006894
 for <linux-nvme@lists.infradead.org>; Mon, 24 May 2021 07:24:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=PASkZvuvSL/6SYV+MsZYUiM/TWLO32SForceiAn0TQg=;
 b=mEXYGn8hdvsUuuLWbTHXuRNzQFyP1YUOpE+dWBYh+qos4LCPcYD/nButa4yVvuYQV2qn
 GPhldOWbyHm5d3HtA+y6jGxfWdNhpWW69VCOKdyTLGn+LsH4XH2WENjY5yYRzKXwTQy6
 T5iGQsAGWCa5h5BRmxRo5RNqNlEWSdZuwShIRqhxQ1x9fC3LGI6LJ6U+vzAcS1l4jRtC
 3BXvcwcwWwnzYuUp7BiZHmW7EtF7qUVgKLvGNwZkXnmScJYujUy3Y1RUrVy5MZMbXCsM
 VuUQ3Ftn4fBuzMYdP4NMvUUG2P2gBSgFT0aayjvmzHQovLQpWlgMNvz0NzqICcO75+51 KQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 38pw14n8nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Mon, 24 May 2021 07:24:47 -0400
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 14OBKpmS073721
 for <linux-nvme@lists.infradead.org>; Mon, 24 May 2021 07:24:46 -0400
Received: from esaploutdur04.us.dell.com ([128.221.233.10])
 by mx0b-00154901.pphosted.com with ESMTP id 38qexjf0eq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Mon, 24 May 2021 07:24:46 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.98
Received: from vd-idand.xiolab.lab.emc.com (HELO vd-grupie.xiolab.lab.emc.com)
 ([10.55.224.98])
 by esaploutdur04.us.dell.com with ESMTP; 24 May 2021 06:24:45 -0500
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Elad Grupi <elad.grupi@dell.com>
Subject: [PATCH] nvmet-tcp: fix memory leak when having inflight commands on
 disconnect
Date: Mon, 24 May 2021 14:24:41 +0300
Message-Id: <20210524112441.27400-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-05-24_06:2021-05-24,
 2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxlogscore=960
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105240078
X-Proofpoint-ORIG-GUID: zjfb03-WqropWAAsBB1XMPM3j4hjS0do
X-Proofpoint-GUID: zjfb03-WqropWAAsBB1XMPM3j4hjS0do
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105240078
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210524_042451_812205_5ABC23F7 
X-CRM114-Status: GOOD (  17.69  )
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

Some nvme commands might get completed during the execution of
nvmet_tcp_release_queue_work. Those commands are being added to
resp_list on the queue and never processed after cancel_work_sync
is done, causing memory leak of the resources allocated for those commands.

Signed-off-by: Elad Grupi <elad.grupi@dell.com>
---
 drivers/nvme/target/tcp.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f9f34f6caf5e..3c6e36c6ed4a 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1426,6 +1426,33 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 	}
 }
 
+static void nvmet_tcp_free_resp_list(struct nvmet_tcp_queue *queue)
+{
+	struct list_head *p;
+	struct nvmet_tcp_cmd *cmd;
+	int c = 0;
+
+	nvmet_tcp_process_resp_list(queue);
+
+	list_for_each(p, &queue->resp_send_list) {
+		cmd = list_entry(p, struct nvmet_tcp_cmd, entry);
+		kfree(cmd->iov);
+		sgl_free(cmd->req.sg);
+		c++;
+	}
+
+	WARN_ON(c != queue->send_list_len);
+
+	if (queue->snd_cmd) {
+		kfree(queue->snd_cmd->iov);
+		sgl_free(queue->snd_cmd->req.sg);
+		c++;
+	}
+
+	pr_debug("qid %u send_list_len %d, free %d unprocessed commands\n",
+			queue->nvme_sq.qid, queue->send_list_len, c);
+}
+
 static void nvmet_tcp_release_queue_work(struct work_struct *w)
 {
 	struct nvmet_tcp_queue *queue =
@@ -1441,6 +1468,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
 	nvmet_tcp_uninit_data_in_cmds(queue);
 	nvmet_sq_destroy(&queue->nvme_sq);
 	cancel_work_sync(&queue->io_work);
+	nvmet_tcp_free_resp_list(queue);
 	sock_release(queue->sock);
 	nvmet_tcp_free_cmds(queue);
 	if (queue->hdr_digest || queue->data_digest)
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
