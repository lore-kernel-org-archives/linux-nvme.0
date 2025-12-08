Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F975D3B7E2
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Dec 2025 22:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/+hZdhcmDxEVs5qpHIYHICJcM+9NhN+VIw6oOZg1jcU=; b=X0cOmfBb+jmpxTh3xqMoGJVhRS
	K5B5otT1RnLZkUWym+be51MV15EOU/zNZqMRWATYVAtApIKqmItHRV7gEyk00nKvE6BXAuolxjDx+
	DcRy/CeOuiyF+ZAjFXPMJjK6iqWSdDlJc2cQP5k79Nyoxscu+P+AcJIadiCXtGD1dSqmlRgVOSw/n
	UmAg2Zk/Zm2eb8ACdUchPnL2O8DPqIDFkUxzz0z/vQxfK/95NOgv2i2Gliud8UiziwSC7/HGyE4ph
	mcSyfsnwES7axCX4nSzhvJAJb2nBYZCsypBDCjLK63ZeJYxuw1gmw46UiiHxvztIU9nC1rNJ9qe5U
	WoiCfQpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSjgw-0000000DamK-1pqq;
	Mon, 08 Dec 2025 22:26:50 +0000
Received: from mail-northcentralusazon11010030.outbound.protection.outlook.com ([52.101.193.30] helo=CH1PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vSjgu-0000000Dalw-06A4
	for linux-nvme@lists.infradead.org;
	Mon, 08 Dec 2025 22:26:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R37psQlyw+8wIveIrJFOUzgQQaAqo7X316vSoOHwmRU2i1QgYWbcnV4x8bAnkHONAvgEcsjG3d1jLpsKzk+utgjF4iwCojZOA9ZeAtXV0hK4YJ3xe1mQju97D75CNqu17vxUDsFq+Ja0MypP1kq4Rd23SmbnSaiWm/4bVPq24QmDzffwXFBEu9vYc75u2tWv7mtb8uR+fe3fQfJOQ80PFUP9N7AJiBEZuarcXYK1XBuNr5E5pickgb9OXA14tKdPIB7q1XiSL1Bom7QPqKCTuMjl2zAI0fVBfRipMEG5gRY5lwkcxvIziB5OUtveuZvI8WmAhjmXp8FwAd5JymIYAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+hZdhcmDxEVs5qpHIYHICJcM+9NhN+VIw6oOZg1jcU=;
 b=q3JVlEAHOBhVj36cnBem8KKwaDEonCePAe5vxUG5F1pIlCVtfov0Atp2Yfx/HiRBf0k2RAJ2OVbYjd8wEuZfLgXmNWDYQ1Q8HWYZfUGP+RpFh10Hb4t0Emzi6mEIsmLoWnGPgiug28QHWdblsZqUb/kFR8WZiWmayZq7N18pEuyH8KTU3518b0LxsU/SAuX4xZdkR8JLOWb1Jk1oXWluqJh80IpS4llez5EMhE+am3JRz03v/ui7z/FBqPLSS80bVV6wo+1M+/TPZn9J/3yXFpXhT/nF/oOrm4JMKT/5NkGYNfmwzgxPMxtvWGLnx41vFG/IsfQUWyyahUXOGEIrmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+hZdhcmDxEVs5qpHIYHICJcM+9NhN+VIw6oOZg1jcU=;
 b=Zq1jBhoG3iBi3iI3gsRLgOWkdMk5svLptCX1UK5tkkZI7Giwy5YvrK1h8qjZ8KCQ7SDupOoCwSsXDq/uZm4sSJehvfZpD4SsgY6eb55s4xhHbYtJy6qMp2bXA+v5NOYQXnTzfqBa3K1kajFJCZ5U9uoO94nRAEe3QLaU7pyl+ej8ci06Nqr8wU0hmjoi01rrj90c8vXV+12TjUBtpmYnBo0oZQF1Kuovhn4W8dNl8EIfYwq6ghZbBaQkyjywBFAt3sBMjkCc58rP3e396w8O1ZY7IHmHHCAntYS/VBMUJYIDHaiUzW6au0/z0qszB7sbDifUHYuIbmmYChZ2Q8a17Q==
Received: from DS7PR03CA0157.namprd03.prod.outlook.com (2603:10b6:5:3b2::12)
 by SA3PR12MB8023.namprd12.prod.outlook.com (2603:10b6:806:320::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Mon, 8 Dec
 2025 22:26:38 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:3b2:cafe::d2) by DS7PR03CA0157.outlook.office365.com
 (2603:10b6:5:3b2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Mon,
 8 Dec 2025 22:26:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Mon, 8 Dec 2025 22:26:37 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 14:26:24 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Dec
 2025 14:26:24 -0800
Received: from r-arch-stor07.mtr.nbulabs.nvidia.com (10.127.8.13) by
 mail.nvidia.com (10.129.68.8) with Microsoft SMTP Server id 15.2.2562.20 via
 Frontend Transport; Mon, 8 Dec 2025 14:26:21 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <sagi@grimberg.me>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<hch@lst.de>
CC: <kch@nvidia.com>, <axboe@kernel.dk>, <linux-block@vger.kernel.org>, "Max
 Gurtovoy" <mgurtovoy@nvidia.com>
Subject: [PATCH 1/1] nvme-pci: set virt boundary according to capability
Date: Tue, 9 Dec 2025 00:26:20 +0200
Message-ID: <20251208222620.13882-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|SA3PR12MB8023:EE_
X-MS-Office365-Filtering-Correlation-Id: 6820bacd-c7e9-487a-1cf7-08de36a8da65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?13Bj5ErOJsiMQmmAMWiUJOO1HzcHd/1PbnlSaymh1Oik4PDa5N+vmN0RaDz+?=
 =?us-ascii?Q?EHtlX5wB1qPuPyjXpbOcipVfmekycfMJKm8525AWzKTO7hDfLd/x7Faskqj5?=
 =?us-ascii?Q?Nolnni4rtuVqGWo4fdh5zAZS+J3uiioHvzz14/FDNfGtigK3oUEQeTRk4N/e?=
 =?us-ascii?Q?3Y0S0ShXdwjwgQbCMmhRgU1ukuWc6DdSVu4HVOb3VknRt0l7qkzMZiCGwOt1?=
 =?us-ascii?Q?/Kn0r3jcNDl9od9fDjUadV4E763VTIsjc0xASlkWngUfKG/vCua2Bklu5Wg6?=
 =?us-ascii?Q?Scq/RE1l2VJWlK1T+OPZRqF/4HClQtMIrgtc1Yz1g4wqWaOdFe3a6oFXKRrA?=
 =?us-ascii?Q?4gn3RHQsnuq2goIckOWPsIWcFzGRTHnlxrUpsuyNxvqSD2SCzowdwV+Wof1l?=
 =?us-ascii?Q?vhoB0P3PaqIaxXhUtKUfroyJUSOOOaffFKUenQsDNREYqwV9Y1ahtIEPk8aJ?=
 =?us-ascii?Q?FYbEHEzaGrguhDdZI7TIR1/idFHEQ9FCKYyIxn+GBn6LdGbUZ6/QRNwO3oMH?=
 =?us-ascii?Q?5iUYH0EFAHUJ3vlLZ2EZ+YXPcpfR/hTnc6DjXUFNHhHmUXksfPgH7N038BD7?=
 =?us-ascii?Q?ztCU3kPRxtuvELhv2pOB+mX5ZnOM/qvsisMjkS4O9F27b0E30cEN/CAVkgsN?=
 =?us-ascii?Q?BADKp/VcILbbZHUAMSODwv/ldw1tTWSFatWdyIq6A6zaTlT+wY2oMgf8carE?=
 =?us-ascii?Q?Y51KRIqHhZ4lNjsIDaNnB+uDVQfjD64kEwBt9dokgPi9dubBgMa953ypLacf?=
 =?us-ascii?Q?RslouOC3BuhUXG0XlDndRPvIckV+d17J//FeZ9pirjKS8YBS8bpchunMahLF?=
 =?us-ascii?Q?HqOBzYQ2B2cOc2ueJrGIwkUMuXYIh47UNkpfOxShgMe/iQU95dbuCePzhFgd?=
 =?us-ascii?Q?Ybd6uZKdPwUputEdnuqjGMmGmAJnmJZZVp44SFLhfTd1dTXsGLMj8tYiRuHn?=
 =?us-ascii?Q?GeewlKg6t/Cc93i21FxTPngzZm3zAVLvzx5IC9ul9ZgZbkQGhTkWf5tmXdp8?=
 =?us-ascii?Q?DZH4WDWdHP95AqDUly03lrDHC4oPdAd4F/bjVfEWt9+ew9+c2qgGA2ox3MlJ?=
 =?us-ascii?Q?A/NxVshMcgiqTX4H2Ynw0ZjJugxcUQK03zHO90WoSaOt47gsJEB0Pw5GB8VF?=
 =?us-ascii?Q?E1TKVBa/q922kroNGvfKyC+5WNAFPRNIBjH41nZ9A8fPN2rf+75IwQPyraPc?=
 =?us-ascii?Q?onebyVrxI+YUZcHb2ch8tGfi9yMIkrZv0PI/p2Qq97QJHKAEHQy5OcFtuTrh?=
 =?us-ascii?Q?UnxTkQ25/KsCoQYsXVSMLv9xT5dUsNajqmE8TYOE4HhAmjEsAnBwLtk366/a?=
 =?us-ascii?Q?g4xm2cUpyYw3rJjYvSfgYH3usOeoIn1fkk69XD996mrzsJimXt3iTqw4tP1n?=
 =?us-ascii?Q?e5QlHpgdSasCW5zWHZ/eReXlj9YYX9GeFcIBPpxsxBQqXsjqfsJRRAf/ljO5?=
 =?us-ascii?Q?eVIu2flaOOXvWM5VDW6z0+wODrDBxKdF/z4xmzK0SJXBZPbvILoX9JRbutQB?=
 =?us-ascii?Q?S8E2f3Uix5Y4vKiVxtk1XUyYIkKMHt3KuhpuYzQn/Q/mCK5BIOdgxDP/0Xgm?=
 =?us-ascii?Q?1rF/Par00PUwEfDY3qM=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2025 22:26:37.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6820bacd-c7e9-487a-1cf7-08de36a8da65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8023
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251208_142648_066980_7EBBD5EF 
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

Some controllers advertise DWORD alignment for SGLs, so configure the
virtual boundary correctly for those devices.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e5ca8301bb8b..eacc89cd25eb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3326,7 +3326,9 @@ static unsigned long nvme_pci_get_virt_boundary(struct nvme_ctrl *ctrl,
 {
 	if (!nvme_ctrl_sgl_supported(ctrl) || is_admin)
 		return NVME_CTRL_PAGE_SIZE - 1;
-	return 0;
+	else if (ctrl->sgls & NVME_CTRL_SGLS_BYTE_ALIGNED)
+		return 0;
+	return 3;
 }
 
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
-- 
2.43.5


