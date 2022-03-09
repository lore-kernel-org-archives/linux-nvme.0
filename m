Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2E4DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 06:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1lkoxorXpi3tkZvkKJjZfeqCJWV1PxZL+qdPNgGgytg=; b=KNCKP48OdSBfDiw7ZGqKOIIe9D
	5wSPO+M+BCG5TZmmFc/vYV1+yy/JAPsWrTTXGZwi4Nc4aUpbyOsnFvft6VfAIGkGif8p+r8xVzuqr
	UwMQU5tpuhQRAA12nci0bLZMIrK86UKlopzUGthM43oBzXX1ZLCeykK17HZL7w4J/MOyYg+bVi6d0
	m9Pm8JKFFuYRxbwdutHVuA0Dz0WsR/Gm4XEwqozo0TJmvsNjerdXfV/8hi5CsWOoO7eiRLFSd5AMB
	5UPOnRx+isTo9ZBCxpFCrrxxez6lwcyDpohM2jLR4LEUiWn0mx21fvZG9/Hr9iIrsN71GBNU86EI6
	z01rGdRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRpMf-007PNI-6i; Wed, 09 Mar 2022 06:00:01 +0000
Received: from mail-dm6nam08on20629.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::629]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpMc-007PMC-HV
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 05:59:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQaPUe/uLiGFP/SEn3BNh9TmEcN12r9Riba5+SW3BiCYWg89l44Vq60skplwYUXSLKNwn07uDdH12lvEjFmUi/8R/5ZnaSub2btZ87d0lagsU8Qs2YhdcXCoO8GK0WF3GC9l7BzhKwAlzLryAu5MBVLXdD0X511YyCX1BVitr3rrqo3aM/tvRVHPEO5dO/6V/+brKlejorBvvLOrxvP5kLl8qu9eWN79/N5FloqCPFZmDTXKimUQVdIdtTiCnff3TLlpS3GgIyy7kKDMr64eybGeuAeoFqE0dxNIaMEqiwvre3fHOpiD2t2K4j0tIZvHi2wlz/9KHogvDEJj1C/TFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lkoxorXpi3tkZvkKJjZfeqCJWV1PxZL+qdPNgGgytg=;
 b=PVYxv3dc2dvLGauRGRSSISQiFTJQMbIRvn/YZDs3NuKu4kSGA+cwG+xNzmLMyZ6Dufhk7ohT9asgCRt4uu/uS1qzl9GpiUOQ6qxqb5X15JrYjr/ak/DTTPejY4wmb8CM9CM44U0GRYAuzXy+iOa5kWbJbeRnGlBG8BwnKMYbKN8IThxs+mSHfCyJOujWbK5lRH1/ag6GisVeSUMzF9bWXv0D5E6N07R0a0yG7Yh9eeW255ZdxYobmO09491MnVn8TNOfyrAerYP5fEKEel12ixtZEPsYw3ZGh5zYIHZ/ZePLvzgbQnyrLovC6ycHjjoKQsNQqmGLJSWx9ybMrZD2Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lkoxorXpi3tkZvkKJjZfeqCJWV1PxZL+qdPNgGgytg=;
 b=sfLjeetCSWe1DQkANAs06aYNlKknb7GxHyk/Kq9fpYNDOFRkJdw9HLlSk1EjyZLDP2QxY6rLbgpV0WCF3Qnfzhb3MTwbArgqpPDDh7s+xSV1eOugQGdiMiAyHDfOJszwxyBBtYvxWzoUpK7p9fftiOGhkcaVcY9SAf+2hrEN16pfkZtq3ZfNM+yv1Oh07ajUB0RmdZTxSX1lllROzBFBsYWD5pHszd34CLd9G/WqDEQmS7Q8mSqCpiUxVnHMVkxZ0QV/2Hk6WXD25nMzh0zv+0bU0e5znAEFqFqBRdliuhE1qxxCt0imNKhn38vWaHcgJY7tScr/aMnGCchKFK2RDQ==
