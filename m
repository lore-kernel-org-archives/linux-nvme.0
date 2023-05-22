Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA78C7EE26
	for <linux-nvme@archiver.kernel.org>; Mon, 22 May 2023 09:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KlDQAEteoGQTD45MGfC6RJaETeChWP0SKeUNYKs38FQ=; b=co3rgrnZmzznXz4wfbm64rSli1
	JXuFILuKKfzqktW4lbnLVv3bvFAI+NexzmYLkCCVwqRBTYtezp7JJRPhpY+/qRr8YTRLKJYqYFmlL
	EmpTb90C9VYmTHsU6i0yq7UtHmfb2OBLC5RuBA6fCpxQka2hq94pyEwuvfrJ0F9KFxW4dgnjXXGrY
	TVVnWkIy8VaGFmXWED9J/IZwpUwORsjDSsffPpyCNdgEBzCyngqVH3gJEoBMHHPPH426mjj/nPdLE
	hBx/Ei8vCqQLtaLoUBU8RzFKM5wEftHuZc9kRA1DdajmPJS1Mq+nP4t39pR0BO5CklxLdVnmWf1ap
	UZdFBRow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q11XM-005pzw-1Y;
	Mon, 22 May 2023 09:09:04 +0000
Received: from mail-mw2nam04on2061f.outbound.protection.outlook.com ([2a01:111:f400:7e8c::61f] helo=NAM04-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q11XI-005pzE-1H
	for linux-nvme@lists.infradead.org;
	Mon, 22 May 2023 09:09:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e68rvYppnRHqRUSqyA29XeMQr9ip4ENStKFWYTGFEBpf4uxHfaXvUCsF6pv9fIhtlRhvugEgk6OiRD2ZzW4FdgzgUqHOFYHILp+ErMn8PHUKOccdSK4X9MdIQq4JYYzz2BwuyBd2FdtMOdfVC81VMq+akPpmuDOrNGZ0cKGUg3rz4uzchbOeH+nEzN15XtTR0MS+YKcx0i00wQG9fZIrQ5gYMzayr2V53P9VcOS0z4uCP6XsymHl3tLO6c2apgFlyw7+aJyu1mxJeM/TQzFKhdy45cLoKmvzDaUHZqFQvECRwas2DvDXwQ4n46POPertYFFxIO640e6234Hfq/Q4NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KlDQAEteoGQTD45MGfC6RJaETeChWP0SKeUNYKs38FQ=;
 b=KEwZFkGkf6yANogxXvw9CsrQ3dZfmciyosZ4DzoViKy4K9T0jqls1NhnWTsAuKBtVQndNFfhyFbFjN2bNNoEa5OQ0aVYCf8UXpZJrPjrX/kmyiFjCYLnq6yK1Qdd+YXauMT9fwSsPWhRLVlU0/inv/ForYBDYyn3EXE1yhqNC+8JF+sjCH9J5gSrW83/TM5vIWsnrVjqrxsYyD2azCzVZUT708lusI8N3dFLBQbrnM/yiGbuncTi1Cwb2E07huj5Na37A4AoW5qV7NtAA2Ne7I3sIdEQRpikwJzIx2JAn/G+24U1VRnukjSv+1iy54qvxaIk+BI8NlX4qHVf3nI/Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=suse.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KlDQAEteoGQTD45MGfC6RJaETeChWP0SKeUNYKs38FQ=;
 b=HJqTzpM2stv3V6fEchpf/ld5aaKMhG8t959+GD0TOcIU6kJdnYnCL4n6jKFLslFC76aX4qT0Xw413zGY5ppPrUCfSaVC1leXG3MzqhCUJzkBut78TJHXql2+XEIe4HjvYumd1dUi8uEuWIpJ1B6kGYo8YBakIr4VTcuLyTTjHFnQ1yLozfZpyc3GIKUjvUiDYjOtrh2Sw9LzwLX6E7yCd1Yrr3RmXoGQUT1nQyKHUj3RmPXx8cOhnA74dZeA/oYXnsoJyPBmkuofmw9zTk1/M+9NgRhrStSHvuU0E1+4sdR1GfNcmyf9FmqD7+I2aZ0HcKQTjuHCzMjksoGBkJ9UGw==
Received: from BN9PR03CA0251.namprd03.prod.outlook.com (2603:10b6:408:ff::16)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Mon, 22 May 2023 09:08:36 +0000
Received: from BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::54) by BN9PR03CA0251.outlook.office365.com
 (2603:10b6:408:ff::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28 via Frontend
 Transport; Mon, 22 May 2023 09:08:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN8NAM11FT111.mail.protection.outlook.com (10.13.177.54) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28 via Frontend Transport; Mon, 22 May 2023 09:08:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Mon, 22 May 2023
 02:08:23 -0700
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Mon, 22 May
 2023 02:08:22 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hare@suse.de>
CC: <linux-nvme@lists.infradead.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme-core: init auth ctrl early
Date: Mon, 22 May 2023 02:08:13 -0700
Message-ID: <20230522090813.135540-1-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT111:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 81eca8c4-d51a-471e-b900-08db5aa42019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	+usPDYX3gwq6gOEFPbejirt+Lgqq97vrHEKWRV6z5v+QRk9lVQg4sURsGJvjgjsPPGHuKt210fXh5sXek0mw4jGrD5Op8ikx3iZW1HiQsXF80NX/l2hTD5vsrcYTx128sCvYDklZEo4w7bhLDamKgVWJmnEaaoGc8V0TJP1m7RwyjFIsS06zk6LiuZkCwqqWMiZn+4Chxv+HAKCx2vuAUqd5wRA0tCer1+8Y98ak4DSZOG6DtmPn+CtdECseVHYm5z9ClXzLjHAnJat6JU4CSzKjJUcj9DEP20nOFq7lvVlpwKOTu9eFM7P88P0ZB537peRNArbhcqKF0j9oREIFyvk05A8x7JIvZz/tUxnoIcfokdw1VTA2+qM5QnhxGJgvNLlciXxdak+F8/Vgy+u1HYH9tj8Tgvd71LB2FlryzI8Z6CkhlZZnJkaxrL1J+Wy0j4s5UYEjzaVzDfhMvpBq+meaBB51/BBRJzECgfNOOP0V/q8PUpADOkkiubiHEVgsHGVcRMkA4OBduIIeotIQOSy1iok5oauWAc2BxoTfCPWImmEFST+a5vxlc1ped4j7iRKaxbbcDsjm0sKy/wquzE8p88aimmCwf+nQ5IUdGT1xrpcFXsGh2GnLRpBUu75kqn2UR0hHaibhzpD3zrxURCFZ4ylh3sOEKiXWSLhhvWAMjebd9qRVEWbjgwt/LtbiUlvuMDDpdJZgQB0Xzt7oHtqqwPX5MXMGmvg/P+NG8svoT9imjiv4Q5aNpbMORQkg
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(8676002)(8936002)(5660300002)(36860700001)(47076005)(82310400005)(83380400001)(186003)(16526019)(26005)(1076003)(336012)(426003)(2616005)(107886003)(7636003)(356005)(82740400003)(40460700003)(41300700001)(6666004)(7696005)(40480700001)(70206006)(70586007)(316002)(6916009)(4326008)(36756003)(478600001)(54906003)(2906002)(66899021);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 09:08:36.0875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81eca8c4-d51a-471e-b900-08db5aa42019
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	BN8NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230522_020900_498023_53FC5FD3 
X-CRM114-Status: GOOD (  16.12  )
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

Currently, nvme_auth_init_ctrl() is called at the end of the
nvme_init_ctrl(). Prior to that call, we allocate the discard page,
allocate ida get the controller reference, and add cdev(). None of these
steps are required for the successful initialization of 
nvme_auth_init_ctrl().

The only non-nvme-auth properties accessed by nvme_auth_init_ctrl()
in ctrl_max_dhchaps() are ctrl->opts->nr_io_queues,
ctrl->opts->nr_write_queues, and ctrl->opts->nr_poll_queues that are
set by transports.

Ideally, we should avoid adding anything after device's addition to the
the system that could result in failure, since current position of the
nvme_auth_init_ctrl() adds more code in the error unwind path that can
lead to potential bugs which can be avoided.

Move nvme_auth_init_ctrl() call to the top of the function in the
nvme_init_ctrl() since it allows us to make the error unwind path
smaller that requires less debugging and maintenance.

Note that the addition of the whiteline after return 0 is intentional.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---

Hi,

Please note that this is not masking of the exiting problem that has
been discussed earlier, but it is completely different idea to error
out early before even allocating any resources to remove chunk of error
unwind code path.

blktests is passing with nvme-loop/nvme-tcp with this patch :-
blktests (master) # sh test-nvme-memleack.sh
################nvme_trtype=loop############
nvme/002 (create many subsystems and test discovery)         [passed]
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
nvme/005 (reset local loopback target)                       [passed]
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [passed]
nvme/017 (create/delete many file-ns and test discovery)     [passed]
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
nvme/041 (Create authenticated connections)                  [passed]
nvme/042 (Test dhchap key types for authenticated connections) [passed]
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
nvme/044 (Test bi-directional authentication)                [passed]
nvme/045 (Test re-authentication)                            [passed]
nvme/047 (test different queue types for fabric transports)  [not run]
    nvme_trtype=loop is not supported in this test
nvme/048 (Test queue count changes on reconnect)             [not run]
    nvme_trtype=loop is not supported in this test

################nvme_trtype=tcp############
nvme/002 (create many subsystems and test discovery)         [not run]
    nvme_trtype=tcp is not supported in this test
nvme/003 (test if we're sending keep-alives to a discovery controller) [passed]
nvme/004 (test nvme and nvmet UUID NS descriptors)           [passed]
nvme/005 (reset local loopback target)                       [passed]
nvme/006 (create an NVMeOF target with a block device-backed ns) [passed]
nvme/007 (create an NVMeOF target with a file-backed ns)     [passed]
nvme/008 (create an NVMeOF host with a block device-backed ns) [passed]
nvme/009 (create an NVMeOF host with a file-backed ns)       [passed]
nvme/010 (run data verification fio job on NVMeOF block device-backed ns) [passed]
nvme/011 (run data verification fio job on NVMeOF file-backed ns) [passed]
nvme/012 (run mkfs and data verification fio job on NVMeOF block device-backed ns) [passed]
nvme/013 (run mkfs and data verification fio job on NVMeOF file-backed ns) [passed]
nvme/014 (flush a NVMeOF block device-backed ns)             [passed]
nvme/015 (unit test for NVMe flush for file backed ns)       [passed]
nvme/016 (create/delete many NVMeOF block device-backed ns and test discovery) [not run]
    nvme_trtype=tcp is not supported in this test
nvme/017 (create/delete many file-ns and test discovery)     [not run]
    nvme_trtype=tcp is not supported in this test
nvme/018 (unit test NVMe-oF out of range access on a file backend) [passed]
nvme/019 (test NVMe DSM Discard command on NVMeOF block-device ns) [passed]
nvme/020 (test NVMe DSM Discard command on NVMeOF file-backed ns) [passed]
nvme/021 (test NVMe list command on NVMeOF file-backed ns)   [passed]
nvme/022 (test NVMe reset command on NVMeOF file-backed ns)  [passed]
nvme/023 (test NVMe smart-log command on NVMeOF block-device ns) [passed]
nvme/024 (test NVMe smart-log command on NVMeOF file-backed ns) [passed]
nvme/025 (test NVMe effects-log command on NVMeOF file-backed ns) [passed]
nvme/026 (test NVMe ns-descs command on NVMeOF file-backed ns) [passed]
nvme/027 (test NVMe ns-rescan command on NVMeOF file-backed ns) [passed]
nvme/028 (test NVMe list-subsys command on NVMeOF file-backed ns) [passed]
nvme/029 (test userspace IO via nvme-cli read/write interface) [passed]
nvme/030 (ensure the discovery generation counter is updated appropriately) [passed]
nvme/031 (test deletion of NVMeOF controllers immediately after setup) [passed]
nvme/038 (test deletion of NVMeOF subsystem without enabling) [passed]
nvme/040 (test nvme fabrics controller reset/disconnect operation during I/O) [passed]
nvme/041 (Create authenticated connections)                  [passed]
nvme/042 (Test dhchap key types for authenticated connections) [passed]
nvme/043 (Test hash and DH group variations for authenticated connections) [passed]
nvme/044 (Test bi-directional authentication)                [passed]
nvme/045 (Test re-authentication)                            [passed]
nvme/047 (test different queue types for fabric transports)  [passed]
nvme/048 (Test queue count changes on reconnect)             [passed]

-ck

 drivers/nvme/host/core.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f586a4808e6e..a6487d67d2ac 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4475,6 +4475,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 {
 	int ret;
 
+	ret = nvme_auth_init_ctrl(ctrl);
+	if (ret)
+		return ret;
+
 	ctrl->state = NVME_CTRL_NEW;
 	clear_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags);
 	spin_lock_init(&ctrl->lock);
@@ -4543,15 +4547,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
 	nvme_mpath_init_ctrl(ctrl);
-	ret = nvme_auth_init_ctrl(ctrl);
-	if (ret)
-		goto out_free_cdev;
-
 	return 0;
-out_free_cdev:
-	nvme_fault_inject_fini(&ctrl->fault_inject);
-	dev_pm_qos_hide_latency_tolerance(ctrl->device);
-	cdev_device_del(&ctrl->cdev, ctrl->device);
+
 out_free_name:
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
-- 
2.40.0


