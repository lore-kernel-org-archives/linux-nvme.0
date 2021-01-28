Return-Path: <SRS0=ghx+=G7=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C72C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 15:28:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1645B64DFA
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jan 2021 15:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1645B64DFA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=540jkbNlFXIu539dzSi5XAnP7ukDPRAWtDokEvPyBD8=; b=Oj1ExYKl/NOkipyrk0kJjao+w1
	nV0gT61FnLJAY1dMM/EZoMEdGyCsHa62DYtkasaKrVX0XeWXzvmi4uMD6IdolqfIqhg3jACck1k5E
	/2wy6fXtbwaOS39hEQYqqahM/QqhxSscMivRHpOByCzW0OflmoM2tKDXS1czkePNcRnQJvXI4Oi0k
	sZr4f2XsjNVfGdcB2nbtWl2EZ5j/Y8pmiaRHuxg3FXgRm5tdXAY9Gjq7HIPJeD2SVQNnB0TAm2+7x
	f+bXiSaXiVsxvJbFinkDYhhWTLYuj0bjoRRx8dpb2FHOvr5y6znV2v8XpCHg9py+/oGx19aeR9p22
	g20QQQKw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l59De-0007gn-BE; Thu, 28 Jan 2021 15:28:26 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l59DL-0007aX-TL
 for linux-nvme@lists.infradead.org; Thu, 28 Jan 2021 15:28:09 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SFNC2O007882
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 10:28:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=9jx+EOBo5hsvvumrMimnPl9X6tF/IRnUZTfZ9Z6L4GQ=;
 b=E7i1Ed4EFbOuEGYUqutvU6K94OwfM2PGCU0LxHmMWRUiBa5JXs5wngbSszjmhpDoHPW2
 EiuMCAM+zNDCmlPHqGD5DN3g8XvL9jURM9xO0OyNaIMG1Haxq4ykTmW3h3zvB/qXm4RA
 kl0LjVW17kLQcubWfSxZ6VtZOJF7PE0XBsgM6/K26/z5+zyGf3UA6tcOoqPHA5E71ZC5
 Lf9umUvybuKznRUe+SRikZlSyJ2aRKfnIFniA3AbsRY0gJ6T00ZZVDxzHXUWYHq08IyC
 Z6EWd0x1tlh8sD8fhRUlxYvxrFeTEa6ZmQlOSIVw9lvTPIbop9v7QVpg1tEDQuhqifCV /w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com with ESMTP id 368g0q9a73-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 10:28:05 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10SFKXm3108058
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 10:28:05 -0500
Received: from esaploutdur04.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 36928rc7pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 28 Jan 2021 10:28:05 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.148
Received: from vd-grupie.xiolab.lab.emc.com ([10.55.224.148])
 by esaploutdur04.us.dell.com with ESMTP; 28 Jan 2021 09:28:03 -0600
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp: proper handling of tcp socket closing flows
Date: Thu, 28 Jan 2021 17:27:58 +0200
Message-Id: <20210128152758.114112-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.16.5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-28_11:2021-01-28,
 2021-01-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 clxscore=1015
 adultscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101280079
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101280079
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210128_102808_126332_502DBB6C 
X-CRM114-Status: GOOD (  19.39  )
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

avoid calling nvmet_tcp_release_queue_work if tcp socket was closed
before setting the sk callbacks.

Signed-off-by: Elad Grupi <elad.grupi@dell.com>
---
 drivers/nvme/target/tcp.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d535080b781f..dac737bac874 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -647,7 +647,7 @@ static int nvmet_tcp_try_send_one(struct nvmet_tcp_queue *queue,
 	struct nvmet_tcp_cmd *cmd = queue->snd_cmd;
 	int ret = 0;
 
-	if (!cmd || queue->state == NVMET_TCP_Q_DISCONNECTING) {
+	if (!cmd) {
 		cmd = nvmet_tcp_fetch_cmd(queue);
 		if (unlikely(!cmd))
 			return 0;
@@ -1453,9 +1453,27 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	sock->sk->sk_state_change = nvmet_tcp_state_change;
 	queue->write_space = sock->sk->sk_write_space;
 	sock->sk->sk_write_space = nvmet_tcp_write_space;
+
+	switch (sk->sk_state) {
+	case TCP_FIN_WAIT1:
+	case TCP_CLOSE_WAIT:
+	case TCP_CLOSE:
+		/* FALLTHRU */
+		sock->sk->sk_data_ready =  queue->data_ready;
+		sock->sk->sk_state_change = queue->state_change;
+		sock->sk->sk_write_space = queue->write_space;
+		sk->sk_user_data = NULL;
+		queue->state = NVMET_TCP_Q_DISCONNECTING;
+		ret = -ENOTCONN;
+		break;
+	default:
+		queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
+		ret = 0;
+	}
+
 	write_unlock_bh(&sock->sk->sk_callback_lock);
 
-	return 0;
+	return ret;
 }
 
 static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
@@ -1506,8 +1524,6 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_destroy_sq;
 
-	queue_work_on(queue->cpu, nvmet_tcp_wq, &queue->io_work);
-
 	return 0;
 out_destroy_sq:
 	mutex_lock(&nvmet_tcp_queue_mutex);
-- 
2.16.5


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
