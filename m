Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03ECDC77B60
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nA3VxSW5VxHeBxBymy9RiCKKR/YcXFLcw82QzeEWZP8=; b=S6Qw32mcYXYRWxNtYiJrcj3TIv
	tbPPb3o/Dt0PECzuUpV0eGJOQzEciQWYH7i+pfXAqaR6vOPKf5LapqNEHbV8wGqDbxx6oQyX3U+3+
	0ffRnWkjLZLY//6FRQUMNoiU7yx8jrwMjQAZzXcjWuN3pIhDbLMww9rjH26y/4mKIu9c6LHM4CgY0
	wMp7b7F3/ncPxaPB0GuFRLTFv/RDzYu71vlRGjC8WRS9JOoFcNFtoq8WIb86KxtUAkaC/OwBnP6QO
	w3S2eB6hku982YknTWq+ZEIKXD2IoTXMkBE/XIR2z1EN/3bCC3vB5eq90tYpN5uIPzdJzQn7oscYd
	O9mBaNVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psIak-008QVY-1O;
	Fri, 28 Apr 2023 07:32:30 +0000
Received: from mail-dm6nam10on20626.outbound.protection.outlook.com ([2a01:111:f400:7e88::626] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psIag-008QTy-3C
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 07:32:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DcI/P/SyVh77AmhlFPcJrQFVFAnxYDzCA04Foejr82zYxjR3IcDn9BbKGqDX6eC3t9FteQ/SdbTkgHx+h2p8/MXTbItqKytICkEMj58C6f4nuK1C7ubtZXfKEQIjWSWCaqVGqkRbhBMzOceOthRA2AF7V1gxcO6dTAFi2gNAM7XmmDWW4U1hfSH+BtRT037OQBf+hBbu+jUGPQVwDviboCDZL+y8JUzF2p6TAbg/lzCOHguN21YciLS1Yz1/Bbxo5GpcjHf8O6vGJKLJekjPMlCaBLR77jcF1Rdu+0Z3Ky99ROkBdiCBBcEUqd283ZxECL+TUr9oYVneyhcjLuGG6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA3VxSW5VxHeBxBymy9RiCKKR/YcXFLcw82QzeEWZP8=;
 b=cGYZicBgGsITd+rvehZh3EvVW8qspLyH3FLuMmBUmhYu5GM0jASLmzOerjJ0qnaABk4dSJuoNJyAh/TAM6A8jqBtFjtokevjsojqPMZcj914JbjBQRzGB+rezbHz5liHLuH0F275NwPxvRsmMLcoCp0Vr2ppfOpv7R/ARZRxquF9ooiUFxTLSvxHSm/YKsBKYwfL1D3lqV+ELxh50iXIlWZWW4So4imjbvbGIcG1vcBR/i4swnvfhwj7FAcTHJ3lt3LEISM8rgCsunXxZM7Tv35dTrWyGtJOe1NOeAVRl9tf2dSfuY642hNdwVK3OMt2vdfLuvTfpeunAAM3v58+yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA3VxSW5VxHeBxBymy9RiCKKR/YcXFLcw82QzeEWZP8=;
 b=neQQwdgjilO1h0+ZJzZTABem5QP7KHoAjIfOfZR7HbZvfekulZzayc4MmTTeK64Ro3SXugnHY/nS2vBV2cHTCjzubc7AxbNPh6zJlhKvlzF8tfOZ5sp6TewpqSQta+aqnwRJCUlwXgLm09E5p1VhjKCCsPM4o4hsgzVAqEHDYvxdGallvazjSL6tJJ/sOqNQtWTuxQF9FAHvj94M/Bpm+qAV6h8SsJDXvaw9tAOQ96tLrtuSlQAAb03uGk1U12Rp+J6R22uFjGmWaWh/Mif/hZqxz5w6YLPsMmmKEO83mRSe14pi0mF280uFHzQb27j1x0SjUHDmccSaN1J9xmA/Rg==
Received: from MW4PR03CA0255.namprd03.prod.outlook.com (2603:10b6:303:b4::20)
 by BN9PR12MB5100.namprd12.prod.outlook.com (2603:10b6:408:119::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Fri, 28 Apr
 2023 07:32:23 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::6b) by MW4PR03CA0255.outlook.office365.com
 (2603:10b6:303:b4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 07:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 07:32:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Apr 2023
 00:32:10 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Apr
 2023 00:32:09 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 4/4] nvme-core: fix dev_pm_qos memleak
Date: Fri, 28 Apr 2023 00:31:15 -0700
Message-ID: <20230428073115.22987-5-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428073115.22987-1-kch@nvidia.com>
References: <20230428073115.22987-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|BN9PR12MB5100:EE_
X-MS-Office365-Filtering-Correlation-Id: 07879927-46ad-4af9-331b-08db47bab4a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	KgF7fvA4+uTlp5zrKsJQ0N+gVEHnwX5BRCK0QMydgpoJ3dsfnl1i4+HCuq7I9Im+n9invDtQbX6podV9K/da1/sjDGRBuRQZzTw3ld8WDmqrs/stjlqTHcLg2aZSlHzV37/X+3vgG+6Nhb9TbFzvX92JIqsctAF0OVIj0iSmm97JEpyRqrURCXBNvXJK2ORuEDZiJrEODc6xtAKANildWg82m0X1ZbxydKHZCGZRcXn4p0PbeP2TEm28XOIFlhOX2ZzZSoXiv3rMt8/tqFSgYztMNJrQC+sUvi3SG2FaC6nGfxanXMRMh43PY6v7qJC9JxBfyLUp2HkaH3jTYtsjbPBUP8/lLttIoi0yKUoDS3EUusfU6lUCPUuVafqOfs6ZSPqFpjBTPyUiiHvUc1DmDKD5lartB75MWUgFmnC0r3Zrt9rTMGlG0+9QDv3bPbs+wAVGc3Y3MSoNaye6OQSAOBYFw+1ie7PYuggL/dBx21eWb/YZ+vYJEVkRD0jvpCdEpzYKhEdncwaoOSRMcJrADCU00iraAkada4icsDE0X1pTxVgqE8DPv3KGCQekW8eGCXRXXmPIWmqsZ36UeRjrmNElXcjaSdDbyX/a84lpAUn2eaSvg5qT7aK78WQCBFfGXcJKoARn+jFeBENypUpH9Q8H+K60UilltcS+PfmUk9vDsfCBvlIj/7ElwKzvKo/WZgxJMLauZeYeedGXugZaFIU8cnC452+saUQEzwAo6IUU0Qu6jkFD+NySDth+QAHlE/B/JQAPPb0Ky8gNzLj1/g==
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(70586007)(316002)(478600001)(70206006)(6916009)(4326008)(54906003)(5660300002)(8676002)(8936002)(82740400003)(356005)(41300700001)(7636003)(2616005)(16526019)(83380400001)(186003)(426003)(336012)(36860700001)(6666004)(7696005)(34020700004)(107886003)(1076003)(26005)(47076005)(36756003)(82310400005)(2906002)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:32:22.1709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07879927-46ad-4af9-331b-08db47bab4a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5100
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_003227_031278_89663016 
X-CRM114-Status: UNSURE (   7.80  )
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

Call dev_pm_qos_hide_latency_tolerance() in the error unwind patch to
avoid following kmemleak:-

blktests (master) # kmemleak-clear; ./check nvme/044;
blktests (master) # kmemleak-scan ; kmemleak-show
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  2.111s  ...  2.124s
unreferenced object 0xffff888110c46240 (size 96):
  comm "nvme", pid 33461, jiffies 4345365353 (age 75.586s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<0000000069ac2cec>] kmalloc_trace+0x25/0x90
    [<000000006acc66d5>] dev_pm_qos_update_user_latency_tolerance+0x6f/0x100
    [<00000000cc376ea7>] nvme_init_ctrl+0x38e/0x410 [nvme_core]
    [<000000007df61b4b>] 0xffffffffc05e88b3
    [<00000000d152b985>] 0xffffffffc05744cb
    [<00000000f04a4041>] vfs_write+0xc5/0x3c0
    [<00000000f9491baf>] ksys_write+0x5f/0xe0
    [<000000001c46513d>] do_syscall_64+0x3b/0x90
    [<00000000ecf348fe>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 15607281baaa..90dc4b832200 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5202,6 +5202,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	return 0;
 out_free_cdev:
 	nvme_fault_inject_fini(&ctrl->fault_inject);
+	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 out_free_name:
 	nvme_put_ctrl(ctrl);
-- 
2.40.0


