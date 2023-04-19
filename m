Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB280C77B73
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Apr 2023 23:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5yAkwX81VooUjd0z6Wto1X+zuqvn99nf1UT7XLMkuC0=; b=RDPpaW2cwVdZmr9v+NHlU8Tobz
	B3M3/uXcjdyO2ranQXo6kyjH8kkWb/LPSJwOZwPHOSkjTCypVxUmVBxws0jiDBVJf4HG744Jl5g5m
	3pYOInbLkBeBuWHuH2aYo4QfaSfcR1YmxI73I04qipeqQc5cmQr5UCB/CR18pibl3mYG+sfcUnuj4
	Tia9DRHEjUVt0pcKI+PL85geMO6qFOd/48ZxZyziXwzAc9LJG132WrQvktnzxVmL6yz54WdxTPB4U
	MyBMiCgrdF1T6CdfsZvQr64kTZkonhMAI1aCBdJSockAKNsuUn+ad2wkHri27vfIvJ0wUf33cO5l3
	lAb3C9yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ppH45-006d4a-0B;
	Wed, 19 Apr 2023 23:18:17 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ppH40-006d3q-1r
	for linux-nvme@lists.infradead.org;
	Wed, 19 Apr 2023 23:18:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEWQCUB4ZMAtI6LS3TzfWrQwwD7opM17VKcuaa6V39CiY23jpUbBlcn2L9HLBEwvQN6XEi5+GiGuuQwFIexiVC/Q0DCZNyAzPGW2Lh5ZIHYMKCZt6tYSWM4EgG/po7Jyppyfj1AVmE0z04NDyI/pbiqJmydWMScMQWNRFKy1AoTVyMgPoyWDbknWz52UKIAVri5xoVNk2JAuvLHsle0rlayz/D1htcqKIvgmh1YkXRDpsx8QUcD3Vd5J0K1bm+U/k2HoCyCEN68jstGv6MXXf7jfuH0u+UUECXurIv34Ix5Iq9KDfBwCVOty5fKTZdgcclfu/j5cdxauz5tgL2mNPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yAkwX81VooUjd0z6Wto1X+zuqvn99nf1UT7XLMkuC0=;
 b=h0rrQEkIke/gJX0pkESkxMK+18V3zs4Y5icCwVaiuxS78aJUrO9Rie/EaAD/nQEDCCkMMclySfJNwzFW/K+WkRUwgtR53HHAQ/LPkBh1U2nqgT7bKGo3mDPa8LDpkgdCqi4lhLBGFZTCbcZh4Ejsum5z9Jsn24/NyOOhxiXeNRYUwzbXp4kU4GT7Y5Z+X2Ri+G5uHdzK767EjJmnCh9sHQ8QCMbuxgdArsKAYh5staC8uNZg6VkrrHW4YA7XJJY5JcA8iv6u1+zBpoN4n1sZinEzZZKMPcspnTVqd5CkXTEf7ziZ7BKVxwTnpG2kBndsJTsTm6OwEIgfPeV1p5NgbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yAkwX81VooUjd0z6Wto1X+zuqvn99nf1UT7XLMkuC0=;
 b=uSst4Xrsy67KbH6KsIJVZfXmgFYMlZVizYJPguyHM/jTowlWiwVkylrfmsL8br5uDAThG/H+IZ6Mc1xlrxUVdcqOoYWhVuXG1izthtMqkUDercqxTt5yvYknPzY2EmALyJRmg7tN0r2ZG164eOtvZsXDf4IVr0oMUpuZPTa8wRtjn7e04pNJ06OX4UzKR07V+bk1ig1GYbDFidBIZAiACbi/lER6fnH725pMPIysp23cYgiRzF+tFG2WpCZlzNtURRFbO3c4hAPj6Smj6VC1lbkR98ciLWExJ81OpZauBUhwK4HuGJa75Q+vOegCiPTqxWaqeJGl2PQhGw4/2KxbKA==
