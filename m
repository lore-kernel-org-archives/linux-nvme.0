Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32869C433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Feb 2022 21:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fR7pliI8E/4bnaBjzD2jWPHu2zcqdI1GAe75uNm90Iw=; b=evCeQj42oyCK/aVtqVveldgHLb
	9aJ1vjTmXX8e5it3GvzXSPaEOU/p6RRQjUURkGl8SKFSqlhjw5cgcZarBT8lZYXW3ScnrOJpBmdX1
	6Zwkqj4U69qPTSjLJXc+u5a6a8iV4Ce9jq5FAmYxdTtQ4Gufbl3fUolPeizwak5lzNuTyYvE/xTCg
	5YgqPApG0B3hV7unGDc2O9wOhvlS6smPrW7r2YTZ4pmvWst2u4pNOSgA/BDh/KX3x+KAHdATc1eec
	+NLnpkw00s9y9dPyGPHbh5KkT1dJJkFLg4HTYyCu/i92uOAZYnaoiJ4nqR/RQ8wQU35ePyz8L1rkj
	YNkNWICw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nFNIG-00Gvhl-9w; Wed, 02 Feb 2022 21:36:00 +0000
Received: from mail-bn7nam10olkn20804.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::804]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nFNHy-00GvdS-No
 for linux-nvme@lists.infradead.org; Wed, 02 Feb 2022 21:35:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GPOuJ5GdQfVueoD67z3KPipKmGEMBdUZFcTMKvotw32j9DV6MIEhT7rxyru2zDUDbTxQ4/lgWnkeDC8M/FqAxPbezA3eXqmxmInpFUKs6419x2cR/eZrANdXBGLk32nAxSsCS85874rQqfIGwCg+XjXUm0Ahijcu8z40lwyC0gt9iRNXJwNjdfYlqk2ll5QmyyR7IsfHCGmt+IhS28HheMPFOTNSPKjyWsOqotB1P7MH5sw6K2ACID1fYAVrDYZVJeJMBEUz5osKbq7UHpQs8EEEi8eTlsDemxkC5FDuvAOQUEtUO6YSu3H1sMRYM+ElMs4ZbzyGRNXxpxNoSiNY4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fR7pliI8E/4bnaBjzD2jWPHu2zcqdI1GAe75uNm90Iw=;
 b=aX5bnGfG4S5/Tu4ZBa5crL5TA6zdWpze4RvoI8/m0LL1f1Dhyo91d47aVAnx6mTixOhQpgQ2i8g8GGbi/OvoIOrmBBR4fxEcB7fAzgKqAoCaPbypnMLu05DFdc0oUadeUz3CMSQOfkf8nFFclkN2pohRS4EOBuKxulSvVDqP/R8E18vTcv0y9uwaiPSJTFaJRQqyYlUDKetSg21U0GNEN/rQma/eab3XYt+mJNhBprR4x2l9rfL8rmKnXXmjndYd+qm4maFtj62ECkmX/iaWlJIQ1mbIjDhEdXOa2Ww/fs0deyf6fi04FQvkncrV5QhkztNRY/G1BdmTI23qLkewPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fR7pliI8E/4bnaBjzD2jWPHu2zcqdI1GAe75uNm90Iw=;
 b=KWOSrkNPQU0M630p/H7oqKbpgmw6pQo6RJj/HUX1Gkq1iBNSqEQcr1LMzL2UqZ6XtUY+sEF2lrp6VVxCkGcjvR8rfVKv3RGwW7xaTmnrP50UDZLVw3HnU3pDh/FTKgsKXtvNjc+VfyeUZz+eGpfms70aJyexIA1SJ7E82IHL9iXQMEYHqpr0M/OHrpazRqOi1rCqHqfPxP/5kqbRe1lXyRhLjs6HlTrJt3ciYO/JUbYzp/9tIbP6C9eQiLdDcjC9tQwmyEFAQJac77c6h+r0mDpkb0mnn2CTdfUqVy5UL4dYPIwzQI4V6hAhQUTSHviDEsOKed2oPnO4Mp4ToSMHhA==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MW5PR13MB5560.namprd13.prod.outlook.com (2603:10b6:303:191::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.9; Wed, 2 Feb
 2022 21:35:40 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::7c29:86b7:2695:b71e%4]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 21:35:40 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hare@suse.de, axboe@fb.com, hch@lst.de,
 sagi@grimberg.me, stuart_hayes@dell.com, charles_rose@dell.com,
 Martin Belanger <martin.belanger@dell.com>
Subject: [PATCH 2/2] nvme: Expose cntrltype and dctype through sysfs.
Date: Wed,  2 Feb 2022 16:34:51 -0500
Message-ID: <BL0PR13MB4291C612318AC862FDDEB7719C279@BL0PR13MB4291.namprd13.prod.outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202213451.33599-1-nitram_67@hotmail.com>
References: <20220202213451.33599-1-nitram_67@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [7IGiT1YfD2Nw1n1Ae203lRRbmj2mEX2s]
X-ClientProxiedBy: SN7PR04CA0050.namprd04.prod.outlook.com
 (2603:10b6:806:120::25) To BL0PR13MB4291.namprd13.prod.outlook.com
 (2603:10b6:208:8e::12)
