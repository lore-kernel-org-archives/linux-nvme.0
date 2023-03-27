Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79CFC76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 06:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jUB4X31JccUsH7JmsM6o5fLHgoBZtRrgnCcJnq2gJt0=; b=eb6Ews1UmXmjxbWKx9cRDux8Cm
	coczRnJ3WxMvrkSFYxQ7ZD5q4fLpqeHEUOcvOEatqrL1vRFBXJLdbZhLz7YV2FzwlBxflziZqkfm5
	yHkifDhRkczzo8X91zjJtS6gGxYfuOweHrrZ1jPNgILHl0hILpBD3+i0hsdPu7MwZSPIDE2dCPN5M
	pXDtq6rpgNxJZbwwelRxr0yMIa4GzAlXPaZ+cKiN2RJ29ddcpVXrEf3b989+sSq3rtiQf/vPPwpoA
	1RmS0CESMFlgtWhyBC2DhihUt32FI5cuOdwEWjyw3sGR7ejzv9+0YybVsHLbgHq1mhLd/ICUv1aee
	6pFNcEvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzE-009uFK-1C;
	Mon, 27 Mar 2023 06:05:44 +0000
Received: from mail-mw2nam12on2061b.outbound.protection.outlook.com ([2a01:111:f400:fe5a::61b] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfzB-009uDV-1M
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 06:05:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj45BDdU+YrK61f5kjmb50hZgn9xJ3v/JFvIRHRKe2VxJQyhm99bdkLYfmjnFBngn6TCffkupckXGB7ZB35G8r+nih5CDmWRnm6u3foZgK9TicqDuyV8FbfzqrDwM5qTBIuDHCDNg+9fRvuUwk3yCmg8VU/dnuKnRGI2oAUPb88u/yeZMdyAizjwnRoez1FC9XI9QSTIE0Dp/A1DDmIaosaQGVyblnlUSVW/cymNYiSVP5Qeom5iKsJ6TMIDlv8IijeblV84C8btrg31HjLtL0RsooVe8WQI3wcsRrWY5jREs/Cr0fiOoSoc15U3R3B5d2O6mOkX+hQ3fj+9WCiSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUB4X31JccUsH7JmsM6o5fLHgoBZtRrgnCcJnq2gJt0=;
 b=RNbUocKrRnOqxrhnLg4mSUXLHhGe58z/5j1lzyoA3qlDpEzU0VPFqnO8o70zOzws7zQ+u0I0gkeYtiUuC90Fiy3nH/zoQYOFuQCrrVr/oLaED6eNPOoQ0aq9Fxe0xVm+la5mK2xJqp6c0ZXwYQlau09C8NOJR954wLy+KB9BlKOgGVYnZgJj491wI2/Tj7ayshNDOH4iyGLuxJ7jh2li5c+UtQH17mUqSxuK86+R5UtQaTZDj7LYxH3yAxk+FQhV7RwwGyl3jTT9WXe6zGQg8EMNpZMZ0VFQFNPyv3BfUSjcv4YFwv2uuts072o/3zwVvNf3IddjH849RquhwUU63w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUB4X31JccUsH7JmsM6o5fLHgoBZtRrgnCcJnq2gJt0=;
 b=kgOtKrAifqIYN4dQGPoH3rjiGpbjjBSC/p+eDk7womnwbwTPq/Wm2Mf81R4FPavuCU+0r76B3Qoc4PzFHccQykMbUGbCbu2IXmuIgoRwr/yp+o3+1wTYHl9hK/B7bVntQzPem6xJPjLNPuXUHdYrt/cLqQ6NoDNSO9dAlnEQg+qX9Gu2L0k8XSj/RDj8JGvmmvymWl99evgBI67zEEkk9uGHxK7Ny8Ugy3cwrGIgsvbutO83vu3RGhaY04QVS+Q0XF8R19/PEyL1pEq+SJoH0JvnjSJCRHxqJ1AIvF5bdzALkyymKH6f4xMEKyXdT+CZI9ToijCUOuc79Pi8SI+X9w==
Received: from BYAPR05CA0097.namprd05.prod.outlook.com (2603:10b6:a03:e0::38)
 by DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.29; Mon, 27 Mar
 2023 06:05:37 +0000
Received: from CO1PEPF00001A64.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::99) by BYAPR05CA0097.outlook.office365.com
 (2603:10b6:a03:e0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.16 via Frontend
 Transport; Mon, 27 Mar 2023 06:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A64.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 06:05:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 23:05:17 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 23:05:15 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 4/8] nvme-core: use normal pattern
