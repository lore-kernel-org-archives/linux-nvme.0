Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE68FC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:08:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oJzNnrrN5kXiyixkwnisz0H0HeMwrSttgHekZzNkOJY=; b=auR0HYqYXvv/eFmzdfj3ydqHsg
	ZF0MPtAl/sL6P9ZnzbrWkMEm9Nu8TiElgGlqC3Im50WhniEWZ0ghAO4SIuwWPGz7XmFp7DWfcY9ao
	wBSSt/1loYJzapmKTTMdCS4pCkST+y1dnGbjpoKmTpf+hPnZ1ZPPcvO6CGXug+9QuG/qNHHi6Ig/P
	Kt55GDTsgzHNEThz4VjTyERHstMfN8+9KiC7pS8g3xnsb9+coTXJWrfVzjIUXoUozd4lUsEtQzn9L
	5vzZ8lpflFL5dCncFiKn85OWlnNjKPFysLd+cBnlEjl38bikug7OMHrKiazbe0ELNxip/qG3dGnxZ
	+nU3hxHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZDO-00EhvR-1G; Mon, 14 Feb 2022 11:08:18 +0000
Received: from mail-mw2nam12on2060b.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::60b]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJY6s-00EMyQ-Bx
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 09:57:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fhSpt7By+/ClPp7XX6SLXOT8+uOYR+6EfqhDtf3lQrT2xtdMto1KeQEfdyMb/X4yDoMvf3YjAPRpFc/GB0ZMDz7T32aatzD2KWSyVYcHzSxaVwgF4BIVo+/vp96ANRjpe4p82/leVYLsrUuoyXNPM6Ti6o2vWdIfpB1fbD9ZYAAyfYh0ulX3ywCHUmU59wFw2j3gBEia9LaqPOpoR+ZhTC38n+gFnDtD/9RYEsQ65wGVC9gxus1Rr4YHPLVIDGmo1HlwM5qhxCmLvkRYzo0EpbRHbb/bLbXi37JCPO0HY0RoGCzSw6yqoscE1ZpBqtgiYncp69LyPaLfYjt85XHDhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJzNnrrN5kXiyixkwnisz0H0HeMwrSttgHekZzNkOJY=;
 b=epcfeM4i5ZAYEd1X9UPw4sjV5DSA0l0dR+L8ooRK9zzWf/WT1jdFg2oplIP61ACnNa17A4EMhCZSnqumDVCtczE7szOZWx91BlXVWGSQty5yHgK5ckGoEeYJx9zkPHjAwQ2TvGDYBVdETUHrUk35iC7+Tcnphj+EugBUVdcdqFpMgn3scQP5/aDEfl0yt2HRmkj5bNNf6d9aIyf5R4Lkifmj0CDMFwPvaTE+mxlj2wKbA5CvlY78P/sxYQwKmnmphpNJUwAnGig5s/KLfjDs2xFcJZOS3zzhEGBbQFEGRmXVFBe0ASxq9Pkk/XcCIzkDnwWOsFuyJymev8vLKzvbfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJzNnrrN5kXiyixkwnisz0H0HeMwrSttgHekZzNkOJY=;
 b=DPkHbM9kaXtFuupohIrNPDQFuAS4BQdojEoMZGVJcivydEVWqGlDUq+lArDvkKpFdfQhYnS/OsCGJV21qGKh8UY8B6WaQQkoS8NtqlJk+yBFxM02djhH1fvgrVXgFqTECrWyCeOuuzy95kQ7X/GW3W65anV01CuRB4s9vnJA87t2S23MzMsB0Wh9iDckzrifS9dBK7BUn8+5Eey0xxxiYz6X8fBopLL3bf+Xp6ZaYlDZimHseQxDuQVQCpBWiswwokCF4CN0ds1eYWRVSb/NUwfcWfFsvYJxigOCrfV7YZLcLkvG00jJRT7TDpsdJwx5HkVguPTozoYf7cEDY5kCrw==
