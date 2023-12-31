Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49CBFC46CD2
	for <linux-nvme@archiver.kernel.org>; Sun, 31 Dec 2023 00:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xlyQuphr86xJr5ARwfVXLTOwUEvsu1jU2DPwrIFZg/U=; b=DvZWc6xfVP1fMCRMtnTKMMYIQH
	pPRY4qJ4umhLu8pKRL0aVuYy0GGbMB9SvKXVDl42vKqkRZrncs2IR8Gg4OPy0WX7CJzRHhp0gd0Th
	XSh0gqAUpoFMU5ltgMeL8bkfDPFPswjqdjHofFT5JvQTJIK0QRWf5txD6uGPM0mNeBJTajd00cUL8
	gSKqHvhNZaFGhn4DBHtCPSzUAmCOxVEgZOgiuKlIqOac/+SppjTWBGR+Z4jNvSI0LGEkSg+GVgeGC
	55hTuR7EeVs2RKZaYG0UjqtJ1/7MaFqIrqTqQWHOTjLjVsu8ytTnHZCdUgxi4MIF6YQi6PZClmAQ4
	4Bh55cWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk57-003g75-1M;
	Sun, 31 Dec 2023 00:53:33 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rJk51-003g2E-2U
	for linux-nvme@lists.infradead.org;
	Sun, 31 Dec 2023 00:53:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STXTTV/USsfdhwTVoe4CDzv9Lm4LUpCspVpwrjIGQoJMuVRiIud51QA054h1j5L6d3x93pM3WNjF/rZdTRZrrI3qd8rzXf3X5/Wwy4A9buOGmOVwqTydElxwRDXDZ+MyvuU8EFjNBV1GZu2HkhjWfwEomR3ZHCi9AlmEY6pMf9PJ5/XJ6JsmHmPanfsE/JSRefHMirjhWVmTGZ8+Ri+bRdsEvYZTSn6kk47hf+9qQ601JgBVDHOMUMRQGI/wxWv1M00DAUkk7asr7XfQDpFadmNKbSiE8Kf9CK2mVC80qsi7Qcfotk2415iGTkVA/sbpvUy2umq7fFultMZYfkORZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlyQuphr86xJr5ARwfVXLTOwUEvsu1jU2DPwrIFZg/U=;
 b=Tksvlo+7pGBL1ZLqRRtHkESg6E504oIc5d4OJLgxUR1NwcAXAKxHP+U2e+qzDYDvcqs6XVzRG0MOJhKMmIobFqpqaKxgGM2Zu5is0f6bMdyr3Kd/fFFWRrKZkkNfOAvBPIO979l4MjikpCV087eQxbGqP+HaAmdmkf3Kpv7vOuMngKCe0zVUwm5Y/Kc+mz4SjLuBlqMDGBE/WmfUsGOShrvl31UVcIRGnq3WowZj0E8v4rpwlFFeKwqsaqgZIisNs8UovI9slkDYcWKuudcOtR2dtQ39YGqrNOCI9laMNaXOLtpwPDICQS/XuRFsRMMkgwHz0HkHbgHvz4YYp7fQuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlyQuphr86xJr5ARwfVXLTOwUEvsu1jU2DPwrIFZg/U=;
 b=Jcx/q01U+TC7jizt0Y4gs0pQ6kCIESWPSYX2Feow2fepW6CBJAr5lEO+lezm7yBv9MIWQaczVP/pILhSjOsYl+OGWMEmLg2T7ao83sOzYgv5A8dSg7ue1hF2EhczDfFFh1kNrNWiLQsC3gI2gyzbBnNsCbioiiRffwGbGufbc61d1Uq8oZur+C8cjR2RVwRU6FgmOoLJCtjJG/1LzavWmfpwwOOdH67ZlXeYSIge/FAGz1saJkB+sX2FfRhloh3W4+09bOU+23HNOQCRykxB0u6JZnAsgtL6I9Uup/J/DHC3RiKGbr66/LzKdVf2rsKZ8Z1OxZMBRh3ztapkHds4ig==
