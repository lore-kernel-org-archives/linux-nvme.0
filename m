Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 305B5D39421
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Apr 2026 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ID9Gh5MTq+EFTLAxgQl+7EGSTackaSeJBASRr3fH6Fw=; b=HkStaScI20UOGTWZbosrccpbU4
	phLTmuxNGYNXtnWDS7qQNZo+Gdy5Wj3cEPXXT7UxIP4p7KHJwZyrvNlbwc006GdpoDovjxDB0EXLK
	XSB9OyfpxVVotERPqD6zZASHccQoHSMN6zdJbsHxNB82cM9FBrfxEEIX71tHtBW73DbY3llUDwO9K
	zePIWlR8jRcf0j83+VQvfcPhu31IUGLgAIPmQ9LoRW3HBwPngA86SKxRUijS1suyvwNnNTGkLhuDk
	0udoGjt4JBe6Z1u8K5Ve6F4JHDmeIFloqCYnr6JIoUVDI3F8g3Eg0yLL9KzzdGNwZuctJlFt+XvDa
	VDg72rLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8I1C-00000000ARW-10CJ;
	Thu, 02 Apr 2026 13:23:30 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8I15-00000000ARJ-43Yf
	for linux-nvme@bombadil.infradead.org;
	Thu, 02 Apr 2026 13:23:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Sender:Reply-To:Content-ID:Content-Description;
	bh=ID9Gh5MTq+EFTLAxgQl+7EGSTackaSeJBASRr3fH6Fw=; b=ZkRutvdQaO4tz/fFKYH2ANt3oC
	FVzRk2ZTe4Gf/eEu/kLNvj2fGPObTeNDbBdyH/BI4FPK1E3H+TxFFWgFB/IVWz1RB0nj4KFu8FVxk
	ufRThvPPJRV6hwR8GnG4K6C14p3jYYnKxDeZ8umJMouSiY58eiI3eJI/xGkIkZGOm27OWLJnUGIEj
	lUpEmdQkjbI55FwD899IB6b+vFJ2Hhx8FYmG9bYAX0UgV4MtOwJmPw3R9alEu1uUQF6h6Qujyikp0
	6aMIdIcgPlKCbl4ry4bQnenB8E9q84K19C7/YBZDloeaZ00by3oITLP2k3gWVU7iG+hWTyrQQa9Zu
	36na1siw==;
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8I12-00000002X4L-1kwM
	for linux-nvme@lists.infradead.org;
	Thu, 02 Apr 2026 13:23:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DuQUytTIIeLECJmVYwBiCFsVyLwP2vujb1uloN7DYZpRDHQvsC1/OpnmZ2vxfuLOjososBMG03TQlTjgye5MofVkZEhdmB2if+/oz0AxDW0q7ldaacgCSCclK91/tWiMel3Cp4Fm0DLAqT1KSOHkBudrnxdstFCMt8btnrBgqIy87KOpyetMLR0Jg7+3080VmuAiHqqv8eBWXqIpE6SFV9gm/tme59L5fVIxdcA1cIPgDDZh4aBfzSLQ8TQ0u214N4SRIbec+6cHQplqO76OGOQ0sggFW6KVcIi93uEvG49+xTbo5J3Xw1X/ua86HqeTmciRU8NXc96+UCebDFkltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID9Gh5MTq+EFTLAxgQl+7EGSTackaSeJBASRr3fH6Fw=;
 b=ChNvqBTUi1im9vHLy+jI24Npzx8ucfgQrAOcKOPtVxv61WrahhVZdJr3C688sx99EOQ+gSRZqQT6fTE6S5Guw4czHoxjbxmjSGL6zGVYnsPyeBvuvjncSdwoA8YvMQnmPIO7+t2tHzHL9K+rJqWIdAY7c11/getIakohLEK/iep1z+OGDXaKJ6A9e/AUa1+8yHHMFRNve5RuwqBE+9mnaIOHjjPHsz1RttDhwoS/R2IEbpFwY7Que5KfRSMltIoEuf8Vfvh+29pwO8tgInd0k5CtDJUwEJEDRvsdBe/6DVH96iyDCg7doOUnS8KVhGCsFAzbl58DjuMT6KInxpEMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ID9Gh5MTq+EFTLAxgQl+7EGSTackaSeJBASRr3fH6Fw=;
 b=cQV1BYWyb6cHsTvsDyURmmHM+1hwKCWMjPosj8EvzqbSwQGyM7gYToywd6QZuWFYT0hK2YM+dtrZrc2CNmKpOfwHUtC8jfZc3DHqA61nGgyNA5sXhz+LD21GwVzd8cbIgIETJGPAB4VJyokxa38OU6mbSCglpGK/rURASW3W/3jr6EIwCNgh03m0+z9+8Ex/p08WdE5qiBk49SQigGi9vuuIxzir+DVLp0MLt2JxuzbyCxqHduvwMlu4O0H6RgfMOXhIXanlF+I2Ktm/2wc4vXBt1RRIKrNv06x/VCQtPYs/l0neWhoT7QjWYnFmIqONAHbjoqgTlSl/POV6IamLow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 13:23:11 +0000
