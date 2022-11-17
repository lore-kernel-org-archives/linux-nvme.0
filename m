Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31B0FC433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Nov 2022 13:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lYBXRrnQGaqCIHYsFfWCTnxaM02xYGlRBlASwQc4RhU=; b=NzpwyzALBoXmzV8H/mXJmDuyrk
	0djTQ5R6ur1ysLw5bi/GfUFm04k2MI2vLJ5qhtkvKWIUB+umVGI92T89rGtm1uNQ4+Z+LqwQhyZfe
	WDM4oq3z7QsxzGkc6d0Ja1LXoxGFVoTM8h3eQ34nrbjqOTic7SKFapiqKq6CzGPBzs/wGcat1kyA1
	HvsVyOSXORBtUmy0s+5PjALRJqAYHLGKHbHTkWBGmECDC9+gs4lPGZKDGfClKp7Mb4gckEztXxyYr
	JpO2Kjj6/HECmRSwOBFLrSjQlFMPJUNKJ2Jj/fSO94wXHvUkrJAtjDruVktF11oxWrE6wOGftSwB0
	D7WZmtCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oveis-00E7YM-Vu; Thu, 17 Nov 2022 13:14:31 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oveiI-00E7CS-98
	for linux-nvme@lists.infradead.org; Thu, 17 Nov 2022 13:13:57 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHC0Ppn012592
	for <linux-nvme@lists.infradead.org>; Thu, 17 Nov 2022 08:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=lYBXRrnQGaqCIHYsFfWCTnxaM02xYGlRBlASwQc4RhU=;
 b=jPA+HBTYP8SefFaTPpOiDIYhcG/SpnbpQ/r8HagTLH4/de1f+qg0wxabeQyHCpjQMNfh
 zd7qJKWr6Swt+PSmZlhjl0y4H+907Q2fCbXfitqN1PWQOF00NMuQwcBo3SzKfv+8Awh/
 q3Lj80VjwyEJ5edt8rzvaSnydyPH/R1Xs01On6yG4CXV+DLb4FnbrkQmr1feSs+BkdRu
 8Q44RjmxmkyMAUnLMi7E1xWNnW2fmgqEG5d3Ws7N3wUJPhwREoSMOTC3p7MNuHI8yYkd
 n8jtrmTcqldHcDicfZydiHijdosK+5mxocQ0Tvz4I9QjPBrbYJz6Nu5Tf+syrbUWisi1 Xg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3kwmk48xeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Thu, 17 Nov 2022 08:13:51 -0500
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHDCmhY009862
	for <linux-nvme@lists.infradead.org>; Thu, 17 Nov 2022 08:13:50 -0500
Received: from esaploutdur03.us.dell.com ([128.221.233.10])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3kwnky838n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Thu, 17 Nov 2022 08:13:50 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="261842241"
Received: from vd-engela.xiolab.lab.emc.com ([10.55.227.144])
  by esaploutdur03.us.dell.com with ESMTP; 17 Nov 2022 07:12:59 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Date: Thu, 17 Nov 2022 15:13:44 +0200
Message-Id: <1668690824-2034939-1-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
References: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 clxscore=1015 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170100
X-Proofpoint-GUID: xLZ9GJXMSL5NnlUXMuW_YCIrHa0tdfHB
X-Proofpoint-ORIG-GUID: xLZ9GJXMSL5NnlUXMuW_YCIrHa0tdfHB
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 bulkscore=0 suspectscore=0 phishscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211170100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221117_051354_453636_5F38389E 
X-CRM114-Status: GOOD (  15.28  )
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
 drivers/nvme/host/tcp.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 1eed0fc26b3a..5abaff5d6f6e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2277,8 +2277,11 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
 
 	dev_warn(ctrl->device,
-		"queue %d: timeout request %#x type %d\n",
-		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
+		"queue %d: cntlid %u timeout request %#x type %d cid %u opcode %#x "
+		"start time %lluns io start time %lluns request timeout %ums\n",
+		nvme_tcp_queue_id(req->queue), ctrl->cntlid, rq->tag, pdu->hdr.type,
+		pdu->cmd.common.command_id, pdu->cmd.common.opcode,
+		ktime_sub_ns(ktime_get(), rq->start_time_ns), ktime_sub_ns(ktime_get(), rq->io_start_time_ns), jiffies_to_msecs(rq->timeout));
 
 	if (ctrl->state != NVME_CTRL_LIVE) {
 		/*
-- 
2.31.1


