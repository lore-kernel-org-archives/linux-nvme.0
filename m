Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71ABBC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 11:57:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDC8B233F7
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 11:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDC8B233F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u4hE1c6uKlqWfNPuIL6g0q+CfupnYFE+OmusKkaagOo=; b=jNce//61DrHrLsEnlxVcOI2lNG
	wU1+jtmb3EjpXB1qGTeKHMQmufrAsgcAJwPA3H7eNi7sP3J8pbqi1V6phhVhT+6i1nYp5MrGf57bj
	hW0tJhnNPDmbRlTyj3/kdcDBI+mMEG4RxkNpJcLI3YKXlUaknfJBvohC8lWMaRc6HocPncGncvQVV
	qSRYELFbkm8h2oJm7qSIw22uvzvAmk2ofO+I/0nuxEGUZbzaiUVzIe4xC1vsNh7/nHXNWHR03J7Si
	Fi/C6Ix2aT/Oi/u56c6KbVzHmvQ7X+1gpLXiLTYUeXkZC6Uh5dCKTwZeOOMI9I1MQd8ouA9rZx62i
	tk33mR+g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzely-00079U-Pm; Wed, 13 Jan 2021 11:57:10 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzelt-00078T-To
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 11:57:07 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10DBrUc6015318
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 06:57:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=7s0OuJh8ZVcb0+zT6V1Q9rXLs91YdNMH5x2JJ19F8pQ=;
 b=m6TJyW8DhQY3w3KQIpeAhnJ9dkXUHtnFRKJ3ao/v4fQ4syoapiwDlERJU5l2oCaetdOe
 lK6bqDi0dJt1XZ36TLhqGTnp/A1xLFiUVMFHv3ByOLBSFWl4dKA7kBNl5ptMtu8fzvXn
 KKeOjVXouEt5N9J1E1vA0P44HGRH/zhs8dyHNXPvTRXmYoR/7QnUOTU/ivGMXUuRFKeu
 BHP7VPduVMgj8VO5vewBavxsyfdYiXXw3i78ZNeKgAZsFN/bDMSrtHBchd5PA+CPMjCI
 PwYhv2Q8zYLrjFEkNaS3+O2AEZQpaMJ8xHSXm7fCZwEYDo6QfKbo2wsu0J+MsPjbGgJ/ Ug== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 361fy9k18d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 06:57:02 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10DBpWe6090849
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 06:57:02 -0500
Received: from esaploutdur05.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 361v8wuqfs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 06:56:59 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.148
Received: from vd-grupie.xiolab.lab.emc.com ([10.55.224.148])
 by esaploutdur05.us.dell.com with ESMTP; 13 Jan 2021 05:51:56 -0600
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Date: Wed, 13 Jan 2021 13:51:52 +0200
Message-Id: <20210113115152.69692-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.16.5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-13_07:2021-01-13,
 2021-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 phishscore=0
 impostorscore=0 spamscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101130073
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101130073
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_065706_177555_849D208A 
X-CRM114-Status: GOOD (  18.99  )
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
Cc: Elad Grupi <elad.grupi@dell.com>
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
 drivers/nvme/target/tcp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d535080b781f..dea94da4c9ba 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -146,6 +146,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
+static void nvmet_tcp_queue_response(struct nvmet_req *req);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -476,7 +477,11 @@ static struct nvmet_tcp_cmd *nvmet_tcp_fetch_cmd(struct nvmet_tcp_queue *queue)
 		nvmet_setup_c2h_data_pdu(queue->snd_cmd);
 	else if (nvmet_tcp_need_data_in(queue->snd_cmd))
 		nvmet_setup_r2t_pdu(queue->snd_cmd);
-	else
+	else if (nvmet_tcp_has_data_in(queue->snd_cmd) &&
+			nvmet_tcp_has_inline_data(queue->snd_cmd)) {
+		nvmet_tcp_queue_response(&queue->snd_cmd->req);
+		queue->snd_cmd = NULL;
+	} else
 		nvmet_setup_response_pdu(queue->snd_cmd);
 
 	return queue->snd_cmd;
-- 
2.16.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
