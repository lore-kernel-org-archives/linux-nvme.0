Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87855C7618E
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Apr 2023 12:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pOXjh4pmQ9tqefBNSAdNGN6L2vK6TxUOrp3ssBUVtGA=; b=m4TzxTPilK8g7nFY3pU3o3836u
	s2+HOT0e5tk9m/HYuegZP2s9JJHI6ZAuIyGb6Ix0EHRa75KghTG1KOA/RzA7tyy9LghKqHpIvnD6B
	ft/V0JqkmOsAJizMEg29b8J9cuyi6D6c+LW4NAovvh+/e2jbygpCicM3onKzsQSI0z8pymIOJ7t0H
	bt6whtHtgad+GvtEs2HETPacIAT/GX1lhFYsx3viJUTomaT4VUZp4Kzc9ZAwXd4fUjClYFLSohOv3
	rSb4tRi7qqVdRpIMVIRwAYFgKPJ7JzSsRoydySYu9pf8zVDPQAsIow0LDdrwZU2CO96gvcbvYet89
	a8ssmV7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1preJa-003vFP-34;
	Wed, 26 Apr 2023 12:32:06 +0000
Received: from mail-co1nam11on20624.outbound.protection.outlook.com ([2a01:111:f400:7eab::624] helo=NAM11-CO1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1preJV-003vB1-2m
	for linux-nvme@lists.infradead.org;
	Wed, 26 Apr 2023 12:32:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0qK4GllWIbkrKefkCuXDxESOoZZ9QmWdhpf0lTtrk29P8agVo2uPfCGiwboCN9ZX9aO/EZIk/dhsuAzJGzi24KTqxfLHif98jpf9cPeYP3LhnrjPkfeXCRGirVvWOhjXRTAEcxEqcWsUkY0tQXq3uyvT6cmQKDREldOvArJsheoGjK8d0hy+++qdSJnB32hsUr/jKJd9UZv5YUaYrNMAJ65XLFjEgU5NnoCZ5qD0c+8JM6mVSMVZ9CySmPqfYr4idUfgBsWRexQRNSUIiR3BtY6gX8VoSIIkCg1qAORf3I+LAEN0D+q6nzLJ4IAgIRKx1zbBTpHJCwTzHvxyavbPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pOXjh4pmQ9tqefBNSAdNGN6L2vK6TxUOrp3ssBUVtGA=;
 b=L18q5mF6LpUuFCSB0FPrzXgjoie8pCfNk+1JZOZb4v5MY9ZXka1sKX+FsxaVyQ8yCjdcuKXEowaL4k9BZINu8aa2I2//NRxuIzLSOQyIzWlmDNIi+P4nT4ttBAojeAfn0u1BdOlXaOBiqHlXQCZikfqJEcGrHLnMQ+h6vvoUY9OhmdB6dxRRYAKIvVHvQV93teFzT+bNxEStE8k79RDvefgYJ6TAInQiJOYP5uFuVLIg3Ez6nNql5bcWcOIWlxmu84KPs5hqNLa9RXVeREACpbeQcEhgjPnGtWZaFqOXnJyTiz7wUSHuEDYhIyZ5xwKzEgJ9z7UtUDqG8cM6LfySXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pOXjh4pmQ9tqefBNSAdNGN6L2vK6TxUOrp3ssBUVtGA=;
 b=f16oXe96jTeGlDKfZwcG5XR1LhADmu0LvS+uKNu0kpKrCnK6shQa6ePUEzwQMIMI14HmAcWaLMLVDfue7dmX3OSJQgnPo5RpJbz0RQYIQ0TmqIFFZ5SLCzkcxc6CS1Le5eT4gO45wR9c5NH7RP03mtUzrWCoMpPm9nxLPirKcddTPj1DTjDcKrUpJqySP41RE8D1eDhKw0E3ANDL8KX+GVwSQMfrfxq/cMND2S03Rb86lgVyRWlEPZVWwKGfdFXUuUZxYSfaevSErvndF1RPS5mrb7I7ZVAEcFbF1+deAnBdAe9I7PWSlyBh6KLQeUvhHC5z3q2aRvrRHX0eqVWZrw==
Received: from DS0PR17CA0017.namprd17.prod.outlook.com (2603:10b6:8:191::28)
 by DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Wed, 26 Apr
 2023 12:31:49 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:191:cafe::92) by DS0PR17CA0017.outlook.office365.com
 (2603:10b6:8:191::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21 via Frontend
 Transport; Wed, 26 Apr 2023 12:31:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.21 via Frontend Transport; Wed, 26 Apr 2023 12:31:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 26 Apr 2023
 05:31:40 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 26 Apr
 2023 05:31:39 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@fb.com>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 2/3] nvme-rdma: use helper to reduce common code
