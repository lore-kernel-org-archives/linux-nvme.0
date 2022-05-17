Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B5AC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 17 May 2022 05:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kDdpEN0ze85VSgrc+Sj0Dj3lvlKGj8OfLKkxwhWxpzw=; b=HvOlM5FT506NqsJXyLvcXjIJrg
	WGI8PlpBus6UCXfP+9f0fwDO80ey0EH/pMMHKLVHzjl2JmC6zywMj9Jj7aZaT8S73c+pXc48NCNuD
	NcZENRDqxoONlfW7UREVFpMG2ryIDC/N25TxAXngCtX9ikDiUy6mR3z2sL/lskQBPR0ycjYCkA1Pf
	kNGMkNdewaGnyplDSsCUh9h04DbFN1JcitddtpX8cPe1Zs8Crj/42g1e13Yn+sY56NaWWpG0rdUr3
	hZQy2ZmkXgUUe59aD0n3gY9+ydmd05MEUEeuCw7QgGrXopNpvnxdaXnG3JTsO1QVJawR5THZqBJxY
	0B3QB4uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nqq9C-00BkA9-Md; Tue, 17 May 2022 05:53:30 +0000
Received: from mail-dm6nam08on2061e.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::61e]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nqq99-00Bk9H-6D
 for linux-nvme@lists.infradead.org; Tue, 17 May 2022 05:53:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DFFk7rA29VQISLMHJQZqgPWUsOg35uYQFnmd1O0kXvmuT352o++CsWtdHev7UrCxoFZskRAsHQeb0jC6oyJzmFrE+u/xpN5eGMOehjWDAEZ/z3YXw5gNKXh21cgBPmpJgUeZpH9Rzl/pdfgD5hIKMX95T7i2fIcwkEA1CaszMst4p5lG0sd0A/1oDVQoAB6Rbw9difAojUnFUUQHCYaNZboTZ8a3vh/Jv7l29Ss3MED5yDBniHRvS2uMBNyoM9Znd33KMSc9YyzX7o8glDM0uVP2Tu92TTsnHguJFCdhiGlk+0T2DkcOhAFR4ntXmKOuOPz3DPXN4oef5WC82d7SNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDdpEN0ze85VSgrc+Sj0Dj3lvlKGj8OfLKkxwhWxpzw=;
 b=GpzW+2sHKDuKM5YykiUiVYKvd2wN+mvR/zg2s2N7BlDfJJ8YskhbBJbpBXQs42fKRf5lX5+uM3PpfCbXVEfkTIt74G4yWFVtJpTHJVH7Wk3/8vzX6Rgmg16GJXTcy1hFd4qJjj5z5nnjMumn8/3eU03V5rZ07w56WZZjQt64B3aZa6rARd7y3UxVgW1IpVn7gXTiVNkJLeKQBgUJQLGtjdYKu5a6FkWODpqHgAqbmwhVSuODKcq8EjtrNqZnnJ9px7wUNRjYzGmQMj2FEyl14U3VB3/EYeed/lxdEGe37zQsqoLuu4gJUPlJwpPbGevJ1QLLtBmWrG0gz2gKPMWK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDdpEN0ze85VSgrc+Sj0Dj3lvlKGj8OfLKkxwhWxpzw=;
 b=pThUU630zSKnIwZyQU3FHNX1qNNA2wPzsSNZs2/Z4VKZ3kF6Bx1ceAmEFz5QRuQTLBNqyjZm/pkqOFxmqucccYCLIl5U9j/WnE1SSw0PYq0KhzaRK+r7I7D9/FqeT+y0aixaYTNe1EyyIvY9WrSMnE41s7USOFxKFD9u70gdl/se99s+vTsroWqXxp/esux6RH8xHRbmfC+okRnOgo6CTdGwRgyqozAj2xgCNaNPa8wBLE42UJxN+NblnyZTPgYR93gG/ZUvEE5kuxqVinnrEmRX1F4cKNKmfeEIrxK8ZMLPuwYsCqwwFZTlyPX4QV2CS33w9hKfpDOCGlql3WsRvQ==
