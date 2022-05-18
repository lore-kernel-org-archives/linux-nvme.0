Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FA9C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 07:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TsC/YQjePnu3SxYZSlwxubkdUpiP2xZac/+eAMVORyM=; b=kMvTbvM9BNqR34UE7sg0RoPQJI
	dWybd5Q8t8MzY9cmOepC+kcdOw2K4uDW2sC7IbY4wkzs9ApeiL0/QfeVlhLd5iP022/HFwbsuIXSW
	tLO7yxAU1zVuxG7sC+PyhE6hTGV6ZuefsJmiLY3sbe+wFTxNWVSBZZc7HKywfoEYaNZK2Nm95BWMD
	RlBdO6JS1xVSwZPyydiFeJ+rIg3Kn217DpzytbO1g39MsMIK9gqdnSYG7DDLiPlPhH0zQ8yloKaCy
	fJ7dmxT7xCEkwCEEvJJOTcQyN+0IQ9MGXUp1z/EoRLgr9EvEdrKypRCy8eBcFTGmMMmSkYWgRaWFR
	CKf53pOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrDk8-00HY7Q-9B; Wed, 18 May 2022 07:05:12 +0000
Received: from mail-mw2nam12on2060c.outbound.protection.outlook.com
 ([2a01:111:f400:fe5a::60c]
 helo=NAM12-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrDk5-00HY5d-6r
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 07:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuVZJ85mDktfi5gOKYUIHs6A7PokqQdEQaeIa+WKCww+PLDronU3AB+USUTchfRdztCeLE7c4/16xR+AI7J4K8Rn9qBKiNiy9CDzE+GGqIoA55KU+yhX9exAhL12UfQuPfaeslBxrxTy7RFvjg2v+fzNflZ1Zy3aGREvUfo7PSw3YS6T7+pn40396s1TM+3mOrqqNupXZy/GENQ0u0ockOLq9qIdmTGpy2u7VsEAMqeMMSPQkufN30bdAgcWBlHVo+Jspaig5LMLA/cK2bC+EFiiZQp4kRmaVlSUbRTcpCJJuAWg+aCoCj6amAc7UXwDtxzxmqt0udBq+y7u8o/eTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsC/YQjePnu3SxYZSlwxubkdUpiP2xZac/+eAMVORyM=;
 b=Eh1OB9znv8lx1XHGxyy8jBYNCMCM/Op6fR7ptvZTHh7D84SK+RTttZixfiTyWinO1ZA+NTV7N5Xb4ig2e2EpnqTm1jCErw9Lnvz4YlYDt1TadIAKishqL0cckPrjjNMAQDDUGAAkEK4WfQRiKaZxiRsdpkU8Iv9oh2a6pPqbWEgjzHTvCyf+JxVSZPL56aG33vW2VbLCkGp9kxZQM3jgs6Enn5cgU+u9LFoES0f++CuW/giIM/iUPTzz1wRV6PzzDwaMVMCVF5mWeu4LHCPtMWQF3JKLOS6xzUP6ykh/GNiuAu3gMp6XOJ5397ONkRejjYfxaGOZjGAUulcAju8l9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsC/YQjePnu3SxYZSlwxubkdUpiP2xZac/+eAMVORyM=;
 b=pKkCGaK63N75oZm/78Azyz3XE2zavMx6Pca4euep5XUUuSaWS4ceXNWYTsMQhXJXyy4IweLpdWIemQwFOGZwBSZHb85SkRA/FXfCKx5hboExamHXgKmGqQM+7Y8lIikNg6lSVI+5cVn8RF1orVpkQkaMq0n77YgPt12xH5s0OpeJQdTcBIqCZ4fPpNqwdEW1p+eAt03y4hcY9tzti2stCIaHBMPfzJN5HNZxgGFlemSDMju2OMIiIRKo8ta5kMBxv2+HlyowifHd2MrJh/rRNRvZPWkhraG9B9OepTG8wL8Ax5ADnPgfhINf1zH2zNpiZw40JQKVMln+je7oiZyaKw==
Received: from BN8PR04CA0015.namprd04.prod.outlook.com (2603:10b6:408:70::28)
 by MWHPR12MB1920.namprd12.prod.outlook.com (2603:10b6:300:10e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 06:49:54 +0000
Received: from BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::f5) by BN8PR04CA0015.outlook.office365.com
 (2603:10b6:408:70::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.13 via Frontend
 Transport; Wed, 18 May 2022 06:49:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT026.mail.protection.outlook.com (10.13.177.51) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 06:49:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Wed, 18 May 2022 06:49:52 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Tue, 17 May
 2022 23:49:51 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>,
 <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2] nvme: set non-mdts limits in nvme_scan_work
Date: Tue, 17 May 2022 23:49:44 -0700
Message-ID: <20220518064944.4228-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29655998-969a-4042-3963-08da389a9cd3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1920:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1920638D4AEF4B0FA7950A25A3D19@MWHPR12MB1920.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsx4pbFm3pJ2dWV9jcG9bpnUD2HkRZHZb8m9LM3A8KiNIo/XUHHKDu8K4gRUtBLa/9HAEXqiLZCD1sIuf2hEfiQmuRPvjdADOQqTDKZuQCoe+kdmzfCqbjZw/wzuAH2tmMCwnhSE/I5pvntolLCnb6wWdO8nJBkAzHq40UuVGx0PRIB8KpZmlL1p7H8bq29MRTYwO04oj13iitkAxJcnVm+JVX/37aWQHktEzLdopQrnGxAAAP1Az7BsSbk4bYyLtIK0tnoh7UvOYTLhEr8ERUAjPMDGb2CuI6yHA2yC9SnQIg4OJBxMWSlgx+lrI58XTYxMwQzEA5E6+BtE/XvB3ziiBsbmVhKaa593liTKi+sjomDMMuZWKC/6qhFdBsquMT0bsYL0Ill23I4+TzQiofUox+wtulkn1k+l7171WOMBPYn4nef3QDch/jbCY1Y2OWfUpmFQM0bsjlgr5olVJ2nGE2uHvD3FsJ52n4RxmbVCB39BsDpBzydtT9hg127rtmoVl7+2WheeidgufZB8LjLyRnIA4NbWHBeRne0Rq02ChfuAjZwxXeTm9wOT4uV6CV7yXgicRQ6jWYpbYvjcsnvVL8CIUGSW0pbhKoJQ3DsqsrMdbr6Q37vZyl7uZ4ZQVjPDTdRWKp1833MYDWpKb4od0LndoUAo2gJ6OLpGU88Od5AbKmGTKUEIJWE8MY9NIMXgi8ansuj3HGJZ40AWsg==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(36756003)(7696005)(508600001)(47076005)(336012)(8936002)(107886003)(426003)(36860700001)(81166007)(186003)(1076003)(356005)(70206006)(110136005)(5660300002)(26005)(40460700003)(4326008)(8676002)(54906003)(70586007)(6666004)(316002)(2616005)(16526019)(83380400001)(2906002)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:49:53.1835 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29655998-969a-4042-3963-08da389a9cd3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT026.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1920
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_000509_281325_D639AAE7 
X-CRM114-Status: GOOD (  15.88  )
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

In current implementation we set the non-mdts limits by calling
nvme_init_non_mdts_limits() from nvme_init_ctrl_finish().
This also tries to set the limits for the discovery controller which
has no I/O queues resulting in the warning message reported by the
nvme_log_error() when running blktest nvme/002: -

[ 2005.155946] run blktests nvme/002 at 2022-04-09 16:57:47
[ 2005.192223] loop: module loaded
[ 2005.196429] nvmet: adding nsid 1 to subsystem blktests-subsystem-0
[ 2005.200334] nvmet: adding nsid 1 to subsystem blktests-subsystem-1

<------------------------------SNIP---------------------------------->

[ 2008.958108] nvmet: adding nsid 1 to subsystem blktests-subsystem-997
[ 2008.962082] nvmet: adding nsid 1 to subsystem blktests-subsystem-998
[ 2008.966102] nvmet: adding nsid 1 to subsystem blktests-subsystem-999
[ 2008.973132] nvmet: creating discovery controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN testhostnqn.
*[ 2008.973196] nvme1: Identify(0x6), Invalid Field in Command (sct 0x0 / sc 0x2) MORE DNR*
[ 2008.974595] nvme nvme1: new ctrl: "nqn.2014-08.org.nvmexpress.discovery"
[ 2009.103248] nvme nvme1: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"

Move the call of nvme_init_non_mdts_limits() to nvme_scan_work() after
we verify that I/O queues are created since that is a converging point
for each transport where these limits are actually used.

1. FC :
nvme_fc_create_association()
 ...
 nvme_fc_create_io_queues()
 ...
 nvme_start_ctrl()
  nvme_scan_queue()
   nvme_scan_work()

2. PCIe:-
nvme_reset_work()
 ...
 nvme_setup_io_queues()
  nvme_create_io_queues()
   nvme_alloc_queue()
 ...
 nvme_start_ctrl()
  nvme_scan_queue()
   nvme_scan_work()

3. RDMA :-
nvme_rdma_setup_ctrl()
 ...
 nvme_rdma_configure_io_queues()
 ...
 nvme_start_ctrl()
  nvme_scan_queue()
   nvme_scan_work()

4. TCP :-
nvme_tcp_setup_ctrl()
 ...
 nvme_tcp_configure_io_queues()
 ...
 nvme_start_ctrl()
  nvme_scan_queue()
   nvme_scan_work()

* nvme_scan_work()
...
nvme_validate_or_alloc_ns()
  nvme_alloc_ns()
   nvme_update_ns_info()
    nvme_update_disk_info()
     nvme_config_discard() <---
     blk_queue_max_write_zeroes_sectors() <---

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
* changes from V1:-

1. Instead of duplicating the call for nvme_init_non_mdts_limits()
   move it to the nvme_scan_work().

---
 drivers/nvme/host/core.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42f9772abc4d..8cbd70606f09 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3082,10 +3082,6 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	ret = nvme_init_non_mdts_limits(ctrl);
-	if (ret < 0)
-		return ret;
-
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
@@ -4239,11 +4235,19 @@ static void nvme_scan_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, scan_work);
+	int ret;
 
 	/* No tagset on a live ctrl means IO queues could not created */
 	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
 		return;
 
+	ret = nvme_init_non_mdts_limits(ctrl);
+	if (ret < 0) {
+		dev_warn(ctrl->device,
+			"reading non-mdts-limits failed: %d\n", ret);
+		return;
+	}
+
 	if (test_and_clear_bit(NVME_AER_NOTICE_NS_CHANGED, &ctrl->events)) {
 		dev_info(ctrl->device, "rescanning namespaces.\n");
 		nvme_clear_changed_ns_log(ctrl);
-- 
2.29.0