Received: from SA1P222CA0082.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:35e::29)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.23; Sun, 31 Dec
 2023 00:53:20 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:35e:cafe::bb) by SA1P222CA0082.outlook.office365.com
 (2603:10b6:806:35e::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.22 via Frontend
 Transport; Sun, 31 Dec 2023 00:53:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.9 via Frontend Transport; Sun, 31 Dec 2023 00:53:19 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:12 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sat, 30 Dec
 2023 16:53:11 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Sat, 30 Dec 2023 16:53:09 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <kanie@linux.alibaba.com>, <oren@nvidia.com>, <israelr@nvidia.com>,
	<kch@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 07/10] nvme-rdma: introduce NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
Date: Sun, 31 Dec 2023 02:52:46 +0200
Message-ID: <20231231005249.18294-8-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20231231005249.18294-1-mgurtovoy@nvidia.com>
References: <20231231005249.18294-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aa7d5ae-12d1-45cb-9185-08dc099ae1fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dhR646FPcftaNfCZChDewADCsKh1wmPs/ySOdFJnk5CnlNp250jVHxQ0pioSCsdvJHUWz4JXNwZbKxlKXgcPtXghIOZUA00eISYBc+4r51cAppfRsyYZ/LLCCYkTkEpsX9lbviW1fUA8MnwyQIkstX9P9cHv2e/3Wm/fbT6ubuU+SYcTKOF1aahCZX1LZkQsW31OZu07MLBll+yO31kzz3bfZZKJXMu+uryRDjk22ddjp+VMkWGD9F6Panx+UTpfSb+h7szsZ/56cQ4qMPH8yeZq4bVu8EXagpzxrKojoTw809/53fIV0uPlUkXJyqofKJr3WiRaiGvxIis+7aCtz/kq138wgB1cSYvSFxitJ92avINlQelrlaPu95VEgdPMmLVY8wyllGP4qscfuyX5XQjzahofPAlGBxSRDyjzdEH4S9QC3P5VtanuLKV74zTVylGlrCa1Ip2P+kIAkj/bDmAMt5TIhYTuJY7Qen8upxXr4dSe7GDHXQTh5oWl1U5EBvFn9QSLKEq3HWI4EdeaNq7gnSSdcqz9UiFII3I+jlfCDlmD851jrEbZwwelT/MpOWQfqOd8FoEOgOBxkK76BNxMv0C0qn1IEB9MpkReu5mWiN0DxR8uhXty2/2a1AwXCvoNNEDwLPoP2vGKR3HmkOEquBKlj12tLAOx7DqnKucsIU1jyE3Pr8qeNxZVpUJB3wFGUKJ1xcWSFXJaplKR6PfJgTFJ5fQNNASMm21elh3t6jRM+abH+NpqyA8Zs3Ar
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(336012)(426003)(2616005)(107886003)(83380400001)(1076003)(26005)(86362001)(36756003)(7636003)(356005)(82740400003)(4326008)(5660300002)(47076005)(6666004)(36860700001)(54906003)(8936002)(8676002)(70206006)(70586007)(316002)(110136005)(2906002)(41300700001)(478600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2023 00:53:19.9335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aa7d5ae-12d1-45cb-9185-08dc099ae1fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231230_165327_811327_97F3AB35 
X-CRM114-Status: GOOD (  11.24  )
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

This definition will be used by controllers that are configured with
metadata support. For now, both regular and metadata controllers have
the same maximal queue size but later commit will increase the maximal
queue size for regular RDMA controllers to 256.
We'll keep the maximal queue size for metadata controller to be 128
since there are more resources that are needed for metadata operations.

Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 2 ++
 include/linux/nvme-rdma.h  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 4597bca43a6d..f298295c0b0f 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2002,6 +2002,8 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 
 static u16 nvmet_rdma_get_max_queue_size(const struct nvmet_ctrl *ctrl)
 {
+	if (ctrl->pi_support)
+		return NVME_RDMA_MAX_METADATA_QUEUE_SIZE;
 	return NVME_RDMA_MAX_QUEUE_SIZE;
 }
 
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 146dd2223a5f..d0b9941911a1 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -8,7 +8,8 @@
 
 #define NVME_RDMA_IP_PORT		4420
 
-#define NVME_RDMA_MAX_QUEUE_SIZE	128
+#define NVME_RDMA_MAX_QUEUE_SIZE 128
+#define NVME_RDMA_MAX_METADATA_QUEUE_SIZE 128
 
 enum nvme_rdma_cm_fmt {
 	NVME_RDMA_CM_FMT_1_0 = 0x0,
-- 
2.18.1


