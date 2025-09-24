Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211A5CAC5AE
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 20:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Du+ehXw2BdzD48vTrc5+QFN+f4Sba0GFA79mSY5DZDI=; b=Q62Yy/qAhOiD32XR80c0S9E6Lm
	+Qmt8KGGnM6s75PT9pRjxt9dwKHikjqBMnorqP0FDYfrAVG5Ggu4PfooZy1qtdN+fHZK8eWot7Eow
	bfiragpPwvtT6cWHTOAYIoBek7yoVJZf8MDviZ9vYUpzhHjEDSi3ke+ZKGGzb0tDdOf661DRR32Lj
	sao9c0qwsuJU8fMjeG7JIdjIcZo5mqVAuUYRueam7uc5muRnf42KKrLKbJEqSrvphBaPMhhThLAP2
	V9QcWhwIFS9oMLEg3GggHGkYOk3Bb2RaMAmFRwrbqrz9fgVbmxEHcVVEFhWXwcbX+4yZUbtaLN1J9
	KXAL3Gsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4b-00000003SNM-1wpp;
	Wed, 24 Sep 2025 20:26:45 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4V-00000003SGx-1xYc
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 20:26:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P1FESR/idY+4vYckLR+sG5obbqwH4eMDs9T55o9bxGBzyrBpmnVVm/5gjcTWDiK2OgfFThZ3M5hFlDxbDDhzzePXdZ4ovfUKx0Vg9nq5WeiMSgkGhlLqWMtI6OXY09vx96d0pOBZHD9OUkM1Q0uo1uGaxkJhOqjKUjPuTyoAl4g9Rw545fpHEx7g2b3dcqTEI/6L//k3230aN6YVIca9UOiV7winjURdOCe2y2MOarkU4gu5JLOnfNUGbEPG+0yVxjE3aAwWCrbCDLdgSfBOBWV9A+q37ORcu9fCtwA6UAGc5p0jv1TJFVMarFyP8PdOQvlLo45Is+AyOAnG8Gw5dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Du+ehXw2BdzD48vTrc5+QFN+f4Sba0GFA79mSY5DZDI=;
 b=nwmkpyMLFJZzyUFFm23FpFap7rRK8EIsZst2yh2z2dgZtN2gHaBIRWzNgPUyhN4nxY9xtUksPFQVZ//2G/UxBpu6aVV/h/kfjFfCA8ZUBwVlZTL8SSSE+jNAFg8hvAFs7qhEbUh4J+wAa6PRc/b9NaALMlRIkLdvB/t+cgIUiImIW/AJPAuJ2DSK/jjF9gyozZ2hjXoYz5rY2PFXrk0VS4c1a2EegHWyy3IqxVdVL/yeh9il4W7wlNWGJpHfg92zhUN95YcJzIwegNaA4eASiKgyhGvrPq0W1xN5DfRJmzaa0IO6llnacMVHEuy17qROdxtvx5CyNKuPYg8A0vagmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Du+ehXw2BdzD48vTrc5+QFN+f4Sba0GFA79mSY5DZDI=;
 b=RRwKc/QsSDGG8kNSEnM2kkSGIrtYwJYeoCNoBUj/ajEU1UDMo6NMp5Rm71nbhOTgKquZzHvchaD8koD1UZMmC8RRufkqoZM+8uSsbbVw3LNUHE+CEzQUF52nVGGTj+HdcrRKdyiGz85ZOBXpFK1Fqqp8ninc/dVljwgafAwTycv7ScsiqMmuKgL/bxIiaTfLmv+RSXvnKVW8ehOJfVRqdt5dHVltwDrRztZc4/nbKgXUsuFjSLG9wjrayrEdka6DDA1IUpXiA7ZG2cipeZH1squ6sf5/5W59EOPiyvvFTojv7/FHIZUWx0Sa3bfs3MUfvs/IPHKjaymaWkJO2D7sXQ==
Received: from BY5PR20CA0028.namprd20.prod.outlook.com (2603:10b6:a03:1f4::41)
 by SJ5PPF5D591B24D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::994) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Wed, 24 Sep
 2025 20:26:28 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::1c) by BY5PR20CA0028.outlook.office365.com
 (2603:10b6:a03:1f4::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.22 via Frontend Transport; Wed,
 24 Sep 2025 20:26:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 20:26:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 13:26:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 24 Sep 2025 13:26:15 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 13:26:13 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <dwagner@suse.de>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 3/4] nvmet: prevent max_qid changes for discovered subsystems