Received: from CH2PR12MB9517.namprd12.prod.outlook.com
 ([fe80::2be8:2dfc:4d86:cfd3]) by CH2PR12MB9517.namprd12.prod.outlook.com
 ([fe80::2be8:2dfc:4d86:cfd3%6]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 13:23:11 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: smalin@nvidia.com,
	linux-kernel@vger.kernel.org,
	Aurelien Aptel <aaptel@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2] nvmet: introduce new mdts configuration entry
Date: Thu,  2 Apr 2026 13:21:08 +0000
Message-ID: <20260402132108.250386-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <253ikaa1woe.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
References: <253ikaa1woe.fsf@mtr-vdi-124.i-did-not-set--mail-host-address--so-tickle-me>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0030.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:3::16) To CH2PR12MB9517.namprd12.prod.outlook.com
 (2603:10b6:610:27f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9517:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e1b9d1c-21fd-479b-df43-08de90bafcc7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: r1CZlkmvrz/6YaO4u0zmcixX4vzENy33peMm4l9cL5SOQBFDJtTPmDCj4eSwsxZ9CcIwLVriepSpJ5A8c8ElpktaBHWoitK+BEGTtq1/28ffOjtU6ziloKR5JlDTSgHBNoxQyjjd4h2GXWKAtn1H0L5RhpcC8gTbKyQiR8PTc5HN1gZ0/0yv01w1SP/XwDtzenKDrmeEz2t1lpSyJhE+3VYRoyd160L+fp8fHe2qJWwpObd05xAfikAopTrUjhhhOpl15DMNnBx/ziwRIW78yH/NnK5OsVhNxSF0KpMkbTM+xtxckjqv756NaNoXA2rFXdjTM2z8T/kbJ/zvSc5ULu60YHbpfK4T62xz5wsDANeDwampNtUIIrhf3q/8FEla30CPZqcBTQcRORCiWnZNW0CkgY7ONmq3j7WfliyABRblGsJxhbWe1nMvYyr1eUkDnjYZvBHB4VLwaAzAZK/cZ+uS7HF5OfsnP6h02cVw7WqW8Fe9NDyn5HeE6WVLqWJGOSiyfBIMUk/zi3YWccDyM4YiU1rPMd7UJ/c8z12f6LlenaOR07WGnnAzzZyYQaQP/6pxI1Y37ldt2mbynHmFda8Qg/eEoyR1wPAqRxyA9VYYA0Jue1vC6TMoRnaTE67f/bDo+SIqWz2UBIvTZ2yNqH4pgQ12jDggRpCTCHtYQLGGsFV1GhtZCCwZYS/Hz/OQKfYeVl94ToEfTvuZ7XTbZvCq0xgiZaUaFmV4e6ZUs8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB9517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Yski2r3+D7r9y0krv6askBl/73EkU7S/9+oTI+Z/KwkwkI+wn0yqL3fo7qsy?=
 =?us-ascii?Q?nPN3UR4sQ8t/gKy6FqrgbJ2UbzZMIQ/2RrTXh6d3csnwJSsx9B1Wwdi4d0Vj?=
 =?us-ascii?Q?qwjmsGbx9C1m5oPIJNhacdLEbVWevy9kRUYyWW/WdBWn0cvnR6lnaPl/9FSy?=
 =?us-ascii?Q?98NXxScRa+3CMLXp9HVs80ST4AHGl7pNfkSFQQwQ+zojZsO5JsSlReuvANNI?=
 =?us-ascii?Q?4a2xCvRfvfI8OoWuFkXdncCzWJ65iXGAFYLfL0PSqxakTuX04Uyq/yDzUxK/?=
 =?us-ascii?Q?73p+/qc6B9C9Isj2tjVZwPBKAjfX1jsUTZcQwmJvf+eny2qWCP//qWpp0N7A?=
 =?us-ascii?Q?JXFJL1iW/YYLMaO52tLJZFdTxlc803Um3KBCBhHIm3dL5JONooBybee7GdgZ?=
 =?us-ascii?Q?f3G6EI6RH4fd4KKUOQIqmA23CcKz3fkuVaDlafvcuGIJ9fhShoRf0od9ZZUN?=
 =?us-ascii?Q?3mZ6fRojwvqD+KkN7Gm/93Wu9GoGgU/BFbtX+cqfFeRVH6SKq9NK39uXzULc?=
 =?us-ascii?Q?ldAhiUh5vorhwUZCeX30Dfawq5M/Y2LWSYCuAEWmS9bj8QLZtiZRWvW/nU2e?=
 =?us-ascii?Q?J9IuwU8mFefboFsbOQuC2356Tv+WCeDyonpGvR6xne/fFoucwaqkGi4UylYC?=
 =?us-ascii?Q?MWkuMFLJFXoKytbZ3rTilHfdhSKEzgMDoZ45oXITY9n+BHT2OLZue+4Xndgt?=
 =?us-ascii?Q?maAKx51rUVOiUMk1bDqDUxA0zEbEy7Q8I5LWjccsxpFByUE9XbKCuwX/uLls?=
 =?us-ascii?Q?jN3sGEdXNqLeleUhbu7gkXj3oup5oPPKhWD1f3D3LMm/Zg2IesWzZ1SUbryQ?=
 =?us-ascii?Q?ExnfPr6sZl9cjMlzH0uefRHEdzEoEYcILWWVeYJOwqlX557Ti0UFNHYdMWvn?=
 =?us-ascii?Q?nPjj9I6Lwy7YSOyKyJu0ScM6oUSeO6fcmnlfLJSOysXZWMAhT1c4PBxeBH/0?=
 =?us-ascii?Q?pmYw90H+e+Ajiw2oCoOg1Eu6XJY/IVGnkttLCBvqScxrtVpn4TpjU3DneUmi?=
 =?us-ascii?Q?KZCo0z9v3KmEumW0bsbfgn77578hdjHNyQDuiIUaCCwJc+vRfecK8ymGC31O?=
 =?us-ascii?Q?pjkkfEE91T95Lz2BqZ8Ppns7aByjUz2ltlN1OgaNUoSYgMG0PIcG1qzFYpLr?=
 =?us-ascii?Q?Zjc2HWKpk3esJM8hy08aVMmPNKu81/h5I0PnvOntSBN664KJp5llJzU1bg+d?=
 =?us-ascii?Q?F6YTaMAaVsdq+SXXa3F1ZOlCGflWVi/XaDbRGXKrbV5akPfWXxx1UNvwH/Lj?=
 =?us-ascii?Q?6r/V7fg4ouLZNU0gXhUCCF8grUaXzZa9+OKtqj59slTP1CvidOjPq2llV09K?=
 =?us-ascii?Q?bQj6nVVKv7LorAXkgv9ZuCsjiPHal0HoMnYSmlRL7QG/UVIUpSHg2/l3tBC4?=
 =?us-ascii?Q?vC0d1x/Qal87/9wbFp6NRM5cvnSHVkAvVitYJdfLuJx7Iu3udGPy7DB65gMR?=
 =?us-ascii?Q?MSYCPHE3zw+UrL4vrytgoA4u07YRLgQquMU81T0IQBSmtkc2zneNfP3vrpS2?=
 =?us-ascii?Q?+jGLoMfACln+tYfOz77QhbKzk90QmhW3s9cTKOxqmr2GgS0eJ3KHt+x9zTWJ?=
 =?us-ascii?Q?xEuOpucN03NCti+X9w41cECDA7NUIREvsfM4K0Zm8GANGJgsoe9E85OoCMAf?=
 =?us-ascii?Q?qR+rYo1mQyOVJM+ecSWHdwSCfMrlXgnDGaNL5JCRCP1bxem2RJXJli2pbC3b?=
 =?us-ascii?Q?t4FeyJAD/yYqPxgLjmHHDypXf4GR2FdKKhMAFICaIAACZ37d?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e1b9d1c-21fd-479b-df43-08de90bafcc7
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 13:23:11.3607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GoYVCPNLpTAv/2JL26npg9UpvAO78FUQWnRFWuO3YylNr5LEe5Ll7DeCIM8NVJckEkFDITzMHpU26FS1NUq8pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260402_142320_948210_82E59BA4 
X-CRM114-Status: GOOD (  18.12  )
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

Using this port configuration, one will be able to set the Maximum Data
Transfer Size (MDTS) for any controller that will be associated to the
configured port. The default value remains 0 (no limit).

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c |  8 ++------
 drivers/nvme/target/configfs.c  | 27 +++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  8 ++++++++
 drivers/nvme/target/nvmet.h     | 15 +++++++++++++++
 drivers/nvme/target/zns.c       |  6 +-----
 5 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ca5b08ce1211..4b759fc96cfd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -687,12 +687,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->cmic = NVME_CTRL_CMIC_MULTI_PORT | NVME_CTRL_CMIC_MULTI_CTRL |
 		NVME_CTRL_CMIC_ANA;
 
-	/* Limit MDTS according to transport capability */
-	if (ctrl->ops->get_mdts)
-		id->mdts = ctrl->ops->get_mdts(ctrl);
-	else
-		id->mdts = 0;
-
+	/* Limit MDTS according to port config or transport capability */
+	id->mdts = nvmet_ctrl_mdts(req);
 	id->cntlid = cpu_to_le16(ctrl->cntlid);
 	id->ver = cpu_to_le32(ctrl->subsys->ver);
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 3088e044dbcb..63d72fbf4d9d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -302,6 +302,31 @@ static ssize_t nvmet_param_max_queue_size_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, param_max_queue_size);
 
