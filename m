Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7495C47DDB
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iv/eF0/K3SrdRquzWNuGO5x1oCRll5wpTfbXnb06hI8=; b=sPdUJEQtbUEm8LYxMRjYKo8nOo
	KbYWf9viZd2mX97XHsNWyD2NksDvFY4MjT86KJHCGEsNAc48tJc0SvxMQqzcIQC06eceXI+Xzj28t
	69nNLU3aCPtflfIbxAb7SOZCukB9/PcQMVTMXa1dn968Jr5795H+kfDiSsDdgF5E8d4qeznmNyEVx
	kHAUDXGHiKX71eDpcDEvhM/NTg8T460jakGnQXlwA/GPz0BKfqiU2W3XGtEnbbX5UH4woge12tf5t
	48URQRqQtzps88Vnq0oWNdoJvsVTHM542XFgeqiJ9lLMqHzpSkpuy++EWpBCfJAJCSL5gKD9k+Fzc
	eZg3Arkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxp-00Gr3x-2o;
	Tue, 23 Jan 2024 14:41:21 +0000
Received: from mail-mw2nam12on20601.outbound.protection.outlook.com ([2a01:111:f403:200a::601] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxn-00GqzO-17
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:41:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQ7D8kmm6ZdX5eOS9Fml4Zdz5uf5PBn6xwzqCrFUfz/KtUYDBXtDnHx0oPOeysE45lAbtFTR+TA8jUOQFqwBi3gAzcTcRgdy1Fu/ObtsCo+50hgTTeID9p0/5o0A8+doE15M2UvBn67W+Du/F8OELO4paOpKNkBcXgUhIl6XPPV7z3dKVYDIfAeB779GPkPX5nQz63V7Zx8fjLZtqW1tEcuUkd11Vn8n3Mr7jOKkCYhgC6Kka++7U7dqoMUtBvN+P6qi2KU1hptdEVqiOlrO6Q5mGGJHQ7hHdIktGqiTeW3kWVMwTExeFJzJkm5scPRqpOySKPJO/Zf3E1z4YhvigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iv/eF0/K3SrdRquzWNuGO5x1oCRll5wpTfbXnb06hI8=;
 b=Ark0qMi0ReTCcOhsNG/upRcDGSeHn1tQi48ihRdgkU1Ylqh+vshdgkni75R12qbxHjKxItmPQ9ohdy7TKuqhMVNCa33BN82F8mudNxb7zVVtHkNtbtmHNbxYEtwq92UKyQTrcP+uvcZc9C+kABpIi/7kn7z4pVpRAyi4VvCNoS4I4TzUvhyxlTyb9/MDQ+BnbCpgDmTTgt8quqEbufjxjHFVyH8HqQ53Y3iB+4XWU6SG9ty1PNMVDkaz3Ns1P5tDvvyPyOF/350aClJkDKYCXpWHvJ4VykzvzOwJvjKA8KzPiEHAY6oC32eelxg5fcJuW5Ekn4xf+jcn6VnWitsDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iv/eF0/K3SrdRquzWNuGO5x1oCRll5wpTfbXnb06hI8=;
 b=ktl9zfGMEt5ncDaNX+XsctTZMR4qJ7zfr03JiUHu+HWv6jZGdeB46+1BpTYlt8h4B0KWJGomkuI+uSP7iO0w52Bil0gzLy7AxbmLbqzhgFWeITA7kvNoX6OsC6eV0J45SX/kMLCP7RQ+bSKcqtMHCDfOR0HWTYT+IS2zXWcAoVLBaX3eeyuMXkqhdgms3cFZ82/lGn3vPrlWHNwMIVDtF3HdFLxARNPzg4QnU49O8HiNnJ+JpeVv1WeIWrXANwA+zyyLLMUo3Bg2hG1wDVE6+czN5pioY3fgDqZeyCUM3yYPYwCiwBKZyPgydPT9vNeSjPzUPYgFNPbORGnkZl+H5A==
Received: from DM6PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:40::46) by
 DM4PR12MB5104.namprd12.prod.outlook.com (2603:10b6:5:393::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.37; Tue, 23 Jan 2024 14:41:09 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:5:40:cafe::9c) by DM6PR03CA0033.outlook.office365.com
 (2603:10b6:5:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32 via Frontend
 Transport; Tue, 23 Jan 2024 14:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 14:41:09 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 06:40:56 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 23 Jan 2024 06:40:55 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 06:40:53 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <kch@nvidia.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 8/8] nvmet-rdma: set max_queue_size for RDMA transport
