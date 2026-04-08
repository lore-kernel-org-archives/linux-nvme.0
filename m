Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676E4FD5F99
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Apr 2026 09:04:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-Type:
	Content-Transfer-Encoding:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bjrQfjGBhWTfVLS8e3xvwI8I9cFahblkF+xjNeSahR8=; b=Dad7QmHlNqwzngKvgmgIODnQth
	VMMvBARLhDJpQv6tR+AOo41MbOCxRdudSQv/YZGvvvOkIE2oIyekV4U3uWQJOBbst9Y3V5QYejaEl
	HshT5oE+9ohb82XIodIwRP1qcWUCzJU59/vloG2Nkhdcpuyfq4xr0TTmD03BGod1g13Gx14dNgY/4
	7jV05+Q/cE1F/+M7z+xkso3tuEd1ZY2XFPoiTke9OFLl0203FED8RteZP/qqxWqWBEhqztuITSb7m
	iLafDVGMll/gIa+UwkMO8YDLbtOwLQMkryTPlgfUx/g3ndmn0K4Z+ob2OB3GWIfi5U4cVDsKw1Xm7
	XGIZv5aA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAOq2-00000008YpW-1Ip7;
	Wed, 08 Apr 2026 09:04:42 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wAOpz-00000008Yof-0ZJf
	for linux-nvme@lists.infradead.org;
	Wed, 08 Apr 2026 09:04:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bqG8vDy2rG1wFz+QepB+GMtaT4yMdhOZNY1X+7WtzG9EX8zDis3KxHoCMJ8+Kl71jT+jfhRPfd98ZVDM6n2L4SBuJExQ8a238g2LoakKJDBXqCYQb/jY/9M+dvwcGJ/isUAZX4rkv1qHfzk95t1roiwc58Y9iK2GaY1K4fGBNPUtNi2TYFdNkiieCp4cPZxAARj31DxCmqFF/R78wzFytu/rPazHlwFs6tx9JNEtQcAB+l4M//16cZCApZtkmvlJWreBlegATkQvuxni6TDbX0/gnOX3udxxeW3+0I7KE1WFleFK9oVWGYrz9PxSew4rUEUaD01BZFeuvn7Emi18Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjrQfjGBhWTfVLS8e3xvwI8I9cFahblkF+xjNeSahR8=;
 b=RH3C/TI8X1NWvskkN6Q8sq0wWL1GMvWuKlTJjteRNj0yCzhUDnxyVGaGYaDGZFGpmVHC0yuGZ3riOCyI/2oWOxNF9nEj2BWEfktGdqeiT1Oqf6JA3FlRT33/Ii6o2Ngbpak0qe5FMetHDGL/gkRX711sMOwcaHJRXEkbLO37FQ7BHsIMzvx1Q+2RqZiA/VEmGqF09tSg8ihxWeZjwN0hH7h1BkQqSZdHoQOik2ySzN9t9wARP7yD7Pxp/UrcgoXcty6UzhwT8lD6lkJdVtshatSM5OZOVtoZq36SACxETHp8YJ5vkOV4h19V7EJd0DcMc+2mxqOT567v+/dLhg5EYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjrQfjGBhWTfVLS8e3xvwI8I9cFahblkF+xjNeSahR8=;
 b=ZBFKoWdQAn3yl8NiXML8v7p08MvqvAReksA0qOUQHi2mStbuYXaf2Kn875YMqdoN2M6myi+DJ8z4NWRbsSxOs0bxZL/PX04KBSx5T/Y3TE/JRO0KkQuUay+k1xL0A23t20Kfnqtt3QeRSoCkNNcW2Y6jr3fh5JG4VUM6qtRZ2kbyJDewpgD+ijLxt4UpEMmnIgzpvoedj/2inMXgJcpVore6JHOw1N6dqQt+yaQdgD5Ot9GSZiWJXaRelHuLRB900WzTVAJp/9HR3dpM3Snh7IM7wZp5SBuS3SDwfFVboKfghfomoh0OoKsjrgoN9+RFkC8iukCABNUKLV7zg6tvdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
 by DS0PR12MB6655.namprd12.prod.outlook.com (2603:10b6:8:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 09:04:33 +0000
Received: from CH2PR12MB9517.namprd12.prod.outlook.com
 ([fe80::2be8:2dfc:4d86:cfd3]) by CH2PR12MB9517.namprd12.prod.outlook.com
 ([fe80::2be8:2dfc:4d86:cfd3%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 09:04:32 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: smalin@nvidia.com,
	linux-kernel@vger.kernel.org,
	Aurelien Aptel <aaptel@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v3] nvmet: introduce new mdts configuration entry
Date: Wed,  8 Apr 2026 09:02:26 +0000
Message-ID: <20260408090226.319321-1-aaptel@nvidia.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260407052358.GA6089@lst.de>
References: <20260407052358.GA6089@lst.de>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To CH2PR12MB9517.namprd12.prod.outlook.com (2603:10b6:610:27f::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB9517:EE_|DS0PR12MB6655:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d5e51b2-d6e1-4451-f244-08de954dd94a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 84S/Af+zOTJdygudx0gaBwnJ7Wf+O4XMNPIdUMsPM8qTgPC5sPD8mU5F0cxNaED9/jr2HTYcZiJfA6pucRB/QpIGGdZHwhG6anBJRvVb+yJjgjk3r1T86UFKIdyE5saWGYuYwkfJBDR4uEXekkh/3lneE6cXxPrlLu9FWHX/jaNrfOzctcTn7DMUTgciPAmEbglLQOpmqk/ru7Y8JJ401hrb9lgOw3v2HqUNWP9wuFCbZB9OJGdyKdpF3Oqc5NPScmFtRNtnpVOTqiPWFe/iqzf7YyrExznQJZaHbWiq28jEEn/rU5Ppfo0A9OMmwdjw8LS1damp2OMXsG+izomUncakTQ/XTZaZzvjnDFuj0Bx/ZSNUmcMwBz7Mqvyrm4h45CTAmcBpXjRVKVKSy/DYdNJs/wk4/DUDU9NC3Ai55PSsZjqMLnFqylfdXUKkrrcJUStW505dLicnKjFM+EHx83d2cX0/o2hYsz9x6oHYmY+jqm3XdJTXPYTtdlcsFQAoDzurQStCSKRr013BY2dPUkq2v8cER+KlIJxGnLh0Sonyxt6dLlGEA2RpllXi6Fltna6MAMigPOAA81IVwYMqdHHaAC0Xt0Oaz3uJ0EPhY1rmS30KsPXYOegsP+9IshLllM/UpyKCHcaLd8tuX1vjoSBsHOiqfFSHpxvypQUpw5g16LMJqJyTHEhCiLXpDJQxd7Hvu5JQP00hs8yYTb/eYVLjbTa7V1IjxDX1aI0sFJw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB9517.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EqA4MCL/34zfA5rOR85r9PUkdN8fYB+iVr4uokOYf/mLEfZpGZ4uDVQMCl2h?=
 =?us-ascii?Q?GOT4s9ztYWcmXoN8Vvl4Cn40TkJrV0PSZ5+W5sETBlgQvhfup4yHM4y2cYgN?=
 =?us-ascii?Q?ZFfAlecKGjnDXBietpAiLhsyd4QQPlc81KaB1loPOsLrRqdSH11E12NcdGjd?=
 =?us-ascii?Q?ym1OUfVU2BlxvHLMruY8ku7U4fBRAzsDtpB8AsAx8PWRY0THLwWgm0aoynWR?=
 =?us-ascii?Q?hWEO4mx4FMJXrobNR77FhILosyR8nhUDZOva0joQQJ47m1AFRaOIbBMbPVl0?=
 =?us-ascii?Q?NX0la1+KyYLt5zA91e1CVlcWgdujyLoZraj1TnwprldbsZA3WGPnKWEvHLD6?=
 =?us-ascii?Q?qeyOoWksObO2PGoutQsYrmcHpuIe/c3MhO7AWxfFqP/TRoGwI+LVamgPRARr?=
 =?us-ascii?Q?HOFQBRZhkucs/fmjNBi/Z/b1qSdeUwFI0DFsx0ZOn4+v8bkUHteEqTWWDPJH?=
 =?us-ascii?Q?79SIeRX7RhsaRjfMGjLyy6+UAZN2rdgeXbQMoZVGP6mFoX3veUvnE+DOFcd1?=
 =?us-ascii?Q?u3eyHrRIpMCgiWhJaGhxpRMVSz6mZgTBek2jpbT3aXjAeZrRWDZWBoMSf8qt?=
 =?us-ascii?Q?cFznsHIgtwEkAEYOqeMNo2HoYeu3/WsH8e9M25zcjmHbe4fO/15jCaIMfBpT?=
 =?us-ascii?Q?lZ5wdVDHftQ4k4BnLedQFVtiNcWdnA2a6s3US+rhQJlDoGa4BL7nL8nRGCfj?=
 =?us-ascii?Q?uaNm+DljPW/FT/EovWiugJFAF0WgVA3m0/6ISDAi4VIWE+yCYqJ5qSxMBajs?=
 =?us-ascii?Q?9CeoWg/l6yG9Q67ytTgi4Q40yd47QJzQW/fekQA3mSwY9n7I+5TPw/tQTjvS?=
 =?us-ascii?Q?i5z4yEhg7flnYEhO5rYp0zISfY9OMVuGqckih1j9I69rvQyjUXOV/HYV+LnK?=
 =?us-ascii?Q?9jaNlYkRAacLno8dbDusEJx07gDFXSN0ER5XJqqHn7Z8p8zZI9Osm4Cv9zDj?=
 =?us-ascii?Q?yz0uTmMnbTmtuv2vsejibwxKmvLv/5h1HWRHrqTFc/a8qnJNzFXOHdMlz+m/?=
 =?us-ascii?Q?LTSbNv8XJhij2I4pLvXG+Vfv0ZmvOLG+XFcRFglN4o1pcvkjtO4M6mjixKwg?=
 =?us-ascii?Q?cHCrCY8tuyoFfiDHDji6Gw2nh0YSovUi2FGYX+RBiLnBjw6V9hp1PcmOJuFw?=
 =?us-ascii?Q?FPCAQRiCOwc4OvGU+8o5Ox82LNowDYnaD079M3INJHIYwMk4TwkVOCh9kllQ?=
 =?us-ascii?Q?IbLz9rEgB2JFmX1vM11HyjeRPLMoMbgyN6d0AYiGLSD1rGGx9Ml6P61Rfzxw?=
 =?us-ascii?Q?gX3b74yAz5x4z/n51rWjQMzlYYPJ9jgthud/KdoMgMR4mX1ituL5/YTbgGSS?=
 =?us-ascii?Q?ocpUjlG+h5Lz+PNDPCkqBJqU/rrsYCU6LVcQHP8+4P3wpVIMGJWSk9XTeL4t?=
 =?us-ascii?Q?9Krz4x9Oa1HLjMRUIfMP0MKZOUOCU+IClOhx+vfUE2nNyaDCcfIvQNMX/ucY?=
 =?us-ascii?Q?HiKE8otA7JuD73CRtRpeHXzCgNk33CvjrZDkVKIAjAsnZf0Im/1hDbseztJT?=
 =?us-ascii?Q?FD0dlJ/sUsY8bQek7HhUqAeTtTLVyXhuA2dLUxdyc3hTJ36Yz7vjTQtt6x/y?=
 =?us-ascii?Q?MSwbxKcEk9SQ2cYHLg2eaYRtPR1rwkXAaA6czKqAEXBDpUdJrhSSl287YbIV?=
 =?us-ascii?Q?TOYtp2NWXRVGVaK/HV2qa3XmJyCGW3ZGj4TRZYajCjTgnKJJA0sdWE4a6Km6?=
 =?us-ascii?Q?vlBsdya+5IC9qXLIcZ6fuDQiF+dwuq1pfKyIuSU9S1rZvYGD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d5e51b2-d6e1-4451-f244-08de954dd94a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB9517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 09:04:32.6559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8yHbExtJQequPxakIL33UwE5PcYR2PaJolio1MVjkAI9OxYfNaH7lHPSth+xcvd/agx8KhjRJlqIvFOzVwvDrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6655
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260408_020439_187169_547FC573 
X-CRM114-Status: GOOD (  18.68  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c |  8 ++------
 drivers/nvme/target/configfs.c  | 27 +++++++++++++++++++++++++++
 drivers/nvme/target/core.c      |  8 ++++++++
 drivers/nvme/target/nvmet.h     | 13 +++++++++++++
 drivers/nvme/target/zns.c       |  6 +-----
 5 files changed, 51 insertions(+), 11 deletions(-)

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
index 319d6a5e9cf0..1c94e2a01e34 100644
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
@@ -759,6 +761,17 @@ static inline bool nvmet_is_pci_ctrl(struct nvmet_ctrl *ctrl)
 	return ctrl->port->disc_addr.trtype == NVMF_TRTYPE_PCI;
 }
 
+/* Limit MDTS according to port config or transport capability */
+static inline u8 nvmet_ctrl_mdts(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u8 mdts = req->port->mdts;
+
+	if (!ctrl->ops->get_mdts)
+		return mdts;
+	return min_not_zero(ctrl->ops->get_mdts(ctrl), mdts);
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


