Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DB5C47DAF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jan 2024 15:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hQLpDbXZOHukKz9lT52VsOaxwW/dvIsU4Y7LxUokH+Q=; b=D+5SdvGbqweI9mslhctUr9CTQj
	0ALM+vos1Wxlkl5RPgXhSP1UJ5QXvTeEAKQDEWRa9PlFxWwyMfgVYakF9gQMYA9MsvKxdG050FCbj
	7neDg662K9Hxi571ZCxGfgsE7QYs+CM7VMJZ7FxkZIY5fIFcmU/bVap5s9wApgqgFqXvixzCy83p5
	H88fX6qARkolKb2Uewf7QCz7fARmmH0L6Pq7opeEqh/9hrAGOPInzV5ZYQv7zXwRPbVtg3TsGE/8h
	lAi36S8VcT6GeFKcnFAd3/o0ePvYA96toh5y/Sy4Z2HDJdSwPDp0LG0YaVYHIlZ3SfV0p3Nro6doK
	LLdFYdQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwJI-00CkJi-0b;
	Mon, 22 Jan 2024 15:34:04 +0000
Received: from mail-bn8nam04on20601.outbound.protection.outlook.com ([2a01:111:f403:2408::601] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rRwJF-00CkID-2L
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jan 2024 15:34:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cctp4FW58/p1rv2PUGkttFgpmWz5v5CQa/5iIpeYKsU6IRTvPJwp/aYymCSsIem4r+A5RiMZ8JFHfHzbM/aK3vwDW8YNDuzNo4ktGnBJa0dX0zRO8xGMN7oO38aE7uFjpW3Lqha6dP2EY70AKZ5DFKpUFlWtYEbpyZOJnsv4NLnPy/BpkjQUo0WJrn8ggksIXlgxkbD69ZKs42XGtspNfJSo9jWbyvBNv9gGxxDu5Cbj9yEs+2UlG9iwOxl71LYnfjN6xMxWfeHPeaUEJK+b8VXi5v9q6T+7mxiWLHUgCj/YMwudjF0JQRIZjdwn+Y0A9zhLc8EhoF89kZ4iiBGjfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQLpDbXZOHukKz9lT52VsOaxwW/dvIsU4Y7LxUokH+Q=;
 b=TJUfCAin3UmCaJ4rl/ISQSn/MzPEi0//mGrFth0Q7+7kMLp0Q3bXbcR2m0PY84GeQh3genp+w/NCawwGAEob99iVm3OZ9iYp+9ZyhbmlJKcdaFa3ckRokwUnNdFlNUPfBAac2SsKkFuQgj9KXQlUXVDvVzT9i5WJ7qJvvUvHaJ4lmxAJFSDEXW94uo4KPx4l0L9xZMp7ypr7OcAOQTIM6DIc/smEo/n0QDOlDUIeHporo5QLyxgXHC80SVUgHA9eAPg/k7KjSHGQS+RsMEXDSpHTPmXBlEDOTeoqiQ6MY2B3Scha7rPlRpQUi4GtLEVUdZ++uGkn1OsYA6jKT4SATA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hQLpDbXZOHukKz9lT52VsOaxwW/dvIsU4Y7LxUokH+Q=;
 b=niQXN1FPtXW4eJUjngjPJId01V6ksRGzE8eukTWHWqk/gMWfP9+9uRCmybD9ud64KC0KAHhTSGW0oKhLzPNdx/7SRCWaRZ+MTwucVxwR/F5l1q/SMoc+oIE66FaNF/shkCDgCDlSC4uI3q1BzRl9egrmRJMYyRBqi/RHt0e2YZlFbP/7VJZkhFITDrZc2Artjpv2rXfP6VnbUy0Nni7fFq20GK/agSIQQmUG3zJQ1mXp9TaZSov1x3Oe9tQXk7ccAJWEgQy6aB0By8Lqs3agx6Vqnm0AjSNF8MDr3sjs3ty9QSdRJQczC7BptnGU4Tf9wBsieKPZ6wc8BKrXwT92UA==
Received: from SA9PR13CA0007.namprd13.prod.outlook.com (2603:10b6:806:21::12)
 by IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 15:33:57 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::ee) by SA9PR13CA0007.outlook.office365.com
 (2603:10b6:806:21::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.16 via Frontend
 Transport; Mon, 22 Jan 2024 15:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.16 via Frontend Transport; Mon, 22 Jan 2024 15:33:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 07:33:44 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 22 Jan
 2024 07:33:44 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Mon, 22 Jan 2024 07:33:42 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <dwagner@suse.de>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, <oevron@nvidia.com>
Subject: [PATCH nvmecli] fabrics: Add disallow_pi param to connect cmd
Date: Mon, 22 Jan 2024 17:33:40 +0200
Message-ID: <20240122153341.20757-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|IA0PR12MB8713:EE_
X-MS-Office365-Filtering-Correlation-Id: 89708b3d-3ac6-4004-6a6f-08dc1b5f8c85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xSLYpPBpsxS1FWhNV+zunfymiYr8QbDwTJ5ejESysEot86MFJ2gZlK9ugj44mZO0UJfrBry++Gq/DQw2WfqcuD/X8/JXB3ZtQjkL1l7loYiQtYsGO+nhoAgOJeqeveVy9nPeRTc6slqCl48y6S70d5jKGVuIVEQEukZBJTvYZJsDnaf/ZtHAIU7mJ/zWLZLMofSfrQivxaIUBctkkg8tuarvQ41MjOfligFiYogQ3r/2RFsWuPKVcLrvwM3dTgNd4VAuYiiBg/066K80BydMVWL7yG+qMUD9+jkLMNdWs91bc20PEqRo4dx0pn7eBiwvNVwkyfY3Cnc8AAzNd6wBt0tvvb0DFUBogyA1ZRewpaD7GrEYwc87DA42EwdbNzwhDdRCXMwAk2ndCFExEoD0w4Lc8RxnoWGsz2yIU96w2oZq/KaNkvpHXDSI6XysAj7Mfc4ikyxlPLDK/10J6epdewUO3tU3Yo/6YLsc+MBgCSMwyCnrgMY8XpneU2YzaJwCucJjuQ9h/3Pu5zDrcEQuMGez9poq3FXTdHtKvpT/EUhbmHylE1O7uuyyqHTx/SoShJIL2BgIC5ukffcTBZxYqRaShE+PUAHLwcE5FTPF4IM57AK19Q8+uTiNedjXKboqr3NOsvuiwO63YaF5bcXjxoEQaYgThqZcoqYmUlhvlPn4K0ysVORPrpR0s4v2AKYkbva0W8ZklDjogU0xSAQqXD6NsgOOsEiShfMl8EVviS6a6ps1Ve4nls1a+f3VR/Z
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(426003)(336012)(2616005)(1076003)(107886003)(26005)(86362001)(7636003)(356005)(36756003)(82740400003)(41300700001)(36860700001)(5660300002)(2906002)(47076005)(8676002)(478600001)(4326008)(54906003)(8936002)(70206006)(70586007)(110136005)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 15:33:57.1758
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89708b3d-3ac6-4004-6a6f-08dc1b5f8c85
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8713
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240122_073401_765385_9882B792 
X-CRM114-Status: GOOD (  10.52  )
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

From: Israel Rukshin <israelr@nvidia.com>

Add 'disallow_pi' to 'connect' command, so users can disallow
metadata offload support to save resources. When using the flag
on devices that support metadata offload, the NVMeOF driver
won't send metadata over the fabric (same behaviour as devices
that doesn't support T10-PI).

Usage examples:
nvme connect --disallow_pi --transport=rdma --traddr=10.0.1.1 --trsvcid=4420 --nqn=test-nvme
nvme connect -p -t rdma -a 10.0.1.1 -s 4420 -n test_nvme

Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Israel Rukshin <israelr@nvidia.com>
---

This patch is complementary to NVMe Kernel series:
"Enforce uniform metadata settings for ns head"

---
 fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index dcae9aea..f3bfe09d 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -84,6 +84,7 @@ static const char *nvmf_disable_sqflow	= "disable controller sq flow control (de
 static const char *nvmf_hdr_digest	= "enable transport protocol header digest (TCP transport)";
 static const char *nvmf_data_digest	= "enable transport protocol data digest (TCP transport)";
 static const char *nvmf_tls		= "enable TLS";
+static const char *nvmf_disallow_pi	= "disallow metadata (T10-PI) offload support";
 static const char *nvmf_config_file	= "Use specified JSON configuration file or 'none' to disable";
 static const char *nvmf_context		= "execution context identification string";
 
@@ -113,6 +114,7 @@ static const char *nvmf_context		= "execution context identification string";
 		OPT_FLAG("hdr-digest",        'g', &c.hdr_digest,         nvmf_hdr_digest),      \
 		OPT_FLAG("data-digest",       'G', &c.data_digest,        nvmf_data_digest),     \
 		OPT_FLAG("tls",                 0, &c.tls,                nvmf_tls),             \
+		OPT_FLAG("disallow_pi",       'p', &c.disallow_pi,        nvmf_disallow_pi),     \
 		__VA_ARGS__,                                                                     \
 		OPT_END()                                                                        \
 	}
-- 
2.18.2


