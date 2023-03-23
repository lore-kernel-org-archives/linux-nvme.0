Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC50C6FD1F
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 03:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gHeHCQLaX8nE/+bdzUi3dbSXvb51LcIvjjOVD9OHzZU=; b=4BLG+m4sBY0je0g4UsIzqgTVin
	uSdTJMalKo35AnwzFeu6mHjMhQcCFHsz2Y6e1exWu182iG+mob/RoPx2SvuyprGqS8pU/NIwJEPpz
	SDmqNq4ZujW28dASUmMY2LU/BVuObvIt49ZFiVeIxLQubsPoRNK1kqGfGUCjITgZAV5wtcUZ+jaWZ
	jNHeC1fFIByGKjEEswHvwX0HQFK+d46ZJ9GS+6jbqcy/WPuolK3WKBnsevNwhifgzgvfrfLV5hAyk
	C80PnRMGEkZBEroZXEMQKmki0j/FJc5OPqkX3JkXaK8x5hAQ8sqnnLmAd+rSz4d8AXHJ/W+E1+5Zu
	bEGYp1rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBlA-000duD-2Y;
	Thu, 23 Mar 2023 03:37:04 +0000
Received: from mail-dm6nam04on2060b.outbound.protection.outlook.com ([2a01:111:f400:7e8b::60b] helo=NAM04-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfBl6-000dtG-0q
	for linux-nvme@lists.infradead.org;
	Thu, 23 Mar 2023 03:37:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVdMFM5NL6tMend3fnu5KX9c1EgBJSZcRXZgSeeHfaj7fsXPM/XHUglGZ6S1cVd3H+pPiH3WUUMzyFJHdfJ40p8yFtsqRWQOg4qZPrZPqnpoScUb0+oDqDogFfbaEUTKXlo9Z3fLyFH87UW706jwDcUN8Fc0l8Kd0ahsf7/u/H5OxgiARHJFjwTHQ2pt66lRq0S0G7EyPEYtzmuPPfYvZ7rvxrKGdng+nM34u3nGMwTWBmQ1aCdRFVHP3PvkVvdsyf+tum3RkHex6XjzkxJ4uxYHvGLuLyMTtIyJGeD/oxZGnEiSFz/BtFspsJYEcBqaHYYJw5aMs6geOTQ6V2NqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHeHCQLaX8nE/+bdzUi3dbSXvb51LcIvjjOVD9OHzZU=;
 b=YMvBT3HGXQgvoMDQkn3+0vX8Lg0cR9TlyXgfqV12pTy/DXy2uUfNQH5vbVr39onJcZ4WAx5IS+PoLzEo7Pwe+V5SqrBfT5oEsFO/ex+0331mVmsX/HR4JSvkua1/AzTzNmt/+nGSHhXS7limL+E40WF1c+mt87n4wC7NmmFoKTzk6ehrOO918p/MyHAuITQ3RcvLMwVqCbfhqtCUnxwUcvWhmHQDrIDIU38AF6FVbrAhvUBe/KeR4FapLLw6Xe+wVk6kFupoApzXBszbGYtN7qPMf5wL3t+KhffIEpo5YCy6KXpOtzTIfCh8rB20QNL9LtYjqrnne3tcDbuvFxgYaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHeHCQLaX8nE/+bdzUi3dbSXvb51LcIvjjOVD9OHzZU=;
 b=BYtvM8ArIunqHsUve2qFSMfG4TZqNzQWs9sjlaKYUm8+x4Y3YDBP4EpDCBhXONsRZs9DtyVWlOur5oAAQ1AzB35Lq+1T8U2sSsig+FAEUpxejLSLkkMjBcH+gqvQjMn8XLU8Uyg5nztdOSpLKm7bsgupsBiB3wSB7rUVvGdKHGJ+sV+biVB8UA55tlojjuN9QEyxjfCpRvR6xkj3qGPSySc40z2U3a4fJ5V/BT7/gVcdQGtvFHP3Cb/qvfI2bM0zM3ZqaLzeFR0q3RtIB1PvPMuHRkZztj/Bu3urhBED8P0r+DXyxYAtciPdGDaaVdZW+DI0pyrw30kiOxH563PgMw==
Received: from DM5PR07CA0082.namprd07.prod.outlook.com (2603:10b6:4:ad::47) by
 BN9PR12MB5147.namprd12.prod.outlook.com (2603:10b6:408:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Thu, 23 Mar
 2023 03:36:55 +0000
Received: from DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::a2) by DM5PR07CA0082.outlook.office365.com
 (2603:10b6:4:ad::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Thu, 23 Mar 2023 03:36:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DM6NAM11FT051.mail.protection.outlook.com (10.13.172.243) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.17 via Frontend Transport; Thu, 23 Mar 2023 03:36:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 22 Mar 2023
 20:36:44 -0700
Received: from zion.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Wed, 22 Mar
 2023 20:36:43 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/9] nvme-core: trivial cleanups
Date: Wed, 22 Mar 2023 20:36:27 -0700
Message-ID: <20230323033636.812758-1-kch@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT051:EE_|BN9PR12MB5147:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdcb248-7900-463e-152b-08db2b4fd920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	cmm5hZJ+piRfPOG1XMqS2rdgqR+6q7tJhViruxWUysux+SeQNy/MVxZbBs+9BujruXEODUBSj7B1/0k+g2jUqqM8avZLOsI5p9fP6DxyC9iKQGB1NjxQ4+BpJFajARbLAHWKDiYziab+5/UAl/JTlrAtOeQMbGFkl22x3FglH/QZUGd8tgGHstl8tk0nrdh/AHs6tNIGrVtwi94cKOLe+xC6lKLsP32hK980kGz0wkEXne8A74KyCmvl685xua4HI8kTczZUWTSaJvUqQmzLQOLK2MVL03gRmWWeN3cY6JPkYk/cHO10J/T9y94ovJRNIXEQNYJPNhTXeY6kszonA4Qc8CaJ+rpODrrPP+1iSJh/SrSfnC3CYBjwoMky0k8VrRqLmAASVMCXmZQbdgs6ax1OrOhuR1En1adJE29A5WVyIBRchvfGvVthURI9PmMI0hOdUAzd3v09ga2nB11RVf+PI2BAEMBHOZMgRjQStiQJgW/t25WtQyuSC3yHBLbCVLWsBrEOV2zEZoYCYvwXKf/s3TRHb4TmeZ5CmJ79l+VU/FJMF72bQPnfqXpuWB/BK01y91sHkLY5/5o3m5VcWnz4mtW6JKMsJe7FXZgD49BgkqB/MedldE/wIxsSiiLKn4d47ulF3/+gYeJX4jGL3SSmukNyDv2QdpoOmmu5u6ZQMJHGY3HjYmRzFWf627RaRdBidvwQX1sPrjmY540QRYmil+hhF5B9fgoXFayekhGEDpifJ2kAn8LKha6K3FlL
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230025)(4636009)(346002)(396003)(136003)(39860400002)(376002)(451199018)(36840700001)(46966006)(40470700004)(41300700001)(8676002)(6916009)(4326008)(5660300002)(2906002)(40460700003)(82740400003)(356005)(36860700001)(36756003)(7636003)(7696005)(107886003)(6666004)(1076003)(26005)(54906003)(478600001)(316002)(70586007)(8936002)(40480700001)(82310400005)(83380400001)(47076005)(426003)(336012)(70206006)(2616005)(16526019)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 03:36:54.6820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdcb248-7900-463e-152b-08db2b4fd920
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DM6NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5147
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_203700_724448_4833FE6C 
X-CRM114-Status: UNSURE (   9.31  )
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

