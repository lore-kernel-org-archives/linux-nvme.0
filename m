Return-Path: <SRS0=zNed=5Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,UPPERCASE_50_75
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3796FC2D0EC
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 02:48:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB81820748
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2020 02:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RfZmtxWR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="k9TVS4Vv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB81820748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:Reply-To:List-Subscribe:List-Help:
	List-Post:List-Archive:List-Unsubscribe:List-Id:References:Date:Message-ID:To
	:From:Subject:Mime-Version:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	List-Owner; bh=Jb2y6mW09TN2523xE8LMHywhrq+c4fyZofXo2dChvQE=; b=RfZmtxWRT8M1rK
	sCk7SlarhUC0iQ9VidcXv4rgth+Cz+1d5uv79CuEglEGBOUXANd6vsLxD76O9u0Zck9VpvEaos3C0
	61YVYjQfCADvPTR3xrVUYU1aelqQz3bknHYnxgDZrxcuQWlr1kuJAm5oEnDnWd97wWGAqdakfiqZ4
	ss6qt4Q5WSO27uHbdN3ZNwh3V7EmWAM5aRmpJFuw8H2QWWVPb8H2/Kxe4Gm1EcwDp5OjneNa6hw3P
	vHsI9GM2G4gvF6f9W1No+WxOkSPzqVl8V2kzYKZhOnnT321C4FpFZsebEVW0sqob5R804QHrXm68R
	m0SQpxaaAt3ahxZ5Fwsg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jM0ld-0000mt-NE; Wed, 08 Apr 2020 02:48:41 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jM0lZ-0000m8-HX
 for linux-nvme@lists.infradead.org; Wed, 08 Apr 2020 02:48:39 +0000
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20200408024826epoutp04c3254486a2bb5e26b424b5c826d16052~DuEZwyjLJ2021420214epoutp04M
 for <linux-nvme@lists.infradead.org>; Wed,  8 Apr 2020 02:48:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20200408024826epoutp04c3254486a2bb5e26b424b5c826d16052~DuEZwyjLJ2021420214epoutp04M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1586314106;
 bh=riwV66dvqNkNhGWD+tsBJbTtKJRun5HBeWa4BZ9FJy0=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=k9TVS4VvkA+t6QNXrGK+Oz3UrztbJew12vGiTRKjVEqKnkM/IyorE7jc/J0J6t/H7
 wCJgN1Yd4mPTJ09KieZor9+SARR1HEr1xMPQVUBTM3gYe834yJ296qrSQbcgHK5bk5
 SGkulEG/ggWO7FqTg///fj9tmA6TTX30VBcKiD+s=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTP id
 20200408024825epcas2p36580a241108d1d45e1f5513eeaaa7a71~DuEZRt5UP2300423004epcas2p30;
 Wed,  8 Apr 2020 02:48:25 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.191]) by
 epsnrtp3.localdomain (Postfix) with ESMTP id 48xpcR0bZJzMqYkZ; Wed,  8 Apr
 2020 02:48:23 +0000 (GMT)