Received: from BN6PR1701CA0015.namprd17.prod.outlook.com
 (2603:10b6:405:15::25) by MWHPR1201MB0077.namprd12.prod.outlook.com
 (2603:10b6:301:55::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 05:59:52 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::3a) by BN6PR1701CA0015.outlook.office365.com
 (2603:10b6:405:15::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Wed, 9 Mar 2022 05:59:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5038.14 via Frontend Transport; Wed, 9 Mar 2022 05:59:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 9 Mar 2022 05:59:49 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Tue, 8 Mar 2022
 21:59:48 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <axboe@kernel.dk>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [V2 1/3] nvmet-fc: fix kernel-doc warning for register
Date: Tue, 8 Mar 2022 21:59:25 -0800
Message-ID: <20220309055927.11267-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220309055927.11267-1-kch@nvidia.com>
References: <20220309055927.11267-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79ecce12-6030-4a07-ddae-08da01920702
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0077:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB007789804945B63ED745B306A30A9@MWHPR1201MB0077.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9+q72CRYQyypSwzympLfGBCR8aggNvR4+3ofRI/hrbPI6QxRdx0fK5UdL3EV+z/flkxg511UK6kKvZwcEe89imAek9EMSKmJ/SPA9QonaOqBYirLYZOPCSITqaYoAMkqKlATgHurqsPeDNAR59qICjl+ISJoGex54VZHRHOX5VCKPdlTLCRd1CEbfIvosWrz0LwvhcovYuR1tLPZtYVRj3K2zxmURi6g5LjKl/9aNPpkd6RC9zUXrm5yAr7Pfk1fzgLHBJo53lb8qtm2uEApuDRVAdFeDighl6U0z/iiwqQoNDflAFndVZ5egJurSGcSnlYkO+ai1Oyh7WtoBx5gopwwiBAkrDJaPJ18k01ifPR30BLRQ+PxWQurCdZCdei4ggoz6hT6XvzJtsXBIGWpr9m4pmeC5d/RuzGzzEgTnZ9Ut6dvDXlDGWhjoG6FLBAITjeEtTjyePlWxqxEK7ZU9A8GCBSG8ecl6Od91lrFmcW2dKY/YyctAp/hWGSbubGCB4OGGHJm6NvfonFDIyoJlNej6b4Vu7p9Ryd3qVAqntSHD0rRJmId2FP4k85dU4qZIDV+Gr0AVllCsaPP/GEcnLnLaAPlyu0mcahAZgO1VgdYThJyxmv+jcw/t9M5wnoIjvJRpnQgRTrJMjDA+ZHnUtnTAB1jIpKALxlA6KRMKdLQgN7GBwjuMcrI4RpWIcExXspG0mh7sHf2RdUzYPTwg==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(2906002)(508600001)(1076003)(2616005)(6666004)(356005)(4744005)(186003)(26005)(82310400004)(81166007)(5660300002)(7696005)(107886003)(8936002)(40460700003)(83380400001)(316002)(36756003)(47076005)(6916009)(36860700001)(54906003)(70586007)(336012)(4326008)(8676002)(426003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 05:59:51.9265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79ecce12-6030-4a07-ddae-08da01920702
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0077
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_215958_607768_3944AEBE 
X-CRM114-Status: GOOD (  10.14  )
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

This fixes following kernel-doc warning :-

drivers/nvme/target/fc.c:1365: warning: expecting prototype for nvme_fc_register_targetport(). Prototype was for nvmet_fc_register_targetport() instead

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/fc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index cb013516784c..56c2bdfd8e3b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1341,7 +1341,7 @@ nvmet_fc_portentry_rebind_tgt(struct nvmet_fc_tgtport *tgtport)
 }
 
 /**
- * nvme_fc_register_targetport - transport entry point called by an
+ * nvmet_fc_register_targetport - transport entry point called by an
  *                              LLDD to register the existence of a local
  *                              NVME subystem FC port.
  * @pinfo:     pointer to information about the port to be registered
-- 
2.29.0


