Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D3FE77197
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Jan 2025 06:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PlWh73q6hal69XahjQwRBfanR2LpGQXvXu08Pc+sO/E=; b=Mr3VAt0Swo2Ye6x3qeP4q9bTN6
	J6B3XdkUjczxvGwv+61yyDLRutFXK+vnPF/F/dEwlO0mus/1cwI4dNm+AYdz4TQJRIOSDPWbv+MPM
	6jWyTdqWH8QHgW8yWIpm35Ao+tV2TK2mK6UrTOWVKhvmjJS5CpNM1djuI4SWXxFe9p2BYsrnVNnEy
	Df4AA1/3MKhmVYcHobqdm13CqIHqCXzpiWAqBB5SSDQWlV4BGw7jqSzA/dR+q77xWjyYzjkfz2gMG
	7/jfAJhVGkYbuzEivFz3yfHMnw7In04j+FfhItl+aLbsRF4nllqsUmmpXHU69cAKDnrxS/Uhm5Hxh
	Epu5o3Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVm57-0000000AvtX-11DE;
	Thu, 09 Jan 2025 06:31:49 +0000
Received: from mail-dm6nam12on2060d.outbound.protection.outlook.com ([2a01:111:f403:2417::60d] helo=NAM12-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVm53-0000000AvrF-3H0a
	for linux-nvme@lists.infradead.org;
	Thu, 09 Jan 2025 06:31:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RUz9DWFVCIwSO+osireHKEdbobWbOB4F1VSXzRzzyQJgv6T6kkuToZZormtEHH4XC2j7WM3hJd7yVbCMJj1eqTN2D5/H0IVTwSWYTboFgDdc9Vt5lprAOEbdjPq8QR8OCxfINiXCMYproqDiWKhcez/2LsT0HaAqr3ZmHWTJNm6BNjltrpfMHTXuMM8ED7Ndt7lXwhx405PVIbzlL0Wrc8gplmWCdeh9eFL/t6wewqS4PsvbNAHEsLFuud0LIb1tLX9S8FR8gmmNwNpNj3pVY8mbcrLJfyQeux4XTzVEu2HhgYfc5zFbw+pK5NNZeFZODt7+Xh8AC7emjZqlqFOV0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PlWh73q6hal69XahjQwRBfanR2LpGQXvXu08Pc+sO/E=;
 b=OM6FtNeAQH0fuhOjEWLwVyVI3K2GXS0yuQkpHBZXRAS0o4yMSNUUWTcaTSsVg1zPhXmH19YQWVVNQkJcNuEaKCmx+WNg2sR3ir1CCoBVsOrvi3XXSTXedIJ9zLNKMGRRImPlS3H8Twbe3Y+SJkXFZ0ZWtbdCIIoIwqXFbmP23rBJRdQoLgiYYTLktJxCI1pIDqFFd6lxkHQ5MLUIwSbuaJRNcR79oEctCEq/ZbY1RvW1xZtiVleFLdIhJVcSRSmn18Ekg5apjt/7HzTSiGXg+6sShdL/QF1kfVtUfm2fFck3WAYzk+ObqZQKz6hbmkokJb+g66OFpKm1qJ14EuRoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PlWh73q6hal69XahjQwRBfanR2LpGQXvXu08Pc+sO/E=;
 b=I20KCpASlX77l+MOf7IoTAcuWs48b73keg36FxrM9JYYmErdivK99vFzUyVAV8H06cxzfu5+0tY0+8e3nAZ4JaAezD8a2oR41ppZ/D7ed1DBYXaTRXrVwstQ9hA1ZE0aJU0Es8GIngjBC3+ZCbQUmxlTJf0NNaUEy/hNIHLUKGx6JHqa8168LPxWhvRgm2gYH3h4f1ZAkIubaURXH7juVZsrDCDUQ2E8Jo38zywDsKG43ayRl1klFoNV3r+V5rTgLpgPNwr8vQAM5AptPnc2uN0NYbIqAMMMClch7qkrxr/kmbQ1sgk4cEXkxeNE/P007hOeP+6i9HX0dr60DtPrhA==
Received: from DM6PR11CA0025.namprd11.prod.outlook.com (2603:10b6:5:190::38)
 by LV2PR12MB6015.namprd12.prod.outlook.com (2603:10b6:408:14f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 06:31:39 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::3e) by DM6PR11CA0025.outlook.office365.com
 (2603:10b6:5:190::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Thu,
 9 Jan 2025 06:31:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 06:31:38 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 22:31:19 -0800
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 8 Jan 2025
 22:31:18 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH 2/2] nvme-tcp: remove unused variable
Date: Wed, 8 Jan 2025 22:30:43 -0800
Message-ID: <20250109063043.95996-2-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20250109063043.95996-1-kch@nvidia.com>
References: <20250109063043.95996-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: 39bc647f-dd88-4c23-b5cf-08dd30774596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1/WxE54xGf76TvoJN60QphvT3h60776ZtJSHyDeHa5bmoKFET3vOB7Z3/dPX?=
 =?us-ascii?Q?0Q00lc2qzVOgTeGG01i2B+it0hXhK4MxJJZwASzkv2WV4Qcley/SUS32U+CW?=
 =?us-ascii?Q?s2KWQKsx6jIuEq0DqdMdOPJ//Yw/tAszrmEuXQtR7uQ2LHt1Mob/zVsJ7XGg?=
 =?us-ascii?Q?ZLPfLiDRFLKE/fD95iAYMZ9NZDjN/fvQmo6kmcojiOkelVrNRepYYiKhGuek?=
 =?us-ascii?Q?FR6YDeu2UnuB1wKZTzZyFAEb1zNJZHHvwdPWd1kA/umO5WgM0OT0y/W4DHjD?=
 =?us-ascii?Q?8I+uOMSxh0EiDqYL/LCT4vzvYPWGgkgWe5E/+phZ04LZSw6IjYsT8l72eNQx?=
 =?us-ascii?Q?QPTeJYEHGZ1RET7Zl8WF9JXrU8Ce00BL7Z/ZGxSViKUtj+UPZSknG2RWqwYi?=
 =?us-ascii?Q?1d+TuDLk2HirTJyWsGtepMxB+GmsEUn1cNERmWgwGaSPvfgkOwrY0EZ/RX7x?=
 =?us-ascii?Q?rdr2d7pVZfHbBMjmNB8jwO9JgC3/MelSuuB11UQuSDfrP5IiuDUIcXDZ1QF4?=
 =?us-ascii?Q?mM0yKOLJlTpOXVZhxk0FMxUKzxs3tmWfMyvpiooaIj6PNRFEtTX5rtfnYXEt?=
 =?us-ascii?Q?hC61QHZiMwhJUXwzylzmJDoI58ltyjV+2lcGaZbzRCiRfCfbG135PCmcgLut?=
 =?us-ascii?Q?6EmYrfHpz5kJ0LvtVHDW2aTzCPdALVDuZGlHrNwH1FVO2r3WgHrhMqjIlm1/?=
 =?us-ascii?Q?nvZhrA+JJqoL7531rE8Sz4k6ubTm3OEfeBuAZRwV9EW/yXOJB4fvR6dOjWAs?=
 =?us-ascii?Q?RuJqsxeEGVu7QvlcmApj0e5d1LUDenZXAkGL6OCZg4LFg6rvPajyozpXZ58J?=
 =?us-ascii?Q?a8JNeLfxCou7JNR4kdp3b9iPGy4LCgOfceB1pw+9uRopyEBTkuDUe93mmV7Y?=
 =?us-ascii?Q?MUCaI8VCymBusHEPICrRXA57+KWjR9y8jpVCOC/wLcFO43pJ+VZcWvwzlg2Q?=
 =?us-ascii?Q?HJ42LppqWOnPKlvhnZIlBqFEKs/Pt1XdSY/X3gOQU7xFz/os0474XntmRTJv?=
 =?us-ascii?Q?VJ/sNQzsh+QEXpOTnUtCCwe8H6NCPoYWCr+vBMxoNy3xbSZt4xPx/3yxoKdF?=
 =?us-ascii?Q?2BgNPiOdhGiAr8JlJn8km3N9mDBo+tX6rzSE2OxTxl/M7N7eQb4Hme9Fi99B?=
 =?us-ascii?Q?WYzMjxur5zZumC6nkCT170pPUfI0u81wYDVeS/fCKinojnSFDH54Wc7TrH0x?=
 =?us-ascii?Q?MogoaYvageg5clCNi/W8OHkSMVcaTXu/wAoN3/SzcbszTYjIQ7MGfIUnMQEs?=
 =?us-ascii?Q?nTTdv2qUDHJd6kjwRmFbg3EvgR1St3dZPes/fOB6Wv4qESmAawYSKyNXaQZN?=
 =?us-ascii?Q?X1+80O6gjtkwyKR0s25ibtpzA+dEcoBldqlpLcDuOgHQ04XS5NQCPqGua74e?=
 =?us-ascii?Q?Dn+cE4G1+cqPaoOY4R53CyfpWrOADlKFSRrckywkeUVpm7fM8yfC3YWQQTGi?=
 =?us-ascii?Q?WZNUNNX6XS+1y8sbdUu5mZLYBYS8BJXxGlc/cvQKWaZXSxDTdYXF/OvqQF0D?=
 =?us-ascii?Q?9scYPD4MfKeMBXk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 06:31:38.1818
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39bc647f-dd88-4c23-b5cf-08dd30774596
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_223145_822669_16CACE36 
X-CRM114-Status: GOOD (  11.45  )
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

The variable n declared in nvme_tcp_set_queue_io_cpu() was used in the
original calculation when tcp target was created.

With addtion of commit bd0f5c103101 ("nvme-tcp: Fix I/O queue cpu
spreading for multiple controllers") now all the calculation is based
on io_cpu and mq_map local variable is n is not, resulting in the
kernel test robot warning :-
drivers/nvme/host/tcp.c:1583:18: warning: variable 'n' set but not used [-Wunused-but-set-variable]

Remove the local variable and respective calculations.

Fixes: bd0f5c103101 ("nvme-tcp: Fix I/O queue cpu spreading for multiple controllers")  
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202501090934.Dhw69M6j-lkp@intel.com/
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/tcp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a40b7dba73..e9ff6babc540 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1579,22 +1579,18 @@ static void nvme_tcp_set_queue_io_cpu(struct nvme_tcp_queue *queue)
 	struct blk_mq_tag_set *set = &ctrl->tag_set;
 	int qid = nvme_tcp_queue_id(queue) - 1;
 	unsigned int *mq_map = NULL;
-	int cpu, n = 0, min_queues = INT_MAX, io_cpu;
+	int cpu, min_queues = INT_MAX, io_cpu;
 
 	if (wq_unbound)
 		goto out;
 
-	if (nvme_tcp_default_queue(queue)) {
+	if (nvme_tcp_default_queue(queue))
 		mq_map = set->map[HCTX_TYPE_DEFAULT].mq_map;
-		n = qid;
-	} else if (nvme_tcp_read_queue(queue)) {
+	else if (nvme_tcp_read_queue(queue))
 		mq_map = set->map[HCTX_TYPE_READ].mq_map;
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else if (nvme_tcp_poll_queue(queue)) {
+	else if (nvme_tcp_poll_queue(queue))
 		mq_map = set->map[HCTX_TYPE_POLL].mq_map;
-		n = qid - ctrl->io_queues[HCTX_TYPE_DEFAULT] -
-				ctrl->io_queues[HCTX_TYPE_READ];
-	}
+
 	if (WARN_ON(!mq_map))
 		goto out;
 
-- 
2.40.0


