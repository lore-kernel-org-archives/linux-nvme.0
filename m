Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF73EC48260
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PZeBIETNXkI02A01VVcyNjChHVkH0qbzR6QQbptXd7A=; b=FnxCUdkB9rHrwOzyOIFxPQXLrI
	iDyQWDtps3MX27BQo36jSw6NHgvBW2sM/CMrMTc8yaz19qCbu4P6g6MXFXNF0U2lfAffqMBw1XqeG
	O3zNXIoB1JzJN1bsZpC33qoNBgAqHlnCrF3ZC2/Mi2myOmM9uHM+HWeOVwou18bGua2j/aswxNNmO
	gdQDUi/Q6u4aWG+jyjfQCJpfGaZaMHNuOZ0uEMxkjFQGjhINvVvEHi2ek0vO7W7A155Wg50O/Vjqf
	tQXIVX6CVytZnB2M8NhcpRiqTTt3Gj2Kr866Aw23MMahFXjykv0jruXG8NZF9Ll0ESV7gJmt6z4i2
	oOWkmGZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxS-00Gqo3-2l;
	Tue, 23 Jan 2024 14:40:58 +0000
Received: from mail-dm6nam11on20608.outbound.protection.outlook.com ([2a01:111:f400:7eaa::608] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHxQ-00Gqmh-00
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:40:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Van4gsObLYSTBjEnKe63TTPMfybup8MpSayXUQ3tP5oCLrAcCtRtgz0LXHRfKbRkCMK5m7sdnsPTaYejSmGDWTQg1JOV6kNkxKYBkRxEv+kwyAy2HokNlRI2F28wKDrizIDV2KNNl0gXlyZwN0svD18VzFgg9FQkLYR9G+PUIanDN2B4Bc3iIkChp9F24eYITZ9anaCCJqDEPGtyGVyqUjoSkKXcznfsBN7OSui7m7tf7l56nx4jeFBmXLu/GI23RtOWXYAbwdlzOe9G663tWiklfv+aywn5u59yEeQzXQQhrkYjK1l4Nzw0qkcMeAl/lQFdpXAayzUDXV44Lt2HVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZeBIETNXkI02A01VVcyNjChHVkH0qbzR6QQbptXd7A=;
 b=iwp5IkL98LqBN8PYnZ+YOGC4y+qIcvKCdto3EeDkXm+1NqMMbsxsK446S5CY6fvgts9azbPm9fwY8ly6/fe7esxLWNjIChhrNNmuLhCrgvxLm8eyFiyKFnItEouh+KBdc512oVgV6NPVgwnJxvVfFvRRQm4i00h7sDLaB/iVEyr7CHcMom27HXanBrBohBv1JauFZyezcpdpE1puZmFvFjIzNypLoPTIDpYZRVZBt6I10mTO1Bifd7nIryFt5fkSelFUr/x/FmwLmZKi0r52fkRWj6OxixRacMaU/rUKW8Ag4qASOAlqbngdHCZaRy6o40S3GYtFLlvIteF9WE5SuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZeBIETNXkI02A01VVcyNjChHVkH0qbzR6QQbptXd7A=;
 b=e82q9rOEUGtN7keHn/+jVtFaE76yCIkYpFAH4/0DZwMS0TzNNvEG8S6Uiz3Gr43lYOIei+BiB/c1174s9S8ksN2bHw6glZOHbfmI0Iy9txC7gHHrn5VZB+SxnU2xHBbzR8Y/WCIQrN2cdMHKJFAhb8tAdFrShKs0FV6ooPU2wQX1ygmbX9AJ5Slz12TXwnMcTOeiadeyydtZV1trgyxR3BJmiyJmN5Kk7R6py2ZedjVC9GGzOSD++A3bumoZ6qaJvgj83FD5vnP1MS4h/qifKm05gvFGqy8FdXtm2xl36gl1JH/WXkoqIfwSShdS7xUmQEH4gNNlMEozZu/Y8u35hA==
Received: from MN2PR05CA0052.namprd05.prod.outlook.com (2603:10b6:208:236::21)
 by CH0PR12MB5188.namprd12.prod.outlook.com (2603:10b6:610:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Tue, 23 Jan
 2024 14:40:48 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::32) by MN2PR05CA0052.outlook.office365.com
 (2603:10b6:208:236::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.19 via Frontend
 Transport; Tue, 23 Jan 2024 14:40:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.14 via Frontend Transport; Tue, 23 Jan 2024 14:40:48 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 23 Jan
 2024 06:40:38 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.41; Tue, 23 Jan 2024 06:40:38 -0800
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.41 via Frontend
 Transport; Tue, 23 Jan 2024 06:40:36 -0800
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	<linux-nvme@lists.infradead.org>, <kch@nvidia.com>
CC: <oren@nvidia.com>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/8] nvme-rdma: move NVME_RDMA_IP_PORT from common file
Date: Tue, 23 Jan 2024 16:40:25 +0200
Message-ID: <20240123144032.27801-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20240123144032.27801-1-mgurtovoy@nvidia.com>
References: <20240123144032.27801-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH0PR12MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: 53ebac60-6536-4962-cb3f-08dc1c214a2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGVQwmqS1wYdrHgiR2EOU3MnDab+tDK1hQJdn+83ri8hqbU1Xw5gkdWzyFm5VXFHIUrd01henUKkto3IdWPgQactoFZmX7fiKCRaan4ssQ15Bxe4XQ93oYnxqXQrfw8MiuKZJlvto6wR1GhWzMJNMLWqzZDyrITngewBbH90Pajc6NTj0bTxTWHbgmbprBxGOkKyjqP91QWFId3xWRuIosg86oqxkuKbsMCa+M2fAG485voz4TWStvnp1oWd8weKJ6ClU8+EDz+0XGGBLGgo1t5UxK7upjATqgbNE0QOxL3MtjWljBKX1QbAUt/n0nJvCt+WQYyxinlMftE5hXu5lGP1ufKMzsCpGuor/WtDWsmjtMEqKxNGUkYSlqqJ1hdyVr+HEp1nZ6lvEhxqd9UEe85ErGyTgHB+yy9uyKgmO6OMKXyB8+al/VAv0++DY+8/na9AyRd9IGAodMenjYBHwtcFa09Zn9mytsKm+e1iSA3+ecyPbrYCbk5Vrf0xmO6tcsgeePtV7468Z1SyGCRo1rRORppCG8r1lZ2j6v7mqwjLwwhh2IwqCjDWVVU1l1lP8fALohVJ8v20JxksdIinIBkGq31m0ymLxfLjon1AmDL0rI14R03j+eObBobl1HDvBCzcgPn5cYSq222uW9WBBr8NWupmzTg43FDJDZsR19yL+nQW3XCJDOdBA8gXs3TexMUlCFlXHeXw8DLqdvnDmqPXd0mRyIuCj0HUZNco6kcHUY7jSXfQ4LdaNvW4xHDS
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(1800799012)(82310400011)(451199024)(186009)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(1076003)(47076005)(40480700001)(40460700003)(36860700001)(336012)(426003)(26005)(4326008)(8676002)(8936002)(82740400003)(478600001)(110136005)(70206006)(5660300002)(356005)(70586007)(6636002)(54906003)(316002)(86362001)(7636003)(2906002)(2616005)(107886003)(6666004)(36756003)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 14:40:48.2037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ebac60-6536-4962-cb3f-08dc1c214a2f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5188
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_064056_044096_FC8896BC 
X-CRM114-Status: GOOD (  10.15  )
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

The correct place for this definition is the nvme rdma header file and
not the common nvme header file.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Israel Rukshin <israelr@nvidia.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 include/linux/nvme-rdma.h | 2 ++
 include/linux/nvme.h      | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme-rdma.h b/include/linux/nvme-rdma.h
index 4dd7e6fe92fb..146dd2223a5f 100644
--- a/include/linux/nvme-rdma.h
+++ b/include/linux/nvme-rdma.h
@@ -6,6 +6,8 @@
 #ifndef _LINUX_NVME_RDMA_H
 #define _LINUX_NVME_RDMA_H
 
+#define NVME_RDMA_IP_PORT		4420
+
 #define NVME_RDMA_MAX_QUEUE_SIZE	128
 
 enum nvme_rdma_cm_fmt {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 462c21e0e417..ee28acdb8d43 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -23,8 +23,6 @@
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
-#define NVME_RDMA_IP_PORT	4420
-
 #define NVME_NSID_ALL		0xffffffff
 
 enum nvme_subsys_type {
-- 
2.18.1