Received: from BN8PR04CA0064.namprd04.prod.outlook.com (2603:10b6:408:d4::38)
 by MWHPR12MB1293.namprd12.prod.outlook.com (2603:10b6:300:9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.16; Tue, 17 May
 2022 05:53:22 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::4d) by BN8PR04CA0064.outlook.office365.com
 (2603:10b6:408:d4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Tue, 17 May 2022 05:53:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.235) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5250.13 via Frontend Transport; Tue, 17 May 2022 05:53:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Tue, 17 May 2022 05:53:20 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 16 May
 2022 22:53:19 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>,
 <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH] nvme: set non-mdts limits at I/O queue creation
Date: Mon, 16 May 2022 22:53:12 -0700
Message-ID: <20220517055312.50331-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc9e875b-75bb-4d59-42d3-08da37c98ca7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1293:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB129372448B796AFEF71BD3B0A3CE9@MWHPR12MB1293.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZscnWUOW1x2BTmfFNLvWvrqzMK0DlxoP45CAp1tmwMW+fXfIhjueq5/nRJ/6VjYUALMl+mevP1Q51RtHdHixyWSPaO3J8gEZ1bL12MXOfFFNa37lZ+Ajuav9jlRLG6C0VHc/zMqirjscM8uu0yV12M6bAR4ON3M+c9FjeLOwM9JbnliMWU5T2ukqTuzOOthUPmF/UTvWeP+JZib6+fOlIdt5vGW5Sacfa81SyW5JZXLQM9xalajEBexlEAi2bmTga/mVWTeSoF0An/LpTQA1aW1cn/7GSTMH1zSQaCfTnJc8+0+pouUgZJPNbFC7h1+MtS7y81vAW3STxp7fNgVvUpYVXfLJ8MPSitZWK+WSQbaUqeJkKszfHVN2TxeVJh+QEdpzXyZCoyF6QJxZkOiMsOp8SaiVwXeqtx+R6su9aV+d4+jpGgwnwTBC9ARNxel3l7PNcwP8DJA14IePbO1CAxM++EBi6/bjek8hFfmsJAp7aUXnIT21EKLwGSf+wZCtXTX00fOjHLvuZUy9tjz/YXxUD4GelWhxuhexkFRahA/KQfiNROQ+dth/oTRM1KFL3EbW59dRaQtVHFot26/ZUbcpWG2wz+/v8x1/YDsuEADDfNzvf8KxtKcAhJAD13aMiPwZj7M1lOx2El056KGvxhBX+9alCFmkMDcZPbJoXa0vHTtmd24Sz0NtHXY606q7+TG9B+CiF0alPTlUE6nGjg==
X-Forefront-Antispam-Report: CIP:12.22.5.235; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(8936002)(7696005)(356005)(426003)(47076005)(16526019)(107886003)(508600001)(336012)(2616005)(6666004)(5660300002)(36860700001)(110136005)(8676002)(26005)(82310400005)(70586007)(70206006)(4326008)(36756003)(54906003)(40460700003)(186003)(1076003)(83380400001)(2906002)(81166007)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 05:53:21.2353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9e875b-75bb-4d59-42d3-08da37c98ca7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.235];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1293
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220516_225327_277727_E69A6229 
X-CRM114-Status: GOOD (  17.68  )
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

Export the nvme_init_non_mdts_limits() and move the same call from
nvme_ctrl_finish() to each transport right before each transport calls
the nvme_scan_work() from nvme_start_ctrl() path, then proceeds to the
ns allocation where these limits max_discard_{segments|sectors} and
max_write_zeroes_sectors are actually used in folllwing path :-

A. nvme_scan_work()
...
nvme_validate_or_alloc_ns()
  nvme_alloc_ns()
   nvme_update_ns_info()
    nvme_update_disk_info()
     nvme_config_discard()
     blk_queue_max_write_zeroes_sectors()

1. FC:-
nvme_fc_create_association()
   call nvme_init_mdts_limits() <---
  nvme_start_ctrl()
   nvme_scan_queue()
    nvme_scan_work()
     path to ns alloc & accessing ctrl non mdts limits see above A.

2. PCIe:-
nvme_reset_work()
  nvme_dev_add()
   call nvme_init_mdts_limits() <---
  nvme_start_ctrl()
   nvme_scan_queue()
    nvme_scan_work()
     path to ns alloc & accessing ctrl non mdts limits see above A.

