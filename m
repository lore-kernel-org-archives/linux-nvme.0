Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE69C3DA78
	for <linux-nvme@archiver.kernel.org>; Sun, 15 Jan 2023 10:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+n3P68zOrVnBkM0RUW5HJrE7Ch/ijs92gMsNuA6YKiU=; b=QcNKc2u7o2RMz1k26yUo1m79xU
	1RaiiBfbGW3lNEmCNejhnezoICAuUvx4xzqkj6ovpv5ldErdshSpjjXqxwm+sy7FJ5XGWff8QojiK
	s2J3nqywoAZKo3xQSzmqn5LGzix46nTCWgR1fPLYDGcrtJ6D3kLCQeiXmT5qpAntRGRBWi5Uzupck
	mkDld6sBVZk0TjQcXa2uaNlHpUbZ3Ah/KG7sTsR/zrxaqOWEV3yszfWexw1UAQUcvgERy9vnmR1au
	sR4pS3mR0jluMVibejuVlC/eaG/JhZfF/r9nZnxyPRhHDe1N8sEi3vdo9P17EWaHfrjT8vx43lotn
	03z7ShzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzrz-0079vk-2W; Sun, 15 Jan 2023 10:04:07 +0000
Received: from mail-mw2nam04on2050.outbound.protection.outlook.com ([40.107.101.50] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pGzrw-0079ui-M9
	for linux-nvme@lists.infradead.org; Sun, 15 Jan 2023 10:04:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+mFd1PWRnd4X1vtclbsq5yVMkKX5832+2yxbSMIomj9Fu9lZNwc0alfkShvoUa4NK57BHDasdHxGcQSD/qT4UkVLw9ato5YrKxh5/kMEOQUcV3jzWLbGWIkGqVUDo7DaKtA5dRva65VEc2I4UhWI3V14pAgy41glyPoRJTHu16wROnac/CwzHHuEgOrcoAU6mr/5nxBsq7hkNg6RZs2bsSXAe+LpQTGlpMDMjn92YoEvexIShJOQWccEyH2P88xF+/n1oSAsXgunXodTL6M8kN5EJCNwez+ntx9CKYCDRzItiTHZnXiik84XziTC1NgS3+CLV5FYIEuBOTEwR59gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+n3P68zOrVnBkM0RUW5HJrE7Ch/ijs92gMsNuA6YKiU=;
 b=hwL521JmMJ8NP3GXW63Pm9R6s/G8bLZupgZEw4Cba3khfr4mNNmilEcPqlauWScx+m3ECQqgbsFrKJb1jYZSDoZwMawdSCWX8Xd7CGR2UNte0CmNCv+s1jtZAUWFzJP1jGGdtjNDJuIXUAOZwpQqBvzm/W/2iVdKaQhoDjxe7SS+/CU2pQhP81UiSQ8sjcN4KYRbDWCKDn/Y4lm9M4U3RK807Gx6KpjmK484eXk1HAeTen/1zph8ft7hJcTT5Sfw2t8w9MuFMxf6L1U7dQ1z4hx8GZ/Ibgxol3uxB8TMoQ/3ID+MO50rlk+Gvm0V44ZstU1z25ndEYqaScTiWB3pfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n3P68zOrVnBkM0RUW5HJrE7Ch/ijs92gMsNuA6YKiU=;
 b=fqmJBlpBUHfHbuU58lDZSAZ93tZYAAFvpcwYLaBz92IUS8SXDDfJFMuUXRLlPnLIZJ2Tin78vq58t1tsoJzIMVvpk8rsN+Q796xpC6jhBhmH6jkFWClOgK5hFZrDcukd/LsY/ry43xEbG141NFSjijk6i7Jd+FvFLOgG7sWP4OGc+Z8Lvjbj2SulDp7CqZF3bHIo9WxHlYHX87tJ+cm1lArcZuAbeFUfFbP6FUI+mvr9O04NaWfsEakMg0PToMU5a6CXeKa4ne2Ii3eQkeWPPS/p8LDuAsPD+2H7b4gU106D1H2cuLV/Hi5lTK02vt90yOsu6SMb/2gObF3LwrWsRw==
Received: from MW4PR03CA0033.namprd03.prod.outlook.com (2603:10b6:303:8e::8)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Sun, 15 Jan
 2023 10:03:57 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::31) by MW4PR03CA0033.outlook.office365.com
 (2603:10b6:303:8e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Sun, 15 Jan 2023 10:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6002.13 via Frontend Transport; Sun, 15 Jan 2023 10:03:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Sun, 15 Jan
 2023 02:03:49 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.36; Sun, 15 Jan 2023 02:03:49 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Sun, 15 Jan 2023 02:03:47 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@infradead.org>,
	<kbusch@kernel.org>, <sagi@grimberg.me>
CC: <israelr@nvidia.com>, <chaitanyak@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 3/3] nvme-tcp: implement existing_ctrl operation
Date: Sun, 15 Jan 2023 12:03:41 +0200
Message-ID: <20230115100341.40347-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230115100341.40347-1-mgurtovoy@nvidia.com>
References: <20230115100341.40347-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT063:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 3155ef9d-87bc-40ba-a439-08daf6dfd08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	PS9YWrgmQ2tgx2YgtlvDaSh8sTyAUg/JdgqVXEFmMkXkqocvhJKhtXeOb2sIf6zM0HHKdtKWAk0FOc6d0vuichrblryk8Zl0k2E2356L6Ox93yTqm/XKEXeeM4qEirgXcKORhjjWSLKSgKIhxeT2C3cicdxraNpfxhR/6MrhiTQThZbU4JWBKFH73/uceeNatb32NQ1A/ks2LxRjnUisKas/KqGcd2VyGOGGBI07oUBCO8r2bVlgOH6j+YY7gFGvUncQoC/hH85VrjdCveiXh0hzQ6Y3Aifbkvj7R29/XnIkFNdA3KXgGDqIIuIAo3Z/NIDsyRw7Nre8EAfbumxDFe7CbU3xgla6E+Iu5HR8KcSBbBz2kpQeQT14BnLNGti0ZJ4CGsjkH4Z/2wrD5LEVoeCgji5n4zekqMmsX2VU9lSrRG7KE39vIg/URN0AA/c0X764f5wAyDCMLNViNj9+y4ftsztsD5zk7cx3qh0NTiMyabe7GapWm+5oSygTy3UqNLxkmcN1uOc/V1vM7M8nyA0Lj28AWYJ9GJx88OU8+KDuxjYpI919fdHHdok0EV5CMn9R5fvUTm9NKwZ2PA7WJPJ2p4sf/1DEAcNLqHwFuxTcl6RshRdM0/C/o4c2xOfEqi9JLs0zXxkeeJDofNkEFTRvMR8RL/teSpHEZiW7B0H6bbwUehGjByk0rV75bKNC7lLyBrt23oH8k0NJVjmkyA==
X-Forefront-Antispam-Report: 	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199015)(40470700004)(46966006)(36840700001)(26005)(6666004)(36756003)(8936002)(107886003)(2616005)(1076003)(316002)(478600001)(5660300002)(40480700001)(186003)(4326008)(40460700003)(356005)(82740400003)(41300700001)(7636003)(70586007)(8676002)(110136005)(86362001)(54906003)(70206006)(82310400005)(47076005)(83380400001)(2906002)(426003)(336012)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2023 10:03:56.2558
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3155ef9d-87bc-40ba-a439-08daf6dfd08e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230115_020404_744434_00C66375 
X-CRM114-Status: GOOD (  10.66  )
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

The logic of checking matching connections moved to the core layer.
Implement the needed optional operation and remove the common logic.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/tcp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8cedc1ef496c..233e6c3a85de 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2608,11 +2608,6 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		}
 	}
 
-	if (!opts->duplicate_connect && nvme_tcp_existing_controller(opts)) {
-		ret = -EALREADY;
-		goto out_free_ctrl;
-	}
-
 	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues) {
@@ -2666,6 +2661,7 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 			  NVMF_OPT_NR_WRITE_QUEUES | NVMF_OPT_NR_POLL_QUEUES |
 			  NVMF_OPT_TOS | NVMF_OPT_HOST_IFACE,
 	.create_ctrl	= nvme_tcp_create_ctrl,
+	.existing_ctrl	= nvme_tcp_existing_controller,
 };
 
 static int __init nvme_tcp_init_module(void)
-- 
2.18.1


