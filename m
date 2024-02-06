Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 314C1C48260
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Feb 2024 00:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0T+4n/Y1nEjj/Sf9Zb21jN/3DOKKALC3qaf00pt/eHQ=; b=P7wPEZlj1/Xd3O07IieR4n5yKb
	y/lEEDP7xBxAgeqH1D2N7bI6JsIpZ7lcWOT2EwFcK/Ct/ncLLdJ4ndv9TMv9qVtOOU631695TMSPD
	gMq5R5iE9B08JoIoDotuVYql6MjgiRC9e1FmOZjQsiXVqZnIZFwCgXC79E95ovTsl8HZulmQxoaXJ
	7v4imfRTORYisYPywQl1pFhzjCtGwMOIUocmnOMTa38I7649p6RyWkK5y5q47tXF96AwDhI3h121B
	0ox2ltUGmByM/794dUywVOR5G+cv5OlF9pWJbaWC7yNc02vCL7SB9fKHwyh6MlKYuizvI9v2EsBOf
	MjjUNXmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX9JF-00000005dVe-2aKV;
	Tue, 06 Feb 2024 00:27:33 +0000
Received: from mail-dm6nam11on20619.outbound.protection.outlook.com ([2a01:111:f400:7eaa::619] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rX9JD-00000005dV4-1Iut
	for linux-nvme@lists.infradead.org;
	Tue, 06 Feb 2024 00:27:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ahlWyYmcaJOJZee8QUarW8fnqJK6JXQVm0nJxPaKOaFpl9gqRoZWgKOZQR9CXg9aOtUTMJGLIqSCJmek6DN1MFMx2gn/LZ0TzJjV/ZVZNmr5Q0aU55PWyrV68oIpKBcDSTIdclJbg26IrxYxF0Vdffx/Q3sStJNJuRgTOsIWU69Lg6+OwAqeR15/ngRkNwCwN4OEVhlyNwlwR15B7JPiydJzXXSF7iwv2gGYziVUmTx2++BVKAErbM2DEGF4IcOCLUKMTh0IKY43bfA1u+kh7jYUmhkg09m/nSHzlkTfMT9c1IR149sVwdVQHwV2hD+I2CxhmMLzymjbC+5y+HZ5xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T+4n/Y1nEjj/Sf9Zb21jN/3DOKKALC3qaf00pt/eHQ=;
 b=at90Be7crQ8I85lZ6/lQHMPfF2cUKVN0+Kim0K0GVg0gzL2UAsKe3ZVnEy3blYbZUNj1KO2KRUkGRy+fx0+4A3zftTm1VwoAFXqgO3jMD1MqTZs6KY+6vX0T+EQ6SVr6mLTL44HK8oCYiks2trpdqL79Ux3SCDeg/mHIH6zUQEXDdVY9Kw6Evl5x8BX6WzTVdGUG38mY3ECbreg3poEL85+pz9MZPAxeoLujFLIXri/+fLi/Coita8taruklwL1/bV+RFLCtf4bOPhf1OEUg1JwhkYB7IiVTnxvjt3t0FAoS3aTkW3hh/fvNBLzpZAygKOn+17A8ux1hDhI48mQZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T+4n/Y1nEjj/Sf9Zb21jN/3DOKKALC3qaf00pt/eHQ=;
 b=hmyyb83eDj88+jiAVMeN8Mb04HGuuYLD3L2NdziwFYegqQoYRqqWUJ5usYa7Yw8og7fzntIkc0Zkgmwf/y+HS1cGnRwK6iEVZPnFIOTb3WVLdfJdA1navBmLVR/qWeEFTkZZnSSkCXWZxUJYVYvQPskh42Kaa3FgBlVetw2rjvJIp+lMYoWIARiQJglKHJNqmZZRGQrcV6/PLBuCZR1PlFbfPHBJwidQynt5qbkXmfwIyb4/Lf/HEZ3iTplsaCNtNGLe08N/vq5pf5p7wvXnKtx8C3a1xpF2voNqMwS7aPZCINHDjOl/aXdzee2ll/CWdZ/L1Dt4f96XBryKtf+Ieg==
Received: from BN0PR04CA0122.namprd04.prod.outlook.com (2603:10b6:408:ed::7)
 by BY5PR12MB5013.namprd12.prod.outlook.com (2603:10b6:a03:1dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 00:27:21 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:ed:cafe::8) by BN0PR04CA0122.outlook.office365.com
 (2603:10b6:408:ed::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 00:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 00:27:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 5 Feb 2024
 16:27:10 -0800
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 5 Feb
 2024 16:27:10 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <alan.adamson@oracle.com>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2] nvme-common: add module description
Date: Mon, 5 Feb 2024 16:26:54 -0800
Message-ID: <20240206002654.5514-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|BY5PR12MB5013:EE_
X-MS-Office365-Filtering-Correlation-Id: f9b80866-5189-4eac-cd52-08dc26aa6233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LwTv5PXNy3ETVPNIk/23oP/UAhiknGPGEqTS6sruwiwOq+YqNxMy5YyBEgDPRTVyKc/QR74b9YdixgFqhWklWFWuEgoRK06XtdJaJMAvDH+TqYek+DqPsFVz2zzHjnu1uqgwhg1u/hkkxbigL0AB1266MzOTrIWx90xBgo/07R6leAC0qMYSgWRoMoXyzWJ6WGQJyNIpQ8gO7LmQjlSMr0ydUZFu4sM5cZGv77RSwTsN0P0tq4HZoykcEJLX4A6z35L9+WMAn0t1/Wm5kBt2VN4xY8/hEZU5h98WjI47Z35vujaVrt2CUtn4ve2EIaoM+IqJU66AaMTwgdGP82ZBbhJo5IUoRL+yvdz0SGsivtCQs9r4rk1UsRMcfgJnlrUdEmXZ4wrYhB4pSDjlOnruT88fs4FJJb+JzkkhWGrrccLwCpc9J/J9tmMDNAWZIasJYSrjs0xF7SnlmQ8ZkG/2PwqKkhwHF/B4vbR08kAM3+iWuN6n2SrvLyYona2XAWgW4TB3YVJgQACQOVKQoq5UPlAb7nTUPtVyNRYuuW1GXAoDAw0GhkiIm7Ge3bYeKFFMhFeLJazzacvJr6z9+5oJR8cjji0TvSWkUJmeT8MWbJvPJBAcA8qVA1oyD1h6quz98BHMU7n17UGmykTLfbKNDo/P2shqHMXintVKG21kfAzb8dcqbZ4yrg4YZi1DH0uxzmKsnILnev55zka5JUvdYFsErYoKtJSQXz7h2+7drY9E3dnh9huDNONfzzIkvsAC
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(230273577357003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(40470700004)(36840700001)(46966006)(40480700001)(40460700003)(41300700001)(36756003)(7636003)(1076003)(336012)(478600001)(2616005)(356005)(82740400003)(47076005)(83380400001)(107886003)(16526019)(26005)(5660300002)(2906002)(54906003)(70206006)(4326008)(316002)(6916009)(6666004)(426003)(70586007)(36860700001)(8936002)(7696005)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 00:27:21.1750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9b80866-5189-4eac-cd52-08dc26aa6233
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB5013
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240205_162731_387037_617CBEF6 
X-CRM114-Status: UNSURE (   8.49  )
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

Add MODULE_DESCRIPTION() in order to remove warnings & get clean build:-

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/common/nvme-auth.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/nvme/common/nvme-keyring.o

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---

V2:-

Remove TLS from module description string for keyring.c (Sagi).

 drivers/nvme/common/auth.c    | 1 +
 drivers/nvme/common/keyring.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/nvme/common/auth.c b/drivers/nvme/common/auth.c
index a23ab5c968b9..b707e6b7d263 100644
--- a/drivers/nvme/common/auth.c
+++ b/drivers/nvme/common/auth.c
@@ -471,4 +471,5 @@ int nvme_auth_generate_key(u8 *secret, struct nvme_dhchap_key **ret_key)
 }
 EXPORT_SYMBOL_GPL(nvme_auth_generate_key);
 
+MODULE_DESCRIPTION("NVMe Authentication framework");
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index a5c0431c101c..394c3948e339 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -181,5 +181,6 @@ static void __exit nvme_keyring_exit(void)
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Hannes Reinecke <hare@suse.de>");
+MODULE_DESCRIPTION("NVMe Keyring implementation");
 module_init(nvme_keyring_init);
 module_exit(nvme_keyring_exit);
-- 
2.40.0


