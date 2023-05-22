Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B09C7EE26
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 08:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=i2bZaCOv89xVBPVnJPsqqkAAKLEyIncCJ5zCD/Ve51c=; b=P8K4vs+c4w5Te+Ey9RlW9bLFu3
	dok3NrvkjpUUi0Xdli7LjGSw3cAt7B+BczwGR6TQ1gDCd8NaANxjAtLfLzGzSDPFKUunhM94Mtcty
	pJ9Ch9q72MOeKwpaRPhLSJFY36foSBUyuW6V8Qdf8uytim3hwAUn8DiZJx5nXCsIHfw8RgwVuxEt8
	YpZau5q8U/3m+ijDFsFdSQYRvWu8aRBgO53r4R21CP6Xeb0BTPTzdwADl06v8/X4jibVgFviyBlvE
	AfarwtrPe/ovFaHe63sjbgeut+z1X7nwbAcqkw76NSzFzV/j0JlHL74+EnDmiu2KHzNriPm2nFuw3
	4lVt+qOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q1137-005m3E-07;
	Mon, 22 May 2023 08:37:49 +0000
Received: from mail-bn8nam11on20601.outbound.protection.outlook.com ([2a01:111:f400:7eae::601] helo=NAM11-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q1130-005m1R-1i
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 08:37:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YP0CtV3NfLuewt755WkxO8cMbuUzWbcKEdHtmzmtiNJo2/TezdMxllONIw7FHM1s3I5K4rzExsQlcw/t/YvbAq2lPUjA7yd5c4u4k9uPnmdywG1j7ujTv4RlIKq39a707RS4RwcN185Dvv/FN6fFarsi5LPawQj7dGb+Z3cDAtANOl67W7q+Rkw/gfGUu1GeM+5zcaTBqh0d36fluD4qEaWVKDRQHWH+QMOZn++SfDkfNbm7Mkujat9m/tmpoEKUQJPxnrxa3hdvKCq+/iTtBwWMjTukD+pSrJRbUHkWiLIBIL1VoyWchwLzK0O41vC24aKur5L4feHM3TRLiBHg5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2bZaCOv89xVBPVnJPsqqkAAKLEyIncCJ5zCD/Ve51c=;
 b=gD3KLXHuGxGBliJeGVO9dTB61dfOYz/Uoh/lre/EeV5rocTLx2ov/twPCCIKY69XH6pM2lNEYG2Bek1MxnQjGl7AeAExcanG/5wXK2NnLf3zRw1hOxNbONC9G2a7/oK3hBOhVpgkWSRB946kUG19EtU4ibaKHpY8KR0RFuz6knScy0r2PNDOHgX9m/6tl9Hf9zzkmBV85qCGLusCWRXlvAdM9zR8o+wt1fbvVV1a3nQLD4qaArzhQTxHESR9Wbw9CLf8Skm9mGesJeUMzaQ08AHXSy4C2+MjzOYMJd8EI3M5jl3e6ewfDTjO8yD+r2dxg/KLi8VyL3GX7AMzYrDeXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2bZaCOv89xVBPVnJPsqqkAAKLEyIncCJ5zCD/Ve51c=;
 b=Nxkn6drIyAObsv+9d/rm6OM1vTpfFdnhjc5w7RJVh4jXmhS4l9QYm2k37wdoHpm/1BsF4Ub10DGrOw7YjrwwEfJDgx+/O//H8yqelo6qUu5JrzDFNx/o8tkpdN6pvqksq3FD8jxiPiPCW3eGFAH1RajtzJWO+RTxxitZYV9yOGDwolaNHeJQXDM8KD8m3aPSkRWL5Qw4N6JCoww+BoM3Q4ctWwCOmjXS7l51jL0JoizB45qhwYjPZHXrJSxcdQ6GRrlk9Z89Amx6dmF1k2L9U7Qi6Go1ns6BdH2QTeQgfI9vbSpUyBlYbGLaBHlbIxnsQlGJ7rw/O5kAGSRJKtfJWQ==
Received: from MW2PR2101CA0007.namprd21.prod.outlook.com (2603:10b6:302:1::20)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Mon, 22 May
 2023 08:37:37 +0000
Received: from CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::fe) by MW2PR2101CA0007.outlook.office365.com
 (2603:10b6:302:1::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.6 via Frontend
 Transport; Mon, 22 May 2023 08:37:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT090.mail.protection.outlook.com (10.13.175.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 08:37:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 22 May 2023
 01:37:20 -0700
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 22 May
 2023 01:37:19 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 0/3] nvmet-auth: auth send / receive cleanup
Date: Mon, 22 May 2023 01:37:10 -0700
Message-ID: <20230522083713.107001-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT090:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: fbece88e-ddf6-4f52-84cf-08db5a9fcba7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	5FRvE18NAGtAPU2Qh0k3PsZBLoPXB4EbuAipfZ8ywQ+U9gLcaI/LUbzcdH8nYkyHF99zr+Y3PIndLoHuD7z+NHWzlUmtQG1K5JEupLChlZFLNAQTEQ9fdpCmW9erBGxvCpk1jVYAOr31jiS5M4I5eCZP6ZCee7mg9vBnVU2+o4i2dSsJnaPffyUgH3e0N1RzrA4iMJEXnbyUi6TXjKa4OyTD5V3n9m4t0vgacQE5S+JpKbMnb/wzn5zzAGy1Zijxn+TF0c2U88BapUHAeCZrmZcyzWGEzxjwPuKG8IAdvz6KBioGQjFGsx0CEKL+/9DvzGXnuscDIBCxfy+S+/L8EVaZE3UtuEXj8n/3nQ6b50vlvCpX3Ysx3dqyMP/Sr+omXgsWi9IZPnMrQ9w060qYRB1vm+qe4V0N1M7z6PLmPbmpYrRKUoUgko+s3x+xIxguZsnSmBrUS9cum2yTEKksvEOzIgKv4ymCqOcLq3ObbBa+89j06KQEScscbHDLWzQeRplpraSzy2f0EgolSUEcRbQf6xGRAjiBV5LfLbgX1I26ZmLr0vgrJZpQ4HksPfEqcwO743638edheBT9Bx7AcklF9R6VrgLId3Y36PTImUwHLyJPERKpmmY6P+qDCDwduuzVfC4qePq63zGv1BnuVeM6SHStAH4HdlVWOhm0i5tBheCkQY5/mWKLa0bEoQp26nWk1lir6qa0ki2NHySqHhul1XoouWdbRIsGW2UnSBUWDFh4d67g4bDySk4MrrdTQEmXOYNWk3RsxBtqZkqQRLfzXAl3UAISEGh8tvU2ml4=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(396003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(41300700001)(2906002)(5660300002)(70206006)(70586007)(4326008)(6916009)(316002)(8676002)(8936002)(54906003)(40460700003)(7696005)(6666004)(478600001)(966005)(186003)(107886003)(16526019)(36756003)(2616005)(426003)(336012)(47076005)(83380400001)(36860700001)(26005)(1076003)(40480700001)(356005)(7636003)(82740400003)(82310400005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 08:37:36.4701
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbece88e-ddf6-4f52-84cf-08db5a9fcba7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_013742_635779_B81D7191 
X-CRM114-Status: UNSURE (   9.45  )
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

nvmet_execute_auth_send() and nvmet_exeucte_auth_receive() share a lot
of common functionality such as :-

1. Checking secp/spsp values and its error handling.
2. Initializing transfer buffer len and its error handling.
2. Allocating transfer buffer and its error handling.

This code is repeated in both the functions.

Add common helpers with very small restructring code to remove
duplication of above functionality in the nvmet_exeucte_auth_receive()
and nvmet_execute_auth_send(), it also makes code easy to read as both
the functions are doing substantial work.

Please note that this series is generated on the top of this :-

[PATCH 1/2] nvmet-auth: remove unnecessary break after goto
http://lists.infradead.org/pipermail/linux-nvme/2023-May/039950.html

Below are the blktets nvme results on nvme-loop and nvme-tcp transport.

-ck

Chaitanya Kulkarni (3):
  nvmet-auth: use common helper to check secp/spsp
  nvmet_auth: use common helper for buffer alloc
  nvmet-auth: use helper for auth send/recv cmd prep

 drivers/nvme/target/fabrics-cmd-auth.c | 106 +++++++++++--------------
 1 file changed, 45 insertions(+), 61 deletions(-)

blktests (master) # sh  test-nvme-memleack.sh 
################nvme_trtype=loop############
nvme/002 (create many subsystems and test discovery)         [passed]
    runtime    ...  43.965s
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.194s  ...  10.171s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.321s  ...  1.732s
nvme/005 (reset local loopback target)                       [passed]
    runtime  1.421s  ...  2.118s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.134s  ...  0.131s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.092s  ...  0.083s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.351s  ...  1.712s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.306s  ...  1.742s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  88.563s  ...  84.996s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  88.483s  ...  70.556s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  93.537s  ...  77.927s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  89.064s  ...  71.515s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  5.629s  ...  6.141s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  3.993s  ...  4.797s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
    runtime    ...  20.513s
nvme/017 (create/delete many file-ns and test discovery)     [passed]
    runtime    ...  20.563s
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.315s  ...  1.741s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.324s  ...  1.718s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.293s  ...  1.721s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.307s  ...  1.668s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  1.376s  ...  2.147s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.318s  ...  1.718s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.284s  ...  1.699s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.285s  ...  1.695s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.274s  ...  1.659s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.290s  ...  1.688s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.289s  ...  1.716s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  1.616s  ...  2.001s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.298s  ...  0.420s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  1.484s  ...  5.448s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.046s  ...  0.042s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  7.416s  ...  8.235s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  1.164s  ...  1.638s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  7.461s  ...  10.101s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  1.342s  ...  4.516s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  1.537s  ...  2.351s
nvme/045 (Test re-authentication)                            [passed]
    runtime  6.356s  ...  4.993s
nvme/047 (test different queue types for fabric transports)  [not run]
    runtime  2.281s  ...  
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    runtime  5.627s  ...  
    nvme_trtype=loop is not supported in this test
################nvme_trtype=tcp############
nvme/002 (create many subsystems and test discovery)         [not run]
    runtime  43.965s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
    runtime  10.171s  ...  10.189s
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
    runtime  1.732s  ...  1.331s
nvme/005 (reset local loopback target)                       [passed]
    runtime  2.118s  ...  1.432s
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
    runtime  0.131s  ...  0.134s
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
    runtime  0.083s  ...  0.092s
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
    runtime  1.712s  ...  1.345s
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
    runtime  1.742s  ...  1.315s
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  84.996s  ...  78.021s
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  70.556s  ...  94.072s
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
    runtime  77.927s  ...  70.347s
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
    runtime  71.515s  ...  92.875s
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
    runtime  6.141s  ...  5.665s
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
    runtime  4.797s  ...  3.903s
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    runtime  20.513s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    runtime  20.563s  ...  
    nvme_trtype=tcp is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
    runtime  1.741s  ...  1.307s
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
    runtime  1.718s  ...  1.350s
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
    runtime  1.721s  ...  1.315s
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
    runtime  1.668s  ...  1.316s
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
    runtime  2.147s  ...  1.386s
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
    runtime  1.718s  ...  1.336s
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
    runtime  1.699s  ...  1.304s
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
    runtime  1.695s  ...  1.320s
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
    runtime  1.659s  ...  1.297s
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
    runtime  1.688s  ...  1.307s
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
    runtime  1.716s  ...  1.322s
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
    runtime  2.001s  ...  1.671s
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
    runtime  0.420s  ...  0.341s
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
    runtime  5.448s  ...  1.622s
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
    runtime  0.042s  ...  0.049s
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
    runtime  8.235s  ...  7.458s
nvme/041 (Create authenticated connections)                  [passed]
    runtime  1.638s  ...  1.242s
nvme/042 (Test dhchap key types for authenticated connections) [passed]
    runtime  10.101s  ...  7.807s
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
    runtime  4.516s  ...  1.496s
nvme/044 (Test bi-directional authentication)                [passed]
    runtime  2.351s  ...  1.552s
nvme/045 (Test re-authentication)                            [passed]
    runtime  4.993s  ...  5.859s
nvme/047 (test different queue types for fabric transports)  [passed]
    runtime    ...  2.365s
nvme/048 (Test queue count changes on reconnect)             [passed]
    runtime    ...  5.649s
blktests (master) # 


-- 
2.40.0