Date: Sun, 26 Mar 2023 23:04:14 -0700
Message-ID: <20230327060418.86655-5-kch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A64:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 162d7d93-7ebe-4600-7df6-08db2e89491a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	zjQgSQttIY0i7MCEFsoJ3Zm5mwQa6TgNaDOJw76nSqK3mAEmJNHvK03IJyNlLjGxTvSdgUiH8+kWuILBYwWzEKmV4wv7qykBV4qFcObZrapl/UGwXSPU6OK0ntmIfUQlOf5TJf4toFTXAtTLhEdtjzUPcwanbtb0qpT5hOF7m1QgMOhEqhAiTMwjHX/FVtKUbUXINGYCHwOR8zG0FXRDJsavVVQ93tsoGzTd7p3UYNqyQvtfev+qxgkrkDmH8uLPTe6IikbfLSQGM0g62ragDEMdWJCW5w5kILJfQjyfE15WwtcF2kcHIwz0/QDNXTzZYd5Pz0Q2EQWfMkvPkNtt4GhS7QzxH1JWYl6bAgjhf8wryXz1ZYL+S7hAdkrlhQtqcGPBxX4GpUSzixIR+gWqNs74YewlaXWtkcQO7PE9YViEy+AKva9k3Q/GALrUwobX4oCGz5uG+rbO8Xl572c88bYsz6nFEtv/XzawxeP6liQBy5/1fZdupJzPXQelVk5xZQvUHs6L3Ra2Q9INCXiRxxK2rcyBDXGr+uJJnCDotEIvwYY9b/nCV61bnJtRRsCcILoGHIvy1TsJFlquWIiG1TjXzdIQ/+F9FWmzerI/hmbXgJCxn2OU/V/+QGKIDKiDIkKlmi4RQPquFm/YTYs9mFOa5cE1bW3XcL7gUBDqX+uN1mRZv4cLGeJ2xnrWbmHPgol/S+XEqC0AdOg6zR/Ppx8GFMafdNp/39pvtG3EI/cyLG6zLu0ckCfrEYD8XER0
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(2616005)(47076005)(83380400001)(426003)(336012)(70206006)(4326008)(70586007)(6916009)(8676002)(54906003)(7696005)(478600001)(1076003)(16526019)(186003)(26005)(316002)(82310400005)(107886003)(2906002)(40480700001)(36756003)(40460700003)(41300700001)(36860700001)(5660300002)(8936002)(82740400003)(7636003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:05:37.3833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 162d7d93-7ebe-4600-7df6-08db2e89491a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1PEPF00001A64.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_230541_462854_62699171 
X-CRM114-Status: GOOD (  10.28  )
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

Although return is allowed in the switch ... case when function is
returing void, it creates confusion for future code which is desirable
pattern to use for switch ... case. Repalce return in the switch with
break that is standard pattern for the switch ... case.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5a12be27bea7..cf9469e486ec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -403,13 +403,13 @@ void nvme_complete_rq(struct request *req)
 	switch (nvme_decide_disposition(req)) {
 	case COMPLETE:
 		nvme_end_req(req);
-		return;
+		break;
 	case RETRY:
 		nvme_retry_req(req);
-		return;
+		break;
 	case FAILOVER:
 		nvme_failover_req(req);
-		return;
+		break;
 	case AUTHENTICATE:
 #ifdef CONFIG_NVME_AUTH
 		queue_work(nvme_wq, &ctrl->dhchap_auth_work);
@@ -417,7 +417,7 @@ void nvme_complete_rq(struct request *req)
 #else
 		nvme_end_req(req);
 #endif
-		return;
+		break;
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
-- 
2.29.0