3. RDMA :-
nvme_rdma_setup_ctrl
  nvme_rdma_configure_io_queues
   call nvme_init_mdts_limits() <---
  nvme_start_ctrl()
   nvme_scan_queue()
    nvme_scan_work()
     path to ns alloc & accessing ctrl non mdts limits see above A.

4. TCP :-
nvme_tcp_setup_ctrl
  nvme_tcp_configure_io_queues
   call nvme_init_mdts_limits() <---
  nvme_start_ctrl()
   nvme_scan_queue()
    nvme_scan_work()
     path to ns alloc & accessing ctrl non mdts limits see above A.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c   | 7 ++-----
 drivers/nvme/host/fc.c     | 4 ++++
 drivers/nvme/host/nvme.h   | 1 +
 drivers/nvme/host/pci.c    | 7 +++++++
 drivers/nvme/host/rdma.c   | 4 ++++
 drivers/nvme/host/tcp.c    | 4 ++++
 drivers/nvme/target/loop.c | 4 ++++
 7 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42f9772abc4d..8bc0d10931e7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2854,7 +2854,7 @@ static inline u32 nvme_mps_to_sectors(struct nvme_ctrl *ctrl, u32 units)
 	return val;
 }
 
-static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
+int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 {
 	struct nvme_command c = { };
 	struct nvme_id_ctrl_nvm *id;
@@ -2905,6 +2905,7 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	kfree(id);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_init_non_mdts_limits);
 
 static int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
@@ -3082,10 +3083,6 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	ret = nvme_init_non_mdts_limits(ctrl);
-	if (ret < 0)
-		return ret;
-
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 080f85f4105f..a04a0627b0a0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3168,6 +3168,10 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 */
 
 	if (ctrl->ctrl.queue_count > 1) {
+		ret = nvme_init_non_mdts_limits(&ctrl->ctrl);
+		if (ret < 0)
+			goto out_term_aen_ops;
+
 		if (!ctrl->ioq_live)
 			ret = nvme_fc_create_io_queues(ctrl);
 		else
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 81c4f5379c0c..2f3c6fcaa440 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -784,6 +784,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg);
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
+int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl);
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct pr_ops nvme_pr_ops;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5a98a7de0964..2ceca29ad997 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2526,6 +2526,13 @@ static void nvme_dev_add(struct nvme_dev *dev)
 {
 	int ret;
 
+	ret = nvme_init_non_mdts_limits(&dev->ctrl);
+	if (ret < 0) {
+		dev_warn(dev->ctrl.device,
+				"reading non mdts limit error: %d\n", ret);
+		return;
+	}
+
 	if (!dev->ctrl.tagset) {
 		dev->tagset.ops = &nvme_mq_ops;
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b87c8ae41d9b..7acce264375d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -971,6 +971,10 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	ret = nvme_init_non_mdts_limits(&ctrl->ctrl);
+	if (ret < 0)
+		goto out_free_io_queues;
+
 	if (new) {
 		ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, false);
 		if (IS_ERR(ctrl->ctrl.tagset)) {
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index bb67538d241b..2a9c32afb6e7 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1899,6 +1899,10 @@ static int nvme_tcp_configure_io_queues(struct nvme_ctrl *ctrl, bool new)
 	if (ret)
 		return ret;
 
+	ret = nvme_init_non_mdts_limits(ctrl);
+	if (ret < 0)
+		goto out_free_io_queues;
+
 	if (new) {
 		ctrl->tagset = nvme_tcp_alloc_tagset(ctrl, false);
 		if (IS_ERR(ctrl->tagset)) {
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 59024af2da2e..2ac9017e966a 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -522,6 +522,10 @@ static int nvme_loop_create_io_queues(struct nvme_loop_ctrl *ctrl)
 {
 	int ret;
 
+	ret = nvme_init_non_mdts_limits(&ctrl->ctrl);
+	if (ret < 0)
+		return ret;
+
 	ret = nvme_loop_init_io_queues(ctrl);
 	if (ret)
 		return ret;
-- 
2.29.0