Date: Wed, 24 Sep 2025 23:26:03 +0300
Message-ID: <20250924202604.7201-4-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250924202604.7201-1-mgurtovoy@nvidia.com>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|SJ5PPF5D591B24D:EE_
X-MS-Office365-Filtering-Correlation-Id: 09531c43-9afc-4271-700e-08ddfba8a3dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FDA4VuTT40KhbhUvSOAjgSF7Qbo8jPqB1t40EoyayICj6kSAb0VTdmESzHTb?=
 =?us-ascii?Q?66B6srhwUC7/z9QVIAGVO2bnyEMtAYDTfSPcgqVZ8S3OOBlXbUKOQpok1JFJ?=
 =?us-ascii?Q?F99jyzpwwgBDNkSoJL3RS/xXoHzckICBDpOHRRA/kocRpgq8DlocYiNSRvAC?=
 =?us-ascii?Q?B9GCWpXR8DaTQgBrDS63YqKd6AHDrrQ6BoPTYdOHSrToP8GkfhAeWw66+TeE?=
 =?us-ascii?Q?0ghIoSjf3N6q9KKOe1e/M2Z6YXVay3v68MGnr6M8A6oA8myDg/cN41Sx5REZ?=
 =?us-ascii?Q?1b+DqxZ5Rxk+haBreep3x4YJDTmfElq2wnf7jG1yrGrHTNV0NxXk41Zt7k/6?=
 =?us-ascii?Q?rhiz+RfaRrOAQ7yeu1Oij8aIv8gJmKeVokzWf7BG85Fe4tJGQUPywQ2i5B+h?=
 =?us-ascii?Q?8/oDBjnK5PbG/V3oGR2rFibcMBL3yAAVG6aS6XZ4QS9F2JIgl+1fhtDQdj1B?=
 =?us-ascii?Q?RP+Exd1muIQckn+nVB9aRxFTFumcDPpTmWIo/wzl6zBNoMIrlFLFtti3SPNv?=
 =?us-ascii?Q?BgU3Z3p2CGqdnTch2MhPuKtjq7zfd3TDY1zacfsi/vQTPc/39Z4kRpGaD8+O?=
 =?us-ascii?Q?1fnVHD9B4JlNRKPOXu1mtNMl3lQ8LSGm7zZIqbhvPZ+Ea/aifwkgnDfp4fy0?=
 =?us-ascii?Q?N4ieLoc0dN/JKYEUIzazng24aat2kBzXytN/APZoW6N232+HjPrzEUa82tAt?=
 =?us-ascii?Q?ehlTJoHmS2gE97arw3mcx2+4bBZtBlwWEmIfLXDD8667F0JWNepibyKJhY3B?=
 =?us-ascii?Q?RL5WGF99gpfnExRnr4H8cwnfI2hrIYz6gERcOQUrjogf9NUF03PsK+Z/IzVw?=
 =?us-ascii?Q?0Lj3FQ9fGd/Dhv9cMpgRLJFHNRJbk8YHOCG/Q/QQ0ju3GF9ApmaooVX2Tbmd?=
 =?us-ascii?Q?ArcOwOIzjy7ERu8gbA4iz/aLqz8Y23GY7KZScSpSD5wkfOZOk+UIHZUz/iWE?=
 =?us-ascii?Q?nFF03G+/27jktTjV+bPZq8p84SkubWeJcVtiRJzXGaSh0ZHmyYgyRyrnxzfe?=
 =?us-ascii?Q?ynazb5rfocrEy8ZDzLkYAlDStTcQdzSpU1s2jYEC6UkG1EviJLXD8kODjKvI?=
 =?us-ascii?Q?KRXKTeULJY9l9zZ806HtGiqiOcyzRHKP81ysETxoKDu4TbQSOOd2xOlcGQNi?=
 =?us-ascii?Q?DDIz3aWBJ8XUwHMihhR0wvSi1nErkXqMl5B/qPlMO93ZmLey7J1G4cFd2rvi?=
 =?us-ascii?Q?SwpLH4373O9bMqdAtLMylHQzHv2N6s/Lq5vYTrVx0U4akbYpGAvDJxQKSSKe?=
 =?us-ascii?Q?R58KrzskYKOBjJ1ydHyEQ1TDTk19pIubclMyRBeeQyTCWj3ELZM2e2VzkUqu?=
 =?us-ascii?Q?/VGDqOL40OZCzFqLe3nZEQXdUgkCBWk2pPDCVz8w97uxakLibsWtuzExXm6X?=
 =?us-ascii?Q?QKL8MKL1vwsQuuLA/dD2NZAbRbcWYDhG82bWbakwmOz8zeAIWr9WmbsWHPWV?=
 =?us-ascii?Q?LEGAdBxwcJbiMtViwJfuLOQSIz8EZoB/K1ZedGaAWd+1H9Wirh/LY4aj6gLz?=
 =?us-ascii?Q?9nh+jKigwxmaJBJ/0ZfJJ+r3TWPKDJ+qzzDq?=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:26:27.8387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09531c43-9afc-4271-700e-08ddfba8a3dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF5D591B24D
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_132639_514467_1715F444 
X-CRM114-Status: GOOD (  11.29  )
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

Disallow updates to the max_qid attribute via configfs after a
subsystem has been discovered. This prevents invalid configuration
and avoids races during controller setup. The maximal queue
identifier can now only be set on non-discovered subsystems,
ensuring consistent configuration state.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/configfs.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 979eb184756a..ac12326e036c 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1673,12 +1673,27 @@ static ssize_t nvmet_subsys_attr_qid_max_show(struct config_item *item,
 	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->max_qid);
 }
 
+static ssize_t
+nvmet_subsys_attr_qid_max_store_locked(struct nvmet_subsys *subsys,
+		u16 qid_max, size_t cnt)
+{
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set maximal qid. %u is already assigned\n",
+		       subsys->max_qid);
+		return -EINVAL;
+	}
+
+	subsys->max_qid = qid_max;
+
+	return cnt;
+}
+
 static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 					       const char *page, size_t cnt)
 {
 	struct nvmet_subsys *subsys = to_subsys(item);
-	struct nvmet_ctrl *ctrl;
 	u16 qid_max;
+	ssize_t ret;
 
 	if (sscanf(page, "%hu\n", &qid_max) != 1)
 		return -EINVAL;
@@ -1687,14 +1702,12 @@ static ssize_t nvmet_subsys_attr_qid_max_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	subsys->max_qid = qid_max;
-
-	/* Force reconnect */
-	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
-		ctrl->ops->delete_ctrl(ctrl);
+	mutex_lock(&subsys->lock);
+	ret = nvmet_subsys_attr_qid_max_store_locked(subsys, qid_max, cnt);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
 
-	return cnt;
+	return ret;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_qid_max);
 
-- 
2.18.1


