Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCACC6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=54XLh/eNbkG9jTuSv5nrGwpJ4G73Ejmk6YOhPGl7/28=; b=Ahs3U8LbVtOHyxi0uccs0xIxo8
	zvFxl2axywZUUy3molQlOUOJ1cDccC6QgfhzrDWoQh3WWLkhKR+8sfVdBTeF73AdKBwEdZNXeu+qG
	jgUEZAAHOERVzA9/XcoH0bLHbQ7WCrwen5Rsa2apB09+JU2/uRlE1Kt38goxReKPCKpnCQyKjNBNb
	TKFLfJ/RKdZIxcjx0oM3wXkW/n3paN14M3NYZdeNpgnrOscItjkaDx8sZhQ2E5BevnkTjczqDYTuA
	ogJzvlzYNuqZ0NzOumQ/LdnZVucxVP4dEBHE04/7B6ZOrO2BRLh/CJ9vMRBNE+uw1iuZ49XXGSs4G
	wfTmNIMw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlR-000dwk-2h;
	Thu, 23 Mar 2023 03:37:21 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlO-000dvY-2s
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cp5jreue26P3TLx+a0j9FS+MlKcvwkTW2GSIpFzC3lw7rv/dtLXbg59prmFqUbWwSbko1adR4dya4JQAUJeWcPwNg+HDs6ElVMaerQ/gdM52fwJ9HJCeLoylK4Q5lXjCuETTarYCPd+aNeqKAavBtBMZHlrrMcCSbFneSopWYmOPAv6aLOoAQABQxNVFqpJP43u8VNYvLuJxGNAXMFsNY0TCVD30MIznmue3PW5LeVHuj+vEuuZUVWTjqwFbjajLrIrjY9qBfmOjgogBY6vYsLCm3RJr3tnPgF0I4l4tjcybF3OOnUvp9MT+5jtxJGBOt7NTkpHDp5NLGlIpoweT6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54XLh/eNbkG9jTuSv5nrGwpJ4G73Ejmk6YOhPGl7/28=;
 b=Qm5zG2VlKAP4IFIL+dQVm4/Ok/6yBzCyu5xAL1SItwkNKBuwNnH9eODEqrXEyw6AtpCNXOoxONpCvp41cUVSeBfwMQ/8/sW7RahUOlO+qqHM2GuXe5LR7N9XqE+WnCTzm/rVxAP5tfj3/SvfiH1+INkBPt8wwR2SaF9JC1QsasRWi+pCoXv8EJ4alh060ACpXYgiJNqrzvahnk60lAVurKM3pU0ZKtchX4m/rFP8pXcoaOSaxVod6y2Tsn+IMq1zK7PV7AeQfN7EXkjdJApJrcP/oqxRgbrI90MmK/de67qs++R3iWysmpAAUwRYX+eNmCEG9fguG2IMtLF6+pFSIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54XLh/eNbkG9jTuSv5nrGwpJ4G73Ejmk6YOhPGl7/28=;
 b=JflJRjqXeHvOzqJjiWA8ET4/UEsmU0tJ4281zVOgBLif/FaEQlOs+WzR8h3VBNu3TD0BmE75C3V/vOH7BuOQOh/hjiZL+a7o413y1N8QhyTflEPmXIw3WvEhJfYxOvRAGgxirIKR6O99D86HQ9ZHpklPy6Tkejvrc9h4u2lTCavec5vHtaPws5BDE3tjaA0PRIQL7o9S8GZDi/o9qfhsGbWhQ6OgyRucLF7LG42acxXveH5ofeoamFptFYPGSLufYvKTdZ1gQ7A2hLJOwL3Z/0qWtRYnK6UlJ+eEx5N4KZB3AmbRX19Dy9hwgZKtPo0trdR7rJnNuuxfoVWJf+YVHA==
