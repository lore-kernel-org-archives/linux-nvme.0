Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A0E0CAC5B0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Sep 2025 20:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+GogJ0otPYZvVnELFf9uH1jKUU7RnVJ9Tilvjw/dplE=; b=NXvbtPt+3VR0w9Z0W0xcy7dzHn
	3/4BznHh59+X/odY/6za7SLB14ZhSCG6q1+fKfyEgd2DWGBCkiVh/jrEQwAiJYT8/v9Mp9jx/jpKw
	Z2w/IF9ImecgX4af7BYmizDReX3PcQoAPBN67E/ftBhuhlZf5jDYBuZGFos4Q2+gxba3ZHNUwTyZb
	eVnMquojTK1ITR9L02khmHjWJsJCl3l6Md5V8Of7h+qrTj7ZuqkVQMPmkOJ1SVajB7vptM5wHk7MR
	G/edkn5r6C9EfLy4rA2veZC/oRV0iYqOT6V7vUaZbD396XzWqgYPaVzBJrBvlC7wTdjLaGhwtc1rr
	OfvhDP8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4b-00000003SNu-3Rd2;
	Wed, 24 Sep 2025 20:26:45 +0000
Received: from mail-westusazlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1W4Z-00000003SKv-3KpH
	for linux-nvme@lists.infradead.org;
	Wed, 24 Sep 2025 20:26:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o92HBjb19EwiXM6kxFv+2G4O6mHRFZdrPI6sygPzu7EhCQHJDpkpEDd0ndgw676n/vyWlNxYGe32RioAr2T3OyKXoKagBL0F7kN2eUx7/LviFxfCzIq9aavfIbc9vu+mnEL5bdqPisVDgTT/hd+n7d4znH4DpTc8FHojbdfFRl6KZPUBX/h0QCtfkzHHjM00vkWxlIoD/QXLFx9NrGK1/1crX9KhaeY3GSxy5Oozc8wXU+gQiYlFHnK8kklAooEoAyjOpN8UrKKas9zOWKHxqqlDyZbna6HMmVrbZeGeaRQT+vv9ImswuGhNEZG9Q1GL61a3E37niusa8exQj6/wPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GogJ0otPYZvVnELFf9uH1jKUU7RnVJ9Tilvjw/dplE=;
 b=mJnntcYOn2jZ6+5r1tQ5VyS70gHFRmjhRUw/hJOxqNUwohLaL1WYOkOPt9gCNrmq4Ezl2PyCzOJp0SWs+HZ25DH67vNZvDfcxoUwUySFXn4NqyFsEdgQYGZHBijndqS780+xypa/J8cdBOr6HnwRhN22k5an1UL0Etl9abAM6IR73BpnGGHWWzrzfI51NZbAXnoEmS3eFVCYFncv4426t5kDyIKrBcjryz32qF2wHqLeXdGgF8TvSIlEq6TvkQkc19ku+9z47wUj2BKJleL9jUfz7w4GkKC516rBAbC83aTDmcMkw9mCT4u82RYTaxO38eNaNvCPAyc7ZaPy9MWr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=lst.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GogJ0otPYZvVnELFf9uH1jKUU7RnVJ9Tilvjw/dplE=;
 b=He1EEG1qnbWVSzJEG3sS5OhNZkg4p1IBuuD69btSW4SvB1kBWjA6LCTrmEUDJCQVa4/BF/eE4xw4NLY4ZRwQ03+tP+bbNiQF9zGcqFOqfrEw7L2hvoz6YkoBcKrqWletPGxzFRuLnCU5eSC8tzhfffHD8gA3vsxM/mxgjOCLyurYKX8SZMCnVxefqXRAtu85ZWSxvAH90V6JONCC2vZdqJdmg9UoTxG4ItpXK6ynyboqVK0mORi8LPM7nUHPynHSuabLmJXNyWX5oNs4j6Rm76qCWMTjz5uQHMvv+rf7uMl+YsR5rVOgB3SC417vPdiupqnZdkFe8LegNwMrbVwgsw==
