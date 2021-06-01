Return-Path: <SRS0=ddWr=K3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F392C47093
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 16:22:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A03611CB
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Jun 2021 16:22:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A03611CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=9PZoBpCb0/0GrLkheEPJmX8mB7Rg17TfZISydm9YCvE=; b=sQwCQVeHQCvr2O
	/JuvCXtk4/AcN2gZLJtma8MrkqHlMDmFJcW78AyH7BvhKo9tpqGfhIHzF492XzjmUzfh3GcnPNZqb
	kQqembzYU1NqyGM1TPGBgc54y4fmCMVEaTy10KpNQPEZYLxBhXpkp8fO0MTLHtpa1R3DBnnrVQmbq
	ttWQ6ZflAN5IrAAycgkNnrai3WwyBuJ326/XyB/oil+Gd0uKt7e6pB/3UGrIL71lfcxQ6796pH7JW
	84F3x8HDas7BrhIHOWh6V55pkmcSodCFlOsHlnoSA0W0S2GkP//Msjdv1sce/KdxjbJPD6SSvAqcZ
	0aURnelPg4yyktikqCKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lo6qz-00HOYh-D8; Tue, 01 Jun 2021 16:02:53 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lo6qw-00HOXG-5i
 for linux-nvme@lists.infradead.org; Tue, 01 Jun 2021 16:02:51 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 151FvPRw010541
 for <linux-nvme@lists.infradead.org>; Tue, 1 Jun 2021 12:02:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=2JUtlJhGSwAJXgwXpe/X1CrHMrl7TgpDS3IZ+72fXqE=;
 b=YxUxHz7Cfe6aa2zjjafyXqoJxLzOPwTXFBGOmDOVPVN/Kql6QPbtnGRPQiVe/HdYYjy0
 iiEQI/QYM8KOGBlJXRvR0vthEtk8RVcgz7R84dVjsF841GDLU/p3iMKmNWoBAkofvx51
 fXvwwSKtNMlxg7IrkjiNhMCdz52LGiwkonecH8cOp0g2f4o618VQxAJy8U1VElxWp1D+
 x0EyWSOBfgC4CKwUMl8IP/WQsyfDVeTspS5YbkjD9vFEsMILz3v3SGphtXvw06mceBxO
 qtkYs6lfFc973JECrJcREuvv3wtA+tC/E6xwjlioHFT3a15aqROizSSOqnS16jttwsNO MA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 38vyx6mwf1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Tue, 01 Jun 2021 12:02:46 -0400
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 151G0FvC171675
 for <linux-nvme@lists.infradead.org>; Tue, 1 Jun 2021 12:02:45 -0400
Received: from esaploutdur02.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 38we22senq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Tue, 01 Jun 2021 12:02:45 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.98
Received: from vd-idand.xiolab.lab.emc.com (HELO vd-grupie.xiolab.lab.emc.com)
 ([10.55.224.98])
 by esaploutdur02.us.dell.com with ESMTP; 01 Jun 2021 11:02:43 -0500
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: Elad Grupi <elad.grupi@dell.com>
Subject: [PATCH] nvmet-tcp: fix memory leak when having inflight commands on
 disconnect
Date: Tue,  1 Jun 2021 19:02:34 +0300
Message-Id: <20210601160234.5200-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-01_08:2021-06-01,
 2021-06-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=948 spamscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106010109
X-Proofpoint-GUID: b546PxXyHZqurTuDsvAum62Im3BbvKQZ
X-Proofpoint-ORIG-GUID: b546PxXyHZqurTuDsvAum62Im3BbvKQZ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106010108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210601_090250_303046_DD41C205 
X-CRM114-Status: GOOD (  18.20  )
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
 drivers/nvme/target/tcp.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index f9f34f6caf5e..04d53b532ae2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1426,6 +1426,31 @@ static void nvmet_tcp_uninit_data_in_cmds(struct nvmet_tcp_queue *queue)
 	}
 }
 
+static void nvmet_tcp_free_resp_list(struct nvmet_tcp_queue *queue)
+{
+	struct nvmet_tcp_cmd *cmd;
+	int c = 0;
+
+	nvmet_tcp_process_resp_list(queue);
+
+	list_for_each_entry(cmd, &queue->resp_send_list, entry) {
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
@@ -1441,6 +1466,7 @@ static void nvmet_tcp_release_queue_work(struct work_struct *w)
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