Received: from BN9PR03CA0810.namprd03.prod.outlook.com (2603:10b6:408:13f::35)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 03:37:11 +0000
Received: from BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::a6) by BN9PR03CA0810.outlook.office365.com
 (2603:10b6:408:13f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 03:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT063.mail.protection.outlook.com (10.13.177.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 03:37:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:36:55 -0700
Received: from zion.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:36:54 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 1/9] nvme-core: use uint type for shutdown timeout
Date: Wed, 22 Mar 2023 20:36:28 -0700
Message-ID: <20230323033636.812758-2-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230323033636.812758-1-kch@nvidia.com>
References: <20230323033636.812758-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT063:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: 11561df6-d98b-4bf8-c82b-08db2b4fe27e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	YVK8KigbzegSiJm/16E2kxakuAQc/XeaI/kv4xmImoua6SUxTXY2U195+/fngmxZ1L0a2IoIUw9CcQd0uxICXtmXPJYxFHOcz7ddDbsI0Xaqunj1i6UC0JqkPsTSsqIt8L1PTYEXhSPBi1XjcXNWlrJVnWvjL9CGzJ210Kb79egUVbvrb+EDKHJ9R3Njv6HDhGnXUdS7mdFcT5Ume/KuxjeYEeFyHpBUs3pBGcWwW7V4Zuivz78w+bmDJ8k/70wzjwjBjFhVd+2ddaLdaCbQPp97MwdIhIEOqzdikFPNVij5mAo3l5uMV6bgO8K3Yxa3XR/RuqLc4PUuU8LYus0lCyaUa+7Pgm8txbahykLuCaQpXI7bAkh2lbGXcGKMAQ35bDLvVmNNyt3MMX1BPVMMbYWmoj6+3Sgbnazh0nwxsaOs0s8vggUjzIMhWPxtx4YUABiRMg6JZD0QDfVWmXG1VNG2S3mkbyuvTvw9HxE7XITenMNKkICPGJar2FW8SVhxyPvOOUpwrD640ySnSIQgZZw+bQI+ooHeuOnr0kkOfV+WwALwnO2eWP4Hg5O4gQvXitEHo0WMFbJufqs0HyzFqnTC14vQ2vyzhzZlZxKOLIrp3KvnvjQTFx+8M3GL1EiYdoGbotY3+PfplqLsQdCRUDl+5OOPzgzNy1XYgGss52rvRS6kebt/pBU7Xuc8Mzdz0osvyTK0ADOahemyiDvEtPEP2rQAWdfhwiU48bhss1766sUpNPPSJ43meFe41ZW6
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(376002)(39860400002)(396003)(451199018)(46966006)(40470700004)(36840700001)(478600001)(54906003)(47076005)(82310400005)(2616005)(426003)(83380400001)(2906002)(8676002)(36860700001)(40460700003)(336012)(356005)(5660300002)(82740400003)(7636003)(70206006)(70586007)(41300700001)(4326008)(36756003)(6916009)(8936002)(6666004)(107886003)(1076003)(40480700001)(26005)(7696005)(186003)(16526019)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:37:10.3240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11561df6-d98b-4bf8-c82b-08db2b4fe27e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203718_931636_F9114D71 
X-CRM114-Status: GOOD (  11.43  )
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

Use consistent type unsigned int for shutdown_timeout that matches
other timeout types. Also, use this oppurtunity to print default
timeout values in the module parameter description that saves a trip
to source code.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d4be525f8100..c9636be68d74 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -43,17 +43,17 @@ struct nvme_ns_info {
 
 unsigned int admin_timeout = 60;
 module_param(admin_timeout, uint, 0644);
-MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
+MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands, default:60");
 EXPORT_SYMBOL_GPL(admin_timeout);
 
 unsigned int nvme_io_timeout = 30;
 module_param_named(io_timeout, nvme_io_timeout, uint, 0644);
-MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
+MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O, default:30");
 EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
-static unsigned char shutdown_timeout = 5;
-module_param(shutdown_timeout, byte, 0644);
-MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
+static unsigned int shutdown_timeout = 5;
+module_param(shutdown_timeout, uint, 0644);
+MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown default:5");
 
 static u8 nvme_max_retries = 5;
 module_param_named(max_retries, nvme_max_retries, byte, 0644);
-- 
2.29.0


