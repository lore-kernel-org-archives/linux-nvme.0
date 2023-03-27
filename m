Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5CDC76195
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 05:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sQ+4FaqagUku7Ih6iKXSnGqio/33UT64IuV0s7aQyNw=; b=y0PbsCFD4ycusLY90wR3IO5QIE
	Ly7fPt6NCwC58j+PGpbnjOJ/aRF6yvFXzrX6x8Q07BcWD8d2reZu9qpwzyPdJVrSveXMaOz8vcuhj
	a9QudC6fGtV6TbhK9plHo1tzLyv54ET05b+GImAXOGH5mrc/Rsouwabx1VVFJWS3Q8+kPzs4Fg3G8
	X5jdrxiUBsOK08gcpo0bi/XKAeO+yY9a6129FTZSRUkiYuGUynLuWUWlv4HPrMYz9p1HMd7uKbNrP
	9374MmxqHzlgLouteckZ5ATQF5O1NdgPkeeVzjPxXbXZK0EFye8PIsBc50RR8Ke1wHsMBos4ZD5m7
	jSjX26Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfjK-009r6M-1M;
	Mon, 27 Mar 2023 05:49:18 +0000
Received: from mail-dm6nam11on20605.outbound.protection.outlook.com ([2a01:111:f400:7eaa::605] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfjI-009r5f-1V
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 05:49:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P/40ewTNbauUtINsLmvuHVz2cz/VbYx85ZPPLAQuDrMTELQZIrCgbOg1vUn4V6xu24J3psh5mjqn6WbvvoKdsR710rKb0KIkGjr8rmADYlw0xnqilI8SAGhmm25HCkUuYVHTRBHbS9AniJs8canGaZplx3Ap/kievQLhMGZ8wHJZ2eLCignWe9D0auxGTxbkRP75r9OAQklkKvXh73YmeeWmGHKeqzuFkpqES1yECcTsmJltEtkg500KhU5I+YUs0CafpZeAKXqPAV+b8AD+1IxiduXKtPvN+5y3BSFQfIvvaop6XZjFFFTTWkEk5tuqhhr7GLQRAo4aNbUjWQcZRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sQ+4FaqagUku7Ih6iKXSnGqio/33UT64IuV0s7aQyNw=;
 b=mjZncek2UFUozfkwFc1y8Xiv5b5fu8xfVe6sCHz52T9U5A/4oo5QcS337QT22GAP4Aj4jbNMY2IAOQEJ2Y2vgsPU2hO5n5CeRkuDYFBXd2V4j30bajiOOEfZwGS1qX1B0a4UUpKwgXJXhTnRpyUtPWu67qGnPSOlhsF26+Yn8peJHcSyrRJHfpN2M6+RWzZbGLnJjDhrVHBcIxfTYLNOJdzfMhZGGt7NcXQQBVOotgPoDaOpvtNYTb/+Sp32WCyLnzAwrMCd3pb1Y69id1ROhrUt9w9Z4GTC8Eu26oOPHI/83kpfqBNaruv6iEyimbXXv+3m52x5nNatnH3TD5nbNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=marcan.st smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQ+4FaqagUku7Ih6iKXSnGqio/33UT64IuV0s7aQyNw=;
 b=JC5rTkdxQp5HMFYRp6F98q+XtxsxiC0rtGMyJjlPeYq+5Ipgd7doN3bdojTtw533rnVxCu8We+ISj3OZqUjwBIINJ/lHBkX5eeLn1etdVbafB+ZXbVFlLQlFOjQJsPQOR4okPIdtHpNuMSzy/aKrYVPdOWiLvu9C2YZIdwknATF+ao9cDp2tiYqUrOjvJMbjZFhz/tEWnsBVhjfyHf4YI9hl929jCS1J6L4T0g8BLD4p/d6NI8s0+N0I8PK0JLc0fwRj+FS0kQGE8nL99v2jENdfD6uOvouJbzMTuqTYZmOJcC89lHOiyE1cjfWjT7vNnOfeov3StIqDiWxM/Aq8LA==
Received: from BN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:408:e6::24)
 by SA3PR12MB7999.namprd12.prod.outlook.com (2603:10b6:806:312::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Mon, 27 Mar
 2023 05:49:13 +0000
Received: from BL02EPF000108EA.namprd05.prod.outlook.com
 (2603:10b6:408:e6:cafe::ab) by BN0PR03CA0019.outlook.office365.com
 (2603:10b6:408:e6::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 05:49:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF000108EA.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 05:49:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 22:49:00 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 22:48:59 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <marcan@marcan.st>, <sven@svenpeter.dev>, <alyssa@rosenzweig.io>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<asahi@lists.linux.dev>, <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH 2/2] nvme-apple: return directly instead of else
Date: Sun, 26 Mar 2023 22:48:38 -0700
Message-ID: <20230327054838.67353-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20230327054838.67353-1-kch@nvidia.com>
References: <20230327054838.67353-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000108EA:EE_|SA3PR12MB7999:EE_
X-MS-Office365-Filtering-Correlation-Id: 935c2354-2ac2-40ab-1fb8-08db2e86fe5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	ZCMdCK7yomIL0R6sUXv2Zz9boK0z54pDlOUSa335yRZd5LvKB5Z1izXDUpt9LVBX8KM+ae/PIrkm91Xjh0YxPFrQkkoQwKnGNWZJ6G3YSuXpLTSznpLjSnDxACADeWQHnDzAm9oXvgXfdOXtSSuk/T6PIaJHVAUpzz/B4RPJRo3JTJcAgRYpJVPahnwsi0SkPW835LVE+nrQgjuS7luPvRUZbDr4kEzTs42qXaazc8ClHYiah75oh0E+bEceMhHU+gF4gRubiy/strkTrz7ojq5k8lF8kJw2VaKOnwsmDjuL4wZDGSwTPJutSHvhwjvDtZQ/Cy2N8tGwAfi75FiF2QseM48WkuMd9j0vWVhIkrnb6ByGFSrd5r8F237h3gXrMt/y4Gwk+pOygZCcEUdwybSt17dsPfJq+FFn6BhNKRNlEmOUfKPVBDMVtJ8UkNvBY37hV08rMzQfiAXgw/odiWSNRJLFLurALyKmhYK3wztUcFtFiZ+ZBj6Pgxg4IesvUVTkhMF++iFB9ku/DIy5eXEayk9A2nT64HWCGVOIpwOP/amuqzIvWSU+zDvIQ1VM8ZvRw8NMXDqCZthZVevqSm1TmpydCjZYfHIeWrT9QYN8+UG+xucyrK/L7SuZYvv5VLJUQj+Qs1DVeVHkShOS7DrzWVhQ2j5n7Q+UXlKyOiETdmRvJyKioXCHZmwuPvGEKqgD5JfPEJn1ByXqzW2qg5awSSwqKkGNlsIan5b6U4uTGYHtY2BkopVr4iE/lVnV1y4xqJli08iFsIZluucEkg19SIsIQLrmYSXh6W8UChg=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(47660400002)(451199021)(36840700001)(46966006)(40470700004)(40460700003)(7696005)(7636003)(4326008)(41300700001)(82740400003)(36756003)(8676002)(36860700001)(8936002)(356005)(2906002)(70586007)(70206006)(4744005)(40480700001)(82310400005)(478600001)(5660300002)(316002)(6666004)(110136005)(54906003)(107886003)(186003)(16526019)(47076005)(83380400001)(426003)(26005)(1076003)(336012)(2616005)(46800400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 05:49:12.8905
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935c2354-2ac2-40ab-1fb8-08db2e86fe5b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BL02EPF000108EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7999
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_224916_508752_1DB95929 
X-CRM114-Status: GOOD (  11.59  )
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

There is no need for the else when direct return is used at the end of
the function.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/apple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 942a3b71a6d5..33601494ae50 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -217,8 +217,8 @@ static unsigned int apple_nvme_queue_depth(struct apple_nvme_queue *q)
 {
 	if (q->is_adminq)
 		return APPLE_NVME_AQ_DEPTH;
-	else
-		return APPLE_ANS_MAX_QUEUE_DEPTH;
+
+	return APPLE_ANS_MAX_QUEUE_DEPTH;
 }
 
 static void apple_nvme_rtkit_crashed(void *cookie)
-- 
2.29.0


