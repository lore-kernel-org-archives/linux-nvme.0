Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E8DC48260
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Feb 2024 21:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yLHf0L9c0VlLdFHBj6QF92m73JbXWJA7drUSVrYgeyc=; b=VGrEy9eoRYruKCBCAS0YhA1Zb8
	QGdI/JW9fe8ry3k65NuoE4N/Joyacli6PjjGp+D6C5R7kypJsnBH8RrwBCTVJwv5l732ypPnEt5ub
	MupzCVZBLoWzfysNhzFyqdgG55R0txBMlsYqRKm5tbISz5NcgPOhW67Qs1Fblm3jojdgknnYal4XP
	wt8hhpYbvI7ys5/v1oX1pbhWZin5JLxXzvc3qOlsEe/qYyALGVxahArdajfH88jq334X8aBUCLCjf
	i8A+1QM5NmiRxGN1R8o2f4x1fSFXy8tLUbbjQnPZ0TJsgs1ENSCrhQgM6OjVgQtdhpeom/V0xBCgM
	eVKFfWwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYCJ8-0000000F5Yn-1GGX;
	Thu, 08 Feb 2024 21:51:46 +0000
Received: from mail-co1nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2416::600] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rYCJ5-0000000F5XD-1bbW
	for linux-nvme@lists.infradead.org;
	Thu, 08 Feb 2024 21:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NJwELr4o/yXjGwsthittwaqkpJX3V974/iqS7tMnOArTlEJQUbrWb3JP+tMzqqvkghMqNTC0ozXQNPe8fqYGKWq//isDE+jFd9WqfBb0aJIPqKIGFd/l1+EFnIEIH6AbdWIT2OZkvfL/k6Z1jdj+SB66nzhIhIQFVOCc5tB4fGV6K3/IwCoDlPGilvre/rIOteZ/gXUfQG8kW3vNlPkoCaFcaPS+l20JRXHtoM2jzEMr7JS7DF+l5VRHoDLQDscvYBPIbTZAFPFvystdWQ13L/r3k1duVKKv3Rrek9slUqlQpoYDrASwb20VuZW87Rn0MfrPEBTIuBq11QXZ3v0ZjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLHf0L9c0VlLdFHBj6QF92m73JbXWJA7drUSVrYgeyc=;
 b=fbVlXBUvRIw2MTPcUaX1RBjHX0VI/TttpGjhxgKIiWwHYuz12gabzlptUa4hGmZPRrRAAg6lNVqLLWrViQb6Fk95rfb8N8Mra2VcvTbm6z3B1JfckAafWmwHNLY3RLRTnlozeA8LutYi7O66F1TLNAxkWai5Op3MOJ0ITnkDY05kZsY4InW2n3K5I/uqcFEf329GPPKpdahuh9zaMEQi1CAsEcOdSlQ6SdrrEwoTzvKt3YWy3/shvTA58aFYud4aMqLuzMtDbQUNZ5fYuh1Yb5qSZMQSlLKWwMiL4LeN0Mkb9AJFepcKK3sFjizlwkahxfRjBDpGjF9FTKQ9fKKqHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLHf0L9c0VlLdFHBj6QF92m73JbXWJA7drUSVrYgeyc=;
 b=df3h8sYwpu0DBe6EIzz0WVl/rBixnoFnnluUT7Q3p9GJ1riTD+LIGD7LSt/OZY0+v3sjj8OhEV0h49PEojlr61KA5OjXdLhP/yqhVuQZUcO0a0QFCGFLEMWsmjdAd+Jnaux6k9tpMXGQsQUtOE5BJori7KeXq/+lbl30noEjMk7PAAla3rTrG9dSy4F4Sg0xKKGTBABuXn9K7fqUHhJBLDLZ843mLsH+ooZF55fZYgwn3iMCc354jTneQJgqnZdsLWe4ZLEY2bKbeNHnV+Dj4we1u45XZZEjWisoIgwvyn9WmwXZcuj+STgyi4RJ6wQCjuQWdDeCRvz7jghH06OGCw==
