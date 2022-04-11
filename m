Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC83C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Apr 2022 03:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEFT30QwMgaV+gKH6rDxmf1IGpc2qFx5Wnw+q65Lpys=; b=Gsl1736dU9YeLDaT42jRcpN6r4
	WX5KQl2dBKAlCTdSpm9yzZIdCrl6iftF0ftcxFlwI5NoYnPYi1sPe3EaNvjZs5r+V9KxDfOBbm6MQ
	55Lukat8TvTafnJQGhIhuMfWP1qNbsB6n50WOuB+oZpwWX96OIsRP0ow370efmnPg/90+kBcvBWZC
	JlaGdy2QOGfbdT9KbD2CAAA4v9WuqXi4P1BezhPFITRgSUOHwhmv8bYY9hblypf0a9tLmhPi2FTHC
	JzYFea5GaLm0K/rE5c85n3AhJI8ETmS9rl7eF29bNa6fEJPZo9PdGRuTMUMx36LHxm70OZ75Z8pDd
	s61ADyYQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ndkUw-006PPE-Nb; Mon, 11 Apr 2022 03:13:50 +0000
Received: from mail-bn8nam11on2062f.outbound.protection.outlook.com
 ([2a01:111:f400:7eae::62f]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ndkUY-006PB0-Jw
 for linux-nvme@lists.infradead.org; Mon, 11 Apr 2022 03:13:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PAf1tqqr44B7WXDXIgKv7JsUCU4+r83s6hfHiAu3OcU0GxGcH8tnpIKVWXqShaQt7nidSGkzIcCMruLsnZdNP/A20Uwz9b3Ovlqti7mp8L8FQ8iRRXGJ+F3A9Mnl3RidfYxm38VkP55SfBT1UsrY/qjvawIzZLjErniwdFcjrM+49DnNcSQUErqT93SD4DK86D9uHAv3fBSrkvw+CwP9+pZfA/Xi1abwPuUAk5cDOz4TwWVAVFp0sOwjMGXtWOWBZlqYI7LZX3CUUDqYiDYumwE4Yy93/dUB0GiQITKP6C/yrao9IHkg9lYR/EvnvIXNe1IP+2rVpsfYhEOZ5+/ujA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wEFT30QwMgaV+gKH6rDxmf1IGpc2qFx5Wnw+q65Lpys=;
 b=B0gOz3pBxGcHA+hMUJysb9hklSys/vTTm1Yqo8rKqTvbLWp2iTc8pWkZXIXxKhHKRw1BsfzHNnTlRlRoFr/9b7qtAJk5pj6PzFImzChgCJXSXF3dkct5Mtkvzeb2Bvp3mkgCMDVF8pIDZ0FVjmaAw9ZWXwwiPwH+6noVnjoKJK9LP7uD1t9Gusu9iQhN+LYZ7Two+GmQSemzephwRndO9QQkTDYtHGn6ezGA8kJftTSEnJlmhwpzRH2nZJNBCqSyYEB7HbUo1WWPMP2fGpSfv+HmndwUlEo38tA6weIkWd6T3WnVIKnBfwwNolzCG7O6Cch7KpyySRHGUiB384CgTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wEFT30QwMgaV+gKH6rDxmf1IGpc2qFx5Wnw+q65Lpys=;
 b=EeXbY0TczbZE+oP0jY7Ls/TH621w2U32foOsrDFbeQnxl03kt/HtjWaZQzPN9m2Dzd0LfLTbUm7/tsfkR7nVQnv3GCR7nrvomXwa/UNLOONnkSA3f81q8NYQOCstLEIZHRlwFhrJ5SQaOjTGV3jLQcwlo7W1eMhyAYopD4dJmKFWfPtDrEsk3BxT+Wk0b8yIZ/yJJovys1RL/MXotLL+qTmHkbwpHkTTyVGjKVNMWMMfHGtnddVBGwaUS2wbV1t4FIdtbVji1c/mXEj2IGOt/ll2EUXrmuRLYQt2uQuKk/eXNLDsQXypp5DB9A6cek8akbl0q6kjzj4tqAJotisEHw==
Received: from MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20)
 by MWHPR1201MB0254.namprd12.prod.outlook.com (2603:10b6:301:57::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 03:13:21 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::b5) by MW4PR04CA0285.outlook.office365.com
 (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29 via Frontend
 Transport; Mon, 11 Apr 2022 03:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5144.20 via Frontend Transport; Mon, 11 Apr 2022 03:13:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Mon, 11 Apr 2022 03:13:20 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Sun, 10 Apr
 2022 20:13:19 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <kbusch@kernel.org>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 2/3] nvme-core: don't check non-mdts for disc ctrl
