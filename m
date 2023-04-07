Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6347BC76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 20:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=f2XML3lrICLhPJ8M0Q/zRbO3jNZeGELX1yUU1fJ6M+c=; b=ZJSUJZNKtSP7p00Er5xSVfAf3V
	B1InE4z/oPothbM8/Kf8Psb1Givno6kF0J0emCHzECxXPGloqM2J3BY3wVOavxXu/m0d6IjkC2pLy
	tOdjEUFST52/uWFaT/73rh9hBFRoh0TzGtikt9AgtWB/7pEpU7dIu8sOpwRp8CtSuH1VbQS6U19IZ
	IP3RdHYKJkeJCWehTUG4iRJx4etWWmOxY742SSnC7RLB99e+fnhrx94yLZ87QorIsCCxucq8aVfQx
	aKRFSBBTqddTog/vYe4fUxRbEPexWAB8f8O+6IQ+PuZjViqtGi+mzxfJSLul2FEH+ionNqlxhCGk+
	W+xjrQPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLm-00B2b5-0j;
	Fri, 07 Apr 2023 20:06:22 +0000
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pksLj-00B2ZA-2e
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 20:06:21 +0000
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337FxBZY030887;
	Fri, 7 Apr 2023 20:06:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2022-7-12;
 bh=f2XML3lrICLhPJ8M0Q/zRbO3jNZeGELX1yUU1fJ6M+c=;
 b=PcCICaRoOh+6ol1HQIRpkxI5F5kusZAXVyp5r+rEXff/xvkMYXWfcmOHMx97h4JXlioU
 S5s7OMm5itoh+eaNE6iKdqd66W+7EWRMKAxfCl8KJJMoiKwva8YUB4n4Syo42K4Cjo09
 VmDs1ZSXizemogSQd1phetTY9auqZ3455zkmx1W+JeceaWlusy9mG1C/O9mIWzztS2JE
 R3Ed37cIinSaUw26Kav0EpjPXZ44sBY6z9cdMHx3fMzV4bX67g32+7q8wa0arN1ZvlyV
 YTaz6lv9xuJIjTvrDYT47ViLMaLeEXkQ/f9oXA51UXr26z/olaQyo40RC8g3c9E0bept qA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ppd5up0mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:06:16 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 337IdXYw034243;
	Fri, 7 Apr 2023 20:06:14 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3pptjxees6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Apr 2023 20:06:14 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 337K5tr6010228;
	Fri, 7 Apr 2023 20:06:14 GMT
Received: from mnchrist-mac.us.oracle.com (dhcp-10-154-128-1.vpn.oracle.com [10.154.128.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 3pptjxeeam-8;
	Fri, 07 Apr 2023 20:06:13 +0000
From: Mike Christie <michael.christie@oracle.com>
To: bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, snitzer@kernel.org,
        axboe@kernel.dk, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org
Cc: Mike Christie <michael.christie@oracle.com>
Subject: [PATCH v6 07/18] nvme: Fix reservation status related structs
Date: Fri,  7 Apr 2023 15:05:40 -0500
Message-Id: <20230407200551.12660-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407200551.12660-1-michael.christie@oracle.com>
References: <20230407200551.12660-1-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304070180
X-Proofpoint-ORIG-GUID: DiIkmaQhx6edPIHhSKRpV7Xpr8SezuVE
X-Proofpoint-GUID: DiIkmaQhx6edPIHhSKRpV7Xpr8SezuVE
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_130619_877206_723418C1 
X-CRM114-Status: GOOD (  15.42  )
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

This fixes the following issues with the reservation status structs:

1. resv10 is bytes 23:10 so it should be 14 bytes.
2. regctl_ds only supports 64 bit host IDs.

These are not currently used, but will be in this patchset which adds
support for the reservation report command.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/nvme.h | 38 ++++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 779507ac750b..83704fc04a94 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -759,20 +759,42 @@ enum {
 	NVME_LBART_ATTRIB_HIDE	= 1 << 1,
 };
 
+struct nvme_registered_ctrl {
+	__le16	cntlid;
+	__u8	rcsts;
+	__u8	rsvd3[5];
+	__le64	hostid;
+	__le64	rkey;
+};
+
 struct nvme_reservation_status {
 	__le32	gen;
 	__u8	rtype;
 	__u8	regctl[2];
 	__u8	resv5[2];
 	__u8	ptpls;
-	__u8	resv10[13];
-	struct {
-		__le16	cntlid;
-		__u8	rcsts;
-		__u8	resv3[5];
-		__le64	hostid;
-		__le64	rkey;
-	} regctl_ds[];
+	__u8	resv10[14];
+	struct nvme_registered_ctrl regctl_ds[];
+};
+
+struct nvme_registered_ctrl_ext {
+	__le16	cntlid;
+	__u8	rcsts;
+	__u8	rsvd3[5];
+	__le64	rkey;
+	__u8	hostid[16];
+	__u8	rsvd32[32];
+};
+
+struct nvme_reservation_status_ext {
+	__le32	gen;
+	__u8	rtype;
+	__u8	regctl[2];
+	__u8	resv5[2];
+	__u8	ptpls;
+	__u8	resv10[14];
+	__u8	rsvd24[40];
+	struct nvme_registered_ctrl_ext regctl_eds[];
 };
 
 enum nvme_async_event_type {
-- 
2.25.1


