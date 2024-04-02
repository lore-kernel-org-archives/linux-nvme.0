Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D42ACD1284
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=UVd70LHGhKpZHClJa8xJrrdZcZ0mLz42gh3v+vqWtvg=; b=Zu0YtJqZnyW1aI1bNjHkF3FVLP
	h+hsmz4MOOdlRgylVPk3zEkEo8u3Cf/mF+BmCxO5rxcOZynfTjVWv5NwbYqnzbB7UN88Mh6muCo6A
	Zirp4rcKTsPUE0VqboBvOc9iC5cqTh+RJagnIjjVF1+6J4wUsq5zn+3zgVgBwnFWxW2n37l/yU/3v
	jkd4gmtI0MJ+lnxhnrV2g89UIY5HzG129xxn5l8ocIUpDt3Eivva2ojMPAES2zB26x0wpjviAtd6T
	2+lv9Vuq4LfK6qcmE02btTSudF/ogfAIKhIjimoyMAoTrcQCJHToiSQ9gP1jWf+z80y3dI3Q1fCC7
	9uwnakSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rreGc-0000000BNZB-0AqQ;
	Tue, 02 Apr 2024 13:33:34 +0000
Received: from mail-mw2nam12on20600.outbound.protection.outlook.com ([2a01:111:f403:200a::600] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrd6V-0000000B1Ov-0CU3
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:19:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZj5xx0NyoaBeFDfhxpaDBMzcdTKsJ5aEuHSiuMacoQaMuxf/Nm8CD+CNPt1YMECQv2j4seDIQpbZJ28fBqBfuiw162gcbSzpso+5shAuZgcRTFy1VC3s0KtAc/hNwUpvpoMHHkv/t8cs26FzcvSLAX9SAgGVK+bp8tG3uWgK2JXrIfXTOzflkSl0pX0C6ANJo7fQcuIT4QVlqt8C1P+ZVCQOfcO6TqJxOLBqDRgbOtl665QSwlovg7gK/mAx2iHscmKeJHWkJJaXS5xFzY1GjhGhySjTmN8epGyDNfryWyUZtlUhWFaC9BS5lhsb8Lqrhes4zKcbThK4ksZaaiCSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVd70LHGhKpZHClJa8xJrrdZcZ0mLz42gh3v+vqWtvg=;
 b=hfs7D6PK90KFQOohDg2DK66ldfxFbSJ2VZUy4kxYHc393xDs41zE/EFHSXmuxysEJZ0GTHJb4v++8qnLnAfGDLPUyTboXURw1IBHQ8VGELGoOsAByJSviHmvstORaXi7mlwN2Ttnt56NW5zklywyGntN3TMOGPECgBi4tA3f2K0OvITqHQ8XDgvaGZWfo8DoQ/UFmc5dUM63BukNe//yRKVV2FDxlPW8zNaIpL6isO/LHs/crQDZ7r+erXpAMY8TxpNQDrzp7yTYHpYkim+5d5V2PVHEksaIVtIyaBCyGEz7Gkd1B/ZH7ycg811njimVxYv51Mrlll7xMzTTBstMVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVd70LHGhKpZHClJa8xJrrdZcZ0mLz42gh3v+vqWtvg=;
 b=i9eeiedFuIm8bRZ2j/E+r8gzv797VrTP0RSZ2aEiVhweQA5PwSBzJ953nBF8uuggy6BHraeBvi1jmskD4rjVlYOpi4qvok8+m8pg3J9k5YmH9t6Gf0AnJBwGXdUnof2ZGYhJpfSLBo3oX3/gVKJQaf/mcwmx6+lw6Ic2P9YdXT2jYbGGW1yS03Gxx1S71QJerrgWeiLHWYmCTUEEM3q2wLEhWcdw2823kyDELvkv+bO3WmM1K+q89SEp9eh3TdmXlaOLw0kU2QjUOQqSFivafCR+WeDcrvb+nOdTOHw4dggexqorNl+hR3BhbpdGKhdGfB3XtQipWM86RkTl/VDi7Q==
Received: from MW4P223CA0012.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::17)
 by SJ1PR12MB6266.namprd12.prod.outlook.com (2603:10b6:a03:457::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 12:18:45 +0000
Received: from MWH0EPF000971E2.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::78) by MW4P223CA0012.outlook.office365.com
 (2603:10b6:303:80::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Tue, 2 Apr 2024 12:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MWH0EPF000971E2.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 12:18:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 05:18:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 2 Apr 2024 05:18:30 -0700
Received: from rsws46.mtr.labs.mlnx (10.127.8.11) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Tue, 2 Apr 2024 05:18:28 -0700
From: Israel Rukshin <israelr@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, Linux-nvme
	<linux-nvme@lists.infradead.org>, Sagi Grimberg <sagi@grimberg.me>,
	"Christoph Hellwig" <hch@lst.de>
CC: Israel Rukshin <israelr@nvidia.com>
Subject: [PATCH] fabrics: Fix fast_io_fail_tmo option
Date: Tue, 2 Apr 2024 12:18:12 +0000
Message-ID: <1712060292-11054-1-git-send-email-israelr@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E2:EE_|SJ1PR12MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 23bbb1bf-8152-47d5-bd53-08dc530f0adb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CuBOwWCcDA7ex+hypGf6hAnEk3454thyxIzyL+3au22IjiRML/YMgHATrTbbCrVy7ko8SSOfI2rA41L90iYMRtmpVaeKCsVBGE38TpsRuj+f+IA6dOQLocIryyH99Fz5VzGKwbjbpUBA1kCCRov884HqbtFA5fC99/PZmVooQ1Z6sstavRJjdwRt/d/ScHyVETI4oy0Xv83Qm/xtErf0axo2P9o8KCXPKJmvyEs+HyFvp8NNgWJBZfhG4L31n1P5YxWUkp0Z8G5jUF5VF+Scr3b4bd0TR1lKAut0VL5S5tHjlzRr8ZW1uwxBAoSPoho6M0dPnV0xeBJeTwZX2ba8Ja4QzyGIt7Xyl0td136IrjztZXHUiWhCe/ceaajNuOVd9zl5EguyHVncUIGUCHplZ+uOlQUjn1bi5c60ATnK8qYHTVn5HP1oFsUtm+g4m2MwHbKhQBjZS7H7oiXw0FKroub8o8eAYfhuT5ZVv3BdIBm3lYRnV58OnoTzoUgNaAERBfo9DRU0J6XTfvN9NThzIjv0hwtaZZIvDHqAfUbdeWK+7dxJA+zs06+g0oZAIXyiVptJIzytAbcXSfqQdkTe95C1w8fRhESg6He+r8Y3X9Lpg6QnPp2UFXoEJb0dK6fa1u8qWe3sO+twczIFGZvujDPVFAcHxEMJzCgTW4TOuFHqLhU6NaiIiJjx6JPdPFCDwKXRV61KhYu6d8/evgU1iZu6DPWLaKPyZNV+2ATwOUmrBpPY8XCxFN1uekqK97zG
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 12:18:45.0618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23bbb1bf-8152-47d5-bd53-08dc530f0adb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6266
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_051903_111183_BA8254C9 
X-CRM114-Status: UNSURE (   9.28  )
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

The option was partially removed by a refactoring commit.
Return it back, because it is still supported by the kernel
driver.

Fixes: 18de3a6d61a7 ("Convert to libnvme")
Signed-off-by: Israel Rukshin <israelr@nvidia.com>
---
 fabrics.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fabrics.c b/fabrics.c
index 6b25f74e..14682907 100644
--- a/fabrics.c
+++ b/fabrics.c
@@ -78,6 +78,7 @@ static const char *nvmf_queue_size	= "number of io queue elements to use (defaul
 static const char *nvmf_keep_alive_tmo	= "keep alive timeout period in seconds";
 static const char *nvmf_reconnect_delay	= "reconnect timeout period in seconds";
 static const char *nvmf_ctrl_loss_tmo	= "controller loss timeout period in seconds";
+static const char *nvmf_fast_io_fail_tmo = "fast I/O fail timeout (default off)";
 static const char *nvmf_tos		= "type of service";
 static const char *nvmf_keyring		= "Keyring for TLS key lookup";
 static const char *nvmf_tls_key		= "TLS key to use";
@@ -108,6 +109,7 @@ static const char *nvmf_context		= "execution context identification string";
 		OPT_INT("keep-alive-tmo",     'k', &c.keep_alive_tmo,     nvmf_keep_alive_tmo),  \
 		OPT_INT("reconnect-delay",    'c', &c.reconnect_delay,    nvmf_reconnect_delay), \
 		OPT_INT("ctrl-loss-tmo",      'l', &c.ctrl_loss_tmo,      nvmf_ctrl_loss_tmo),   \
+		OPT_INT("fast_io_fail_tmo",   'F', &c.fast_io_fail_tmo,   nvmf_fast_io_fail_tmo),\
 		OPT_INT("tos",                'T', &c.tos,                nvmf_tos),             \
 		OPT_INT("keyring",              0, &c.keyring,            nvmf_keyring),         \
 		OPT_INT("tls_key",              0, &c.tls_key,            nvmf_tls_key),         \
-- 
2.34.1