Date: Sun, 10 Apr 2022 20:12:48 -0700
Message-ID: <20220411031249.5158-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220411031249.5158-1-kch@nvidia.com>
References: <20220411031249.5158-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ee9daa5-24c8-4708-2479-08da1b693b9f
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0254:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB025444B4DB691A0D9DBC171FA3EA9@MWHPR1201MB0254.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uXV6yx8N5AYhihssj/X5bSjlrPvgcDqDNKvgJ3nJ4lSB6A/RST70Iiooqg4E9qkE8IYRsV9bIrVdK6bPmM2c4DEBaWMO+LQiBMl3aqN+QCewQcMio6O9qxw8w1C+vAK6Hyg8gXqKsROslrf1P/GBQjPmWmH5QfQCiMUE7ehwQOskVtIZ1+UgC2EKpXaGjhTRjNvoaJstj06uJD8uGpnx//4BFBdBFHEEhWYaYPHnyh7Ohc/Ow8V+XCQLo5X7RBNm1/6a9FA1EE31dA2WaBrtf6hJ2Br9yOLfyrci8AHMMurK8NC5PNoGGEVsAi9HRq1dUzQwMr5F+jtWZ+oMiP+NhdGZOzz9oGn5YvzuyghExr9dt78iYp0pCM4JK1Fh6GdpCk7i04tF/VdR1N/XNJ1Gr4MKDfYPnjDOS8A9bJ/ObZxKNthYzlYNk6m1CLv3y/dkCszEa8i9WuvgQT6B3Zy/Pw32SxuUbUJhkdhNX2rxXBUlz8Ar1DMq8szzn1oq6EJ6u1k01487JDSoXZXBG5j9Ugpxtp5bUx4JDhVhLFF1AgflDV2jw7YgG+QBB3vjNutQDSXTSK+etHqcMf7LZqjr+/XAXLGk/sAfNhSR4gFJ8cf90aaCenMFfAEApptis1HDUTICvH8tt5CPFDlbX7DZv58VkwHKF4jOh88IXKtsT64EtOCrOgPZhO3TV+fKsZ0myMF3Z9sXZqa3hnqkQZxH7w==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(4326008)(426003)(47076005)(82310400005)(8676002)(336012)(36756003)(8936002)(16526019)(36860700001)(186003)(70206006)(70586007)(83380400001)(2616005)(316002)(26005)(107886003)(356005)(5660300002)(1076003)(81166007)(6916009)(54906003)(2906002)(7696005)(6666004)(40460700003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 03:13:21.0897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee9daa5-24c8-4708-2479-08da1b693b9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0254
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220410_201326_696680_7F7C57BA 
X-CRM114-Status: GOOD (  10.53  )
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

Don't check the non mdts limits for the discovery controller as we
don't support I/O command set, this also masks the following warning
reported by the nvme_log_error() when running blktest nvme/002: -

[ 2005.155946] run blktests nvme/002 at 2022-04-09 16:57:47
[ 2005.192223] loop: module loaded
[ 2005.196429] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
[ 2005.200334] nvmet: adding nsid 1 to subsystem blktests-subsystem-1

<------------------------------SNIP---------------------------------->

[ 2008.958108] nvmet: adding nsid 1 to subsystem blktests-subsystem-997
[ 2008.962082] nvmet: adding nsid 1 to subsystem blktests-subsystem-998
[ 2008.966102] nvmet: adding nsid 1 to subsystem blktests-subsystem-999
[ 2008.973132] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
*[ 2008.973196] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR*
[ 2008.974595] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[ 2009.103248] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f204c6f78b5b..449378a96a9f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2876,6 +2876,10 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	struct nvme_id_ctrl_nvm *id;
 	int ret;
 
+	/* Discovery controller doesn't support non mdts limits */
+	if (nvme_discovery_ctrl(ctrl))
+		return 0;
+
 	if (ctrl->oncs & NVME_CTRL_ONCS_DSM) {
 		ctrl->max_discard_sectors = UINT_MAX;
 		ctrl->max_discard_segments = NVME_DSM_MAX_RANGES;
-- 
2.29.0


