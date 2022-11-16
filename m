Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A57C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Nov 2022 13:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7wqGd1KIl2SP7OL+7LM23ukFQRdfuQLhPkt4xJootYQ=; b=WbcmDHCv4klNgaQEZgte+lvzmC
	gHv//vB+0AKPj7j9IPys4wv9OvzKTNad51uecD1l04Xu03QbceZQBXzpEfjRgzeKIR2xCpw7g54rz
	Sk2guJU39I9Mc5zjBGwuKItZFvSSGGVbbmTRv6kwuqbzoUeoy+Ngd2Oka6PB1VeSq9mwz6nm8jc1o
	ybx0PwJEv4B3Zihd9HymPAgSVlqnfbhpKhlZdJaJyMQHi4Cm1pONvOPQGFLiChAgR850JQW581FHC
	i1RGMNqs4aVSHn+YuRzJwQm5SHGiTn6kOg/BZhjNQjqTQJfYpLTXex33ubAUbDCNfcYrIVh3g7nYk
	+HFRfhsw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIwo-004LyY-W2; Wed, 16 Nov 2022 13:59:27 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ovIwT-004Lm0-LQ
	for linux-nvme@lists.infradead.org; Wed, 16 Nov 2022 13:59:07 +0000
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGDtYik018316
	for <linux-nvme@lists.infradead.org>; Wed, 16 Nov 2022 08:59:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id; s=smtpout1;
 bh=7wqGd1KIl2SP7OL+7LM23ukFQRdfuQLhPkt4xJootYQ=;
 b=admMWMjqDaP/AlzYttntTNuBbTX1VErtcgRXQHCn4UjTIwOYlGjh2AiRB/wGwbGT21D9
 OMRIczTV2rrq8QfYVw52d/jaWUQfEpwDBXVoVofvly8pGlkVPSWW160M5h6hQwsbkHOw
 RLFZq+0SqTGffxCe1IrtW9eOE/Ewz9p7d6vOoeXD6cveRuc0eMxr2TyqImW7PoIdt297
 7fWUaBJiHgQ42Xo1N293UNawUFFQePLXf27gBiypYgMJ3QwEB3SOB2p0UxR9saNyAtfW
 RQntvt6qOWBQ7kfHsT9cPz99K9XXzOBXJ1MChugplAiK9sOKfBl1dB9Kl+w1SCkL6Ukl iw== 
Received: from mx0b-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3kw15xr0gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Wed, 16 Nov 2022 08:59:00 -0500
Received: from pps.filterd (m0090350.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AGDtIo8029910
	for <linux-nvme@lists.infradead.org>; Wed, 16 Nov 2022 08:59:00 -0500
Received: from esaploutpc104.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3kw15r84d6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Wed, 16 Nov 2022 08:58:59 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6500,9779,10532"; a="134593509"
Received: from unknown (HELO vd-engela.xiolab.lab.emc.com) ([10.55.227.144])
  by esaploutpc104.us.dell.com with ESMTP; 16 Nov 2022 07:57:57 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH] tcp: add additional info for nvme_tcp_timeout log
Date: Wed, 16 Nov 2022 15:57:53 +0200
Message-Id: <1668607073-1814545-1-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-16_03,2022-11-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 spamscore=0 suspectscore=0 clxscore=1011 malwarescore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160097
X-Proofpoint-GUID: vI_Vz-K2QPpXBZedW_A-O52-O71KFHbs
X-Proofpoint-ORIG-GUID: vI_Vz-K2QPpXBZedW_A-O52-O71KFHbs
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160097
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221116_055905_911533_A6ACD210 
X-CRM114-Status: GOOD (  14.53  )
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


