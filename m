Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CDBC77B7E
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 07:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9y8bjnKEW0h3FzVS1Y4K1X3hRkBEKnBSrxY8YPPiYAI=; b=3uNorOnBAAYou3H9aa5LbLYYAW
	3hUSxmy0JWBeAjPkOTubhEhue0y7cWZv8HfywwmnKDL+iJwrGMQ2wMgsQPqGacNLhs8abfmGzcuSP
	8qD5v3cT85YFNOFg4dddP9I3g733M8KDzsZeNKd0rx8FQjpaASCAL8PYVHBhK3MmrVgLj+pvnbzvS
	jQ9LcY9r84A6Ka7ZLXarqtMEVtFDUYfkqPcxNItm3UaBPgBFjpSypDSB25eLzCDBewH/H/kOeILA0
	gs2Worgd3um1fS/Y9WOgtiaLJcAjCHoB2rXOG3LcLLjGR0mCeim1Yo+J1oPid3Q+ahMUQhv4iZ9cl
	6YrmHQMQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psIa8-008QMW-3B;
	Fri, 28 Apr 2023 07:31:52 +0000
Received: from mail-bn8nam11on20600.outbound.protection.outlook.com ([2a01:111:f400:7eae::600] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psIa6-008QLL-1B
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 07:31:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPTJLYQaluEoyauTzQ66SejA7i28wp/d7FLHazS9HOrIYg+oK93okANJRt4dMdjn98hj1lk2swcN/ZHMFwtl89qWth5F/643+g0utefTv7VyjqR2aP33fbXPN5IPOTqaRj7ds0zrGvJl3fs3e2fpxWb8zByHHqlRt0o4j23gKJupCE9PcijCPuAIGJ2T/7bDkhaA7xxrm9tpXqWOfzXGEXxLBr/gERljSmv9lv7MBm0EH8eQMYG1Ii2SwVTx5nZm4wXJ2hFS73llmdiiXpV2ffHLl9mag2WocP6wAxw6uQ3KcOQzMwp1yJtJZhJTNfRNOBCgb0p7NPDQyCzz31deOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y8bjnKEW0h3FzVS1Y4K1X3hRkBEKnBSrxY8YPPiYAI=;
 b=AE1wT2Fk7gSbzm4FE6f4qgaYt2k1zRaKAWLGoA+kmNHvpEmNQ/0g/ZCSHQZlsfDMPj4LP8aXtvsF/lUsNb3mwEKjq8Enf8X7qhIYIhDLa7e+wW+M8kE1odwpswlYjKVEU5UPs+L+o1o9I7nCsyfkblS3zCoL/v/kAdStRbCRjOB6g9SDrkH0+YfFV4vMs1diy3S8jbp+vyQdtb4T8Da/BhmCwikblHkHB/ICUtnGeotu468jF9s48jhDpJYGNJ4zSENXpcv9Xi/5Qs2yAOCe3/0OeHa/unRYmdjPeaOc95aMZx4VXuWB+eoN0mlWDeWDzhGDU30I6M/odM/YUGi3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y8bjnKEW0h3FzVS1Y4K1X3hRkBEKnBSrxY8YPPiYAI=;
 b=taBfMyRczBcAY9ineI3Z/Y/BTg+zNRtySEa2YoM4iAbC6lOHYhzBlH29+alg/wQdlFg4Xogu65mgjLfnr32gmON3Yy81Djh6FpOOk/00dEh7onTlKP3UhyvqUY1PXrIp/5VOm2+BtRqApD+DhQzPZlxtfOQK4u/babKRNENPkoBn0+Y8zIrpYOAf1rGsdTcJbww6rY4hMFulvpZzU6q5OAprqqL4JnxuG8eOnnHF+8ZyxlvilaQ7AQqXtBNIvBxCjg+MMaOr3kmizkK2NMMbMk9Sl2PZpzrkYqjaQarqW6a9bc9rm5ZasxoadXEXWsPIgp8UoUiU2U0bw781i6Ot8g==
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by PH8PR12MB7376.namprd12.prod.outlook.com (2603:10b6:510:214::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Fri, 28 Apr
 2023 07:31:41 +0000
Received: from CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::fc) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 07:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT071.mail.protection.outlook.com (10.13.175.56) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.23 via Frontend Transport; Fri, 28 Apr 2023 07:31:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Apr 2023
 00:31:23 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Apr
 2023 00:31:23 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/4] nvme: init ctrl memleak and debugfs fix