Received: from SA1P222CA0128.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::10)
 by SJ2PR12MB8720.namprd12.prod.outlook.com (2603:10b6:a03:539::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 21:35:46 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::52) by SA1P222CA0128.outlook.office365.com
 (2603:10b6:806:3c2::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 21:35:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 21:35:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 8 Feb 2024
 13:35:25 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 8 Feb
 2024 13:35:25 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>
Subject: [PATCH] nvme-fabrics: don't repeat HCTX_TYPE_DEFAULT code
Date: Thu, 8 Feb 2024 13:35:18 -0800
Message-ID: <20240208213518.167865-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|SJ2PR12MB8720:EE_
X-MS-Office365-Filtering-Correlation-Id: 1111894f-a55b-4090-19ff-08dc28ede953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tjk2/m8B+nXSG97LZ3aNi0sK6WpBmjEH71nXcaR/jYaZ/sGsWjruniUoY0Tn7nkgSHcwsuZRPC8dJu+uohVsDC/WYYPQL4hos9st9eCDxKB91SxiLc6gqFv5rz1BiWmwI+V7gT8/btIc708fw65KP+t8ssAc3jl0eDsEnhl5LbhXMLy3OJuiYYgaFulwtMGykFjDJrvoX6yb/oIi5EaZSVm2Z/aKtFNHx1SWbwPQaBtpNkOUZXAO6qVpc+qdADcqtTHBZzq8965BeOm6rhvx6m4uB+2t0E3IcV9d9lVbAuBbKENKpSpwUNeJdJmNXwi03e2TD6guaspZWmECjOwPdDjmeje05MFupfBJqIciNGtwCNfYOQ/o6D4h+ODvjX43rOMYZeJVPoAv4zy1DlGeyVn+cEafmhtUflTBQGjiq2nHzEKJvYFZKc+SaYKmvHiW2jkyJlNxvauXicrgOGgeJsPunGa+h4l94ebU7k/xfgtlRm5jC/1GTNXeZC9AsOK+CKEMK4dfFZeM+ybNQqjZjGb7mVVZig1uWEyaCRc4pDS2Q2+LcRpliqOP2ffZt4p79I+qvZjuIIl4O3FYH8UL8a53eEkDqWfwOgkfKrAWSeo=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82310400011)(46966006)(36840700001)(40470700004)(6916009)(7636003)(82740400003)(316002)(356005)(83380400001)(478600001)(6666004)(7696005)(54906003)(26005)(336012)(70586007)(2616005)(5660300002)(4326008)(16526019)(107886003)(1076003)(8936002)(8676002)(36756003)(426003)(2906002)(70206006)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 21:35:46.5415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1111894f-a55b-4090-19ff-08dc28ede953
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8720
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240208_135143_696295_7BAC06B2 
X-CRM114-Status: GOOD (  10.35  )
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

In function nvmf_map_queues() setting up the HCTX_TYPE_DEFAULT map's
nr_queues and queue offset values code is duplicated when read/write
queues are separate and shared, creating unnecessary confusion if
those values differ for both cases or not.

Move common code from both cases & set those values before we process
the separate or shared read/write queues case.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3499acbf6a82..9922ee7f1493 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1101,20 +1101,16 @@ void nvmf_map_queues(struct blk_mq_tag_set *set, struct nvme_ctrl *ctrl,
 {
 	struct nvmf_ctrl_options *opts = ctrl->opts;
 
+	set->map[HCTX_TYPE_DEFAULT].nr_queues = io_queues[HCTX_TYPE_DEFAULT];
+	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
 	if (opts->nr_write_queues && io_queues[HCTX_TYPE_READ]) {
 		/* separate read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =
-			io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
 		set->map[HCTX_TYPE_READ].nr_queues =
 			io_queues[HCTX_TYPE_READ];
 		set->map[HCTX_TYPE_READ].queue_offset =
 			io_queues[HCTX_TYPE_DEFAULT];
 	} else {
 		/* shared read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =
-			io_queues[HCTX_TYPE_DEFAULT];
-		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
 		set->map[HCTX_TYPE_READ].nr_queues =
 			io_queues[HCTX_TYPE_DEFAULT];
 		set->map[HCTX_TYPE_READ].queue_offset = 0;
-- 
2.40.0


