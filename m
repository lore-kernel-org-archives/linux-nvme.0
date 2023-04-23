Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B3BC77B73
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Apr 2023 14:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TBzr2wsHFDY5MRNjiXZr517dh+qC2IlhgyJeFWBYqtw=; b=ZogCSY7EWi3ydA2g12EHrIXNkk
	hxalQNrAFN4OFqIx2QGrSg6tMF+2H5jyyYqsjuoGzumS46NTFBqNUxR9ZXfEpaodeEX/qsI6G2chx
	8NDZVGLC0rQ9sFF5jqpkWTx0c/6f6yRu7OjNsZdln00K2JbiAIu1veHNhU4vOtyc1nBO2e9IXA/7X
	TPFXL7yB/Qm55SL5SLxOWgSllOtDjMUKSV3zZyWzIT/uTz0rq/zJo42X4BdzC9mwgqUhy5UP+wdJS
	+ZgdeTSE1X2Ld36GxISoDHKZYKWjWRtZjdOpx9+vzXL6WtAg8OZ4k3Ha+YldhrvmRjygJx9LUi3Ku
	aYM90i7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqaTP-00EOVI-0m;
	Sun, 23 Apr 2023 14:13:51 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqaTL-00EOTy-36
	for linux-nvme@lists.infradead.org;
	Sun, 23 Apr 2023 14:13:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx1uy3OWUZpTf4yppV0cACdLe961XU5qLZG1f3yDUlMsSCaLAaQHypkjRCZO19V6r26NZaM9ZzV2IiwyrQLaq6mUWIQORlDnZiebbEEwoxyFsn+YXMyWr3pTmhGqnkP+Ce7opP1SAMHVzmmn+ZutTVmUElcn6yNPytjh/AQ3YL+dUufRDvTdmLQZKlxJFvICJ54RNqf0HtSopiO2pHcfGYfFfXhBWhvx0ZEvkcVqrErheZld7YV+RRLUH0EMnDJxq5izLLKRwzBxeimgWVseWxu4AQ2JZXKkDr6jWpwvq5JU6EThJSWRPyRVnrR1/q0TybVwd4RkzpVuUaoy5ycu1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TBzr2wsHFDY5MRNjiXZr517dh+qC2IlhgyJeFWBYqtw=;
 b=PLlOf7s2eH6DkMirkGUto4T6mKO+oKpuQ7Au2hSH4x7RDwjb9AlE0ut+KnIaO2+gmUhEjRhpvnECjtqhNGxTRe3OZ9xHM86S1lCIQ/NRA0pbtJEWr+WKQbpna8mL8B0wVUu4pzaYbQpt1c+GpYzGNHLTg19ospm4AZeVNBsti+J9JIDjQ3qtWYXHWFDNBR/kkotbG3TvjdMqGTUkFPqV3IVdr5vG3P1IfJ1pFO5ZtZ0mN15AQJjx5iEDTOvTTJECXU5zQb+4HYK+QKG4kaua3MRahwdUwX0rxe+FpESol9tlTeh1mhWoy4O4aWlWGE37m85ifECrR4uvURvzTzSiCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TBzr2wsHFDY5MRNjiXZr517dh+qC2IlhgyJeFWBYqtw=;
 b=pIHI99CY3Ll+IZ83FM3mzRuXV6t2HWdBCCsE6y1mLYGF7Eendlj+nXGFuA/nfqApiIEqaPLLYzmbymAt2lMChtEbln1/5nQ47E+QehsUfFZ36Ca9Rp+4fUNY0pgbqSy8xWYV5NHDlWOmkE5qs5Zpr+x3XqbiXtb1v2qG4ul058uP+osLe2iKj90chUM+ePmPTqP8PGXAs+yOgPtcL9WD4phBfZvEhNBomrC9t9G8BRfHeb1uP23Wi1jUQGqX2RGXx07SwsZ1LLknAcl3yfG5DyN7oDOzJagYj9Xq9Sc475JSjeiyaADlrkyVRvQmTEkG9NHgbf+UWXyhjpahUK0WTA==
Received: from DS7PR05CA0053.namprd05.prod.outlook.com (2603:10b6:8:2f::34) by
 SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22; Sun, 23 Apr 2023 14:13:43 +0000
Received: from DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::6a) by DS7PR05CA0053.outlook.office365.com
 (2603:10b6:8:2f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.19 via Frontend
 Transport; Sun, 23 Apr 2023 14:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT103.mail.protection.outlook.com (10.13.172.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.19 via Frontend Transport; Sun, 23 Apr 2023 14:13:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 23 Apr 2023
 07:13:40 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 23 Apr
 2023 07:13:39 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Sun, 23 Apr 2023 07:13:37 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <martin.petersen@oracle.com>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
	<oren@nvidia.com>, <oevron@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH v1 2/2] nvme-multipath: fix path failover for integrity ns
Date: Sun, 23 Apr 2023 17:13:30 +0300
Message-ID: <20230423141330.40437-3-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20230423141330.40437-1-mgurtovoy@nvidia.com>
References: <20230423141330.40437-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT103:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b78630a-e23e-4f18-ca06-08db4404f1c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	h2bxQCZMxYEEIjecJt5su/egkaExJt9gajVed96ckmS5FlrNrtyjNql4mbSXDKdStL/hj45ykdpM8Vavgwk7ZYysE1vpS/5X2vfDjgyms9r7/hMi8tt51SHc4YSl/JrJjnvWPVgvMLQ9AJC0shanrlZIU2d/HnbS9XDOZOOmbqI2bfOffCmieTF7iXuWz2JQJ/A1MtxuIT82Ket+XH6od2C5P3eltCM1mZF184dKzZHH+EXjra0+CV59GdMoqgBxdpOY8Ir6LI78w3SdSkQrulV8DRg9V65t82K4u/XRBjhV6XpQ/jiP814yqkBoZoWmu0n4PU1HV+Cdm/6kriR0kQ6y2JOqAIta+BmoaHc+w4XaDeGpqVh+6NuYVfAzppOSIMSB+jcFCLOxp3HLMvimnM+fnKOwcSJWc0/Margj7n3nWyeoqWzmnGF7tKY3dldh/qKL9E2wse/2wQ6FJ7PjrLHxexeNC0V8yu09yW7UBhYeVIlHeJWP15wIlPZL8p06a12H5fI74DH5n7fYGngpsqRaF61JBYFJXqobiEyDB5T8sDqfiRGGlR0U5/wf7i6xAWMoERunpuB55PHjTnNmik/Rud4iynSMu5mEFZVuxNyAW6zt8cTVpJp3IvlwzfGwPv8dPNRh2nzDi9o9kkklU5YcrsLWQ0ttBbh/AJlFwB5BQvQI6BwIhDK1+aGRHpfN7az0ZRNsLa8a+SyHhbspnzYfVoGm712F9fLSRXtho1E=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(39860400002)(376002)(451199021)(40470700004)(46966006)(36840700001)(34020700004)(36756003)(54906003)(83380400001)(478600001)(2616005)(36860700001)(47076005)(40480700001)(1076003)(107886003)(26005)(6666004)(316002)(110136005)(4326008)(186003)(336012)(426003)(82740400003)(70206006)(70586007)(5660300002)(8936002)(2906002)(8676002)(356005)(40460700003)(7636003)(41300700001)(86362001)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2023 14:13:42.8414
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b78630a-e23e-4f18-ca06-08db4404f1c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_071347_998228_D4F8A00A 
X-CRM114-Status: UNSURE (   9.27  )
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


