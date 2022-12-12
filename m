Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF08C4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 12 Dec 2022 14:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YarI+VZiKYFn3yWaVdwO9bda8bfDLtQQovTgWXqT2qw=; b=VyxK5czg/33WUT5sdqaQIlNm+m
	VrRALQ5M6Y6ScWGGIQkEnHdnmPRgDbWiQesrKtLsHN/mYB7gtghD3UUxdW+cqUSOaANju02z9xbbv
	6hbdSZcvgG7N1uKmwA2JTrRRY03mFXVqqfuD15fkeGCAAtiDkWCx9+w1dExBvEXEbJfV0fibbadwJ
	lYIFtiSG2aFwg62MFejDGqRA6pyVgl1ceV7g8EjMtI9tIE8EdQp0wV04mNh99aHHUdXvCrnTl/5y9
	sH8oqbasz5ZvATXkI0ZSF696Gt0qdKHfEKx6IzY7RrbXKA1WMIb7LRXe7DjCjX/BG+kt0WNqhRyNK
	l83kRdvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4jlH-00HSFr-0P; Mon, 12 Dec 2022 14:26:31 +0000
Received: from mx0a-00154904.pphosted.com ([148.163.133.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p4jl0-00HR6g-Ig
	for linux-nvme@lists.infradead.org; Mon, 12 Dec 2022 14:26:17 +0000
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
	by mx0a-00154904.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCEPb79001534
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=smtpout1;
 bh=YarI+VZiKYFn3yWaVdwO9bda8bfDLtQQovTgWXqT2qw=;
 b=RctxVwX+/deDEF++e1WHna6xKYs9lTVEhmfMlXR8nTBAz0w/VLnlTMsWMY44206uwu4N
 fyWzv+rys0D73C/tvya1V05o222iP7k49KrLnqLCsPm9flVQRHK8KRl/mfsgE32G98Hj
 I6b9ODQDb17ZVBIpFQssmJFhA6cMcJ1TlAtGwLSmandDH9oil7aioWUGNAx4mvGG4nug
 OK0jPOotbjUPr+4LGQwb6qUU2uPMBJicX2K14DFFl+njtk7PJbIQwhSfKorYlspvh/RF
 MDL7UJiv09axMPk05XRz01a/QBGUSokhuiVMR6x9OnbG2CX4ViW0mVH2IFJb7bQblxef Ng== 
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com [67.231.149.39])
	by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 3mcp559mm7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:12 -0500
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
	by mx0a-00154901.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BCE8IMB006702
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:12 -0500
Received: from esaploutdur05.us.dell.com ([128.221.233.10])
	by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 3me0eg6a31-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-nvme@lists.infradead.org>; Mon, 12 Dec 2022 09:26:12 -0500
X-PREM-Routing: D-Outbound
X-LoopCount0: from 10.55.227.144
X-IronPort-AV: E=McAfee;i="6000,8403,5688"; a="268537152"
Received: from vd-engela.xiolab.lab.emc.com ([10.55.227.144])
  by esaploutdur05.us.dell.com with ESMTP; 12 Dec 2022 08:25:46 -0600
From: amit.engel@dell.com
To: sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: amit.engel@dell.com, Amit Engel <Amit.Engel@dell.com>
Subject: [PATCH 1/2] nvme: add nvme_opcode_str function for all nvme cmd types
Date: Mon, 12 Dec 2022 16:25:58 +0200
Message-Id: <1670855159-3182917-2-git-send-email-amit.engel@dell.com>
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
X-Proofpoint-ORIG-GUID: YNRUqKoq1o1Mh9QZqECK71HleGoubVvv
X-Proofpoint-GUID: YNRUqKoq1o1Mh9QZqECK71HleGoubVvv
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212120132
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221212_062614_754338_2F0485F1 
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

nvme_opcode_str will handle io/admin/fabrics ops

This improves NVMe errors logging

Signed-off-by: Amit Engel <Amit.Engel@dell.com>
---
 drivers/nvme/host/constants.c | 16 ++++++++++++++++
 drivers/nvme/host/nvme.h      | 13 +++++++++++++
 2 files changed, 29 insertions(+)

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
-- 
2.31.1