Received: from BN9PR03CA0064.namprd03.prod.outlook.com (2603:10b6:408:fc::9)
 by MW4PR12MB5625.namprd12.prod.outlook.com (2603:10b6:303:168::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Mon, 14 Feb
 2022 09:57:26 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::72) by BN9PR03CA0064.outlook.office365.com
 (2603:10b6:408:fc::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14 via Frontend
 Transport; Mon, 14 Feb 2022 09:57:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 09:57:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 14 Feb 2022 09:57:24 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 01:57:23 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <james.smart@broadcom.com>, "Chaitanya
 Kulkarni" <kch@nvidia.com>
Subject: [PATCH 3/6] nvmet: use non-deprecated ida_simple_xxx APIs
Date: Mon, 14 Feb 2022 01:56:36 -0800
Message-ID: <20220214095639.5125-4-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220214095639.5125-1-kch@nvidia.com>
References: <20220214095639.5125-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c06f17ed-c68e-4b67-5ac6-08d9efa067aa
X-MS-TrafficTypeDiagnostic: MW4PR12MB5625:EE_
X-Microsoft-Antispam-PRVS: <MW4PR12MB5625B1D561E96846027E6AB8A3339@MW4PR12MB5625.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IXkgzbuPvKJtfftPCCRiIZrF31JeVQPxc2CLIZLkSn1C+XW0HZkzsIycwO7hEkiZCdlW+Q8MfC+rhSkmVXd90mFz89gvuKmvODi/1DQn2Q8lJT6CFv7FoSw947QmeHAJJDNJc1uddkS2Z/UPjfP1fYR3xEdon45t+Bf7qilqcJsBACdg6usdU2MGcI4ZEOAW9K4XG5mU3obutj+nk/Aklb0gMKDZeUmQwnre1F2TQdlChHGzBK2aW6lE1FEf5L5FegpuM8dZoavHdhtGnxAFXtrNPApsxcmGRhX4lnexpitjVVz6DpLuSP9CQ8z4+4CYEmCtjV3EuOh19n4Pi4xtZlqW+Y9xQyzmKotFLQyMGuwJ8BYscp85JuPTkDOpvXwBVw8HDO9yP1rjPPeL+uuuRZEE1f+wNMaOWuPael1YcX8s5sY0DQseFW23Bw9zpX+ODoic+rhfm91unRWAq42UoleT6exIn8ww3aZt/+vSvRk8s2sADErXTC7iBlG5JFITCSMAxI0+A2nlbHoU1Z5xx0fcvI1ilEIyw+tC9eQJjlH7Xx6QOPoyJYNEfMnZgRBixYNrWIb7eXmUO0JYxjVRqVrCu98JXsSr+fz30813qMJLYwmjn73Of0NRnfBxPl0sysWRN8zVVR5q3F5JszFDQ0BUck2NM6Ejc1JE82Ac2qfCvA4AryZO6Vi5XPdLtDUYnKTEEzk368vw0wq7vrwq/Q==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(6916009)(54906003)(7696005)(316002)(508600001)(82310400004)(83380400001)(336012)(426003)(36860700001)(47076005)(6666004)(5660300002)(26005)(16526019)(186003)(2906002)(2616005)(36756003)(40460700003)(107886003)(1076003)(4326008)(8676002)(356005)(81166007)(70206006)(70586007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:57:26.0940 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06f17ed-c68e-4b67-5ac6-08d9efa067aa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5625
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_015730_448764_F6D7074F 
X-CRM114-Status: UNSURE (   9.49  )
X-CRM114-Notice: Please train this message.
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

As per the documentation present in the file include/linux/idr.h
ida_simple_get() and ida_simple_remove() are deprecated and we should
be using ida_alloc() and ida_free() instead respectively.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de68..e1455ad487b3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1400,8 +1400,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	if (subsys->cntlid_min > subsys->cntlid_max)
 		goto out_free_sqs;
 
-	ret = ida_simple_get(&cntlid_ida,
-			     subsys->cntlid_min, subsys->cntlid_max,
+	ret = ida_alloc_range(&cntlid_ida,
+			     subsys->cntlid_min, subsys->cntlid_max - 1,
 			     GFP_KERNEL);
 	if (ret < 0) {
 		status = NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
@@ -1459,7 +1459,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 	flush_work(&ctrl->async_event_work);
 	cancel_work_sync(&ctrl->fatal_err_work);
 
-	ida_simple_remove(&cntlid_ida, ctrl->cntlid);
+	ida_free(&cntlid_ida, ctrl->cntlid);
 
 	nvmet_async_events_free(ctrl);
 	kfree(ctrl->sqs);
-- 
2.29.0


