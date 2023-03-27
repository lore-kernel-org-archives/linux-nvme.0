Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33C0C76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 06:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FIySmPg9+AS+76lW0SvMuPZZpN86IxwEtPYKpV32D1M=; b=XBnsoCbPEHhqw/xoLIKcQGbvEz
	CfjhDN/WHMWQUrU+cqmawCntIHo0sZFxlF1xGwsZnuNJD2MweHxZlwWHpgN6voSw8nQYLwfefcRKo
	Go3ITJ8pMMg72BDXNPT/7GZ3fnit9J0vayqhrlSwOtRbw7JXGft2+8fQdJX0EW6OQNG7ht1JRzXWN
	TjkDRGR0MoqWnlqm/aYG/9bssNMp6hVNXZFR+7TjYCVXyK2Fu8d7UVyV4z3f+beHNeL5vHOs4DtYH
	yDWmH953uHcFkbOZsehpRuNKxPXatxL0Zqvt9/j4L3bLnJc0liqJm+ZJfeD4t0Mj7cnILliFgTEhh
	oSs8ljFg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfyX-009u2a-20;
	Mon, 27 Mar 2023 06:05:01 +0000
Received: from mail-dm6nam11on2060a.outbound.protection.outlook.com ([2a01:111:f400:7eaa::60a] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfyV-009u1Y-1H
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 06:05:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5OWRds8XbIj+BsdMkFLUp3FF4pFkztZfxltBXlLISivhJMt64jgbtGK9Qk6tfEzHNgdAjLtvZvu3DwJrZGxMS4wLTIbfTcZuq79Mv5tnRyMBI258l1tIY0joojEjWBJFYvLTaH4qkR6r1oBm/tVeHVyrTcrBxHCElU39U6SRB8+VPDo1kmEuk0HHOKnTYv+Ob1AdtRi1JVW0hc0BTDZyRSRFmF+Sl3AkbJoIDvrplsAv8k0/IOtMz3ZMGSN63brFgXui27tBvGqImNzAbCNCk0ff1gdDxiJgkBLtuyPKffGTkR7Hf1cPyIEXG0Gm425BnOfg2QNDnbR4+S4PtNE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIySmPg9+AS+76lW0SvMuPZZpN86IxwEtPYKpV32D1M=;
 b=lT+MiA/oCdEFvXWSm6etaeyjejflF34EMEWJxVpcHek6bd8eQpLJ0kzZYbeOCm8QNedgHCOEvKzKHDp2UVQ60HRKvId4O66tLOpjnyrptu1zrRsn3TnxaeeVdCk6o58+mXI6FpGsqQ/nZh+pjKz0jadCTpQUuo91R2M/RWcXE+lrossza3PeToWpD6qvU7sYChWh3c9ldx0SbhRCbpX0ISuAHcDspp4ruHtUXGEzAZhVvdy/lMFqqftHIZNs/TrVIBllKt2ZWcaP4hPld3pYdeR6FdA3luqmF42EO6zgp/C/WjDo0TCbjr03N5KOCJt0Urm8jludRloKEzwShlNabQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIySmPg9+AS+76lW0SvMuPZZpN86IxwEtPYKpV32D1M=;
 b=pudM1lnTwgvlD3XABkIRlvz0ES12vm19VAGrX3iy+aSI8WMEGFL6rUHwqKlf3D/4g67vDryzAcy66dua5qIdjA9vAwCSkyE+gVcox9XwKa0ZbDFgH8WCNU0Uw8v/V2+o76B69ZbyeaCbuwKE1AZ8lGO1haauxP8WgAW5VHHOecwE3u753+/E/VV6+PRdE0QNRXtvclqVUF0iV5VP7NBBtoGIpzM74c5YGHGpqt/zSl7gBofjHqgpuXa+Js/bQRWMqcdJvuTYUKXLHdLVhPLHrIsN/KIzt7ep7Ox3hyZZ47OHFxU8mIWx42Dr+0qGDRrafXo6qjL31YJi6BK878LErA==
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by BL1PR12MB5192.namprd12.prod.outlook.com (2603:10b6:208:311::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 06:04:55 +0000
Received: from BL02EPF0000C403.namprd05.prod.outlook.com
 (2603:10b6:408:13a:cafe::c7) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 06:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0000C403.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 06:04:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 23:04:40 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 23:04:39 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 1/8] nvme-core: remove unnecessary else
Date: Sun, 26 Mar 2023 23:04:11 -0700
Message-ID: <20230327060418.86655-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327060418.86655-1-kch@nvidia.com>
References: <20230327060418.86655-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C403:EE_|BL1PR12MB5192:EE_
X-MS-Office365-Filtering-Correlation-Id: 1996432a-2567-46c0-abf9-08db2e893050
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	dtqrmDy+PT23BNp7oh91L2xB2r7Vc8LFWB+76Mj7/LyKzb1UuIoT5lF35hx2xdl/5BFJQYHLMsGFbgkVMUhlUIb6V5U7W+bs4LxSEGalyO7RQ5W6unz2wlx7YbegliLK6d7jJKho7qCjUUID4msbkxhGI5E8sGXx+a0Hbwd7xGR7n/nThqD9L+TDTwyJ6RcvfXNa6LC707B2y0nfj4VkEfeAVfE4cszvnCMcN2yTGJG4c8nd75Zd5CBVPezMiPpFo14BWGhCpk+BJX8l4nvAPVdXi9Yb3fcYZYTVVS/5j3ppPCAvFAd3ZnZ9ZbtKHu/KscVELm6s/xaV6FJQHwTL3lk50ZwElocX5kuc4fKMoarmRfXQt3+MPeXxJHkxSmMvLe9S3G45eh6lwVyBdO7GUK9/bCxjSZUOJQERWyRSgndiyOHOj4fTbXXF0zAPD0RshfAZHnpRyfKhtT/jZs3Uysw315RA/ASHSyIrKHpswhEa4yg2k+6yTETdiwZWBmViqSAmRJxXeaoqzqnAyekQ1PwW/xnhXA0PtQpVAoIFREPkNHHkZV6CFIM7iK4543EtjrVbDdSk2vj2vKI2gS6JMR59F5MfWlrs+5YGJ1RqDTYofbGCQ8VohZtxS9UGxaAz9TS/k9kiF+4fpx/DKoJOPoyLd8X6DevW2t1nR4HPDE4l4cX22kuo9yERVTkuAkAqkzkEAFCeOWrBnhQenLhrUq07D8jAWaILmEHr00CPM7BNd1h4xCwdXz0H2ovMwpk2
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199021)(40470700004)(36840700001)(46966006)(316002)(40460700003)(36860700001)(54906003)(478600001)(356005)(7636003)(82740400003)(5660300002)(8936002)(36756003)(82310400005)(4744005)(2906002)(4326008)(6916009)(8676002)(70586007)(70206006)(41300700001)(40480700001)(107886003)(6666004)(186003)(1076003)(26005)(16526019)(426003)(336012)(2616005)(83380400001)(47076005)(7696005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:04:55.7016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1996432a-2567-46c0-abf9-08db2e893050
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF0000C403.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5192
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_230459_442664_AC29ECB8 
X-CRM114-Status: UNSURE (   9.96  )
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

By returning early we can safely remove the unnecessary else part

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4be525f8100..71e2f6723590 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4475,9 +4475,10 @@ static void nvme_scan_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (ns) {
 		nvme_validate_ns(ns, &info);
 		nvme_put_ns(ns);
-	} else {
-		nvme_alloc_ns(ctrl, &info);
+		return;
 	}
+
+	nvme_alloc_ns(ctrl, &info);
 }
 
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
-- 
2.29.0