X-Microsoft-Original-Message-ID: <20220202213451.33599-3-nitram_67@hotmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47aec537-5ee3-49d5-83ed-08d9e693f53c
X-MS-TrafficTypeDiagnostic: MW5PR13MB5560:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ocqy96hbDCFeiMzvKS0G+Fugabo2uhm3KufKNUrtP5DMypiR630xk1rIxNH+aQcuoxnfpQZ6S1tiJothVv97SGS7kKys8jK3CxV41rKTtSG4VGDStfl9oWdQxyO+5zEWe8jWDtqWqb9lAeDy3Jziw8DVql1m0TPUGXi/W/IxOXSt6b3h8K+x/LzLAigbza1mFK/yTi7NLC7UPlOe8uaxetAZRLDPXpMyx9UmbWXz7Z4h3h0q4Db1vC50PSJhyNj4T2L++vl/oJUbqnW39CthdAiVRCvkMF9XPes8uMBSPTxfYyShqJB4RBKY+yhSP2KkLcXEeWbzjWFwyiTqkiFhVFOQ4Bx283C4wwEfe9wzhA8+UMHhWB8wq1BAt+wrRyGa/8BkIbIsuIwFaRmqkaowEqeyL87R9NmPB/h4dwAz9m39tcNKJ8uZOVbcPLtci0jIK/V3WuYhwr6735PJAWZlvTerR9FI5qhgzIHH1FrwO4wibstBkDw1kL/dIOulrhOS+O6Iv8B/algFXl/4rEcWbMhjSt1fVt/CgS7zFS5ub4HAxwpju4a5OCnFbmAIGoWy
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?04iEEZLh0WKSrQOmcW50rMrB2Mp9wZ3UG2KPZFOkGSJ/7cvKzZdToP3ja4/x?=
 =?us-ascii?Q?q8GvMLumTIbM95Ai5ySzAe5WUnq1kScRBl6HudVduIL6h2ymd3P2pg8LqJ8D?=
 =?us-ascii?Q?KFN3AwCHRQDxlsNLPsqAiSnFPZ84koRkWQwhaT0ZelHFTWo6JF3g1XzbC3y0?=
 =?us-ascii?Q?bKMZ8iWnHq8gtUWkswmT0ftV/wdAQnjVRtGtYORMxVZ7o8kBh4fVilIQMwfX?=
 =?us-ascii?Q?fe32hEnY0IfBCaRMm7hfdAB2pAY4bGUbxPT/21+RQEYODWFSTL5bpxxqzhJl?=
 =?us-ascii?Q?QU8qZCjDx1q3eS39YvP9rH6OSMzFG5eAa8DK9adm8Fk8Ff1xOIJqLzaGkLQM?=
 =?us-ascii?Q?9lxchBuI/igEu80+PTnT/0vTwPadVda/84oS/zwgYufNmboKyFkaTWBXRsY3?=
 =?us-ascii?Q?uP3HbQH6PYclOqRIL6EMMIbIq+2CjBu7mHv1/8ovHJmCGGLoWyYOiL7xxdVT?=
 =?us-ascii?Q?DtD+50q1oXY/3qeo01CY/eyW/kAcUlACpfjBf/7r7OG+qtrjUuCWQtly+3rw?=
 =?us-ascii?Q?gLTDbjXjxgvJOOmZa3S0i9cFUjmX0rm3ZyHnQbvwCZp4TdUVdMKwO/TKafnz?=
 =?us-ascii?Q?dmS4hVN2ba5gKqe3s51HJ0GcZ8EYcQZxA2k6V3H8v7IIPwZBSSQdcQ7UozwO?=
 =?us-ascii?Q?rdfnqxnuDF6g2OZlDs/tjsZrQzWCAt7tDhhyZGo6zj0AWC8v3tiNLCa3z6xE?=
 =?us-ascii?Q?86M/nGh/OQpCF6i336HRSLqqxYHloUBxg/8AnkkA/wBKcyBLtLKn2i0vRAHq?=
 =?us-ascii?Q?hmpEU8v0lPoZGUSmKks0Zss93XcXxIsxKD05vyOzVRWby4soQJtyOzu0QeTQ?=
 =?us-ascii?Q?+qOC98uemYudu6rWJEku1uQewlDogalEc54PbKGF0Npf8T2LFr7t/yBpFI4P?=
 =?us-ascii?Q?O3rWLSdYPxyh6ryszQ5DBwyHlCqHtmTUpPYq/vB10CU7rKHV0eEbLMnr7cIH?=
 =?us-ascii?Q?xZbETivon00jy/oFaCtJnA=3D=3D?=
