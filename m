Return-Path: <SRS0=kiw1=GR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A804BC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:05:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6402023A57
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jan 2021 13:05:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6402023A57
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=dell.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=opoJjp6oRRSTvVm36nkZhJ/U7QlAWfsZ/vmECR8diD8=; b=tirxQlTi/mQ/+SizdGAzAnBHPY
	GQHBwZL3t9jXSyKReHXNTbAiihJS9Ey0tzEUPs8o3TUFZ8N2p0RzMltDRQHIbwiY9Lzd5B+RPcdzx
	InC0l489rKq/Zm28c5RUaxD2RRJ5YrakNgYuinbWd7pVwpBiUl5jmSt7+33zxzYaA/0Az4x8jP7xp
	g5ViVPQXBlM3LSgh6yUtRG8hbiwYLMqsrSni+6BjWw1G9lCGU4wldNFqZT3U/kqGge3OkRP81BYpV
	3FmBTyMv2alevcXn4B7TQvRdMhBoT43ev6G2Myj9pKezBoVA8tag1to/kvyD52qUcrZcDELJWJFp+
	vAMZWEHA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l02J9-0005Cc-TZ; Thu, 14 Jan 2021 13:04:59 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l02J6-0005C8-K3
 for linux-nvme@lists.infradead.org; Thu, 14 Jan 2021 13:04:57 +0000
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10ECgJoA025078
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 08:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com;
 h=from : to : cc : subject : date : message-id; s=smtpout1;
 bh=wI/12JKRvT/0S3GM9iniNldLVzmcIxjZFUw3i6HL61U=;
 b=gHyzNiJU57b+COD5rDcbTS6WDPh9lOLzzhbYQlQ9TnMkVc8Tx8FsFygoNPIpoFJGauT8
 0QrECIg4Cn5YjvolF7+7E0PePWAqugTP/iy+BjL/BcyrLwtoJG0dq/ujzhWreNZ32ynp
 kso3kO37DtRatXi233M90uOadKACiityXU6J3DgT9YJ+Zha1XapWBlnbccC/sFWVcR+D
 bLr1BOrz1Nv9AZSQHbAn6ShDIu4n6dGP10CgeaxzWOoIRUIWmYkp3N/zp2L9HCEyEgjf
 ems2rn/oySKmoIvRmYDG8dnwyHvnjIs3aulmU5Aap3Sj0v60pOSsyKuLKKfqbR9bj1G5 iw== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com with ESMTP id 361fyuf5y7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 08:04:54 -0500
Received: from pps.filterd (m0134318.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 10ECfPXu188727
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 08:04:54 -0500
Received: from esaploutdur06.us.dell.com ([128.221.233.10])
 by mx0a-00154901.pphosted.com with ESMTP id 362cv5xrgx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linux-nvme@lists.infradead.org>; Thu, 14 Jan 2021 08:04:53 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.224.148
Received: from vd-grupie.xiolab.lab.emc.com ([10.55.224.148])
 by esaploutdur06.us.dell.com with ESMTP; 14 Jan 2021 07:04:52 -0600
From: elad.grupi@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-tcp: fix a segmentation fault during io parsing error
Date: Thu, 14 Jan 2021 15:04:48 +0200
Message-Id: <20210114130448.91349-1-elad.grupi@dell.com>
X-Mailer: git-send-email 2.16.5
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343, 18.0.737
 definitions=2021-01-14_04:2021-01-14,
 2021-01-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140075
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101140075
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_080456_770774_30B097CA 
X-CRM114-Status: GOOD (  21.42  )
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
 drivers/nvme/target/tcp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index d535080b781f..f181744b0214 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -146,6 +146,7 @@ static struct workqueue_struct *nvmet_tcp_wq;
 static struct nvmet_fabrics_ops nvmet_tcp_ops;
 static void nvmet_tcp_free_cmd(struct nvmet_tcp_cmd *c);
 static void nvmet_tcp_finish_cmd(struct nvmet_tcp_cmd *cmd);
+static void nvmet_tcp_queue_response(struct nvmet_req *req);
 
 static inline u16 nvmet_tcp_cmd_tag(struct nvmet_tcp_queue *queue,
 		struct nvmet_tcp_cmd *cmd)
@@ -476,7 +477,15 @@ static struct nvmet_tcp_cmd *nvmet_tcp_fetch_cmd(struct nvmet_tcp_queue *queue)
 		nvmet_setup_c2h_data_pdu(queue->snd_cmd);
 	else if (nvmet_tcp_need_data_in(queue->snd_cmd))
 		nvmet_setup_r2t_pdu(queue->snd_cmd);
-	else
+	else if (nvmet_tcp_has_data_in(queue->snd_cmd) &&
+			nvmet_tcp_has_inline_data(queue->snd_cmd)) {
+		/*
+		 * wait for inline data before processing the response
+		 * so the iov will not be freed
+		 */
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
