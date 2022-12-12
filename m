Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C335DC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 14:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJNB8F5wG89/VvsFy5KRXRTsuZY6oPwiPdl3Dq+gYXk=; b=ZwU8htG0Y9ykYboLzdw4ivrn2z
	6K5eFQiWzDmltIsZGNzNTEHa5htPFACakgo6KjMW6MZEXHbNJFJ7K8Yjqg/nM1XeKe38WleD4seo5
	IIXryIGqjpR/tFGYWD7/r9f6kFuxCztRp05iX4OW73rGv0hRr5zagvMLbnM/0S8ryYEnXX+cBYVuo
	mfYT+H+iB0ZsP0YfEwW9g23+oqEJ7Lhve+aXhjSCnIex+gY/3StCBPrifxPikWTUKfCSTQEIAJT6h
	ulUt8KuOC7p0DU+V4jMNGY1/wS7vV4lGryTpz6ZEEYJ3bWxRNDhbqU60p+yi8be5EtGdSIua2uc9D
	GPmMXi9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4jlA-00HRpx-U9; Mon, 12 Dec 2022 14:26:25 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4jl0-00HR8E-Il
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 14:26:16 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCB1hkJ018269
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=xJNB8F5wG89/VvsFy5KRXRTsuZY6oPwiPdl3Dq+gYXk=;
 b=TWLHap2njirq4ei5bIVD6t0qMSJk5eUhaRrEi8GVbSVEb6esd8Wb6z+KeVWd3uZnehTA
 GY0ukGOV97gRoPXncM2tRJaqAjosZacp6dXRMMKqId9xgZhtaRwJMu8gjX4TST6Nt0zh
 +XdexKWYMFWlAwPnWpj5SpAQyrjRvLmSF9xtP0XeXUIYopPnbLGfrl8SFfo/zPCjAHRE
 KKHBMEGM9DYEoph/K0QHYqZhiv+d+moogAoZTXrQL/2gkxobPUAl9ocFb+OIATSVgaAf
 JbZZFDsvNRgwUJKlLqbM7ax1A7oxSg85u1JdMS07OuDlGxlfphcnuSNzM3z1CKmLqf4M NA== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3mcq0r9hqm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:13 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCE8IMD006702
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:13 -0500
Received: from esaploutdur05.us.dell.com ([128.221.233.10])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3me0eg6a31-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:13 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="268537161"
Received: from vd-engela.xiolab.lab.emc.com ([10.55.227.144])
  by esaploutdur05.us.dell.com with ESMTP; 12 Dec 2022 08:25:47 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH 2/2] nvme-tcp: add additional info for nvme_tcp_timeout log
Date: Mon, 12 Dec 2022 16:25:59 +0200
Message-Id: <1670855159-3182917-3-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1670855159-3182917-1-git-send-email-amit.engel@dell.com>
References: <1670855159-3182917-1-git-send-email-amit.engel@dell.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120132
X-Proofpoint-ORIG-GUID: K6UEFZF9h6EQ-fTGBFBtMw8AZjb8ZMTS
X-Proofpoint-GUID: K6UEFZF9h6EQ-fTGBFBtMw8AZjb8ZMTS
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_062614_752464_9264BD59 
X-CRM114-Status: GOOD (  15.41  )
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

example log if CONFIG_NVME_VERBOSE_ERRORS is configured:
"nvme nvme0: queue 2 timeout cid 0xd058 type 4 opc Write (0x1)"

example log if CONFIG_NVME_VERBOSE_ERRORS is not configured:
"nvme nvme0: queue 2 timeout cid 0xd058 type 4 opc I/O Cmd (0x1)"

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
---
 drivers/nvme/host/tcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1eed0fc26b3a..2676f6787d30 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2275,10 +2275,13 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+	u8 opc = pdu->cmd.common.opcode, fctype = pdu->cmd.fabrics.fctype;
+	int qid = nvme_tcp_queue_id(req->queue);
 
 	dev_warn(ctrl->device,
-		"queue %d: timeout request %#x type %d\n",
-		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
+		"queue %d: timeout cid %#x type %d opcode %#x (%s)\n",
+		nvme_tcp_queue_id(req->queue), nvme_cid(rq), pdu->hdr.type,
+		opc, nvme_opcode_str(qid, opc, fctype));
 
 	if (ctrl->state != NVME_CTRL_LIVE) {
 		/*
-- 
2.31.1


