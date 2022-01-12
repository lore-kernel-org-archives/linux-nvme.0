Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C36EC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Jan 2022 06:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PGSuAtJGT4mHaaFrp1rD1meeuY3Rk9NpamJk/02VdHA=; b=VHR/YB+5SbqbdQAPfp1QgBmT5u
	22uTpDo8t6wEa9LbyPQl7U/sYGBr7aBRZEVpCyW4u7tDgZ9HBOMAACxUgRDOnlKpM7JIQin9uIABL
	19wR0E12KlYeJhKY6Y9GdTx9h1NDumKameZpO0IgM7pxKSehT4qQYzSQEDEF9K7IKp1nipAkhQd83
	WC2OhQwy17sonN1NBXS9/jDtB1egaqTNRxik2xBuvWAbqQBLaxoUHeIKOtP5lVHl3IdwWojK40eH4
	nvHw151X4FLzqykLnm6t6nEMM/Df3JZF238O9ExbDv5HCkwOEB59qrm8h1I/h5E07QkPnDTeaWeQG
	zyfZqR1Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1n7X1R-001H36-Hf; Wed, 12 Jan 2022 06:22:13 +0000
Received: from mail-bn8nam11on2085.outbound.protection.outlook.com
 ([40.107.236.85] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n7X1H-001GzV-4d
 for linux-nvme@lists.infradead.org; Wed, 12 Jan 2022 06:22:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YghsU3qpTaapjkNF12j66tJgutANjxJ+3gv4wilQuDRJ+5OyNTXB6tOBhBul+ZiRy314tqNMEYu442dTI83YFew5FHLBUIFiwr8zz0w3ohYi9ksj2M0I51f95j6CcYSVxIHoPh2nP7PoRmDb3aS8Sa6KlbnPFIkOT3kSIZlCXzt+YbfQH9b+6Kr2LAvGVYia0rGrmwepJRGghJTawTmX4Lv++J2B4V0IaNXudcnlUkznCplK6CCnMDgKhhd41Y7bdJI3E/nQM1RBIcE8NEJlKvgedWrz8IZK160F2YGoR8uynru5Qv+NS1M90B0qA2SjrO+1d87bw9G1HA4a+UikKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PGSuAtJGT4mHaaFrp1rD1meeuY3Rk9NpamJk/02VdHA=;
 b=eSlhpU9w57EN31a9FMzfuVlgTeC0LJDr0OUqRu+xyKF/cDxyBnN0MOQjioEFr0WTWoYZdQV0nZfqBfgjpKg3Bm62B2srVig7wq5OF1ljqJqDephyNkbbKtEjlfkueYuUwfXDAr8M3pPT3YMY4CmCrn8v81Yaq9VfvtDawNZoBeUoetvpk6rG+L0FA8qLAzlywLKQ5nSOLVXC5X/j7TvluPGDGwNaZcze9Y0DdwIzneQspLjcEeIFYAx7/ThjtpHUJAh/yVl5yMk4R9ejHDqHgpgEUZMSdNw/MoFahMAHtpJwaLHhnho0Nlh0ucJLkEhr0xn2twy/sknZtMSWQXj1XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PGSuAtJGT4mHaaFrp1rD1meeuY3Rk9NpamJk/02VdHA=;
 b=AEgWjV6mODkdCynS3f3l1s43ZulKaQNsqVQmjXIDQhkT87kRgyJIBz/Ih2oXkuLBPlEAy+ZzWRzn7pOlNLoMZXmZT9ybDSEw+cPrVJPqIyX5G9GPEvlcEF+q2CaIWnC8NbpH12CGn9CJmtA8SDi8YEhsSbwtO9H24FeFaj+MhHTYBGMapvTa9k2DMPeSGG+JVdsatM8fTzXHwOEr4+UDW8H1OKEa42NyESHeRsIPJEG7Vuvo8o6fWvxNO5fkp/e4zLRitNHq5nTLdyOgnYdPHLipbuOX4HDSV1Jd+S5+ZlAFvfUXUP5xV3MraKZAM3aKlIR6RVfExFtdYCku5TEauw==
Received: from MWHPR2001CA0024.namprd20.prod.outlook.com
 (2603:10b6:301:15::34) by BL1PR12MB5109.namprd12.prod.outlook.com
 (2603:10b6:208:309::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.9; Wed, 12 Jan
 2022 06:22:00 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::c0) by MWHPR2001CA0024.outlook.office365.com
 (2603:10b6:301:15::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Wed, 12 Jan 2022 06:21:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4867.7 via Frontend Transport; Wed, 12 Jan 2022 06:21:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 12 Jan 2022 06:21:59 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 11 Jan 2022
 22:21:58 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 4/5] nvme-fabrics: use unsigned int type
Date: Tue, 11 Jan 2022 22:21:00 -0800
Message-ID: <20220112062101.90102-5-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220112062101.90102-1-chaitanyak@nvidia.com>
References: <20220112062101.90102-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1778594-7b7d-4310-77a4-08d9d593d738
X-MS-TrafficTypeDiagnostic: BL1PR12MB5109:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB510926AA61FDC9E7990F1219A3529@BL1PR12MB5109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4j/mdHASR1IANQQH6QTFLSMShkBnKutvrSzCfPXFQjy3kwWb1B6W83sgEYVdQXQ4ehG2RxQr/zMW3c18lv95XSJEy6AbWtpjGh1fUuo326ycItYZNb57DIXs2DuQSkjJ1bFydAvHQDClh+fu7TPCiAnTn+VRaOIMCckFNbBXx44+abmYdGdIBa6v3+uqs0IMKCcwZO14JBzkbOnxfiIxtR6Agb9bOf3tR7b9u1W/E2IlDEfk/m0fB75zo1ctl13zf541KWlsuo63hpwHQuIvDwY5j44wjSypIav25+Fg3XrMhBp3H/i8c5oy5oLJVwXw6kgOemulZxIdbmdqtxjtZiyu1diAkMpSzkXHHpda8ULavdk+lYoKb1LDpmlicTIl+JZqRrzEDyFEW32ar7fsKjCpWq1j2ALg47I/IBFcGfohr5WxD4LGErKBIwtyBn8jL6biIX35v0W9f3p6JwBtJmuw3GZPhWOBf7zH2S3z+gqOMDZxbLKN4zDJ/OnSe+37HMbKZSxflPQcX9hHJPOXZ/bvujfi7CmIKg94HgUy8tojtAJqfWqWH/hftYiqkKzWIy1JSyuI89jNpfZxCE5tpbtt9cpJlfCStZplgIlW3PP7z6tGo2udO4KVmERZfipxv3vK9t3//n2jDpd9TfccwqKpd4LCUS3Og9zIcYrSlhhFHENI73YGxueNAuF4qFIlRmJZiWVuP1XLQhOyP44WMoAe+S2BXuV1nSFmIHXKaUMQJK+6IJXR9r1ODDziMyZEJYmPz5UFbH6Epw65nj1ZC+Mn0AULihePYMnGwzyWBc=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(40470700002)(2906002)(8676002)(70206006)(70586007)(6666004)(40460700001)(4744005)(5660300002)(83380400001)(1076003)(508600001)(26005)(54906003)(16526019)(186003)(4326008)(426003)(336012)(81166007)(86362001)(107886003)(82310400004)(356005)(7696005)(36756003)(8936002)(316002)(2616005)(6916009)(47076005)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2022 06:21:59.6096 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1778594-7b7d-4310-77a4-08d9d593d738
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5109
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220111_222203_211646_CB5D4128 
X-CRM114-Status: GOOD (  12.26  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Loop variable i will never have a negative value, so use
unsigned int type instaed of int.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/fabrics.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 90b3474ea276..df0326db306f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -922,7 +922,7 @@ static int nvmf_check_allowed_opts(struct nvmf_ctrl_options *opts,
 		unsigned int allowed_opts)
 {
 	if (opts->mask & ~allowed_opts) {
-		int i;
+		unsigned int i;
 
 		for (i = 0; i < ARRAY_SIZE(opt_tokens); i++) {
 			if ((opt_tokens[i].token & opts->mask) &&
-- 
2.29.0


