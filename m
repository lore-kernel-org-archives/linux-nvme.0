Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C52BBC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 18 May 2022 15:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xWG7juevKezL4M2bUsvV2JpDKVZZ/JrYVJkl3FvuGjQ=; b=UhNBJsfBZ3sVCcipXteMmKQjyf
	VFY1dwug6Gn99tDOKtoc/dpJJXzDBxI0Boyv6NivYF8V7bmP29tUTlkz97KB4cC9Opv+FHH8nrpu3
	xcBj3pgVm79rpR/0bkkGBFxexDSI0Py8JElFlBf0YjuQcY+gt+Jgnq1aJoNz1ofd6yB4sN2IFVCnU
	h4cRXTS2mDJ48DLjra+T9FlXpIOh5RcrVmdKbjMPiSYyS+Kpc5hYLjgf9vnU4SGdwPdfQNsi3SxJ0
	KH4/HuXLtxwc0EiewkFeUmVBvSfwIM4T2ZIPN/qUcoK5eE38RjRE3emWVp0uyRx7pbdaNBbQFASyi
	c1ERaVtQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrLxu-002vA9-KX; Wed, 18 May 2022 15:51:58 +0000
Received: from mail-dm6nam08on20622.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::622]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrLxr-002v9F-PK
 for linux-nvme@lists.infradead.org; Wed, 18 May 2022 15:51:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YsMdAmGCObP3sxAFlKLiISmgHsOx5OYSQuDMg/OOpPGUmT1AtC8UQuJL5j8AaMrZfOfKiWUVJ8cUZ78R1D/vOTvMXH9Pwey3GLlOFEtgIPOaSVn4HvNeS2HSl6zfzURuSOaYHDENIrTKQKSmA8NOycV/g+9wQnbLzQ6073aRZ6ZZczjKdBn0CW8FlSXEuhYNeT7zCNuxxFwv8Q4INpS327hEHkdiFwJPoZ6aYLLBkDMAtYJ+3JL+M51APcG/cz3gHTBgvPxR3IUlhIHj64qYwagxuQOnxxkqy5zzz92cAGnqCwX2MlAz9hI6pa0BJLjS6gVkpvIjFKLsVHrDgiAACg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xWG7juevKezL4M2bUsvV2JpDKVZZ/JrYVJkl3FvuGjQ=;
 b=JQAvwrsja+wt76/qibTWs1ZX3EbyhpZv0fVHV98LRfyOcqqeVA8YNKXkmataY6cEzDtl+aNvpt6pL+p5citfimKXw7rKiQyc+bmtINeExTf/NglKU8SQhOPDCitsR4Yv9ArYiWGSMgf/UJK4WSQhvtZQHDShMW870XWATjZO3EGTYYDsgx+PhVRQ2bMmFodxRuSR98n/JBSO2IMZqS8SedT8hFkB4ivhuO2oumW9p9ouDR5r8IFOqWRpvQsjy4utZ+x6HTdRhSdIBSDVOTdA0vQ6n+41WC1cToXdtygNR4X/tYyUXWWkkOcvBpIxAodg6mVuuNCSRlMzX9obIdLmDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=broadcom.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xWG7juevKezL4M2bUsvV2JpDKVZZ/JrYVJkl3FvuGjQ=;
 b=hnJeFXKa9W3Mg7QFErt/j5AdizG/12ogl63D54IPAXQ29rE1BEN16DO6YXG/yd248Vut0ywFAUTDN4hcE3v6dZAbToAHHsCa6xTyL8+Szd5KGDuFQ4sohTW3k1zRlglkovseJloFAM0CNTktWex/wTjacSJInTvK8H8QrjXJV7wLY8tY5+8ptF7OLLoKHwx1WmkbMY/AcGcdJkTWHpcM/CASD//B/QIBdlJFbEWyWfWdCY/Czpsx+DZKbagp+8NqAB+akN324z7IKSQMZ7ArA0+38BL/2WSRt9bz6lovelaRzZZhFhgCNRkHH2xBfzvZOLFcrgaX9wjGJtMBxdFuRw==
