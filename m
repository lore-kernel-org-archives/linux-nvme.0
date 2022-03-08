Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6FC7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Mar 2022 23:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AY9MZgjCDxxUE3/qnTsYZZxpiXPM1zq89sk6n57xA5k=; b=a6gCKBsNm5ZYKPGgpZjKF+oQJy
	V+QnKaiotRtc2ZWOpD5FAcJOpD7+Kgl3RBLXwhr28O6t4BU0pv95WNReohVt0UYLXtP3YHC6xUx/R
	gE5saHxxeTo8+coSSfJ+S+nL7Ay0O4iXbs+E+X0IkIe8Nzj2A7lapuhKHsepuhGZzxHdjleYrd1+4
	ThW6OQHBfhSrtJcA9gOTvoL8qKDmpymAK8ueyfh9GXdQFWy9IJXhXioyDplGLaPPHUQLX2nX2Wx7l
	lPvYhnxLkszCKTtzZxZShFVuRPcLbpRUAg2AzTVuxU2H/uZn2PUsq9gT6MznZtj1PIZNEXZYPrbG3
	Fk+YwGoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRizq-006VZa-7b; Tue, 08 Mar 2022 23:12:02 +0000
Received: from mail-mw2nam08on2060d.outbound.protection.outlook.com
 ([2a01:111:f400:7e8c::60d]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRizn-006VYd-Cw
 for linux-nvme@lists.infradead.org; Tue, 08 Mar 2022 23:12:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nr4lEc6jhkBvBXmQnJbcMKRFOG+uOJ9GAm6aMImu6gyFVNhn61SoPWFfPGUp9OEFuvP0RKUfzBjD9jxTlut922st+wDfglFzTXq/BX4uCAs1SYgkjWs9GKoJOW9oiYkCSEQZvFyuL0oWa01Yst8H5xDfju01tbPSaELhaNRzjZ115AJQ5OpmYrzpouUWuIIgYloB+B9rIWf43TJQenpe5nq1h1dRqGOTVDk5TjEtsvT6PUs8SVGebiINMyW1To1GTW+ifvtHgqBXIuznrCP9lrgSC3tiSt141oTu0++raAQ8aL3dAojsYsLTtiVOoX3lRvzKM/2TnV3jLgR9jQV5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AY9MZgjCDxxUE3/qnTsYZZxpiXPM1zq89sk6n57xA5k=;
 b=eEuonWxuv2oU/rBhqF3db1hd1VzTUW1HTTywZPx9hGv0LnMD1cxhfbY/AY0nUBGCADqDEr/T4dE5ZIEns6/dg+nmR7cDGpRv/S0Lx+MUSNsH0bBZ/BuWaPaPZkx6rVDa6TMFSzXKw/ghH2fZhthc7sn8j2A47cWMjt0SUXvcJqC83ERVXfMXE+8snBbt5KrdQ2DY2myXd+EOuMQx33gzE3KWTRosTUdCxIdHYD8oIykwSFxvKesBFJ/sVFQNx2clZSV/Jlwes0TqCgszK3/e05DZLerhL9AV3Q7H1vQe3ZmVBJjMvSckOxq61qlrEwWP60GJdlhtkHKvBe/MWSI2iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AY9MZgjCDxxUE3/qnTsYZZxpiXPM1zq89sk6n57xA5k=;
 b=qkyEzdiGmjHSvOOC+7aW19o/PyLDvCGgldQ6dfeL9/tziilh8p9XVugfC/z01WQcyCy9C+wj/BadZs1mus+TCxJG/PSjDMnY1UArvzjp79zDl/JKgCIWkdz4rEdIjTzqFUtTvhJz+xmcgh+GWpHo7w1vZecK9UwB3JndPRBWcdaJlTQmcoaQgv4i+Ft7RRmGyEARVfNv/G0eEcLCG8dAjFrOMA3m0Hv+9SgMi8olu60yV8EBBCtuzX8SmmVyVrho/OqkOmZSzlRCZZInjV3Lz6NvfylmMxwZOUh3+uPPD8VGlbRz5ydhC1KVrI38VR0PGYfUG8xvuvwZI5Qb5sgHkA==
Received: from DM6PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:40::16) by
 SJ0PR12MB5453.namprd12.prod.outlook.com (2603:10b6:a03:37f::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Tue, 8 Mar 2022 22:57:38 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::3a) by DM6PR03CA0003.outlook.office365.com
 (2603:10b6:5:40::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Tue, 8 Mar 2022 22:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Tue, 8 Mar 2022 22:57:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Tue, 8 Mar 2022 22:57:30 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 14:57:29 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/2] nvmet: use snprintf() with PAGE_SIZE in configfs
