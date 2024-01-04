Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2239C47074
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Jan 2024 09:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oFwZhroeL/HYSCnrEjQ9wD97SyvjZQLtODyoZRQU7e8=; b=tTTPi8Gd5VcDcMRqMIwkd88DBq
	gYcDl2k4b0L0jhDmOT+Yc3MyCNEBcay1n1/dr+/WrNqonp6tZ+I5ytv2o+7jMaPtcPiNEH7As4Iwk
	9hsJeSNoZY2OlRIpZlMzpdhJ/evLUP/GHdF//r3qnzPduyTlFOVheC9x0V+D5bOFAzeW3u7EZZdJj
	/gCqL+zaZGsXZM0+1I8uH1prKCHvjcJS4hFzS1UCdzmkt+4R+TIhgDvMFYx8Y8IsWAsHbNg6QSqkD
	vM5/i9QGd0uqLYZnoM0t6upWrnNT6sfV0xn7U+RikHMAYpRByzAE8w/LqiSRFz1Qi54CeOH3hv4Md
	Kb4u05wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJze-00DMQz-3D;
	Thu, 04 Jan 2024 09:26:27 +0000
Received: from mail-dm6nam11on20604.outbound.protection.outlook.com ([2a01:111:f400:7eaa::604] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rLJzc-00DMOf-0n
	for linux-nvme@lists.infradead.org;
	Thu, 04 Jan 2024 09:26:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OesUJVAKIbaeMh6/s5IgRylpvKrDIB9rMrT689mVhKIlR7rIokVcPzdKVt2s+6i9leEMZ+fUTgv5yu3Kaq0Sb9h/9Hu2zpi8Ru8mVOFXHOdXGDhOKFj+Z4ILDom/hD2xs0Dc9kpLyJ9X1wz3mcWypSPdL5kAUS6wlsGV6Pn717HT9if6bYRDT0lb6c3ZPPO9JgVMB7o3zR4kjK0EMzVmiYN5GU/lBB4LTeGKLJ7wTGkK/Z+SkN/xD/ZL4yO2yu4mhjzu9wSkuL5KHgj4C3BwM+sPlFIAWLj52wk5qqUNrtoOawkCcgFnxlFSGVN7Tb5ddlu91NE7tDkaN+9N0Ef71g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFwZhroeL/HYSCnrEjQ9wD97SyvjZQLtODyoZRQU7e8=;
 b=XmVrziEHiy5X4AZ2JcuMP0BK9KrbbmJ81s09Ppt2qgChVxKZTJdVwnhxgqtKDeY+rL17LAMjnt9mE7VkxUbNKR7SfXr/Y8XcYubj7jqhtYULhvKml2G2riifJZibWEHKjEHeqhfmTB4t5w9Lmkza+YqcCMzA1YunIF9xuW9CnLjsw5WEbtlGkrkwERbUIGuH12N9+VsvtHMlotIQgprLb9I1xzd7H3I3bNNgmUTrF7PurZESa7RQmGuO6vhesHKl7mnY5uVik3UjT5d+t0jdFASJYPgkUjBtOA0TknO+eVvmA5NZ+rNj6Fdh6iauKudUPuqdD7P+z/1aDSW5mof87g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFwZhroeL/HYSCnrEjQ9wD97SyvjZQLtODyoZRQU7e8=;
 b=r1ak2QiB5aAwBSyQ90TMe3Nc7ua8+NsR0v3kNf4xzqHU3K7FZ2uzvnhoIOCAIN8bSZkL6JEkUxuR/N6aBFi/oD2Rdc7PlmQrSB1IjTdalRSTXA+bv5wO22EIuTL5mKWbd9CvIsoUBZGmwpZaVW+iKY9IOTZO46v/XCvSr/R9aCFMQNHBRU8rVN0jLN9PgbIMZq1Pwcw+hok0GKqEIRsccXrVJK7f7KVZBQVAC+pohgqXYacVFvDJ9Z/4IAbdkdv7Nxt1ARHfHcbG+Qd1qrkaME6n83l5XAndQL0/y5EqbmjOUsuzqPdDcmzIavoLAuN0Cdrk4Sw24g3HZaJnMViOKQ==
Received: from MW4P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::26)
 by CH2PR12MB4246.namprd12.prod.outlook.com (2603:10b6:610:a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15; Thu, 4 Jan
 2024 09:26:17 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:80:cafe::3c) by MW4P223CA0021.outlook.office365.com
 (2603:10b6:303:80::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Thu, 4 Jan 2024 09:26:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.1 via Frontend Transport; Thu, 4 Jan 2024 09:26:17 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 4 Jan 2024
 01:26:04 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Thu, 4 Jan 2024 01:26:04 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Thu, 4 Jan 2024 01:26:02 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>
CC: <israelr@nvidia.com>, <kch@nvidia.com>, <oren@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 5/8] nvme-rdma: introduce NVME_RDMA_MAX_METADATA_QUEUE_SIZE definition
Date: Thu, 4 Jan 2024 11:25:46 +0200
Message-ID: <20240104092549.25721-6-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240104092549.25721-1-mgurtovoy@nvidia.com>
References: <20240104092549.25721-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|CH2PR12MB4246:EE_
X-MS-Office365-Filtering-Correlation-Id: 022df96f-247d-4222-adbd-08dc0d07344b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAXuFWLIJ41YxYTGnaeCQLzb+F/zrjwGTKfmwe+uy1PY7qC8mlhJ4rscMU6RXXCZgvT8XHKfpR03R/YQ3hITphXSm6OfLdUrC6ODEh+XdQcspM+0bhi4OiAQvCTpxhV3w/kWBlw5z/bcWdZJhkgDDz3qGncI02fqJVWLiwyIqqBKlk0I9I1AaYxGMAJ8HZbLoWNO/hssrLu1zeVRJ29ap9ANfNroBrfei3AbJp4q9O7mQmw20QngWzXh2ZBzImsKjLYtuTa2wcnY1AuEA5aqYu5fgUDoy1ObB8LKxHK7GJM+ENVohSj6BgBRK3x0EaHZ/N2fa+hXnm29Xyw3UR+Bv9qXveJ9JIqJ9J/C3u4difLv8xBB6WmWevo486BF1qI7TLq/jnLJW7qqHkpawGcKMOcRwbAzNu+B4TPgVNquX1KfumbDvjbju9vSfjOocOKGYN18glDiBEKhMCzQC6GVR8QMIqaY5iX7isLTG3so5eCkmhnen4CL9kt0GIlj7m6X2kgb4hWTml3+AOxbEZDg9OWpVvTm3UbHupN2tIiX7kfM+91+hQWe2N5gkNjupeL9n6EwB4wPZLfcwLzbdmMRWZzyrD/y1j0qBZRGBeL47tGr2i8Al+uNeB5vbtQrlX9Vonggciyz+/0okko0n0VUDomIsbgsMYnflFsuuRVv+qxIZZlzuw420+6lGKQw9p3CwxzpO3wTQkmOltHecrv343odaN/9jZLzduSJdSkKTnosSAsogM5XJX6DSKTxP9GQ
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(82310400011)(451199024)(186009)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(2616005)(336012)(1076003)(426003)(6666004)(478600001)(26005)(82740400003)(36860700001)(86362001)(36756003)(356005)(7636003)(2906002)(41300700001)(83380400001)(47076005)(107886003)(5660300002)(70586007)(8676002)(110136005)(54906003)(316002)(70206006)(4326008)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 09:26:17.2137
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 022df96f-247d-4222-adbd-08dc0d07344b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4246
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240104_012624_295554_8FC9573F 
X-CRM114-Status: GOOD (  12.76  )
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