Date: Wed, 26 Apr 2023 05:31:18 -0700
Message-ID: <20230426123119.8738-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230426123119.8738-1-kch@nvidia.com>
References: <20230426123119.8738-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT032:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: ac35e4ae-f83a-4d81-9038-08db4652351b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	Fph2VfFeT+z9gS1dAxoU0fW8oWJkXykb+ICDIGhB7jHfDyhaR1ACl6+2ZfBfFH4N9tLtWpSwYuVxp9+t/wvvK2NVN2j77h80MJJOnvl+rW1Kxf3gcPjAPDQqDAWMFQ4Ic7RXSoz7uT8LOoQtlESOUOknIn1snfXxI7wCvM2RzBoVm0tO6pfG7/FrT9QzvmiMS9f2yhUXzIidnePGQ8xC9J6xGLO3O++kI5tTvvrioEqmonp+1gh/mvWnMynLAoHRek75bUx9v+sEqyUaBaK9+JxELI3FijK6W4NfGafY+WRYSqwfWCkwF7Of+vUUW2XLajl2lgjSMgMybZq8ViuH2DoHnFZDEUkkIhnIxOpYGq+guzVLXj9WMyo17DFcPtHrehq5dH+yoBUNETYGpcc14jGY1nL5GI9eCbgFaIe34S8HgVBquOspHa/52lzPizeRBK9FLPKaA8wyebGDUKyT1kMgwcGAghsahzdLe+Yty4miGIaiG3oNVPMu41oECkDWXOiqjSVctnTMgcVmQdYyEEPJ3q3QWJWGu9bjjX96T899/A9z7DNWTgHvyjxCIUH6390+n6Yqe5NxmFV0qPpultdw9IaW4PblCpic//YWjimaGFcjTF0AQybvBEkQF/AsTDHTFd/MPhIXcl22Bj2dr2SVLvxmbraUVExDP82an1MGeV/l426U9k3N+p+ruL1Y4MgAb0SrsRf6CNOOz3PvRRBArU5lUEVY1hpeqXHBxMg=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(478600001)(70206006)(70586007)(40460700003)(54906003)(5660300002)(2906002)(8936002)(4744005)(316002)(4326008)(6916009)(8676002)(40480700001)(41300700001)(36756003)(26005)(1076003)(107886003)(82310400005)(82740400003)(2616005)(426003)(336012)(47076005)(83380400001)(186003)(16526019)(36860700001)(7636003)(356005)(34020700004)(7696005)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2023 12:31:49.3912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac35e4ae-f83a-4d81-9038-08db4652351b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230426_053201_901501_2D091391 
X-CRM114-Status: GOOD (  10.49  )
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

Instaed of duplicating same code in every transport to print
ctrl->io_queues, use helper for nvme-rdma transport to remove
repetative code.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/rdma.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 0eb79696fb73..7dbf50d02b1e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2170,12 +2170,7 @@ static void nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 			ctrl->io_queues[HCTX_TYPE_READ];
 		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
 	}
-
-	dev_info(ctrl->ctrl.device,
-		"mapped %d/%d/%d default/read/poll queues.\n",
-		ctrl->io_queues[HCTX_TYPE_DEFAULT],
-		ctrl->io_queues[HCTX_TYPE_READ],
-		ctrl->io_queues[HCTX_TYPE_POLL]);
+	nvme_ctrl_print_io_queues(&ctrl->ctrl, ctrl->io_queues);
 }
 
 static const struct blk_mq_ops nvme_rdma_mq_ops = {
-- 
2.40.0