Date: Tue, 8 Mar 2022 14:56:58 -0800
Message-ID: <20220308225658.8202-3-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220308225658.8202-1-kch@nvidia.com>
References: <20220308225658.8202-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa69e6e4-b18f-44a3-3067-08da01570aa7
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5453:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB54539F71A072093BA9E319B8A3099@SJ0PR12MB5453.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zKAYtoJ9Ha7CBZlC3OMGCXb2p4YbdHBhFUGY9NMFOxZy9xVJrmkQHY0vli6wAqEhDAm2igstqhYtL4G539/bLXma6Jpx6mDu1HlIkdCrul7XvBb9ruUDxMEnMsdLHEVjzJ+07/GrxAil71TLenAdZjXC/gLaZyM+Gve4kX3CYUqCgzrl7WIoeVs1rUYRbjmORKASxIewTIQ0h2duNrtGthBmXtV2bkSHZ4zbxpg4nlQAIXgDwOq4B8yOudHfihL308Q5zRavhkeTelFHENmzcFTW5QXD+IpJsbnrrpvtaPsl/l0cFdjQAqKhcdtvFhX9n9Es2OJEKqoLLoIQWe9hoGtCF5tlNJB4isEDI+jGXugVOvmREdy2e4xT3uU7q9k7KuCNDzUquQWHxK58kLQA2ctfb2Ov2XwjVlRkI3UJ7L+VNYZyn9srJQXqNy8hqkB7OGvagOHdegNW/Tp4YacMkAcpxX9iFYXjL0enAi23Iy5Dwot/g5iwWJuYJqRtktaRLCEeuSYSzScMZAGZevOR974R8tAE9bK+poNnLPgiHkOjFGZespiVyH4w/js93XpJWgWCxHQD60EbrQbvfrvmEPKtdb//YtTEC9KRhgpqLKBf9RsFAAsNWEaZl09LaY1G6OeKDo1nseGAlggG6B25sWJitKmpyAN692yWz0JzIDc6yU0qJnUZ4Tu41tGyJugFln1QGDHsjeqR+9aXE3qfIQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(8936002)(70206006)(7696005)(426003)(2906002)(83380400001)(36756003)(36860700001)(47076005)(356005)(70586007)(8676002)(107886003)(5660300002)(1076003)(54906003)(316002)(6916009)(82310400004)(81166007)(2616005)(508600001)(186003)(26005)(40460700003)(336012)(4326008)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 22:57:37.7608 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa69e6e4-b18f-44a3-3067-08da01570aa7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5453
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_151159_523907_AA192F88 
X-CRM114-Status: GOOD (  10.41  )
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

Instead of using sprintf, use snprintf with buffer size limited to
PAGE_SIZE just like what we have for the rest of the file.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/configfs.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 0f5c680c851a..ac801fa1641b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -60,10 +60,11 @@ static ssize_t nvmet_addr_adrfam_show(struct config_item *item, char *page)
 
 	for (i = 1; i < ARRAY_SIZE(nvmet_addr_family); i++) {
 		if (nvmet_addr_family[i].type == adrfam)
-			return sprintf(page, "%s\n", nvmet_addr_family[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n",
+					nvmet_addr_family[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static ssize_t nvmet_addr_adrfam_store(struct config_item *item,
@@ -160,10 +161,11 @@ static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
 		if (treq == nvmet_addr_treq[i].type)
-			return sprintf(page, "%s\n", nvmet_addr_treq[i].name);
+			return snprintf(page, PAGE_SIZE, "%s\n",
+					nvmet_addr_treq[i].name);
 	}
 
-	return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "\n");
 }
 
 static ssize_t nvmet_addr_treq_store(struct config_item *item,
@@ -281,7 +283,8 @@ static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_transport); i++) {
 		if (port->disc_addr.trtype == nvmet_transport[i].type)
-			return sprintf(page, "%s\n", nvmet_transport[i].name);
+			return snprintf(page, PAGE_SIZE,
+					"%s\n", nvmet_transport[i].name);
 	}
 
 	return sprintf(page, "\n");
-- 
2.29.0