X-OriginatorOrg: sct-15-20-4778-2-msonline-outlook-da780.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 47aec537-5ee3-49d5-83ed-08d9e693f53c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:35:40.1413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR13MB5560
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220202_133542_815035_B5BBB1C1 
X-CRM114-Status: GOOD (  17.28  )
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

From: Martin Belanger <martin.belanger@dell.com>

TP8010 introduces the Discovery Controller Type (dctype)
attribute. The dctype is returned in the response to the
Identify command. This patch exposes the dctype through
the sysfs. Since the dctype depends on the Controller
Type (cntrltype), another attribute of the Identify
response, the patch also exposes the cntrltype as well.

Signed-off-by: Martin Belanger <martin.belanger@dell.com>
---
 drivers/nvme/host/core.c | 35 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  3 +++
 include/linux/nvme.h     | 10 +++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 872c389dc6d3..c65d44fb65c4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2992,6 +2992,9 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->max_namespaces = le32_to_cpu(id->mnan);
 	ctrl->ctratt = le32_to_cpu(id->ctratt);
 
+	ctrl->cntrltype = id->cntrltype;
+	ctrl->dctype = id->dctype;
+
 	if (id->rtd3e) {
 		/* us -> s */
 		u32 transition_time = le32_to_cpu(id->rtd3e) / USEC_PER_SEC;
@@ -3525,6 +3528,34 @@ static ssize_t nvme_ctrl_fast_io_fail_tmo_store(struct device *dev,
 static DEVICE_ATTR(fast_io_fail_tmo, S_IRUGO | S_IWUSR,
 	nvme_ctrl_fast_io_fail_tmo_show, nvme_ctrl_fast_io_fail_tmo_store);
 
+static ssize_t nvme_ctrl_cntrltype_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	switch (ctrl->cntrltype) {
+	case NVME_CTRL_IO:	return sysfs_emit(buf, "io\n");
+	case NVME_CTRL_DISC:	return sysfs_emit(buf, "disc\n");
+	case NVME_CTRL_ADMIN:	return sysfs_emit(buf, "admin\n");
+	default:		return sysfs_emit(buf, "reserved\n");
+	}
+}
+static DEVICE_ATTR(cntrltype, S_IRUGO, nvme_ctrl_cntrltype_show, NULL);
+
+static ssize_t nvme_ctrl_dctype_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+
+	switch (ctrl->dctype) {
+	case NVME_DCTYPE_NOT_REPORTED:	return sysfs_emit(buf, "nr\n");
+	case NVME_DCTYPE_DDC:		return sysfs_emit(buf, "ddc\n");
+	case NVME_DCTYPE_CDC:		return sysfs_emit(buf, "cdc\n");
+	default:			return sysfs_emit(buf, "reserved\n");
+	}
+}
+static DEVICE_ATTR(dctype, S_IRUGO, nvme_ctrl_dctype_show, NULL);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3546,6 +3577,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reconnect_delay.attr,
 	&dev_attr_fast_io_fail_tmo.attr,
 	&dev_attr_kato.attr,
+	&dev_attr_cntrltype.attr,
+	&dev_attr_dctype.attr,
 	NULL
 };
 
@@ -3569,6 +3602,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_fast_io_fail_tmo.attr && !ctrl->opts)
 		return 0;
+	if (a == &dev_attr_dctype.attr && ctrl->cntrltype == NVME_CTRL_DISC)
+		return 0;
 
 	return a->mode;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a162f6c6da6e..e30626c00791 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -349,6 +349,9 @@ struct nvme_ctrl {
 	unsigned long discard_page_busy;
 
 	struct nvme_fault_inject fault_inject;
+
+	enum nvme_ctrl_type cntrltype;
+	enum nvme_dctype dctype;
 };
 
 enum nvme_iopolicy {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 855dd9b3e84b..af1494d83a52 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -43,6 +43,12 @@ enum nvme_ctrl_type {
 	NVME_CTRL_ADMIN	= 3,		/* Administrative controller */
 };
 
+enum nvme_dctype {
+	NVME_DCTYPE_NOT_REPORTED = 0,
+	NVME_DCTYPE_DDC = 1,		/* Direct Discovery Controller */
+	NVME_DCTYPE_CDC = 2,		/* Central Discovery Controller */
+};
+
 /* Address Family codes for Discovery Log Page entry ADRFAM field */
 enum {
 	NVMF_ADDR_FAMILY_PCI	= 0,	/* PCIe */
@@ -320,7 +326,9 @@ struct nvme_id_ctrl {
 	__le16			icdoff;
 	__u8			ctrattr;
 	__u8			msdbd;
-	__u8			rsvd1804[244];
+	__u8			rsvd1804[2];
+	__u8			dctype;
+	__u8			rsvd1807[241];
 	struct nvme_id_power_state	psd[32];
 	__u8			vs[1024];
 };
-- 
2.34.1


