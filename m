Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED505C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 19:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xJNB8F5wG89/VvsFy5KRXRTsuZY6oPwiPdl3Dq+gYXk=; b=fUIXBjiNE6jAhpiX0D/wqqed3/
	v4WINIeilb8W/LnWpFsERq6eG4Btgo3BNIzWGEODDCp3GkvlMT55ghvS1c7Zu0jDNPXDyTbtBUq1X
	WLtJPu8SZCZaVN0G8zM4h8Zt415XH/Ibr5tUQP7UwRbPAx0FFZ6kbGq9GTvVIKwbv7bUJUo3Tc8YV
	RDqIszFqnebOcVSVDuX4b5yMR+H6+cA63b2dy+jNPoGspdEsXlqVwMx47g5Rs79a2fm/ldXjNsQer
	BY4lyuruJTnezzmY87kprBpL9s2VVOF+gif1PqFN43NvJ6Y6y9JKAnZ8UIJcuHCWWXPS9BPYrsBZj
	fh+Xci9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ofY-004eAz-CT; Mon, 12 Dec 2022 19:40:56 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ofO-004dn7-JX
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 19:40:47 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCFxCWr032513
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=smtpout1; bh=xJNB8F5wG89/VvsFy5KRXRTsuZY6oPwiPdl3Dq+gYXk=;
 b=lhBACwFj3mDL9s/XIGj4U+IGoHc60PFSoNx3uycYfr6NOKRAwUDZgC927USS/3T5Yjm3
 PCdpSQiWEdp1vQefjDmECjGcH/2yUHdP7DwascJszcFzWT5bX1PbhixfugdCyVZOrhNp
 a0HDtP0NYPvcJM07lVku/b4IOKKMVPe7K+IjqBc4Th3uJkwLsD2eGSK5Br9a22UT14Kp
 lExXvpwq06YjEXBYuwZamswDyd20gMb3D6ddR+XQGGWMpkmL4ig5KbPxP2JhG1BbN/ZM
 gQMqmvYgZ1m0XVGBTjEtmrcpZbEseFIDxNlamIOgTaBB1o1ucrUivR7O8oGSV9yBjSp/ QA== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3mcqnu34ya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:45 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCJTw6X024820
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:45 -0500
Received: from esaploutpc103.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3me7h9tr3q-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:45 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="114486708"
Received: from unknown (HELO vd-engela.xiolab.lab.emc.com) ([10.55.227.144])
  by esaploutpc103.us.dell.com with ESMTP; 12 Dec 2022 13:40:45 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH 2/2] nvme-tcp: add additional info for nvme_tcp_timeout log
Date: Mon, 12 Dec 2022 21:40:36 +0200
Message-Id: <1670874036-3222795-3-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1670874036-3222795-1-git-send-email-amit.engel@dell.com>
References: <1670874036-3222795-1-git-send-email-amit.engel@dell.com>
In-Reply-To: <1670855159-3182917-3-git-send-email-amit.engel@dell.com>
References: <1670855159-3182917-3-git-send-email-amit.engel@dell.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120176
X-Proofpoint-GUID: mRdj9M1oxj85mAMHX0GLCPRFV0cC_h83
X-Proofpoint-ORIG-GUID: mRdj9M1oxj85mAMHX0GLCPRFV0cC_h83
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_114046_777153_6358DD6F 
X-CRM114-Status: GOOD (  16.46  )
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


