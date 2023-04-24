Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7519AC77B61
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Apr 2023 22:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBzr2wsHFDY5MRNjiXZr517dh+qC2IlhgyJeFWBYqtw=; b=iFvNebwDw7RiCF9oJh4kEIBMT8
	HmvFS5Ljbg3YGWSu0L6WhIdyo5E8X9bP47k/erTy9zXwDiTUyzh6poHtCoTzmOxbmk/967Ji7PKhH
	AjWdFcto6kX1iTKMbf33QIpx1uSHRJegB2i3iHIGLVeoMxae0XbYqEtOmnm8qbP7/Mb3FfeSYA9Z8
	3jNYcBp6YgnNKS4cHQpIoWR8uX5WBmi8v0UrfgSM6P4PgkcGDDhPSQPA20RknlCDKCB1p5o6i1lhx
	u3NUB5dn7EmSoC/Dql4V6zqPw3YFVwuLv4+2+qf9r/fWFcp7rfXtKnQ4EtqqrA0cbqYKsS1MKC9NK
	AexVoqIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pr55I-00HJWr-0g;
	Mon, 24 Apr 2023 22:55:00 +0000
Received: from mail-dm6nam11on20605.outbound.protection.outlook.com ([2a01:111:f400:7eaa::605] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pr55G-00HJVz-05
	for linux-nvme@lists.infradead.org;
	Mon, 24 Apr 2023 22:54:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENYf10j1MqRNk0l+Yj4IREgBdmy8vc04oN5gGrb7ugIrsBPKmJ5u11gn/fZDXaLYe3BhREVB4lE256HfsGd+zLqdP72glJXx+OPNETKTPqnatc0Nr5LRXpZ4ltvlQDscMCjCZJmovf8aKKzGRas1Kvf56MEi4xGX88wCwN48LPRcvUBPcI7nXAY5trT4t+PSLNAZhci9SobXXPjw9mrSbPPm0TdbwoWR7P+L4utO0NiKUVfF24lGBdy78DX978BccY6N38ts3IZ6GTIWAGhZC9Je5TFJGi49vr1Wm1/k1Kxi0dP5uQV/8E8ju51Osm5xizxg5dFPyu/7YPPNayIinA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBzr2wsHFDY5MRNjiXZr517dh+qC2IlhgyJeFWBYqtw=;
 b=ZzebjdXZTYSl1nJFgBelKzBapp57iH5cvnIaPl35gFULabAQ1lNWfJc7BR83X/O5MS8tH5BxXsz38GgK/lnyBP8yLyixTCMFrQFrHUd0CnpgVgOZAo+5uD79TAhc/dYJIahEOISmd3B9J4VMtBZ0/L1RZnFXIwHMYfywGdtRIXsyM/cHKUwHVOren61d8WdA7Ncx0ErEw2lOfewZco43lJYozQSxDPqGi60PYAeE0/eETES9oFL7sc12gKR1tdqSCBMpS8dO2U8skaJSJOxKVRVdK4h8zJItalBm+GN5UE/szwGwxiUaeulA76Udv8HS/QFY54Z51eMFNiOVT+3eTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBzr2wsHFDY5MRNjiXZr517dh+qC2IlhgyJeFWBYqtw=;
 b=HAHaFmoCvcob6v/+haxt0Qy6O3mBdjEwe+zaZ6Rihvv0cAVMot1IVM/jpRt6vqBmv3CDY336fZtidjl3G0aovfdnOAa7SrNsG7k5JtB2YB9PpIO/LNBoU2MROvMNoAIgPwZCSwsf5JpwzTVi+lgwULfDsGbXANjY9g6UTedwxDrBJngbeElBYUomRpg86294GNuk1Qs1qN5G90MHsO87LSyv8UGn0M6pdOglLwf+9NtxN8VNdpCgPyPX3fQVA7zZiq/1sXjPyl8XX+t9d4Hh1MCStll38H++Ew1tLDc6804JCSA2s4GEyrgTRpzxOheYmk6B5INGLW0P75oj7TCCGg==
Received: from DM6PR02CA0107.namprd02.prod.outlook.com (2603:10b6:5:1f4::48)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33; Mon, 24 Apr
 2023 22:54:54 +0000
Received: from DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::69) by DM6PR02CA0107.outlook.office365.com
 (2603:10b6:5:1f4::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.33 via Frontend
 Transport; Mon, 24 Apr 2023 22:54:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DM6NAM11FT089.mail.protection.outlook.com (10.13.173.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Mon, 24 Apr 2023 22:54:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 24 Apr 2023
 15:54:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Mon, 24 Apr 2023 15:54:53 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Mon, 24 Apr 2023 15:54:50 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <martin.petersen@oracle.com>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <kbusch@kernel.org>, <axboe@kernel.dk>,
	<linux-block@vger.kernel.org>, <oren@nvidia.com>, <oevron@nvidia.com>,
	<israelr@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 2/2] nvme-multipath: fix path failover for integrity ns
Date: Tue, 25 Apr 2023 01:54:42 +0300
Message-ID: <20230424225442.18916-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230424225442.18916-1-mgurtovoy@nvidia.com>
References: <20230424225442.18916-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT089:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 32bda7f1-dd47-4573-3f27-08db4516eb73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	fEve8+nqRui59Pt8RgvgNmFyriWxUnLDxZs/m/8bn4YW+fU2iTDR0mpJocsx43Ua99cHPgL/sGqaAB2fohB6OmblIj0JXf+OsSZ4Asfb8nNFxYa+J5OZXq6juAMn3P6bswA3RP7z17vUAaDTWgaGaBV4g6RR70HZ2rwgWltoFBLBGvG2Dlmq27Uijjd337coBM4Nc2zY7bA0nCtB4diMBmZWhbZlQIRxQEAWVdkoY7+txfrZnHOcudcj0hFVlLCtN034pvRl3SfLDQFysi62W39bty1cYnTvKAK65JLasp9j6RfrK8rF0f6UI0YaSqxyoo1Y8gXb4/pKhapr85A9zYW4xVxE0O2QXKhlQHAAaajQQt3Atf2RPwDELHAu2+jLROL22CqzYdpkPQl+xjvZ8/MotnQ3t/41zWGTx/LKT4uHEwAzK/B3e+YSnrFp4/rhqeb5Ibv5UHjUQtlh4A86uew8TPcZ1GK1Ww7tUV9dY8JUw1kZzzCLLw6biGHlOQvVtZqYJBETOpz7MURs7YaQedF67ZXba6W5d8zBtbkpz+ki1Y5KNj7Upfq7TvgClez8rA1b+B5c+ZDMIpQ4SdrR+bW0Ci1a6HuysxckAUiPp8aW4A1l2ADy3xIz2iEYj+ObTjNRazjdJdtEYsPUoO4cxWmoiKSyzbCfh3joyGAW5TNTbXIwn6x4/pIUwVbV21T3A+4r3jaA+oMyX/d4ZBxT1PvwCrnTuY1yMqESU2BjED8=
X-Forefront-Antispam-Report: 	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(107886003)(1076003)(26005)(40480700001)(336012)(426003)(2616005)(36756003)(34020700004)(83380400001)(36860700001)(47076005)(186003)(40460700003)(356005)(7636003)(82740400003)(70206006)(478600001)(86362001)(70586007)(8676002)(8936002)(54906003)(110136005)(5660300002)(41300700001)(2906002)(82310400005)(4326008)(6666004)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2023 22:54:54.3446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32bda7f1-dd47-4573-3f27-08db4516eb73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT089.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230424_155458_079533_8463B92B 
X-CRM114-Status: GOOD (  10.11  )
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

In case the integrity capabilities of the failed path and the failover
path don't match, we may run into NULL dereference. Free the integrity
context during the path failover and let the block layer prepare it
again if needed during bio_submit.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Tested-by: Ori Evron <oevron@nvidia.com>
Signed-off-by: Ori Evron <oevron@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/multipath.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9171452e2f6d..f439916f4447 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -6,6 +6,7 @@
 #include <linux/backing-dev.h>
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
+#include <linux/blk-integrity.h>
 #include <trace/events/block.h>
 #include "nvme.h"
 
@@ -106,6 +107,14 @@ void nvme_failover_req(struct request *req)
 			bio->bi_opf &= ~REQ_POLLED;
 			bio->bi_cookie = BLK_QC_T_NONE;
 		}
+		/*
+		 * If the failover path will not be integrity capable the bio
+		 * should not have integrity context.
+		 * If the failover path will be integrity capable the bio will
+		 * be prepared for integrity again.
+		 */
+		if (bio_integrity(bio))
+			bio_integrity_free(bio);
 	}
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-- 
2.18.1


