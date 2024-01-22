Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B54CC47DDF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 14:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JqTD0AT86ZFD53JF3RkCKgf6XKETW6E+uX5nwddAatQ=; b=uTGyfsPxdNEXAoBIAzS10BWcDr
	KZ4Ew/T96kVcEQEL7o0yzRYM3DcAmg5rwDLqAr6pVnZhi62tUJi1os3+4Hgy1Z8WzamptwAmXyS+e
	DIe5LjNPbLaooNUPjFqT6Drc5GpeNeRYEFkBG0pBtA8AU9PhvVhGRH0fOdgrRuWy4LFnAquBOKNKm
	WXx0uPeFMfzLOe696uB9vd3wNjh+eRU7VqYbaV5kYBx8W1gSKOqvqVWAmQtxABGxnMmIhcf65MVdl
	7o3l2ebkg9JURzpRJLZ9aNbU8EaQ3mD0Wy9nM0OEtml9ACTWzKbprz1PTYNXsIlnL2izTOGy+f8nd
	pmUu3xJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkH-00CVt0-2r;
	Mon, 22 Jan 2024 14:57:53 +0000
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:2408::601] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRvkB-00CVmk-1U
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 14:57:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aCYOVL3ox2osVbhrpE/FJypBsXzJMebykqUCy10R71T8tsgaUsFhDFC8WGIay9D5zkocSqFn0HySk8vvKvlfw+gyRVq0ChD9tj//BY3J8ozF/jdrbjVLp7Vu7dP4e9CGvU2SdkpBe9LiMsW0/ZtaNg7qYrgnYwcLl7vNlyLvDCG8rLzcOFqgPoxgfydfqvsLBmtPOGKjAXDMGqUG6yksfIPE2iviHMtqztDKwGVCLR98KAnC0iKOdvlpQB1zowJa4IDRJdljl5bpYXv/AFV/W9TpfbRfUiZ7QzZ0EUk5aY506LsjhDay+OJXsONiANixxoMEaQJDG4+5rLA3K8ESlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JqTD0AT86ZFD53JF3RkCKgf6XKETW6E+uX5nwddAatQ=;
 b=PWwzsp93qp7vIf0cwGPtJk+gcHtNr6Ljrd/x15blwKAFaoC/BUtBmtyHRVeDWHccKVd0i7H32+URvD++2p70mH8L/W1nASBiZLyCTT7UWnyVoI+EiAxpAXjUfO7hNn+uUhQ1iPsrT4Ehkh2KLAujOgUXPyudOYiSGplVpPcU65Vthd3UWs4YQfJleqHsJEVbe3IsKTvV+dS2urRV7I3yCF8ZKLYxLqngokEXwDNmbjAuw5hQGEZoQ+lAb53JXn/RxDNShXXhSIMlqdWiKTINrB2JzvrmbL86d4nBMT9n58sKhX297gEfX0XAyKPu5gLv7FPlB0AkQH2lD7rRcO7x8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JqTD0AT86ZFD53JF3RkCKgf6XKETW6E+uX5nwddAatQ=;
 b=m9HZboG61PcNZMQ9b4xsnzdraR6ivgaaxjlCjq1jPUgyLX/NSDFOUl66l3Sm1n9dZE3P6Vknc+d5lBoCDa1YQsdCqapHksf2bXpEyirCDCl0T6IigOqcM0jZ+Ap6dnJAGWCtmMvzWxauUUYmj+aVmEMRpCwh0sY3tL4gofDJnvyQNP1XY1A7I3no7F2ChkwCuQQ3XIn1/54ItNre0e4oT34jH1WJWKqAxW23VrFvZtRk4OqIRvMjaCRquVajBciKZSwktq8qpapvoN7gGnWh3G98d/wVLMlBe9iMorzobVcPOqhFYx6ICkgxYoeUP6ol6VLrLVKK58aW/BDUvZz4EA==
Received: from CY5PR20CA0016.namprd20.prod.outlook.com (2603:10b6:930:3::19)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 14:57:38 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::a) by CY5PR20CA0016.outlook.office365.com
 (2603:10b6:930:3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Mon, 22 Jan 2024 14:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 14:57:38 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 06:57:17 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Mon, 22 Jan 2024 06:57:16 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 06:57:14 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <dwagner@suse.de>,
	<oevron@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 5/8] nvme: sync the namespace scanning during ctrl start