X-AuditID: b6c32a47-667ff70000001129-3b-5e8d3b76a8c1
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 DA.D4.04393.67B3D8E5; Wed,  8 Apr 2020 11:48:22 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] nvme: structures and status update based on spec v1.4
From: Steven Seungcheol Lee <sc108.lee@samsung.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20200408024822epcms2p1995674f0305dd4676395a34665862384@epcms2p1>
Date: Wed, 08 Apr 2020 11:48:22 +0900
X-CMS-MailID: 20200408024822epcms2p1995674f0305dd4676395a34665862384
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHKsWRmVeSWpSXmKPExsWy7bCmuW6ZdW+cwdY9OhaXv6VZPL7zmd1i
 6Xx9i/nLnrJbPP0/g9GB1WPzknqPvi2rGAOYonJsMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
 DAx1DS0tzJUU8hJzU22VXHwCdN0yc4B2KSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
 UnIKDA0L9IoTc4tL89L1kvNzrQwNDIxMgSoTcjJ6dl9gK9hvXrHh/GKWBsZ5Ol2MnBwSAiYS
 W5vfsncxcnEICexglFi4bwNLFyMHB6+AoMTfHcIgNcICbhJPf9xhBLGFBOQlzsybwwwRN5U4
 8u8yE4jNJmAscfjKM3YQW0TAVWL30l2MIDOZBdYxSmxvXMkGsYxXYkb7UxYIW1pi+/KtjBC2
 qMTN1W/ZYez3x+ZDxUUkWu+dZYawBSUe/NwNFZeUWDLlC5RdLnG3pYUNZJmEwBxGiU8nD0It
 0JfY9mc2mM0r4Cux/8s2sAUsAqoSe9ceY4WocZGY/3AN2AJmoM+2vwX5jAPI1pRYv0sfxJQQ
 UJY4cosFooJPouPwX3aYV3bMe8IEYStLrFx6gx3mtFcf2qCme0jcXn+eCRJugRIr7q1gm8Ao
 PwsRurOQ7J2FsHcBI/MqRrHUguLc9NRiowJj5AjdxAhOa1ruOxi3nfM5xCjAwajEw/sgsSdO
 iDWxrLgy9xCjBAezkgivVG9nnBBvSmJlVWpRfnxRaU5q8SFGU6D3JzJLiSbnA1NuXkm8oamR
 mZmBpamFqZmRhZI47ybumzFCAumJJanZqakFqUUwfUwcnFINjOUpwu/nhQSannLMelo247jx
 PrMlrio6MjPSYvPOXGk2uK+T4WTlo72FVS9407v+wyveHDx5kFm953z452OByRtE35dLRL3c
 tORRyHOt3jB1K/8Nu0O3c+Sys5nKG/N/Pv63k2GFig0XU9iCiCcRbxxDE7WcJG3rV7xY9rpR
 56D4lvO7lxxOVmIpzkg01GIuKk4EAC2J7gKBAwAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200408024822epcms2p1995674f0305dd4676395a34665862384
References: <CGME20200408024822epcms2p1995674f0305dd4676395a34665862384@epcms2p1>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200407_194837_942361_E4C7672F 
X-CRM114-Status: GOOD (  16.80  )
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
Reply-To: sc108.lee@samsung.com
Cc: Beomsoo Kim <beomsooo.kim@samsung.com>,
 Javier Gonzalez <javier.gonz@samsung.com>,
 Jaegyu Choi <jg123.choi@samsung.com>,
 Steven Seungcheol Lee <sc108.lee@samsung.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From 60d7ac6dc2a800d8414aa2ca879c3d9569a16603 Mon Sep 17 00:00:00 2001
From: Steven Seungcheol Lee <sc108.lee@samsung.com>
Date: Tue, 7 Apr 2020 19:12:56 +0900
Subject: [PATCH] nvme: structures and status update based on spec v1.4

