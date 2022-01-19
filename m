Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FF4C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 07:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7Jrg1M45t2ksKDzzh93e8tJ0S4Qj7oYZ/t5BGZpXCNA=; b=A12NWjrMkcH7HDW1qHwBHxdZ1V
	RcBhviSc6YNwOg82bh/LVDmrkZHOKpzDC3shvptMWdv3PIMHdhpkfzgO3amm5ndA+edw4NdmtL2bF
	9mF9iR2Pktrbc+Hlhpk/LcoZKGidhVjMqKj883ZnfCwmCAVZZLG9sByuYmANNyPwEQy/NIP0D2woz
	vcCRe0JPTPCEfA363AZkoERtuzls/puIPRroPoUF3cqq25jJX+PBAuIu9zR+etd7sFy/0sGU6ezI5
	e1p7Hs34w9riA3vY8gtVQ3uznIz5X6Aie3Bo9IxgO7dGrPy6qxE0aWZyBdAx2I8msWVpVzpJyZNZg
	KU067jlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA5HN-0048PX-VR; Wed, 19 Jan 2022 07:21:14 +0000
Received: from mail-sn1anam02on2061.outbound.protection.outlook.com
 ([40.107.96.61] helo=NAM02-SN1-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA5HF-0048Na-Qi
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 07:21:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSTK3mJjCqj4kd7Iea8sjPRkl0vY22npM/LQ7DJ+YETAGSZgWnOsf5KRl9PgUdajRSDFIhyoKL5cMcx1tNluwqwLBcQ7QBtmHX9dgbIdQhOWNaYAFbIpx59JoEaKrNBsnsFoX5cWrzjc2sKMO1NqtcuZWl6t7pHeso7/khC5jSOBvQWahUTcUHeloJno8uZ3cRgMGqiRPvEekLi+Kyu4fagIza2LJoa+Ljl74Rw2ZYMK/S8+NtM3AGBAHabKnagWe4bKlzkSxuM/N1cJb37cF37Nd6/951PisImbkbZOzCmA6LRM49ITlUhA29RWjupAgAUSrZa27D2VgUZlFvo/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Jrg1M45t2ksKDzzh93e8tJ0S4Qj7oYZ/t5BGZpXCNA=;
 b=gS2RH6vL3S4mvt1KoRyFE/nsqSunTvWh/V1LBN99PVOG/gRONkl2rSDD/1lor5NiVsC2J2RBe3VRVRy2qKkHD/dFnQTKztJA2IuH3Zky7Tcg0QVhZeL3clM0ISZu9yW3PNmdpcaf6ZrXbsDBQROkN7Zb0Y1MD4eyZ6HBBrXW5rvOEk48lj8EoB4ygcsqXR99En/ZVFTZnyzQCnkp/jooIRpXWhxoocQ3ZNvDEuNAqw+EHjjlxqI8WF+/KPdcoSCPGWxe+8eMvh6dNBku9m+KW6HLCSmTOXEVGaYLwgi7L6SMd72drwfK+48WpjrdZgu70/LFbQiL/EmOzyUEc30aBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Jrg1M45t2ksKDzzh93e8tJ0S4Qj7oYZ/t5BGZpXCNA=;
 b=iLFu68loTc2U4GXshEUrRU2BoZCKz7EPlIZxc/WjMjM/lwcVbO+CMnGbETsYLTqg65N+nb6pSwsX6dBW0XBRd44qxFooDZ7SDf0yIHyW8mv3EVGDbzhEolY3XzxyMCoX5QxwBoNDu4Ys6eNZxABQ/XZXPyv3E88ZJxYWGlVddC9CYHNbUvS1XzXDFmpWZ/gfmLysJ7LSxdwVhNKC34j8qrwWImSmilFjBnnPH824KyYEQUPhnjsCTAIw0Bsqib75Ie3stt4SOGkzJxW7+DcVHtZs5CLeoM4IGYH9Jdzvansy6WRohQ/J2V3KBmoTnhOu8P59CnFJAH2S+gtmmTkGLQ==
Received: from BN6PR20CA0069.namprd20.prod.outlook.com (2603:10b6:404:151::31)
 by DM5PR12MB1691.namprd12.prod.outlook.com (2603:10b6:4:8::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4888.11; Wed, 19 Jan 2022 07:21:02 +0000
Received: from BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:151:cafe::87) by BN6PR20CA0069.outlook.office365.com
 (2603:10b6:404:151::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7 via Frontend
 Transport; Wed, 19 Jan 2022 07:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT035.mail.protection.outlook.com (10.13.177.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 07:21:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 19 Jan 2022 07:21:00 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 18 Jan 2022
 23:21:00 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 1/3] nvmet: add helper to set ns->blkshift value
Date: Tue, 18 Jan 2022 23:20:36 -0800
Message-ID: <20220119072038.3942-2-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220119072038.3942-1-chaitanyak@nvidia.com>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1be92a0b-419e-41de-98a6-08d9db1c3f78
X-MS-TrafficTypeDiagnostic: DM5PR12MB1691:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB1691D1A2051A38D7FF5AA9CAA3599@DM5PR12MB1691.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjTyWkWoLWFQQpjTvFClEpOUpfb5O1koUcE3g8B4r4U/jLzlFaqf4Hj8uPzj208+AUbZsuRa1NH1ifHeI9ehnCn2Z2hwkuaWcVBWuNirlWV3dTnKV8W0IDWQY9myE2nv4WUmzBA0Uu+p7T2qp2cCsdBxQzA07qG325DpfnPQnfaslKWoLA8jdoJCuytHmuFHW/7U34sJ5NlfC7z2oviJxAreAXZqVaS7TVH80AjT+NUgWK/THpx+9q6OmveDPvm7RRx5wCwqVlVgXSVU0rUBkv/lsNRQf+DvtWHx7yEy7U2hTcUjtju+PLBZoV12VStaep/L/S/FRWud+zAUGLfs3piWJNK8FlZTiaa/HJ5/ICUk2jSFV62mtC7lG3gjMlc2Izmcfnvku98p2Kb1SpnK/P25YAhn50XEwV6DihRalU5XkSfhDGO6QO7+HMmeX8ow1nLNt8MT8YEVEhCafJtJ9vggnTUTF6I9DoSFNC8IGoHmmrPiBNhEYDPrE1Txsqh6SCs/YcrLwfR6S5fynW/k7oCpHQ7vsdt8Jk+IwfQ/JolzfGXv8Jyu/1lGZFNxUGkGfZYB8IDfmKbJWz+q/lSxUMAlIuOIVHAvFUI5Un/LDlxBnjXpELkXNmr/niYd9hInkjZa6ELAGZFjpgTAwVBI0uhHpPTN613zVetZcx//yEy6L7aTbQRlCbVj0jK9FyOihePPg6AoqlbCxPjDdV/EToYuVkhIU2TVx701+HkbhsJVpf1txUEDbF+y/lSZTKdsCIEYXUvwTDt6puqxEKAqWYjQpdvg9cB11dRjk8LS4Wk=
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(36840700001)(40470700002)(46966006)(1076003)(356005)(36756003)(54906003)(6666004)(336012)(81166007)(70206006)(70586007)(508600001)(2616005)(26005)(4326008)(86362001)(107886003)(2906002)(82310400004)(40460700001)(316002)(426003)(7696005)(36860700001)(8936002)(16526019)(47076005)(83380400001)(186003)(5660300002)(8676002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 07:21:01.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be92a0b-419e-41de-98a6-08d9db1c3f78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1691
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_232105_897741_6DEFFA6B 
X-CRM114-Status: GOOD (  13.48  )
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

In order to support the block device in the buffered I/O mode, we use  
file backend. Calculating the blksize_shift value for the block device
backend is different from the file backend.  
 
Move existing code for calculating the namespace's blksize_shift value
into the helper for file backend. The last patch in this series will add
the code for block device blksize_shift calculation in the same helper.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/io-cmd-file.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 6be6e59d273b..7aa4cdcb80ce 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -26,6 +26,16 @@ int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 	return ret;
 }
 
+static int nvmet_file_ns_set_blkshift(struct nvmet_ns *ns)
+{
+	/*
+	 * i_blkbits can be greater than the universally accepted upper bound,
+	 * so make sure we export a sane namespace lba_shift.
+	 */
+	ns->blksize_shift = min_t(u8, file_inode(ns->file)->i_blkbits, 12);
+	return 0;
+}
+
 void nvmet_file_ns_disable(struct nvmet_ns *ns)
 {
 	if (ns->file) {
@@ -57,17 +67,14 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		return ret;
 	}
 
+	ret = nvmet_file_ns_set_blkshift(ns);
+	if (ret)
+		return ret;
+
 	ret = nvmet_file_ns_revalidate(ns);
 	if (ret)
 		goto err;
 
-	/*
-	 * i_blkbits can be greater than the universally accepted upper bound,
-	 * so make sure we export a sane namespace lba_shift.
-	 */
-	ns->blksize_shift = min_t(u8,
-			file_inode(ns->file)->i_blkbits, 12);
-
 	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
 			0, SLAB_HWCACHE_ALIGN, NULL);
-- 
2.29.0