Received: from MN2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:208:23a::22)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Wed, 24 Sep
 2025 20:26:25 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23a:cafe::9d) by MN2PR03CA0017.outlook.office365.com
 (2603:10b6:208:23a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 20:26:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 20:26:24 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 24 Sep
 2025 13:26:10 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 24 Sep 2025 13:26:10 -0700
Received: from r-arch-stor03.mtr.labs.mlnx (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 24 Sep 2025 13:26:08 -0700
From: Max Gurtovoy <mgurtovoy@nvidia.com>
To: <hch@lst.de>, <linux-nvme@lists.infradead.org>, <kbusch@kernel.org>,
	<sagi@grimberg.me>, <kch@nvidia.com>
CC: <dwagner@suse.de>, <israelr@nvidia.com>, Max Gurtovoy
	<mgurtovoy@nvidia.com>
Subject: [PATCH 1/4] nvmet: forbid changing ctrl ID attributes for discovered subsystems
Date: Wed, 24 Sep 2025 23:26:01 +0300
Message-ID: <20250924202604.7201-2-mgurtovoy@nvidia.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20250924202604.7201-1-mgurtovoy@nvidia.com>
References: <20250924202604.7201-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: e521bc4b-5479-439a-eecd-08ddfba8a1d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7z9bDonE3qnSJ2jXP6hlMkYYxl69AeZB1ixboJUxuIXyhuin/U/dKcwDjjVx?=
 =?us-ascii?Q?uMlI7k3tBrCxhPctKYaXyemhy9IkXFkk7Rqgfr2gQMY92Prf8fBaxDRT8pFe?=
 =?us-ascii?Q?aj1ocKNiBWqntPM2NgBGFmpoY3U695vUi117iP6QdhgyaPIDfa99aAVV6sI8?=
 =?us-ascii?Q?7PqMOmM4VuhQB3pl8BsjJHxc77d6M79u5vbfBzkcSdlzrNYdPxG4Cogm1mar?=
 =?us-ascii?Q?xpArieEGL729whiNXzROm+3fOF/RaKFscUGVjbymnc3FIhuX7bifDSQwQqcH?=
 =?us-ascii?Q?N1+gUQ1pvPAevJ42CLNMLXs9zugADrhrqXP+QTHpS1fISdFtoxo+KZKwHpvn?=
 =?us-ascii?Q?3h+WFSPPKWUtGPjco68K2hHUxWONLOCSSK6tM81q4SQjo2Lv/UOS43iWX/AY?=
 =?us-ascii?Q?KOwaZwtk9xxMigaGPzw8smaUT+ouraLLzYOmVLIJ/IatWLPjZ8+JKOJYcwcx?=
 =?us-ascii?Q?tEPVaqNIzXQcGE+n7xfqjZD/PNAMfsw/2lOj5P534yfaEvB0aGK19t6zTpSs?=
 =?us-ascii?Q?us/4WnSvCbPk5HKbg54KhrIt5uQlPlVkcOJv5mDXvInQ+JtH/nEFXzDXpT30?=
 =?us-ascii?Q?FMxnhqaitTN1b+B2OYYa9XMbbOFUaB24xETfn9r3KZ2S7B2eStWgEjxX6Kld?=
 =?us-ascii?Q?EbXEJS/szQ9SeIhv9FmmwWZle1m8WsTjImBJBe/NOdGvLA9W52uBI+iYhoNm?=
 =?us-ascii?Q?BQnSNe+QgGCcyxIyqK8MgmQpor5pWumIziCiNlOd3d/8JV/0JHEfOVKj7KXH?=
 =?us-ascii?Q?o4fHG2ev8EFhwkXSio/c01R+BkR5EpK5GSuFGQ/jz2H0oNmtyU2vM2ICdIpB?=
 =?us-ascii?Q?cgtD7cUHV1lSHZDddHhqfNIgko/d8RNI72Xb+/wxsitPTJ+h7noLrQ3+tM6r?=
 =?us-ascii?Q?+hwsQr1zRupjfUYIcjYzbKgXxDd29zVrgFXXWbICiXI5chwYsL8YxhZ/YaKQ?=
 =?us-ascii?Q?HX1OIEHxmsKH8pebaGHacy1W6Gr35+84BTGOjo4V3QEDbPEkbw4oz2Wd3tsh?=
 =?us-ascii?Q?zGWEYFZt9BV5i2a17acNAZj6mACtBy3ZBvisvBYHum8sko14Ofw1SwBmQj5D?=
 =?us-ascii?Q?htQmlwaJ5yBZCTeDwo5jIu4boUNItcg6avRbJ7CTr210qgEmF/R/6crj3dP+?=
 =?us-ascii?Q?OOwU7ovIXJvG5M8/zlgidQIj+X1+2atoFElaFnDGryyqiAQwDn+jwL2JU+Cj?=
 =?us-ascii?Q?DL3EodvmRJxhFtHxz1EKRGtPM0MTuYTGyOtbl1/r1kEnp9bF9rZKuyHz0W4z?=
 =?us-ascii?Q?03hBlnC545vvJ4nZy46drBRSxBF10235RX1CG6AI8FK10UnARrnG1jik3fao?=
 =?us-ascii?Q?wPEKOkTLa5V2kein0we9EKAhDIFTmvSYdb2m2/4i8TryMlCePZ5iw9TizRE0?=
 =?us-ascii?Q?+kCvvtfasycpMv+VUpmeeoCPS8PW/5N74RZN3fOTCNndpd1D1dzGohAN4ROM?=
 =?us-ascii?Q?bhOVVAXRZ9sAHKqbsYmPNHcWaKe/iRjF4Lp0X91xa1OcLLtvDtNQnFBqUp7O?=
 =?us-ascii?Q?OUjiI/b6LipaouNWxOcAozQFgAFvsgrptyZ+?=
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 20:26:24.2646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e521bc4b-5479-439a-eecd-08ddfba8a1d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250924_132643_835477_DE6315B4 
X-CRM114-Status: GOOD (  13.23  )
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

Controller identifiers are dynamically assigned when an NVMe host
connects to a target. The minimum and maximum allowed controller ID
values for a subsystem are configurable via configfs. Do not allow
changes to these attributes after a subsystem has already been
discovered to prevent invalid configuration.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 drivers/nvme/target/admin-cmd.c |  6 ----
 drivers/nvme/target/configfs.c  | 63 ++++++++++++++++++++++++---------
 drivers/nvme/target/core.c      |  6 ++++
 3 files changed, 53 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 3e378153a781..72c741a95ac8 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -654,12 +654,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	u32 cmd_capsule_size, ctratt;
 	u16 status = 0;
 
-	if (!subsys->subsys_discovered) {
-		mutex_lock(&subsys->lock);
-		subsys->subsys_discovered = true;
-		mutex_unlock(&subsys->lock);
-	}
-
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index e44ef69dffc2..979eb184756a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1348,10 +1348,30 @@ static ssize_t nvmet_subsys_attr_cntlid_min_show(struct config_item *item,
 	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cntlid_min);
 }
 
+static ssize_t
+nvmet_subsys_attr_cntlid_min_store_locked(struct nvmet_subsys *subsys,
+		u16 cntlid_min, size_t cnt)
+{
+
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set minimal cntlid. %u is already assigned\n",
+		       subsys->cntlid_min);
+		return -EINVAL;
+	}
+
+	if (cntlid_min > subsys->cntlid_max)
+		return -EINVAL;
+
+	subsys->cntlid_min = cntlid_min;
+	return cnt;
+}
+
 static ssize_t nvmet_subsys_attr_cntlid_min_store(struct config_item *item,
 						  const char *page, size_t cnt)
 {
+	struct nvmet_subsys *subsys = to_subsys(item);
 	u16 cntlid_min;
+	ssize_t ret;
 
 	if (sscanf(page, "%hu\n", &cntlid_min) != 1)
 		return -EINVAL;
@@ -1360,15 +1380,11 @@ static ssize_t nvmet_subsys_attr_cntlid_min_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	if (cntlid_min > to_subsys(item)->cntlid_max)
-		goto out_unlock;
-	to_subsys(item)->cntlid_min = cntlid_min;
-	up_write(&nvmet_config_sem);
-	return cnt;
-
-out_unlock:
+	mutex_lock(&subsys->lock);
+	ret = nvmet_subsys_attr_cntlid_min_store_locked(subsys, cntlid_min, cnt);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
-	return -EINVAL;
+	return ret;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_min);
 