Received: from BN9PR03CA0632.namprd03.prod.outlook.com (2603:10b6:408:13b::7)
 by DM5PR1201MB0121.namprd12.prod.outlook.com (2603:10b6:4:56::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Wed, 18 May
 2022 15:51:51 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::b7) by BN9PR03CA0632.outlook.office365.com
 (2603:10b6:408:13b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14 via Frontend
 Transport; Wed, 18 May 2022 15:51:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5273.14 via Frontend Transport; Wed, 18 May 2022 15:51:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32;
 Wed, 18 May 2022 15:51:49 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Wed, 18 May
 2022 08:51:48 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>,
 <james.smart@broadcom.com>
CC: <linux-nvme@lists.infradead.org>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V3] nvme: set non-mdts limits in nvme_scan_work
Date: Wed, 18 May 2022 08:51:38 -0700
Message-ID: <20220518155138.120470-1-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b6883d4-433e-4b9b-e0a1-08da38e652ab
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0121:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0121A356EBF4429E63822C7FA3D19@DM5PR1201MB0121.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DgpfRgsd0jZSdxVZf1GmLMbHpFguoM/pih1aUvC7n4eG8yyo6KksPztIrZCb1PqbvuWoFo+Vy6at940Wl6auMzDo2vkXdXreAx7mTrU7GP12ngkO3dVDN8f1m//FGBGVOHnhjqXqkN9JdAGEh4I4VhOQK1/eN9bL1+DFCV++hG+ZOeZdcgOaqWNRBCEqHtvPBv+2t7wK/ZBWyhwY5aV6KpaBmu5nJtMcEoHTt8vad+eJaHVdhsQznmuT/s7PxP8XD+mol6SPy2jWesgxa+0exS6wPIvrE6LSJQCoPeZ3CCXl1vnTyILbQxiSB/sJ2M818unx6gJtp8V1b/J5mKugSguMR3vDEN1jWw/QvKgR0KWSLoI5YS4D5hzxPmuOVSs1Jovm7LqqMe+XB5vlbVrny5BqezoU20h3NkBsGYoSRbYRN+aNMc1TeZbCxrzKT7gUtDe7ccYT3ibhYhM61OTOueeYqL9Y4ZT15JBZEIZtXidlyRpk5kie0agpuH5CZOB1UyK6kj9/6SBNgFaM+K8hd8UEP4wWY8DpAGU9OiausgVCStg5U3aRb6cjI9YTMcZK1KWwa4kHkul+8avEkE80ff9kStKrR1kx6Tft976LrotubWxDbt4T02keVLJCCjY49OtEPAK37itvmXE/1+T0pqMFDjNW3SvoA2qnE3Co6LNOV51jAKxbgn6ZvIUwdNt6LgCcGRYjGD+Wunl7vm5VsQ==
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(16526019)(316002)(110136005)(26005)(8936002)(70586007)(426003)(107886003)(70206006)(1076003)(83380400001)(54906003)(2616005)(186003)(5660300002)(81166007)(7696005)(36756003)(508600001)(356005)(2906002)(40460700003)(36860700001)(47076005)(82310400005)(4326008)(8676002)(336012)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 15:51:50.5257 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6883d4-433e-4b9b-e0a1-08da38e652ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_085155_864735_FFB55968 
X-CRM114-Status: GOOD (  17.01  )
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
 nvme_fc_create_io_queues(ctrl);
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
nvme_rdma_setup_ctrl
 ...
  nvme_rdma_configure_io_queues
  ...
  nvme_start_ctrl()
   nvme_scan_queue()
    nvme_scan_work()

4. TCP :-
nvme_tcp_setup_ctrl
 ...
  nvme_tcp_configure_io_queues
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
* changes from V2:-

1. Add a comment why we need to re-read the non-mdts limits at the time
   of every ns allocation.

---
 drivers/nvme/host/core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42f9772abc4d..140f589305d1 100644
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
@@ -4239,11 +4235,26 @@ static void nvme_scan_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, scan_work);
+	int ret;
 
 	/* No tagset on a live ctrl means IO queues could not created */
 	if (ctrl->state != NVME_CTRL_LIVE || !ctrl->tagset)
 		return;
 
+	/**
+	 * Identify controller limits can change at controller reset due to
+	 * new firmware download, even though it is not common we cannot ignore
+	 * such scenario. Controller's non-mdts limits are reported in the unit
+	 * of logical blocks that is dependent on the format of attached
+	 * namespace. Hence re-read the limits at the time of ns allocation.
+	 */
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


