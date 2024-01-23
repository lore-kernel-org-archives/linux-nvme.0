Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F077C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hm6FKlgCln/MVWSBSrLKbMr+476Ge37mUHv6oy1XuK8=; b=Ex9Uda2Ly3qr5/qOnVucTmXK+m
	QdBCqhj1pHEmfUWt5qZNYXz/0fc6xTwWQWwZNjijeQo+5hIwr3vpIpsLO/cMJw/8ou3qVZco9Ik3t
	/NwknRGHADRVr1C/JayaWdPZkunW2bFQSwcNDOmj39H1aMtZgyVIDQIoZt+97fsQboYoLrjxNt9lH
	DPm55nDACTBP6KWEu5OXX3+uL+HVZTNyFzqzJuEqWZQf81xHbZluBPMCi1LlagGHx3yMogj81mtkY
	HunouOYe9/Gu4l9SzZuku9oSXY4VXYdo11A/13Vx/2JesUiLJuPPhgATVNk3iUXdOxAWB1g+h5L2h
	XT/9v5pA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxf-00Gqw8-0r;
	Tue, 23 Jan 2024 14:41:11 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxa-00GqrK-2a
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:41:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oNbhyTPAEqJrEJYbJPePkrgoXXVzwfQftfnYrH/2DlfiUTG8kJj1QQrE9wtRyfXdaJzMmI8CEAmLAtgVaLskwYpPfkJx8iJ25S8KOc+Cx+O/dPr+P0B7jWaldBIOnSvuQUvpu7j5lqyay7vQ44UN0BLxR1mSZcL3vVHqPIKKnmfT/Fa+T7LYbP6Ccd0xc2Ha1GgPNpF79nxqyXcL9b7sUJrq6kdNkhgU20H2EubPstLtWJmxw+x3W2o9fko/0fTQ3tCTeyh/cznmztO0gxs8AdElqdoMvdua1SVd0locI28sH8I6aptcB9mHz9Ta37WFgQKej4R/xey9Q5iXq/qw2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hm6FKlgCln/MVWSBSrLKbMr+476Ge37mUHv6oy1XuK8=;
 b=maUgifEcxML1WKz2ljQkt2Zw8JpVEK2m7IqxxSHqb5R57TmtyJXKQ7FrIdinMQ/DNrxzARG6Q7cfniKucU1q5lvd6ifk3QbjHRt6C0/GhN3V9D4fa0MdhlyGaTCWhMLuU5R5ZL8bX8zzXO+lNKjt5ngmKeeg1rvPGDhddZx93Y9C5mXxmmU0YtZAibM+AhaurZUZ3aTHzs9Z1Nga9hgbEK54UvhWu2f/YLR7/tHYA4jDTPWp0VN8C23a4gCC4R8xkiQMiCGVXJquY+wnPvS6fueXyMdqCq5b18DMjPAWCbRalXcA9ZlxeduD3g+ZiG1TtSfNacKAplwgG2dcGolstw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hm6FKlgCln/MVWSBSrLKbMr+476Ge37mUHv6oy1XuK8=;
 b=euVMvoOO8K9c8IvgyueLhGWzc+5HsBXzSoTvG869gS5hzMJYzpsWSJaF8snoQ/zMCYpk2MmguFX8i3JVMuQQLLgALs7BnRKMLHACuAqzOkAO8jqafQSf3ihayCJMJuU25XKQ8G4VCGZtm6XpRuCDrjp/oAphcbCqvCu67z5GfHFdQlSIEEuBLjdfzJIrcfSEIQHoQmpQnOPktCw+l/ME7Ij6IziK2A5lvSmRCYG1y+Ib5+KteyISSMxahP2E/PwtbbES0TKjzWf8ztga88o9/X8Nv6h4xnRIt/JA0qKfV5cqhKxETyUSqOVBOGTM4kobTbNmRkl9ASjKde87h73RFg==
Received: from MN2PR05CA0045.namprd05.prod.outlook.com (2603:10b6:208:236::14)
 by CH0PR12MB5059.namprd12.prod.outlook.com (2603:10b6:610:e2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Tue, 23 Jan
 2024 14:41:01 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::c) by MN2PR05CA0045.outlook.office365.com
 (2603:10b6:208:236::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.21 via Frontend
 Transport; Tue, 23 Jan 2024 14:41:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 14:41:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 06:40:48 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 23 Jan 2024 06:40:48 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 06:40:46 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <kch@nvidia.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 5/8] nvme-rdma: introduce NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
Date: Tue, 23 Jan 2024 16:40:29 +0200
Message-ID: <20240123144032.27801-6-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH0PR12MB5059:EE_
X-MS-Office365-Filtering-Correlation-Id: 62ec3003-f496-483b-0c32-08dc1c21522b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3Edq4cTpedVc7mvHhUAq09tdllBhho1DUsZNmHV/+dRShsMjs1mjUIPY1vDHArZ0TdNZc0H8g7kaWsVPLyLxW1ufsuXIwey3ACl/8k1jM8uD0TGY7k6of+81KD2Nqb4e5q8IeBf9nj+fe7vtUaTSMGn5wH3EDuj4gV4fxyfU/GF7Ki4+e45TZFTBisxiyruVhp3JfQIdu+eWmkdAHKFmSz5RkieZihepLcB1qVwDpEp9tr/rg1bxfWm1nncL/B75QQEfIRJ2KJKucWsIjERhEso1Xr3WMVOXtbRDPbwD9nqMbhOulzpFtpExPJv/DTLDFK5K9xzRiArfrsXdFozM0nXyGm4fM7yX3PWpzim1RBXkozZqFarWJ71BHIG64MiUznUS19KZdqOY9Ift5wGzhM24jAihbq+6JGqFtqahIt75FFITfshpPFmZYpvXvRzN/regUNLtbUXm53YY4TFD//2bxtaruaDecTF6M85SblGcbwn6oTPkNtnAQvP7hkO/rNlwblMXIDyPrUuld/CHabghcwhhm8vv56O+USQ8L7A9kKRJD/JaTGMCZ5w2okv6LjoyvLMwaBYgMG73WW9KquTV7SRHGL7K8kTmhNYcwKm9GRt1YFosF/vN+QLncdBaBbH63f4coY5Sjmxxx5qwB0aCBhq270QCTnOFuHcdZgdEa3siAPLIKnm4N5URpBA3PKHEyULIn3GPZaFlAK5KiH0lzHS5yyZLGaKtyABbJF4KypSdJ2TBJiFpQD5vlFE
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(36840700001)(40470700004)(46966006)(40460700003)(47076005)(40480700001)(1076003)(83380400001)(26005)(4326008)(82740400003)(8936002)(8676002)(110136005)(5660300002)(54906003)(356005)(70586007)(6636002)(316002)(70206006)(86362001)(478600001)(7636003)(2906002)(426003)(336012)(107886003)(36860700001)(2616005)(41300700001)(36756003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:41:01.5787
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ec3003-f496-483b-0c32-08dc1c21522b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5059
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_064106_846549_5AE549B6 
X-CRM114-Status: GOOD (  12.67  )
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
We'll keep the maximal queue size for metadata controllers to be 128
since there are more resources that are needed for metadata operations
and 128 is the optimal size found for metadata controllers base on
testing.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 2 ++
 include/linux/nvme-rdma.h  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 667f9c04f35d..aaf9c891b2c7 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -2015,6 +2015,8 @@ static u8 nvmet_rdma_get_mdts(const struct nvmet_ctrl *ctrl)
 
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