Date: Mon, 22 Jan 2024 16:56:56 +0200
Message-ID: <20240122145659.5574-6-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240122145659.5574-1-mgurtovoy@nvidia.com>
References: <20240122145659.5574-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 88cd44b3-d86c-4f4c-77ab-08dc1b5a79d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M9i15+rGLCVAw5XuJB8ztR2PlFCrF+FezSdKKog5oOc1ka3WQWbGpafjxLKgL33MZu7bb5r3iPKQ5iNi6KlF9pubJJEJ3oEeHUUzjjaDkQMHL9TayNy9cDW44EAgKU+eLHLIqIyrcFMSQbaXz7muJHb2dDWJ5z1Y12ZV3sn/RFaNIv7hjS9z+mFJM7T1jq+IQNsvyLjpu5YoNcX6DTPE5ACDmroDmvJ++NcubfQm9ogPr3yiKtOPd6nH3UDuYDWA0/TwuqtVDkld6G1nDCInXCjoc1tTjfujundUF3e5d7s/5HV2cxsDm/vz9lnX7aPBtm57UxjK86dhNbPQqjA3/ud5CsGL42TEEcPEH8MFIK3bSWeljVO01RZTS7nzcOgdBMLrlBxF+mRpHKPzKM4nWRkUYpU57CCcHCRs4CuXcuWpYeR2oKumCnIAZWIaJKKIy96urYDfSejt+wX2iJY6fMCnppdRjWOILyeoKrRFROE15jGNzbouvWh1kj27hktGODwpGGrXK3iJO5qrjCku6sWZMXyxl7C9lwaFprFeCeZt+dPP6cHPrE9N6hQLH636jZ28xgv2L2hJ6qZeUYZbTABsdXHif6vmoa+Ztg9gJ/Rc3D2cNnGOIYdejpo1A7phPWlI1gId+4FCNgVcXFNaxw920oGdu4JoEpncqrV8rQE/k0nBu957clDzt50rqO/3Tq/x5cw72YNF+dPSpyIDtIrAUCgtA6AovTuiZV0syjGRv74rRVHAB7rMSZA+00kD
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(82310400011)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(86362001)(478600001)(36756003)(26005)(336012)(2616005)(1076003)(356005)(7636003)(426003)(82740400003)(107886003)(83380400001)(47076005)(36860700001)(110136005)(316002)(5660300002)(54906003)(2906002)(6666004)(4326008)(8936002)(8676002)(41300700001)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 14:57:38.3910
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88cd44b3-d86c-4f4c-77ab-08dc1b5a79d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_065747_514037_F8C5340A 
X-CRM114-Status: GOOD (  12.43  )
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

From: Ori Evron <oevron@nvidia.com>

The namespace identifiers may change during the re-connection flow.
Therefore, wait for the scanning to finish before finalizing the start
of the controller.

Also move the re-queueing of the old requests to the stage that we've
finished the namespace scanning otherwise we may issue a request to a
namespace that might have changed its identifiers.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Ori Evron <oevron@nvidia.com>
---
 drivers/nvme/host/core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d0e4888041aa..90ffb3db1ed9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -593,14 +593,12 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	if (!changed)
 		return false;
 
-	if (ctrl->state == NVME_CTRL_LIVE) {
-		if (old_state == NVME_CTRL_CONNECTING)
-			nvme_stop_failfast_work(ctrl);
-		nvme_kick_requeue_lists(ctrl);
-	} else if (ctrl->state == NVME_CTRL_CONNECTING &&
-		old_state == NVME_CTRL_RESETTING) {
+	if (ctrl->state == NVME_CTRL_LIVE && old_state == NVME_CTRL_CONNECTING)
+		nvme_stop_failfast_work(ctrl);
+	else if (ctrl->state == NVME_CTRL_CONNECTING &&
+		 old_state == NVME_CTRL_RESETTING)
 		nvme_start_failfast_work(ctrl);
-	}
+
 	return changed;
 }
 EXPORT_SYMBOL_GPL(nvme_change_ctrl_state);
@@ -4287,6 +4285,7 @@ static void nvme_fw_act_work(struct work_struct *work)
 		return;
 
 	nvme_unquiesce_io_queues(ctrl);
+	nvme_kick_requeue_lists(ctrl);
 	/* read FW slot information to clear the AER */
 	nvme_get_fw_slot_info(ctrl);
 
@@ -4537,9 +4536,10 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 		nvme_change_uevent(ctrl, "NVME_EVENT=rediscover");
 
 	if (ctrl->queue_count > 1) {
-		nvme_queue_scan(ctrl);
+		nvme_queue_scan_sync(ctrl);
 		nvme_unquiesce_io_queues(ctrl);
 		nvme_mpath_update(ctrl);
+		nvme_kick_requeue_lists(ctrl);
 	}
 
 	nvme_change_uevent(ctrl, "NVME_EVENT=connected");
-- 
2.18.1