Date: Fri, 28 Apr 2023 00:31:11 -0700
Message-ID: <20230428073115.22987-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT071:EE_|PH8PR12MB7376:EE_
X-MS-Office365-Filtering-Correlation-Id: cdf9dfb9-92ee-4e04-3be6-08db47ba9c0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	MNn3SY+YxKRqmKFZbFFRhg683CSz0qJALpC2Mj3ncHitFVH2ghllj3CgryvxJXAeQKZoqQPbHIyrXcmHgVen/KPFJMVaImTyhqDw4SmqVN0euG2jJRrFHbfSAEWb+YByde5bLVte7cN5PNZrKyeOguTj+tMO5ZM5DkjA9S7M8+L/oIcIZ6FkioOcWzzLs2Wh+++nbkSN84j1BE94px+F/2HH+TwViIhVAmYBwSEMnGz+OHtbs5M8FoXwtLnTUnL1m0KN8kkqvu9gmP8/cACQ6gToR5WZX6QJyCk6RVpy5swiIzZ4eUdX8b3SRbEF6HNnj5oqONjch7/HaXPTSdvYG5+JUeVoiC5F4XWrJIkolv1mT5kBlIBGm7PKH6BZ+WQPvs6r5TThyNtLWGtxv5BDPkGsFb1++WATGvvCYpkBXqbfG3d8APHratORUPZEcgCetRspW3F+4eYAs5wmxvqNDWomyrWYM45jHy/2hDIPwEbH3rGVWz0TNri91RHxP0eIRIW1jWIkt9iOP05daacDTbBxUCG4cYks1vd04mV7xDsDU3OSkn5fRCnXKfNbvgrdxxFydOUEtfUWQxbP1Khg616hweMeuoWQPvtKkDLW734i/Vzl1E+AFQUv5990nDU8ujxNSTG6/XfIIgXlkTAeC8uz68sXeaH9QbYX9ba4pmfmDM5gDrtFRl5dG7jSCB/8vj06eFwJo9fM3vXcHVhszLdol7jMRQArBuVTYiA/Ar+Q1ReGaUnEYPEqXf7PctlwsgVY+23t0IWiRCf9sa8Bcg==
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(16526019)(26005)(186003)(70206006)(7696005)(316002)(1076003)(83380400001)(4326008)(70586007)(6916009)(47076005)(36860700001)(2616005)(336012)(82740400003)(40480700001)(107886003)(6666004)(426003)(34020700004)(40460700003)(82310400005)(36756003)(54906003)(8676002)(2906002)(5660300002)(356005)(41300700001)(8936002)(478600001)(7636003)(505234007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:31:40.9056
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf9dfb9-92ee-4e04-3be6-08db47ba9c0a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT071.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7376
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_003150_470148_6540F349 
X-CRM114-Status: UNSURE (   8.82  )
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

Hi,

There is memleak in nvme_ctrl_dhchap_secret_store(), 
nvme_ctrl_dhchap_ctrl_secret_store(), and nvme_init_ctrl().

Fix dhchap memleaks by adding right kfree() :- 

unreferenced object 0xffff8886376ea800 (size 64):
  comm "check", pid 22048, jiffies 4344316705 (age 92.199s)
  hex dump (first 32 bytes):
    44 48 48 43 2d 31 3a 30 30 3a 6e 78 72 35 4b 67  DHHC-1:00:nxr5Kg
    75 58 34 75 6f 41 78 73 4a 61 34 63 2f 68 75 4c  uX4uoAxsJa4c/huL
  backtrace:
    [<0000000030ce5d4b>] __kmalloc+0x4b/0x130
    [<000000009be1cdc1>] nvme_ctrl_dhchap_secret_store+0x8f/0x160 [nvme_core]
    [<00000000ac06c96a>] kernfs_fop_write_iter+0x12b/0x1c0
    [<00000000437e7ced>] vfs_write+0x2ba/0x3c0
    [<00000000f9491baf>] ksys_write+0x5f/0xe0
    [<000000001c46513d>] do_syscall_64+0x3b/0x90
    [<00000000ecf348fe>] entry_SYSCALL_64_after_hwframe+0x72/0xdc

Fix dev_pm_qos related memleak in nvme_init_ctrl() with adding 
dev_pm_qos_hide_latency_tolerance() in the error unwind code :-

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

When blktests are running multiple times we get following messages
consistently :-

[  147.853464] debugfs: Directory 'nvme1' with parent '/' already present!
[  147.853973] nvme1: failed to create debugfs attr
[  148.802490] debugfs: Directory 'nvme1' with parent '/' already present!
[  148.803244] nvme1: failed to create debugfs attr
[  148.877304] debugfs: Directory 'nvme1' with parent '/' already present!
[  148.877775] nvme1: failed to create debugfs attr
[  149.816652] debugfs: Directory 'nvme1' with parent '/' already present!
[  149.818011] nvme1: failed to create debugfs attr

Fix those by adding nvme_fault inject_fini() call in the error unwind
code path.

Still trying to find out device_add() memleak, will send patch soon.

-ck

v2:-

1. In first two patches add kfree() call after strcmp() if block.
2. Add a patch to fix the nvme_ctrl_init() dev_pm_qos memleak.
3. Add a patch to fix the debugfs directory error message.
4. Add tested by tag on patch 1.

Chaitanya Kulkarni (4):
  nvme-core: fix memory leak in dhchap_secret_store
  nvme-core: fix memory leak in dhchap_ctrl_secret
  nvme-core: add missing fault-injection cleanup
  nvme-core: fix dev_pm_qos memleak

 drivers/nvme/host/core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

-- 
2.40.0