Date: Tue, 23 Jan 2024 16:40:32 +0200
Message-ID: <20240123144032.27801-9-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|DM4PR12MB5104:EE_
X-MS-Office365-Filtering-Correlation-Id: 592e86f5-789b-479f-9ade-08dc1c2156b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zvx2YDSyil2b+yHE6ufBTwVJtcD6xSY87feGzYZ5jqf7r/Yv67CC6wy1LIvkNLvxZDFkwDe/kw3ltFMsLJMAtnj5GhJ2a7zb/GBXJXIxQyU9DtHZ9F5EfFsi8KXH+emRPsT3gqVOz0CXPGCVe1tD6RXbThbPi4pGkPe+/G3iOQsbrq/BX/dgJmxJECfITdsz3iGnwTdyEPFj+im31OVL0oXwXpzSZX8v2bMgGvudE8OiGQTJoI6qLlzXoskKMjc46J7YgxiEqaNu60hoTNCNFVkoPdi/yacZ+fcKTo396dsyafkOTlZZ8/eDLYouaZ9cmrzEH3k3vTtwE4VTayr4T83aK9kttz/7UOLXB+hnp/xYt0VQGJ/fcdU0cE81+mxZTwdbj1r/mwHM9utKJ3eDgdluoE2ea6jofsArU8rGNAFxPojfoZr2kNgFgHXelYlaMwr6LifJaV/vvob8j3avxNR0hZs17MsrIjmpmRbj5bJfkYeLJ5Lp+w9z7kSqhZNO9rd2+ilf0G3zjKGzgOnoN2e37WiU07Rfz83N0Jk3XdZRSMc6g7sMsfBcOrw8PukFQ5NKtpBzFXFHMHUfDr3BkH3aImDiX5qB1gr35JpD/AAPEguC4L/1bSC9qyo+FiuxS4nyNypsoSLiIKP8nowzFHeC4jdyRZ2yUdkC87HRRTpLaWKUrb4IuBxUFsHnCo8hlMqD/mtyEneVp6E9/UhxE1x++xl/plg8fortsLMUay6dF0QL+tqMru2vlsdEvNtX
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(36840700001)(40470700004)(46966006)(356005)(36860700001)(2906002)(36756003)(86362001)(41300700001)(82740400003)(7636003)(316002)(70206006)(478600001)(54906003)(70586007)(6666004)(2616005)(1076003)(426003)(47076005)(8676002)(8936002)(5660300002)(4326008)(83380400001)(6636002)(26005)(336012)(110136005)(107886003)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:41:09.2496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592e86f5-789b-479f-9ade-08dc1c2156b1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5104
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_064119_387523_AFA93D09 
X-CRM114-Status: GOOD (  13.00  )
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

A new port configuration was added to set max_queue_size. Clamp user
configuration to RDMA transport limits.

Increase the maximal queue size of RDMA controllers from 128 to 256
(the default size stays 128 same as before).

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/rdma.c | 8 ++++++++
 include/linux/nvme-rdma.h  | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index aaf9c891b2c7..be57446f398b 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1956,6 +1956,14 @@ static int nvmet_rdma_add_port(struct nvmet_port *nport)
 		nport->inline_data_size = NVMET_RDMA_MAX_INLINE_DATA_SIZE;
 	}
 
+	if (nport->max_queue_size < 0) {
+		nport->max_queue_size = NVME_RDMA_DEFAULT_QUEUE_SIZE;
+	} else if (nport->max_queue_size > NVME_RDMA_MAX_QUEUE_SIZE) {
+		pr_warn("max_queue_size %u is too large, reducing to %u\n",
+			nport->max_queue_size, NVME_RDMA_MAX_QUEUE_SIZE);
+		nport->max_queue_size = NVME_RDMA_MAX_QUEUE_SIZE;
+	}
+
 	ret = inet_pton_with_scope(&init_net, af, nport->disc_addr.traddr,
 			nport->disc_addr.trsvcid, &port->addr);
 	if (ret) {
diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index d0b9941911a1..eb2f04d636c8 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -8,8 +8,9 @@
 
 #define NVME_RDMA_IP_PORT		4420
 
-#define NVME_RDMA_MAX_QUEUE_SIZE 128
+#define NVME_RDMA_MAX_QUEUE_SIZE 256
 #define NVME_RDMA_MAX_METADATA_QUEUE_SIZE 128
+#define NVME_RDMA_DEFAULT_QUEUE_SIZE 128
 
 enum nvme_rdma_cm_fmt {
 	NVME_RDMA_CM_FMT_1_0 = 0x0,
-- 
2.18.1