+static ssize_t nvmet_param_mdts_show(struct config_item *item, char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%d\n", port->mdts);
+}
+
+static ssize_t nvmet_param_mdts_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	int ret;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+	ret = kstrtoint(page, 0, &port->mdts);
+	if (ret) {
+		pr_err("Invalid value '%s' for mdts\n", page);
+		return -EINVAL;
+	}
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, param_mdts);
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static ssize_t nvmet_param_pi_enable_show(struct config_item *item,
 		char *page)
@@ -1996,6 +2021,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_tsas,
 	&nvmet_attr_param_inline_data_size,
 	&nvmet_attr_param_max_queue_size,
+	&nvmet_attr_param_mdts,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_attr_param_pi_enable,
 #endif
@@ -2054,6 +2080,7 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->referrals);
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
 	port->max_queue_size = -1;	/* < 0 == let the transport choose */
+	port->mdts = -1;		/* < 0 == let the transport choose */
 
 	port->disc_addr.trtype = NVMF_TRTYPE_MAX;
 	port->disc_addr.portid = cpu_to_le16(portid);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9238e13bd480..779d8a130619 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -370,6 +370,14 @@ int nvmet_enable_port(struct nvmet_port *port)
 					       NVMET_MIN_QUEUE_SIZE,
 					       NVMET_MAX_QUEUE_SIZE);
 