Received: from MW4P223CA0025.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::30)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Wed, 19 Apr
 2023 23:18:08 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:80:cafe::f0) by MW4P223CA0025.outlook.office365.com
 (2603:10b6:303:80::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22 via Frontend
 Transport; Wed, 19 Apr 2023 23:18:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6319.22 via Frontend Transport; Wed, 19 Apr 2023 23:18:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 19 Apr 2023
 16:17:53 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 19 Apr
 2023 16:17:53 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.37 via Frontend
 Transport; Wed, 19 Apr 2023 16:17:51 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <sagi@grimberg.me>, <hch@lst.de>, <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <israelr@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme-rdma: fix typo in comment
Date: Thu, 20 Apr 2023 02:17:50 +0300
Message-ID: <20230419231750.25066-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: 3debb6c3-b6d9-4b13-b9ab-08db412c560b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	gD6E6RyNxhvL2OyUF9MDBEsNjGk9AJN+5NBgSM3KPfUxCIQjKkYmUCwVaD1bj3yWjmXzSuS/MLbkNvZpbAWKl7Kkw4FVYeMdPKLmLUI5CPSe6sDMnFhXhHSvtLXpwL/mp/Lqbq+xoqgeTx8WxtiK5wHX4kIi3dGn0GybcoecsqeTvOrzFniEe+kAwBImmFb5yGLtr39Na1k/ReQNUnl27sAaHX1OvodyMx12F5E/d1r7LTxEH4HnxQr2T52eFk1Awm43/DdtoYm+Q/PTW7w7gS8gPpnHw0UhMg8sB3uXLGTA43Ir/a1el/k9qyLC4jc/EnPwBEtSs5ZMcj2rBKKTrTdIP22MLt0nCDZX20wPtXS/trK9ytZbM2o61ELWS5Tsk0AymJTqi/0JJLV+BfH7U5TASY1mNda9MRrk6jt+ldHpaGidmST/Yw8Mb/8aUfCRZdk/73mHe40+l5kK6pNpqzwvwvnskJasUw2nLrRXtNAfZs7jPikOoyDwKorNlPxcAQoFvNmuoPIhkYk3l7HqbZyUzI2Ooey76y8TCQuNG613E0V7gt1Q+hJVEn8p7pTtbsq5BdpAg9mryWCueiWRHZhppr5ODWMWrvrE0q1NsnV0bOuaQ/a5VBo17e/gUzyCSCTAMAoDC2DYFdEXYl8HOEKDW6k8cI0ZKlCz+T4EXD7nsUMrFHpoQSI5tQ68FZ8TALf7+Wj7abMFWbs9ah+RnidP6/F5UepAXKhzeNjfHv9flVISWVk8EAzNfXIRGZtoK/mznPiOfiTwLIVPjGZ5yaOaqmBUINIO2lc4YHgmjCg=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(36756003)(4326008)(54906003)(316002)(70586007)(110136005)(70206006)(41300700001)(478600001)(5660300002)(82310400005)(8676002)(8936002)(4744005)(2906002)(40480700001)(82740400003)(86362001)(34020700004)(356005)(426003)(336012)(2616005)(1076003)(40460700003)(107886003)(26005)(36860700001)(47076005)(83380400001)(7636003)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2023 23:18:07.9626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3debb6c3-b6d9-4b13-b9ab-08db412c560b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230419_161812_640535_6CA3BD83 
X-CRM114-Status: GOOD (  11.36  )
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

There is no ib_stop_cq API and the need for the +1 is for ib_drain_qp.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 79412e4bfe3e..50b260410f9c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -506,7 +506,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	}
 	ibdev = queue->device->dev;
 
-	/* +1 for ib_stop_cq */
+	/* +1 for ib_drain_qp */
 	queue->cq_size = cq_factor * queue->queue_size + 1;
 
 	ret = nvme_rdma_create_cq(ibdev, queue);
-- 
2.18.1


