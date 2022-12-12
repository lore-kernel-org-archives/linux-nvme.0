Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 776B2C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 09:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HipqxmwVjPNb97n9V5rBkPA4LruCJsniyVKWkKTZKGU=; b=Sn6WZO6eYJ89rSkm+2aO/ldta1
	YzUhE0/EDofKh33XkCnQ+wTcPPRQAvQ7fOm2gPU7xV+xMHIp37jvvizB/pPR+YglhuSkXnf2GwrGD
	0rz1ueP3JM9WEnXGU2v5OQI1n8t9XWMa5Wv93FPPna8YUg1Dco7cJ4xKiHU8mXdUNcs+kv282RT4G
	ehTpUAkuqi+63B5yBlE3skIf0fao8i6FjKKwnulu4BbCCutGyJNAfmyhB5rhnJkvM+v7dqzBXigHx
	WovyAVDwhcLgfzHQ1+nrywioJJX1X5ukubTUvIa1jzHZWeMTHbM2pBfKto07/2EBktE2J2TEwRoTf
	iaTymPEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4fLA-00BevC-FP; Mon, 12 Dec 2022 09:43:16 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4fKd-00BeV5-Nw
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 09:43:07 +0000
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BC426I9018035
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 04:42:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=HipqxmwVjPNb97n9V5rBkPA4LruCJsniyVKWkKTZKGU=;
 b=feFc11tncyGb8o/RHaSvbBWP2wkgqxz3lQh1INZlI7pjVMjSyz4LGr56UPKYdMEooGdA
 B5Jjgs3LI04QxogeyLePBPq43HixFwpPI2g9EWJpRWYQN6n/ttEQ/7CxnfLdg6zjbMTG
 VRrdhyKCjKpMKhslgVKRCUggNpVTOxYb8YhJE65qQYVoXvIcq/W1fskhbSRo2YjtNLic
 Vyd7oD5SP9c5pDCn3HO+9BRD6835PTIBKu5ZiEJiy9TfH2ZIGB/f/AXY3YnPU+4BxqFh
 vFXos5T98S6ZvxMKuCF2IIANNWlocr1ZF2ZT01pGsmDeRJi8Ta9dm9twQkLdpgCIQA13 hg== 
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3mcq0r844q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 04:42:37 -0500
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BC9fnVl036154
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 04:42:36 -0500
Received: from esaploutpc102.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3md8hfdbgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 04:42:36 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6500,9779,10558"; a="163138967"
Received: from unknown (HELO vd-engela.xiolab.lab.emc.com) ([10.55.227.144])
  by esaploutpc102.us.dell.com with ESMTP; 12 Dec 2022 03:42:34 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Date: Mon, 12 Dec 2022 11:42:29 +0200
Message-Id: <1670838149-3147431-1-git-send-email-amit.engel@dell.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
References: <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-08_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120089
X-Proofpoint-ORIG-GUID: -Z_lvn-tytdoERjKgtbH-EszQEXMcoeq
X-Proofpoint-GUID: -Z_lvn-tytdoERjKgtbH-EszQEXMcoeq
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120090
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_014259_680712_EA8FED04 
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Amit Engel <Amit.Engel@dell.com>

This provides additional details about the rq/cmd that is timed out

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
---
 drivers/nvme/host/constants.c | 16 ++++++++++++++++
 drivers/nvme/host/nvme.h      | 13 +++++++++++++
 drivers/nvme/host/tcp.c       |  7 +++++--
 3 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index e958d5015585..81a1d1d8d506 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -54,6 +54,14 @@ static const char * const nvme_admin_ops[] = {
 	[nvme_admin_get_lba_status] = "Get LBA Status",
 };
 
+static const char * const nvme_fabrics_ops[] = {
+	[nvme_fabrics_type_property_set] = "Property Set",
+	[nvme_fabrics_type_property_get] = "Property Get",
+	[nvme_fabrics_type_connect] = "Connect",
+	[nvme_fabrics_type_auth_send] = "Authentication Send",
+	[nvme_fabrics_type_auth_receive] = "Authentication Receive",
+};
+
 static const char * const nvme_statuses[] = {
 	[NVME_SC_SUCCESS] = "Success",
 	[NVME_SC_INVALID_OPCODE] = "Invalid Command Opcode",
@@ -185,3 +193,11 @@ const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
 		return nvme_admin_ops[opcode];
 	return "Unknown";
 }
+EXPORT_SYMBOL_GPL(nvme_get_admin_opcode_str);
+
+const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode) {
+	if (opcode < ARRAY_SIZE(nvme_admin_ops) && nvme_fabrics_ops[opcode])
+		return nvme_fabrics_ops[opcode];
+	return "Unknown";
+}
+EXPORT_SYMBOL_GPL(nvme_get_fabrics_opcode_str);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 16b34a491495..c247daf8c86a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1057,6 +1057,7 @@ static inline bool nvme_multi_css(struct nvme_ctrl *ctrl)
 const unsigned char *nvme_get_error_status_str(u16 status);
 const unsigned char *nvme_get_opcode_str(u8 opcode);
 const unsigned char *nvme_get_admin_opcode_str(u8 opcode);
+const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode);
 #else /* CONFIG_NVME_VERBOSE_ERRORS */
 static inline const unsigned char *nvme_get_error_status_str(u16 status)
 {
@@ -1070,6 +1071,18 @@ static inline const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
 {
 	return "Admin Cmd";
 }
+
+static inline const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode)
+{
+	return "Fabrics Cmd";
+}
 #endif /* CONFIG_NVME_VERBOSE_ERRORS */
 
+static inline const unsigned char *nvme_opcode_str(int qid, u8 opcode, u8 fctype)
+{
+	if (opcode == nvme_fabrics_command)
+		return nvme_get_fabrics_opcode_str(fctype);
+	return qid ? nvme_get_opcode_str(opcode) :
+		nvme_get_admin_opcode_str(opcode);
+}
 #endif /* _NVME_H */
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


