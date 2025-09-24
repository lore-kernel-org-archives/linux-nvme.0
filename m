Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF67CAC5A5
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W5fNfFDVbrbs9Djw03E6AexbBUUKxsMyMa2lkhWJRX4=; b=TlFLiFE6mwoIuo+5+xEiHlsHDC
	5fPo1Bnv56FoQuxH4QNm4VV2Hfpj3f99zkkQ7V3Us5kOwGE0kWPMED2hiYupFR9tXy3TMc9KrbICD
	QkPgb3V4LrG1gdOQ2kvk2mJM8mDenSxVfKDzJJ4g4sST6hH9rEzMw6YhZpuu6H/2oIxqSoS9gnFqD
	oBr0k2+K+Rf0Ax13I4QBqUWAH9HSiaL8ZhU/+xmaSoiumqyckW/lLSZTUnbz4vDOnuhf7fKhhUqQg
	246RhOEL5XdjIcax3Rg6Neq0QaGnrM02EVFbjjz/5pfCSPQ1XIdGBU9iETdCd8E3HGQ91w+o0C5e3
	0ScUe5Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4b-00000003SNC-0WYo;
	Wed, 24 Sep 2025 20:26:45 +0000
Received: from mail-eastusazlp170120007.outbound.protection.outlook.com ([2a01:111:f403:c101::7] helo=BL0PR03CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4V-00000003SGn-0ioK
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 20:26:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQ71VHWd0TFKBHsT+c2mmJkrKA5WnilsN7pM+VnE3iFViLbm7+J1RbSLMQ/qgJ2wVTIZSyWE4sUSe//xLzy3RN3oLHQUByVVVtmxTL8pwdeJHXk8RsMmNGmyFUiwCwgLF24QA+RXMiTFQu3Qqf5mH0Vpw3NlBAPmzHSjwxeaRzQKRkHj1+/yNhMW5RVwbnvbno1lHjjkmRLSqxBlAFGtbkn7bq5fLwQjUOOXozAX+MLKVzMJzr2FhzAc7TwvSEhl9u/Wn9uSndmYSldb9XT5QTW5hr4IW6n398rmc2ULxeDT6SlaangM0q4p5IV111l+sG+mwsP856fJBEBXooBoJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5fNfFDVbrbs9Djw03E6AexbBUUKxsMyMa2lkhWJRX4=;
 b=GqH7Ar6hpngHI7M98PlBcHlMPLF0PzAxojbdzRbHyMsFtLB4UHBcvN31aMj9N9MKuSi3dLRmb0Q4MMcinfft5bS9Huy9yRypkDp6MVpqLPACF+amn5JR7M6cJdHundF69TFBjOGm+5vL9NrGVTZmcT/P7uXChwof5xoC/BCr16/pNKsjJoar7O4VtR9ROCzH1vHqwc3fd8AtzbCOrm0bTkOe14A2w94mufPOtcqCbfeL+Vwfe3fBB8j9eBPrIAqvv/4FNxNrp41Omu3pyyzL4O8syXGiTdSpSkYSvcQLmOGR/AkTYPvsRrV0DbvK6mZknVEUTH8QI0CpNPbcuqIkVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5fNfFDVbrbs9Djw03E6AexbBUUKxsMyMa2lkhWJRX4=;
 b=DzIFdUmJBL1VjOCOTgK0laBr9xZFrVn2s6kO1UJwD5bnW/khBpUMWpIQ5N+Uipi/IbtXdE49esEWNRvPyuPxUOrhOOFygrDPXE7FYyVVL827swtbR+tp7Lni5tfnuDheyeCn9+7++ezJY8TF7xWi2DN5aO+yl8VPN9d7Vq8s2Ouup0BT3+7UbNbH7MkRsdwotXW2RWdR22A3pckkZ1n43yeunn8TrphQPhR4meS4aTqfy2aQhT3c1Ob9lebNzRH8albW4jGMnZ1XHBS9DwHOoPSR7UY6KXbeFUUmj8W17Cz6KfSdzerlBNvn8CfOLGOtHvdD/T5lWIG/krxFh9hZaQ==
Received: from CH2PR19CA0020.namprd19.prod.outlook.com (2603:10b6:610:4d::30)
 by SN7PR12MB8436.namprd12.prod.outlook.com (2603:10b6:806:2e3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 20:26:29 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:4d:cafe::24) by CH2PR19CA0020.outlook.office365.com
 (2603:10b6:610:4d::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 20:26:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 20:26:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 13:26:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 24 Sep 2025 13:26:13 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 13:26:10 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <dwagner@suse.de>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 2/4] nvmet: make cntlid ida per subsystem
Date: Wed, 24 Sep 2025 23:26:02 +0300
Message-ID: <20250924202604.7201-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250924202604.7201-1-mgurtovoy@nvidia.com>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|SN7PR12MB8436:EE_
X-MS-Office365-Filtering-Correlation-Id: 982150cb-55c5-497b-f22c-08ddfba8a487
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RiU47t9OI7vNdRN0TPvGBvss2RA5j5EFa3405+1rrL8Ffvf36oVqr1cowIUK?=
 =?us-ascii?Q?Vf3nvf3IKA5bhje7jYp3326LvXOqIIpEWefJ07tqJzN6wTiUJ9uWQAqZWI7y?=
 =?us-ascii?Q?d2VQ73ggmQ971MIhE0KXGqydr13cczSk+yfXDTR4pPtBshfx5kNbCXWlUmDp?=
 =?us-ascii?Q?y9Kzewk99NDOuXFXz/R++vqfSkivGrlbi9Wqogq29XcmhCAvaLQo8Jzvp3A5?=
 =?us-ascii?Q?kKnTusUDUfwk1L+mMZDeOr/J1YBo4LfOQ8EgtQ7EgY76+kt3fzOndLXHK0u/?=
 =?us-ascii?Q?A2/Dnofi1hMBOn8xqlTdufdtxNZhCqtR7zHRzrLXe188TXChzMRFiKFQXzlx?=
 =?us-ascii?Q?Eeyf/83bcjAaCFMcCJst/JrjBSX7vbJrK+HIEIgTF3McnhgGLhhUi9rSEocr?=
 =?us-ascii?Q?orwwOrF6I1NhsEyBFCu7/NSLMc9OERKe1BIf7qsIPPIDAoj4QWh91SVhtO1W?=
 =?us-ascii?Q?KEM1No5Brdir9uqm8qGA9Cx1TbKKXe/xCgG/B7Q26KNJEHiNIFqaCTMG5qW8?=
 =?us-ascii?Q?p7NQ3B5RE2DHRgUxmatYyT4+Rf/SvTv5TEw62BUQlSpFMyixQRO8uoFxAIvz?=
 =?us-ascii?Q?+G0JyGX0jKqbv2qzVex/mIp3ar0G/UCxamgHvEX/hTVCI/W6+UZnKyW4YKoG?=
 =?us-ascii?Q?FfahNkfMbqipx7vZVOzXR64C/Ns/uvou9XUi1s2UBny2l3GlgRIKNV9/Ux07?=
 =?us-ascii?Q?DiiWqp362a0xvpbZI+T7yuO0+5O2xa1/1K6eorygH4VdyvlujlwmbH5CW968?=
 =?us-ascii?Q?wh90brf1y3eJMcu6k7isLonvE2angm17OpvbEuY6J1HxHd+hJUxKKy+FjXz+?=
 =?us-ascii?Q?c7k0vhD+BMWGX3NkIJnG4JENNngiFgWKDZXlpoI7DpfRrVrvVP27fT82CKER?=
 =?us-ascii?Q?ys8cJ5xLdFYcg415Jsr/+UOM/QAdooz+rei71F6uY6XYrZ966PYD+tA3EbOs?=
 =?us-ascii?Q?RdsSvmSiFhmzMIYgwj/LlTBzxXYHs+TJkSNmiNqpPMkfqAJTG+PcVna+xm3P?=
 =?us-ascii?Q?GCgqRl1v4CutD1YuU2zXWuDcqqJMYhrw5JGcCo2XJgll8zeZeTaG4lwfF6K1?=
 =?us-ascii?Q?EAPYAmVYEknk31Q/dn2OTr6vXaJj30xWnFo1famtJjl/hU7nBoLyYnVLKHjU?=
 =?us-ascii?Q?CMKXhIglDOPFxudUCHJk72R89oZ4EdOvxatSAXaZNhPt4NlMpk1XOkMMPXB2?=
 =?us-ascii?Q?QR7tdlL7EfXzoDD7nxuprxDw6GNnbRSyeWWbZAo8XJMI08mI01oWkuY5lgoU?=
 =?us-ascii?Q?PiQejQwAV22K5TDVZqk3tCVfhNAIQkbKpiF/WXQx2b0iCnwKYF7aO4+XXguo?=
 =?us-ascii?Q?J40YK7BUXjNmroKTbSDYL3RabaqroVmuL+V9xXX2snsJZhT+dJLICjD+pHQY?=
 =?us-ascii?Q?z4EJGbBni03WyXcRgx4kywT97daDf96VV5a7ZOm9Out3ASIb/M1yYEGHwHW1?=
 =?us-ascii?Q?hprLBrLPwvelHF9PfN65H2Ast2kszAu/IFZjsajJiEoZK8ALXIeOKWN+F79x?=
 =?us-ascii?Q?DXmp9v/+yfKpXtsjsYJV8TUH6TH9ztvShpmW?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:26:28.8480
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 982150cb-55c5-497b-f22c-08ddfba8a487
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8436
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_132639_212910_B31FDF30 
X-CRM114-Status: GOOD (  12.81  )
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

Commit 15fbad96fc5f ("nvmet: Make cntlid globally unique") moved the
cntlid ida allocator to global scope. This worked until commit
94a39d61f80f ("nvmet: make ctrl-id configurable") introduced subsystem
specific cntlid_min and cntlid_max configfs attributes.
Since controller ID ranges are now per subsystem, the ida should also be
per subsystem. Fix that to ensure controller IDs are managed correctly
per subsystem.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/core.c  | 10 +++++-----
 drivers/nvme/target/nvmet.h |  1 +
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 20e7b3d6a810..b0bdb20132ab 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -22,7 +22,6 @@ struct kmem_cache *nvmet_bvec_cache;
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
 static LIST_HEAD(nvmet_transports);
-static DEFINE_IDA(cntlid_ida);
 
 struct workqueue_struct *nvmet_wq;
 EXPORT_SYMBOL_GPL(nvmet_wq);
@@ -1684,7 +1683,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (!ctrl->cqs)
 		goto out_free_sqs;
 
-	ret = ida_alloc_range(&cntlid_ida,
+	ret = ida_alloc_range(&subsys->cntlid_ida,
 			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
@@ -1747,7 +1746,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 init_pr_fail:
 	mutex_unlock(&subsys->lock);
 	nvmet_stop_keep_alive_timer(ctrl);
-	ida_free(&cntlid_ida, ctrl->cntlid);
+	ida_free(&subsys->cntlid_ida, ctrl->cntlid);
 out_free_cqs:
 	kfree(ctrl->cqs);
 out_free_sqs:
@@ -1782,7 +1781,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_debugfs_ctrl_free(ctrl);
 
-	ida_free(&cntlid_ida, ctrl->cntlid);
+	ida_free(&subsys->cntlid_ida, ctrl->cntlid);
 
 	nvmet_async_events_free(ctrl);
 	kfree(ctrl->sqs);
@@ -1911,6 +1910,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	xa_init(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
+	ida_init(&subsys->cntlid_ida);
 
 	ret = nvmet_debugfs_subsys_setup(subsys);
 	if (ret)
@@ -1940,6 +1940,7 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	nvmet_debugfs_subsys_free(subsys);
 
+	ida_destroy(&subsys->cntlid_ida);
 	xa_destroy(&subsys->namespaces);
 	nvmet_passthru_subsys_free(subsys);
 
@@ -2024,7 +2025,6 @@ static void __exit nvmet_exit(void)
 	nvmet_exit_configfs();
 	nvmet_exit_discovery();
 	nvmet_exit_debugfs();
-	ida_destroy(&cntlid_ida);
 	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
 	destroy_workqueue(zbd_wq);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e5a4571199aa..9245fe4f6cae 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -322,6 +322,7 @@ struct nvmet_subsys {
 	u32			max_nsid;
 	u16			cntlid_min;
 	u16			cntlid_max;
+	struct ida		cntlid_ida;
 
 	struct list_head	ctrls;
 
-- 
2.18.1