@@ -1378,10 +1394,29 @@ static ssize_t nvmet_subsys_attr_cntlid_max_show(struct config_item *item,
 	return snprintf(page, PAGE_SIZE, "%u\n", to_subsys(item)->cntlid_max);
 }
 
+static ssize_t
+nvmet_subsys_attr_cntlid_max_store_locked(struct nvmet_subsys *subsys,
+		u16 cntlid_max, size_t cnt)
+{
+
+	if (subsys->subsys_discovered) {
+		pr_err("Can't set maximal cntlid. %u is already assigned\n",
+		       subsys->cntlid_max);
+		return -EINVAL;
+	}
+
+	if (cntlid_max < subsys->cntlid_min)
+		return -EINVAL;
+	subsys->cntlid_max = cntlid_max;
+	return cnt;
+}
+
 static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
 						  const char *page, size_t cnt)
 {
+	struct nvmet_subsys *subsys = to_subsys(item);
 	u16 cntlid_max;
+	ssize_t ret;
 
 	if (sscanf(page, "%hu\n", &cntlid_max) != 1)
 		return -EINVAL;
@@ -1390,15 +1425,11 @@ static ssize_t nvmet_subsys_attr_cntlid_max_store(struct config_item *item,
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
-	if (cntlid_max < to_subsys(item)->cntlid_min)
-		goto out_unlock;
-	to_subsys(item)->cntlid_max = cntlid_max;
-	up_write(&nvmet_config_sem);
-	return cnt;
-
-out_unlock:
+	mutex_lock(&subsys->lock);
+	ret = nvmet_subsys_attr_cntlid_max_store_locked(subsys, cntlid_max, cnt);
+	mutex_unlock(&subsys->lock);
 	up_write(&nvmet_config_sem);
-	return -EINVAL;
+	return ret;
 }
 CONFIGFS_ATTR(nvmet_subsys_, attr_cntlid_max);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 099a05409ac5..20e7b3d6a810 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1667,6 +1667,12 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (!ctrl->changed_ns_list)
 		goto out_free_ctrl;
 
+	if (!subsys->subsys_discovered) {
+		mutex_lock(&subsys->lock);
+		subsys->subsys_discovered = true;
+		mutex_unlock(&subsys->lock);
+	}
+
 	ctrl->sqs = kcalloc(subsys->max_qid + 1,
 			sizeof(struct nvmet_sq *),
 			GFP_KERNEL);
-- 
2.18.1


