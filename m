Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3069FC7619A
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Mar 2023 06:04:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FPp34rcVOYrlDIB/NTD+2KI/bNA90kgb3WrhNTBH0TA=; b=lve+iK0ksEpRmHyLQSERd5k1vf
	spMPxuGZ3TSh3P7UUmQ64NDPRvbClpj4po3p5NgXAYE6iT83zv9NucHmDN3JKlJFm1IRMIkAqKC1o
	BRZ6+nq1H9ht5PX7R2kScZ8X9xUVSrxHLg03QO2bjk1HBJXq2Er6BiNWbWO5IZDYLrhMD0B8+pYzJ
	wkPAefIkBxZ3lpUP+rQ+eILofcehJvyNXSo+/jvE+jpUYzRvlv1r18pBLxbXvNnrxhk8jMAO5Vd+E
	KZROsS4tvmlqKmsRbBcn6cKXANnzhkeYPd7HhbGoeAThxOBMkuPpLmfUvwdENGZEf1xbwtl6n88Fl
	pqtSqDIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfyM-009u0A-31;
	Mon, 27 Mar 2023 06:04:50 +0000
Received: from mail-dm6nam10on20622.outbound.protection.outlook.com ([2a01:111:f400:7e88::622] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pgfyI-009tzL-38
	for linux-nvme@lists.infradead.org;
	Mon, 27 Mar 2023 06:04:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N9nEMygTwn1+cahcsCyZICCD/1tsFBKNVgitcDP9BIKYpTIRaAtEVy4OHmTp8LWrXgg9xY25j8WR14mvKWE3F0Ot0xG3F++XgLHCeN8aIQ4IlGz9XC/cO2a280JrCOVrYSf7+L9mj+iKrA5YL8SrDp7XiCXlBUpWXSLgJuGxAjbpPgOW9PexjLt8cPC8L0y5D+lVeCGPrgFGgcI3kfahGgU1xj9llgATJG8fdlz4tjxTU38xyH8H7A3vg+bTUs3nvrsMiaAalajjIu8plxrUKGmKIYOoP270pjVoTtAIyBsz++KzGMLo/ObDlCcuJFT8NQHmhCAQxgvM3LjXgLULHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPp34rcVOYrlDIB/NTD+2KI/bNA90kgb3WrhNTBH0TA=;
 b=iXWEtztwRMrD6kJ47SMFFjmgwXe8bGmhRrDh2cZtLcJax+qG7y/4cIkU1mKFgdeLWJKWEp3kPv8/pHfNNDY1RAPsPPlx32PffcJZPeXOszObUG1Wyn5e9S3dWdV5y6q1Fqe1W9wRsoTrBgRLofKFufoWnoJVRyrzdeTrCiTzGdrVUMVZtaRbZ+3crq6bnwMSlutRqQDLdQKf49Fxmi8njEb78WIt5AZ7yn9URbE2S7l2pTJVlb+GpWfhBQ/zWq5Yl52NwnGeRLVLddQ8+q7D/0d7AxRD+o3S/vKA4KBYE6orsrCFb2FxRdO1oZ75Xe71rRnJU3FQaKo/Wq/3NvOmBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FPp34rcVOYrlDIB/NTD+2KI/bNA90kgb3WrhNTBH0TA=;
 b=PYmg05/MDIEiSMuKsoBN4vwk4CvGWqExK+ZF3enKZMgk/t9zo/h7Z8tbbu9lLdRu36UzT8woADWQWKMrQIl+sp4gezLY2347sEQ3UkKTtGq4sGo9P3G+qMPSCcURcXpwB90dtJn6nkpak6f9cgJxHUXTa/uAGp4oEqFTSg2n1lM6y8/uhOC880m/Sf9mJzJTTSMYMOsFZfugpBkC9tX639tngwlq0EgtG32hXr2wVX7y9UKC2Cb5ZJfTTuD8ABYmGwdt+nDETvpK6U4ZEO9pdquYsTHe4o/KP7qxcEiRBzRaoeU0mwsorV38lEmxBEtpUTjEgsgDWch0lJgwaWK3mg==
Received: from MW4PR03CA0076.namprd03.prod.outlook.com (2603:10b6:303:b6::21)
 by BY5PR12MB4257.namprd12.prod.outlook.com (2603:10b6:a03:20f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.30; Mon, 27 Mar
 2023 06:04:40 +0000
Received: from CO1PEPF00001A60.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::5f) by MW4PR03CA0076.outlook.office365.com
 (2603:10b6:303:b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41 via Frontend
 Transport; Mon, 27 Mar 2023 06:04:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00001A60.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.30 via Frontend Transport; Mon, 27 Mar 2023 06:04:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 26 Mar 2023
 23:04:27 -0700
Received: from dev.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Sun, 26 Mar
 2023 23:04:26 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>, <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 0/8] nvme-core: trivial cleanups
Date: Sun, 26 Mar 2023 23:04:10 -0700
Message-ID: <20230327060418.86655-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A60:EE_|BY5PR12MB4257:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cf5c11e-73c2-4f73-e422-08db2e892741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	EAlCOco+RDLXn+xi4Xxa5DwCIV/0WSRDFeTAAK9w0+bnhZLSJBpCzbUcH8u6ez6vvgjl5xq4/eGDuFx6MB4ZdKFMfaRXaBQxOtKvNGr5zQSoAvuvjJXuy2XymKeh1Sk5P1sm6+PixcvsZnRAWFoKlzyJeHZJ6lckDVuYG+hBG7rcnUsOEvG8is1Kgs/0EPH4mKiAsdUaREtKCnquS1k6Wa7Zx2EtZEodQa2kYjW95QeA+hYXjOnk527MK4z7l8PsTZmXbeOrBnF7qJpkQ4YPXrQsFvKzQxcTbgMLjWmWxJfPb5HZ8LrpG1YRqZoIgqgfiF4tSs0fA83GJKxSGb4xMCbfijKgLx8pdrym5RAMBph6MFVOF5MJ9cxFacrW5dqGbNF8nF5I2EmQtFmws3J5wO5zoqVv5yX8D+j4JHA1czGZgGIT7mMVc6gJjHIy2AU7r9JVrBuVgDeFFnXkhN6hqpW03nyLgajYlHftItZ7vDErwKJF7rBJYyqVHypoVNc3LBr1+nS6WUTvcIMVej20EaCbes0B3ub0ib78SYWjDvbLTqst7T4i4oGHkqAq1tun7wtdrEvE6wL5QE5l0XcOcHNBR5WI9Mia9tM/zqEzWIn1XpzFQ3rcnTFQ+baI1mcQt61DCyqQntorWD7AChZJrUQ2nVKHgf6TMAmh6LtRKwgYwK/mRd5AHNrcRl0t3uWRUuYkWyl88lLRnv3qVmboPkSaBhfyq85EtrYH8BHyXB4=
X-Forefront-Antispam-Report: 	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(346002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(7696005)(40480700001)(70586007)(36860700001)(6916009)(316002)(8676002)(70206006)(478600001)(4326008)(54906003)(47076005)(2906002)(1076003)(26005)(186003)(5660300002)(16526019)(83380400001)(2616005)(426003)(336012)(82310400005)(36756003)(41300700001)(6666004)(107886003)(356005)(7636003)(82740400003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 06:04:40.5990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cf5c11e-73c2-4f73-e422-08db2e892741
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1PEPF00001A60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4257
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230326_230447_019828_83B9E100 
X-CRM114-Status: UNSURE (   8.24  )
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

Please have a closer look at patch 3 and 8. There are no functional
changes in any of these patches.

V2 is passing the blktests, see log below.

-ck

v1->v2:

1. Update Reviewed-by tags (Sagi)
2. Revne struct nvme_submit_cmd_data to nvme_submit_cmd_args. (Sagi)
3. Remove patch #1 (Sagi)

Chaitanya Kulkarni (8):
  nvme-core: remove unnecessary else
  nvme-core: remvoe extra line at end of function
  nvme-core: code cleanup for __nvme_check_ready()
  nvme-core: use normal pattern
  nvme-core: open code nvme_delete_ctrl_sync()
  nvme-core: cleanup for nvme_set_latency_tolerance
  nvme-core: remove unneacessary else
  nvme-core: fix nvme_submit_sync_cmd() args

 drivers/nvme/host/auth.c    |  13 +++-
 drivers/nvme/host/core.c    | 148 +++++++++++++++++++++---------------
 drivers/nvme/host/fabrics.c |  60 ++++++++++++---
 drivers/nvme/host/nvme.h    |  16 +++-
 4 files changed, 158 insertions(+), 79 deletions(-)
blktests (master) # ./check nvme; nvme_trtype=tcp ./check nvme
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime  18.950s  ...  19.715s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.099s  ...  10.095s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.471s  ...  1.546s
nvme/005 (reset local loopback target)                       [passed]
    runtime  6.825s  ...  6.919s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.068s  ...  0.074s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.044s  ...  0.048s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.476s  ...  1.518s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.444s  ...  1.475s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  7.449s  ...  7.685s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  60.217s  ...  78.689s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime    ...  12.459s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  104.896s  ...  79.450s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  10.311s  ...  9.759s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  9.617s  ...  8.870s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime  13.747s  ...  15.775s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime  14.690s  ...  13.533s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.524s  ...  1.490s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.592s  ...  1.470s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.536s  ...  1.467s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.472s  ...  1.461s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  6.758s  ...  6.827s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.449s  ...  1.485s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.440s  ...  1.556s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.434s  ...  1.455s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.429s  ...  1.460s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.446s  ...  1.461s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.450s  ...  1.470s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.589s  ...  1.709s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.226s  ...  0.237s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  53.920s  ...  54.157s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.028s  ...  0.026s
nvme/002 (create many subsystems and test discovery)         [not run]
    runtime  19.715s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.095s  ...  10.110s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.546s  ...  1.158s
nvme/005 (reset local loopback target)                       [passed]
    runtime  6.919s  ...  6.211s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.074s  ...  0.073s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.048s  ...  0.049s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.518s  ...  1.160s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.475s  ...  1.152s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  7.685s  ...  15.872s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  78.689s  ...  67.854s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  12.459s  ...  20.635s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  79.450s  ...  73.919s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  9.759s  ...  8.695s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  8.870s  ...  8.553s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    runtime  15.775s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    runtime  13.533s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.490s  ...  1.144s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.470s  ...  1.159s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.467s  ...  1.136s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.461s  ...  1.133s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  6.827s  ...  6.162s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.485s  ...  1.164s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.556s  ...  1.130s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.455s  ...  1.141s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.460s  ...  1.137s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.461s  ...  1.143s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.470s  ...  1.138s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.709s  ...  1.271s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.237s  ...  0.146s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  54.157s  ...  50.809s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.026s  ...  0.029s
blktests (master) # 

-- 
2.29.0