+	/*
+	 * If the transport didn't set the mdts properly, then clamp it to the
+	 * target limits. Also set default values in case the transport didn't
+	 * set it at all.
+	 */
+	if (port->mdts < 0 || port->mdts > NVMET_MAX_MDTS)
+		port->mdts = 0;
+
 	port->enabled = true;
 	port->tr_ops = ops;
 	return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 319d6a5e9cf0..b2dccf0a4ef2 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -214,6 +214,7 @@ struct nvmet_port {
 	bool				enabled;
 	int				inline_data_size;
 	int				max_queue_size;
+	int				mdts;
 	const struct nvmet_fabrics_ops	*tr_ops;
 	bool				pi_enable;
 };
@@ -671,6 +672,7 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 #define NVMET_MAX_QUEUE_SIZE	1024
 #define NVMET_NR_QUEUES		128
 #define NVMET_MAX_CMD(ctrl)	(NVME_CAP_MQES(ctrl->cap) + 1)
+#define NVMET_MAX_MDTS		255
 
 /*
  * Nice round number that makes a list of nsids fit into a page.
@@ -759,6 +761,19 @@ static inline bool nvmet_is_pci_ctrl(struct nvmet_ctrl *ctrl)
 	return ctrl->port->disc_addr.trtype == NVMF_TRTYPE_PCI;
 }
 
+static inline u8 nvmet_ctrl_mdts(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u8 mdts;
+
+	/* Limit MDTS according to port config or transport capability */
+	mdts = req->port->mdts;
+	if (ctrl->ops->get_mdts)
+		mdts = min_not_zero(ctrl->ops->get_mdts(ctrl), mdts);
+
+	return mdts;
+}
+
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index aeaf73b54c3a..f00921931eb6 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -69,7 +69,6 @@ bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
 void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req)
 {
 	u8 zasl = req->sq->ctrl->subsys->zasl;
-	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl_zns *id;
 	u16 status;
 
@@ -79,10 +78,7 @@ void nvmet_execute_identify_ctrl_zns(struct nvmet_req *req)
 		goto out;
 	}
 
-	if (ctrl->ops->get_mdts)
-		id->zasl = min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);
-	else
-		id->zasl = zasl;
+	id->zasl = min_not_zero(nvmet_ctrl_mdts(req), zasl);
 
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
-- 
2.51.0


