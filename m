Return-Path: <SRS0=LsNR=P3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69711C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:47:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0634461242
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Nov 2021 14:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0634461242
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fyfauOQoUoZDXJBiBL9Vpith2I/dN+X10pDn3BFLHWY=; b=M5/8GqTqs9p/Yt4B2crx0vixfX
	qvQKD9jconEZtUQpA1xEGhPF4iOWdjKPbN82OFI2nOW6Z+zMfZRlutDcGyVopDRl4SeKE0goktUwY
	f+Lp2380MoSEunEAegxMFJLR2pIxmACSBp++NyUnvVjgD6QtOinWad1Y2vVKj0l2mvx5uyOow/8iQ
	1xn+KZFfHW/aSn4zo/Va6CwuwNhrfdG8D4JdouO0pnoUWckoJrHTfLk7LvMDGRThrOSB7Vx5WhNhO
	YWbY4YiaDkXwYmcQAmrKlxb0bqHTvLCEIMZieXrSHNe/nfbCRtSO05qwUeKdq1PLpx+STqWsbV45E
	VZ0h5Y0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mk5vd-00GhxQ-2B; Mon, 08 Nov 2021 14:47:21 +0000
Received: from mail-bn8nam11on2041.outbound.protection.outlook.com
 ([40.107.236.41] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk5vZ-00GhwI-Kf
 for linux-nvme@lists.infradead.org; Mon, 08 Nov 2021 14:47:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOcpk5tckEkL4Is+WK6VkDyMmFpayCzqPRywnKP3tAKa8t5ZdXJ84h0QuVOzluo6OzweACzk2jhxCDOMtLmni7MAx3s0rhFXE0SDDVIchUmMvWcpwRFpmd/QD7jdpPULGuLfMaD8eU0Y8e7ud5zU+/MKBj+6DWy4eSAj5JxO+sUGO1ZLULrNPR/9x2hioec5CRiPMUTXNtlsN0HIacYBwZdyMlTLJ1SfOVgr3FoPudYo2NFcouGo5nQrJQ80XSAAFkFn4OmN6MTe5Lsku6umUYuRXLOgcR/dpbAsd9kBH4b9AN18bFEDCzRkI2VvYySR7EaMbqX8Ir1DK2jDeajUPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyfauOQoUoZDXJBiBL9Vpith2I/dN+X10pDn3BFLHWY=;
 b=ASByThDh6cZAnrTihlqQnwW7IncfERIvQnnNRE8x+D+oAg25ZTXM0b/65gCGgAql/xhtXFltf5GgQN0YjPQ36dXofn2skCcw9KO4fbEHBwPwwq0g9/22Bmecrrv6/P6yd+JjJhzCtuaEU1OPrChn04FaWVCJnpnZ+P6TzJzeujNx9qjBJHuT0GiRe12AsUv9BT+B4b/08F9meSIc84FT5t1DCEiaw8tnJNA+b9l4sdoiZBzA1OMzORrIq7So8nUpNyn6kzpyJnbp0OXlTnn/tLUCPfP07FqCefYECSv+TeXVCJRMrf6msZ/kHhaSkFbV7YJB3fW3QlU21NHphsxm1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyfauOQoUoZDXJBiBL9Vpith2I/dN+X10pDn3BFLHWY=;
 b=deT0RfDjJJeb9/6YTNkekU/j14mfFj4yS8CNSnC9CgwwdduesnHcoQlq/cvLGEclZibAhCdkqgnVFqfbYKSoHPUStk+jRYPXrxfv/l3A7/aHHySCbm3iqxf7W/+YEa49YNGt/kw0otuDwRihnUZL1E2ud/jZHJ2UH9I+tlIZi4BPjpGEcrdcfGoc5YFqcBwsg0HTDis0tRDps9aNRzs5N+JgHJc2zUaqP09+yqJ40HgZlzixGpeZevFLoLiTDVkIidCMGrjMuBXAsSYaLYRXxFle+ToLFJvGpH8fq6mb+sFyT/UrsNm8Eo0kSIURd4MRQxRyeghsnWqXkk/cGcQ1dA==
Received: from DM6PR08CA0008.namprd08.prod.outlook.com (2603:10b6:5:80::21) by
 DM6PR12MB4985.namprd12.prod.outlook.com (2603:10b6:5:16d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4669.13; Mon, 8 Nov 2021 14:47:08 +0000
Received: from DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::a1) by DM6PR08CA0008.outlook.office365.com
 (2603:10b6:5:80::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT026.mail.protection.outlook.com (10.13.172.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Mon, 8 Nov 2021 14:47:08 +0000
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Mon, 8 Nov
 2021 14:47:07 +0000
Received: from r-arch-stor02.mtr.labs.mlnx (172.20.187.6) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1497.18 via Frontend
 Transport; Mon, 8 Nov 2021 14:47:04 +0000
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <kbusch@kernel.org>,
 <sagi@grimberg.me>
CC: <chaitanyak@nvidia.com>, <oren@nvidia.com>, <benishay@nvidia.com>,
 <borisp@nvidia.com>, <aviadye@nvidia.com>, <idanb@nvidia.com>,
 <jsmart2021@gmail.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 0/4] Add command id quirk for fabrics
Date: Mon, 8 Nov 2021 16:46:57 +0200
Message-ID: <20211108144703.7971-1-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 904adc02-8728-4831-9294-08d9a2c6a3c5
X-MS-TrafficTypeDiagnostic: DM6PR12MB4985:
X-Microsoft-Antispam-PRVS: <DM6PR12MB498570021BCDB7ED187CF220DE919@DM6PR12MB4985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:161;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UBplNy5kVvzfYJmFKTA3PI+/n6xCQ8OCDheSfdku4CGjExl08LwFW0fRKgrhLkWt7OFH7JPj7gcNHshxsMehuKnBp5qH/7OIitE9XwbnPIyzBQHiePetBL8PBqG71y3FEipsXzGqZ4dyqTYpDNGYgc0BGYCTkGhH9t3bT3PLNo8Kh7pDBIOIdsrhOq64STQCpnpYWo2RpOqd9aRe9a4sOgqMyADLIHNGS/X5tdW7YbszE913Rz/k6xsvt6iZDYPhezkDw3EqR9dGe2bo1H1wmTFAcG6wrVVe+OWBP6YEaTTTCsbUbcG/1Z6Fj2cgdvIMVYS494M25PFixuku7pjV2D5Hl+0wCqHuYzbJjujO11TtjI3pFOfTAg24hD/XLPAN3Urd0W/ZsnKEzMhk1u73Nt/EqghxnaGxoHj4+tEgxVHBx81LTPf7uxqggDlSuxuOGu/VBYEOnp1UX1d6D8N+t2KPfqj9HLQCUCqufeil1O+7sNpybpnh1M9IFMOy+9iM40ETtzfEktoFjW4kkkeSEhC/qzQiLjD2h3vGnej9YjLRzDplBtETHGoGH8uV52IfhxLYBpABK5o5rYxM9MFXEWyltjpYQuNqyOwkCnTBefVYehYhSP4TsdBsoCrYgRV3z3VN9w5tXbx1gQB67K1Mr7RJjQHNPdZQEKgQ7J3CI4JqJM/fRRkzde3h94Q4hEhsnW2P6Ey7whBhXDZO75SRNA==
X-Forefront-Antispam-Report: CIP:216.228.112.34; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:schybrid03.nvidia.com; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(186003)(86362001)(82310400003)(47076005)(26005)(107886003)(2616005)(6666004)(426003)(36860700001)(336012)(36756003)(2906002)(8676002)(508600001)(8936002)(36906005)(54906003)(7636003)(110136005)(5660300002)(4326008)(83380400001)(70206006)(70586007)(316002)(1076003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2021 14:47:08.3385 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 904adc02-8728-4831-9294-08d9a2c6a3c5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.112.34];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4985
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211108_064717_723968_DEA55877 
X-CRM114-Status: UNSURE (   8.75  )
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

Hi all,
Commit a2941f6aa71a ("nvme: add command id quirk for apple controllers")
was merged to fix a regression in apple controllers that was introduced
after merging commit e7006de6c238 ("nvme: code command_id with a genctr
for use-after-free validation").

This series is comming to enable the same quirk for fabrics controllers
that used the command id index in the same way that was probably used in
apple controllers.

This series is a complementary series to NVMe-CLi and libnvme patches
that will introduce a new flag for "nvme connect" command:
"--skip-cid-gen". Using this flag will cause enabling
NVME_QUIRK_SKIP_CID_GEN quirk and will actually add the ability to
ignore the command id generation for other transport alongside PCI
transport.

default value of the flag is false.

Usage:
nvme connect -t <transport> -n <nqn> -a <addr> -s <sid> --skip-cid-gen
or
nvme connect -t <transport> -n <nqn> -a <addr> -s <sid> -p

Max Gurtovoy (4):
  nvme-fabrics: add command id quirk for fabrics controllers
  nvme-rdma: add command id quirk for RDMA controllers
  nvme-tcp: add command id quirk for TCP controllers
  nvme-fc: add command id quirk for FC controllers

 drivers/nvme/host/fabrics.c | 7 ++++++-
 drivers/nvme/host/fabrics.h | 2 ++
 drivers/nvme/host/fc.c      | 6 +++++-
 drivers/nvme/host/rdma.c    | 7 +++++--
 drivers/nvme/host/tcp.c     | 6 +++++-
 5 files changed, 23 insertions(+), 5 deletions(-)

-- 
2.18.1