Small code cleanups for nvme-core and the last patch has fixing really
long argument list of __nvme_submit_sync_cmd().

Please have a closer look at patch 4 and 9.

There are no functional changes in any of these patches.

-ck

Chaitanya Kulkarni (9):
  nvme-core: use uint type for shutdown timeout
  nvme-core: remove unnecessary else
  nvme-core: remvoe extra line at end of function
  nvme-core: code cleanup for __nvme_check_ready()
  nvme-core: use normal pattern
  nvme-core: open code nvme_delete_ctrl_sync()
  nvme-core: cleanup for nvme_set_latency_tolerance
  nvme-core: remove unneacessary else
  nvme-core: fix nvme_submit_sync_cmd() args

 drivers/nvme/host/auth.c    |  13 ++-
 drivers/nvme/host/core.c    | 158 +++++++++++++++++++++---------------
 drivers/nvme/host/fabrics.c |  60 +++++++++++---
 drivers/nvme/host/nvme.h    |  16 +++-
 4 files changed, 163 insertions(+), 84 deletions(-)

This series is passing the blktests for nvme-loop and nvme-tcp :-

blktests (master) # ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  19.504s  ...  19.508s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.087s  ...  10.091s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.440s  ...  1.476s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.798s  ...  1.814s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.061s  ...  0.053s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.032s  ...  0.031s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.458s  ...  1.455s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.440s  ...  1.433s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  71.351s  ...  82.214s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  73.525s  ...  70.006s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  77.108s  ...  77.670s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  67.936s  ...  67.830s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.152s  ...  4.324s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.710s  ...  3.724s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  13.086s  ...  13.120s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  13.287s  ...  13.261s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.449s  ...  1.456s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.435s  ...  1.455s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.422s  ...  1.419s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.430s  ...  1.445s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.758s  ...  1.754s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.456s  ...  1.457s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.416s  ...  1.432s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.426s  ...  1.422s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.447s  ...  1.430s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.423s  ...  1.418s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.434s  ...  1.416s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.557s  ...  1.548s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.204s  ...  0.199s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  3.906s  ...  4.045s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.011s  ...  0.012s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.869s  ...  7.982s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.711s  ...  0.746s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.567s  ...  4.589s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  3.162s  ...  6.974s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.724s  ...  1.704s
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.920s  ...  3.947s
blktests (master) # nvme_trtype=tcp ./check nvme
nvme/002 (create many subsystems and test discovery)         [not run]
    runtime  19.508s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.091s  ...  10.089s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.476s  ...  1.124s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.814s  ...  1.192s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.053s  ...  0.054s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.031s  ...  0.035s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.455s  ...  1.133s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.433s  ...  1.130s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  82.214s  ...  89.073s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  70.006s  ...  78.218s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  77.670s  ...  75.592s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  67.830s  ...  73.434s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  4.324s  ...  3.913s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.724s  ...  3.564s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    runtime  13.120s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    runtime  13.261s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.456s  ...  1.128s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.455s  ...  1.148s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.419s  ...  1.113s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.445s  ...  1.104s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.754s  ...  1.151s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.457s  ...  1.132s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.432s  ...  1.113s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.422s  ...  1.105s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.430s  ...  1.116s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.418s  ...  1.127s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.416s  ...  1.109s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.548s  ...  1.239s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.199s  ...  0.126s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  4.045s  ...  0.791s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.012s  ...  0.014s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.982s  ...  7.153s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  0.746s  ...  0.402s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  4.589s  ...  2.546s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  6.974s  ...  0.691s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.704s  ...  1.122s
nvme/045 (Test re-authentication)                            [passed]
    runtime  3.947s  ...  3.782s
blktests (master) # 





-- 
2.29.0


