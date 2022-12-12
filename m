Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBB5C00145
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=K2fE0xAg7WoZXfC5bwyscI4QqpB1iVUL7sfu+SRqprM=; b=OArM/Z8Uwegs99SIyc31WLg9fi
	Hh2k+WdZDuhjbmdBCnsbLtAxmeAlyR1f/a88c5l0q3q+JRzWTYdLadpb4TdV8fc/18KNyQuFHiUO2
	nA8SE05g8AByabWIjdQwTjbsMHmGZwZPUKcaBQgE3L1Dbj5vPct/Z5SVnTHIz99XDVK3u/LDCBxHG
	Nxm+Hu6qqshozA9pCnhwq5b3r8ktvhBzQnbBdTsITIY0Wx0Jcp22BeuJ46Pp9niXVbI7nd8quF6MT
	X6TEmuqWnVs6F4CQfc5vIHEw8NaEbBV1curOvjZDLQ7kSs/F0wihMHxOeK67NonvOBZbaOivvQ+xg
	F1BUT9pQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ofU-004e00-3r; Mon, 12 Dec 2022 19:40:52 +0000
Received: from mx0b-00154904.pphosted.com ([148.163.137.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4ofN-004dmU-59
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 19:40:46 +0000
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
	by mx0b-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCGQBkQ031898
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=smtpout1; bh=K2fE0xAg7WoZXfC5bwyscI4QqpB1iVUL7sfu+SRqprM=;
 b=ZhYjz1W0Y8ciqIFbBRXa9WcOApHF2bsVBM5mYfFxXylcpA+Yr4qcCfEvpf+eTw/fFPB0
 ccG8LFcDRZqDwXpe0ShrawM7PGHLF737wSIRgifVQnHjP3r2va3hPXOEz+Lfm4Sh7gdq
 R15MdXYD4/+hxw4YXOBaC7Eb/eJlp19WoAmeYSa+rEy2CHPf1lVsr61uZL/waogxQ3lH
 VMBXhMPyltvmNPQUug3WVDYLQipIZ9CfMWfCKUhh0p32sB4ctcYYpbneKggTqzuorYNh
 p6muefVAB+METuoTk0Zi5EH5Y7Zs8K8N/PVCEAEeMW+rSqpy69vxEwyxpK4P1Kb3yicA Pw== 
Received: from mx0a-00154901.pphosted.com (mx0b-00154901.pphosted.com [67.231.157.37])
	by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 3mcqnu34y7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:44 -0500
Received: from pps.filterd (m0089484.ppops.net [127.0.0.1])
	by mx0b-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCJTw6V024820
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:44 -0500
Received: from esaploutpc103.us.dell.com (smtp-outbound-pc1.dell.com [143.166.24.15])
	by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 3me7h9tr3q-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 14:40:43 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6500,9779,10559"; a="114486706"
Received: from unknown (HELO vd-engela.xiolab.lab.emc.com) ([10.55.227.144])
  by esaploutpc103.us.dell.com with ESMTP; 12 Dec 2022 13:40:43 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd types
Date: Mon, 12 Dec 2022 21:40:35 +0200
Message-Id: <1670874036-3222795-2-git-send-email-amit.engel@dell.com>
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
X-Proofpoint-GUID: 9FRSvV-mIzIudQxxzq-ECR0agN5J1MpZ
X-Proofpoint-ORIG-GUID: 9FRSvV-mIzIudQxxzq-ECR0agN5J1MpZ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212120177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_114045_564858_DDDA98F2 
X-CRM114-Status: GOOD (  17.09  )
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

nvme_opcode_str will handle io/admin/fabrics ops

This improves NVMe errors logging

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
---
 drivers/nvme/host/constants.c | 16 ++++++++++++++++
 drivers/nvme/host/nvme.h      | 13 +++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index e958d5015585..bc523ca02254 100644
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
+	if (opcode < ARRAY_SIZE(nvme_fabrics_ops) && nvme_fabrics_ops[opcode])
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
-- 
2.31.1


