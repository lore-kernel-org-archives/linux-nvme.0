Return-Path: <SRS0=9ZED=LE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0092C47094
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 09:11:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B720613F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Jun 2021 09:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B720613F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=WUglWmYCKvQHy90LuBja3fmstq90MSNuZb/Ccj8D+W0=; b=elmsa+anLIFtA0
	DUmNWTkmSG4LrKYYe+r2BmvN9ubEfXT4fl4Kogb3L6Ewm+5nLz123gI3SHg8k/dv8dELfDfqtr5WT
	DH54QrrxSJr+s00gWV7qnQvXKUxJ3UYvP9Up04uyN0LnoDJY/mKiMi6Q60h/P4ywxeJfBYjxobSEE
	57Qy4kUqrZul7WVZY8W6MCU69/F6TpTm+tFV6a+M44d91SgyDDLU7Se3nTzHvWYNprVidj9vxEX4u
	KDDb+19ulZ0dN3qZVDTA3U1PNd3S/J2MARX9T2I9Eeiwnb++QKqLvZOlbKOeTbxPbs8jPuejIRSDT
	XC7PwH3ErojHt40gsOBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lrGiN-0007Ni-O6; Thu, 10 Jun 2021 09:11:03 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lrGFf-00HYn9-FR
 for linux-nvme@lists.infradead.org; Thu, 10 Jun 2021 08:41:24 +0000
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15A8VbgE014665
 for <linux-nvme@lists.infradead.org>; Thu, 10 Jun 2021 04:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=hINSk1O/xERVEivG6bW4dHT/q9vNh1KECHLVZWdaYvA=;
 b=MeEt7/v7d9G/FPC4Sjk4NBtmw5cj9Vz6LAZO2si0UMeHLr4TIgJz5xBvrISCQF4P6pl2
 EGoKAjXRTUQcuv5kmiCRc0ZX9RjsopJOVpjzgyRk5y0zn/bmtUmVMW9njwdLOV1J7I+R
 +YMaS6VGK3PfhV0wUe1G8Uf7iJikXJBp5gu4hLW8KlA/5mezwHihWMXAdYuhHhLDmjNZ
 ra/E5xNfBvTBa3zK/C4R04fEKskc8Sa8jdEhsJ/b2pvqBBhPf9NZO4O7CRedC65z46Qa
 VQBb/b52kMdHRu3Y99x0487jYt3KTMyKtgg6HhRulyJvZC3Ak53TIpLGttpQdTDRGkF3 OQ== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com with ESMTP id 392r92wf68-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 10 Jun 2021 04:41:17 -0400
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 15A8f4RQ097474
 for <linux-nvme@lists.infradead.org>; Thu, 10 Jun 2021 04:41:17 -0400
Received: from esaploutdur01.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 390pumgsvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 10 Jun 2021 04:41:16 -0400
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.225.216
Received: from unknown (HELO vd-amite.xiolab.lab.emc.com) ([10.55.225.216])
 by esaploutdur01.us.dell.com with ESMTP; 10 Jun 2021 03:41:16 -0500
From: amit.engel@dell.com
To: linux-nvme@lists.infradead.org, sagi@grimberg.me
Cc: amit.engel@dell.com
Subject: [PATCH] nvmet-tcp: Add a multex lock to start_queue failure case
Date: Thu, 10 Jun 2021 11:41:12 +0300
Message-Id: <20210610084112.30400-1-amit.engel@dell.com>
X-Mailer: git-send-email 2.18.2
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391, 18.0.761
 definitions=2021-06-10_03:2021-06-10,
 2021-06-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 clxscore=1015 phishscore=0 impostorscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106100056
X-Proofpoint-GUID: pb5fn4lhXdBydj8JSszqCsvgkf3Lc4An
X-Proofpoint-ORIG-GUID: pb5fn4lhXdBydj8JSszqCsvgkf3Lc4An
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106100055
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210610_014123_609815_13F7725D 
X-CRM114-Status: GOOD (  16.43  )
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

this is in order to serialize nvme_tcp_stop_queue

Signed-off-by: Amit Engel <amit.engel@dell.com>
---
 drivers/nvme/host/tcp.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 6a65b0516180..091f861c2067 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1571,6 +1571,7 @@ static void nvme_tcp_stop_queue(struct nvme_ctrl *nctrl, int qid)
 static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 {
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
+	struct nvme_tcp_queue *queue = &ctrl->queues[idx];
 	int ret;
 
 	if (idx)
@@ -1579,10 +1580,12 @@ static int nvme_tcp_start_queue(struct nvme_ctrl *nctrl, int idx)
 		ret = nvmf_connect_admin_queue(nctrl);
 
 	if (!ret) {
-		set_bit(NVME_TCP_Q_LIVE, &ctrl->queues[idx].flags);
+		set_bit(NVME_TCP_Q_LIVE, &queue->flags);
 	} else {
-		if (test_bit(NVME_TCP_Q_ALLOCATED, &ctrl->queues[idx].flags))
-			__nvme_tcp_stop_queue(&ctrl->queues[idx]);
+		mutex_lock(&queue->queue_lock);
+		if (test_bit(NVME_TCP_Q_ALLOCATED, &queue->flags))
+			__nvme_tcp_stop_queue(queue);
+		mutex_unlock(&queue->queue_lock);
 		dev_err(nctrl->device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
 	}
-- 
2.18.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