Updates spec contents only for existing things on kernel.
Signed-off-by: Steven Seungcheol Lee <sc108.lee@samsung.com>
---
 include/linux/nvme.h | 71 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3d5189f46cb1..e3967296f84c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -114,6 +114,10 @@ enum {
 	NVME_REG_BPMBL	= 0x0048,	/* Boot Partition Memory Buffer
 					 * Location
 					 */
+	NVME_REG_CMBMSC = 0x0050,	/* Controller Memory Buffer Memory Space
+					 * Control
+					 */
+	NVME_REG_CMBSTS = 0x0058,	/* Controller Memory Buffer Status */
 	NVME_REG_PMRCAP	= 0x0e00,	/* Persistent Memory Capabilities */
 	NVME_REG_PMRCTL	= 0x0e04,	/* Persistent Memory Region Control */
 	NVME_REG_PMRSTS	= 0x0e08,	/* Persistent Memory Region Status */
@@ -123,17 +127,32 @@ enum {
 	NVME_REG_PMRSWTP = 0x0e10,	/* Persistent Memory Region Sustained
 					 * Write Throughput
 					 */
+	NVME_REG_PMRMSC = 0x0e14,	/* Persistent Memory Region Controller
+					 * Memory Space Control
+					 */
 	NVME_REG_DBS	= 0x1000,	/* SQ 0 Tail Doorbell */
 };
 
 #define NVME_CAP_MQES(cap)	((cap) & 0xffff)
+#define NVME_CAP_CQR(cap)		(((cap) >> 16) & 0x1)
+#define NVME_CAP_AMS(cap)		(((cap) >> 17) & 0x3)
 #define NVME_CAP_TIMEOUT(cap)	(((cap) >> 24) & 0xff)
 #define NVME_CAP_STRIDE(cap)	(((cap) >> 32) & 0xf)
 #define NVME_CAP_NSSRC(cap)	(((cap) >> 36) & 0x1)
+#define NVME_CAP_CSS(cap)		(((cap) >> 37) & 0xff)
+#define NVME_CAP_BPS(cap)		(((cap) >> 45) & 0x1)
 #define NVME_CAP_MPSMIN(cap)	(((cap) >> 48) & 0xf)
 #define NVME_CAP_MPSMAX(cap)	(((cap) >> 52) & 0xf)
+#define NVME_CAP_PMRS(cap)		(((cap) >> 56) & 0x1)
+#define NVME_CAP_CMBS(cap)		(((cap) >> 57) & 0x1)
 
 #define NVME_CMB_BIR(cmbloc)	((cmbloc) & 0x7)
+#define NVME_CMB_CQMMS(cmbloc)		(((cmbloc) >> 3) & 0x1)
+#define NVME_CMB_CQPDS(cmbloc)		(((cmbloc) >> 4) & 0x1)
+#define NVME_CMB_CDPMLS(cmbloc)		(((cmbloc) >> 5) & 0x1)
+#define NVME_CMB_CDPCILS(cmbloc)	(((cmbloc) >> 6) & 0x1)
+#define NVME_CMB_CDMMMS(cmbloc)		(((cmbloc) >> 7) & 0x1)
+#define NVME_CMB_CQDA(cmbloc)		(((cmbloc) >> 8) & 0x1)
 #define NVME_CMB_OFST(cmbloc)	(((cmbloc) >> 12) & 0xfffff)
 
 enum {
@@ -231,7 +250,10 @@ struct nvme_id_ctrl {
 	__le32			rtd3e;
 	__le32			oaes;
 	__le32			ctratt;
-	__u8			rsvd100[28];
+	__le16			rrls;
+	__u8			rsvd102[9];
+	__u8			cntrltype;
+	char			fguid[16];
 	__le16			crdt1;
 	__le16			crdt2;
 	__le16			crdt3;
@@ -263,12 +285,14 @@ struct nvme_id_ctrl {
 	__le32			sanicap;
 	__le32			hmminds;
 	__le16			hmmaxd;
-	__u8			rsvd338[4];
+	__le16			nsetidmax;
+	__le16			endgidmax;
 	__u8			anatt;
 	__u8			anacap;
 	__le32			anagrpmax;
 	__le32			nanagrpid;
-	__u8			rsvd352[160];
+	__le32			pels;
+	__u8			rsvd356[156];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
@@ -303,19 +327,35 @@ enum {
 	NVME_CTRL_ONCS_WRITE_UNCORRECTABLE	= 1 << 1,
 	NVME_CTRL_ONCS_DSM			= 1 << 2,
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
+	NVME_CTRL_ONCS_FEATURE_NON_ZERO	= 1 << 4,
+	NVME_CTRL_ONCS_RESERVATION		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_VERIFY			= 1 << 7,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_FORMAT_NVM               = 1 << 1,
+	NVME_CTRL_OACS_FW_DOWNLOAD_COMMIT       = 1 << 2,
+	NVME_CTRL_OACS_NS_MGMT                  = 1 << 3,
+	NVME_CTRL_OACS_DEVICE_SELF_TEST         = 1 << 4,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
+	NVME_CTRL_OACS_NVME_MI		    = 1 << 6,
+	NVME_CTRL_OACS_VIRTUAL_MGMT		= 1 << 7,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
+	NVME_CTRL_OACS_GET_LBA_STATUS	= 1 << 9,
+	NVME_CTRL_LPA_SMART_LOG			    = 1 << 0,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
+	NVME_CTRL_LPA_EXTENDED_DATA_LOG		= 1 << 2,
+	NVME_CTRL_LPA_TELEMETRY_LOG			= 1 << 3,
+	NVME_CTRL_LPA_PERSISTENT_EVENT_LOG	= 1 << 4,
 	NVME_CTRL_CTRATT_128_ID			= 1 << 0,
 	NVME_CTRL_CTRATT_NON_OP_PSP		= 1 << 1,
 	NVME_CTRL_CTRATT_NVM_SETS		= 1 << 2,
 	NVME_CTRL_CTRATT_READ_RECV_LVLS		= 1 << 3,
 	NVME_CTRL_CTRATT_ENDURANCE_GROUPS	= 1 << 4,
 	NVME_CTRL_CTRATT_PREDICTABLE_LAT	= 1 << 5,
+	NVME_CTRL_CTRATT_TBKAS				= 1 << 6,
 	NVME_CTRL_CTRATT_NAMESPACE_GRANULARITY	= 1 << 7,
+	NVME_CTRL_CTRATT_SQ_ASSOCIATIONS	= 1 << 8,
 	NVME_CTRL_CTRATT_UUID_LIST		= 1 << 9,
 };
 
@@ -370,10 +410,12 @@ enum {
 	NVME_ID_CNS_CTRL		= 0x01,
 	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
 	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
+	NVME_ID_CNS_NVMSET_LIST		= 0x04,
 	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
 	NVME_ID_CNS_CTRL_LIST		= 0x13,
+	NVME_ID_CNS_PRIMARY_CTRL	= 0x14,
 	NVME_ID_CNS_SCNDRY_CTRL_LIST	= 0x15,
 	NVME_ID_CNS_NS_GRANULARITY	= 0x16,
 	NVME_ID_CNS_UUID_LIST		= 0x17,
@@ -524,7 +566,11 @@ enum {
 enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
+	NVME_AER_NOTICE_TELEMTRY_LOG_CHANGED		= 0x02,
 	NVME_AER_NOTICE_ANA		= 0x03,
+	NVME_AER_NOTICE_PREDICTABLE_LAT_LOG_CHANGED	= 0x04,
+	NVME_AER_NOTICE_LBA_STATUS_INFO_ALERT		= 0x05,
+	NVME_AER_NOTICE_ENDURANCE_GROUP_LOG_CHANGED	= 0x06,
 	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
 };
 
@@ -582,6 +628,7 @@ enum nvme_async_event_type {
 	NVME_AER_TYPE_ERROR	= 0,
 	NVME_AER_TYPE_SMART	= 1,
 	NVME_AER_TYPE_NOTICE	= 2,
+	NVME_AER_TYPE_IOCS	= 6,
 };
 
 /* I/O commands */
@@ -1333,15 +1380,22 @@ enum {
 	NVME_SC_SGL_INVALID_DATA	= 0xf,
 	NVME_SC_SGL_INVALID_METADATA	= 0x10,
 	NVME_SC_SGL_INVALID_TYPE	= 0x11,
-
+	NVME_SC_CMB_INVALID_USE		= 0x12,
+	NVME_SC_PRP_INVALID_OFFSET	= 0x13,
+	NVME_SC_ATOMIC_WRITE_UNIT_EXCEEDED = 0x14,
+	NVME_SC_OPERATION_DENIED	= 0x15,
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
-	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
 
+	NVME_SC_INCONSISTENT_HOST_ID = 0x18,
+	NVME_SC_KEEP_ALIVE_EXPIRED	= 0x19,
+	NVME_SC_KEEP_ALIVE_INVALID	= 0x1A,
+	NVME_SC_PREEMPT_ABORT		= 0x1B,
 	NVME_SC_SANITIZE_FAILED		= 0x1C,
 	NVME_SC_SANITIZE_IN_PROGRESS	= 0x1D,
 
 	NVME_SC_NS_WRITE_PROTECTED	= 0x20,
 	NVME_SC_CMD_INTERRUPTED		= 0x21,
+	NVME_SC_TRANSIENT_TRANSPORT	= 0x22,
 
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
@@ -1379,8 +1433,15 @@ enum {
 	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
 	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
 	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
+	NVME_SC_DEVICE_SELF_TEST_IN_PROGRESS = 0x11d,
 	NVME_SC_BP_WRITE_PROHIBITED	= 0x11e,
+	NVME_SC_INVALID_CTRL_ID		= 0x11f,
+	NVME_SC_INVALID_SECONDARY_CTRL_STATE = 0x120,
+	NVME_SC_INVALID_NUM_CTRL_RESOURCE	= 0x121,
+	NVME_SC_INVALID_RESOURCE_ID	= 0x122,
 	NVME_SC_PMR_SAN_PROHIBITED	= 0x123,
+	NVME_SC_ANA_INVALID_GROUP_ID = 0x124,
+	NVME_SC_ANA_ATTACH_FAIL		= 0x125,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
-- 
2.25.1

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
