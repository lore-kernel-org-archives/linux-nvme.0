Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2184C4708D
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 20:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gHXRQDEOc+8XI4P1rt0nzlXLbzWjqF4XepK3VWdthhQ=; b=fd9xMTPOas3gQ1qT/N70o+Yvu1
	rk326b4nrMDug2lHexkJWZ3eEp6qWpRiTXMAxef1bmgl9dRY7ykAZ6m3PwTtDRVfz7nfOP54PNZ/l
	sYcP9cgVzF4+vZHMZ0sCn2YSYtYcTfnjfIgepmxGOKiU0TgoXwXwSPp8VBBuJ/IdwUDg5jWI8QV0d
	dGbeIYLreQbRzzaxFh7kNe2dkORzeevqHqAs1ZfGjez6CI6jelqnPIRV2p1JqJjjXf+5FyZfN8pTr
	F7DBictNZ+YiTwM8dRz7YW4J7XB+ALK5RoxjZ1iasdR91/R1mnADIpf28ydTAg5U9RXuksDQSu2aP
	/DNGF+Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p30yR-00BlOM-T7; Wed, 07 Dec 2022 20:24:59 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p30yO-00BlGi-MT
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 20:24:58 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B77GJwI032193
	for <linux-nvme@lists.infradead.org>; Wed, 7 Dec 2022 05:58:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=gHXRQDEOc+8XI4P1rt0nzlXLbzWjqF4XepK3VWdthhQ=;
 b=kTQF1v0Lu9hJDnMN0PLyHJXL5rw45LEWrn9vLbtY6KKk7Qe6uswK6yaADwxdTxmDLUuy
 30NcK9Zq0ltVn/L9QHFKM5bbRKAJjLOlU5RABRQU7NnGAy6O3Aj4Erm81Gl1dscn8kcr
 W8spQNUUqGHtT1z0BzlHmsUZmPxOZj3X2/A1+373p5Sntipf5YBKxEgmXkFbN94+olZ+
 llbDO3D9fW+GvrE7smDOuqRJDeixscVMqYcFYU3V0Pm+dEFeY6/qLlEgILcdoVgr9Mgw
 HQynfV9LI6EcrtkWtsGcCxscaOIqPXO4P/CP+U73oskGQJC2QUKJ6ZGAx1j3t7tcKuV3 /w== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3m840usabu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 05:58:40 -0500
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B7AwGTC029465
	for <linux-nvme@lists.infradead.org>; Wed, 7 Dec 2022 05:58:39 -0500
Received: from esaploutpc106.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3mam9m4m90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 05:58:39 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="160066843"
Received: from unknown (HELO vd-engela.xiolab.lab.emc.com) ([10.55.227.144])
  by esaploutpc106.us.dell.com with ESMTP; 07 Dec 2022 04:58:31 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Date: Wed,  7 Dec 2022 12:58:27 +0200
Message-Id: <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1669889667-1034818-1-git-send-email-amit.engel@dell.com>
References: <1669889667-1034818-1-git-send-email-amit.engel@dell.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_05,2022-12-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 bulkscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070094
X-Proofpoint-ORIG-GUID: u4EC9vDgZ09wzAz8GrDw5BdcjFR_pvHg
X-Proofpoint-GUID: u4EC9vDgZ09wzAz8GrDw5BdcjFR_pvHg
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070092
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_122457_051677_1FAB6133 
X-CRM114-Status: GOOD (  16.80  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <Amit.Engel@dell.com>

This provides additional details about the rq/cmd that is timed out

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
---
 drivers/nvme/host/tcp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1eed0fc26b3a..f2be7c23ace5 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2277,8 +2277,9 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
 
 	dev_warn(ctrl->device,
-		"queue %d: timeout request %#x type %d\n",
-		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
+		"queue %d: timeout cid %#x opcode %#x type %d\n",
+		nvme_tcp_queue_id(req->queue), nvme_cid(rq),
+		pdu->cmd.common.opcode, pdu->hdr.type);
 
 	if (ctrl->state != NVME_CTRL_LIVE) {
 		/*
-- 
2.31.1


