Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBE3BC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Feb 2022 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KivxT5dTqJSazC5RR8Ppo2I5X+TAyZ3XHQboazUA5KM=; b=43m/veK9XQBUCJbF2WiAazEyoQ
	gdZswMuU9SmLUXwv1qHBEsV2Y2hzYmQtOdTdQVFhpsxDNhexoHNn3o2FPIsw5SjSoB6yST525prVY
	/8ijxn41fWZhZK1O6VrsZRSUajX2ZF0EDqzTPPLE8vF+KAZKzwrvLFlJnaH+Yqug9VJgaqEPSS+mc
	sQZLe2sYG2Iab4fDyvktexeaZH5ZcbK9hU0WQpaqGW5jYoERAina55BtdwOCnxCcavKJRf+9sC3eD
	T766PO51QWfv/ZJ0LVd412pTfc8SHM4GihhaIJrBFV5wWUW1xy64jEV2bZVCw6c0YXM6Omt36RbAi
	cAduAWog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nJZZE-00EpaN-MI; Mon, 14 Feb 2022 11:30:52 +0000
Received: from mail-dm6nam11on20630.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::630]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nJYLn-00ERHo-8m
 for linux-nvme@lists.infradead.org; Mon, 14 Feb 2022 10:12:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zm+dYhjsRP2rN1BWbixyU+acOhsg65wh9UqqOOQqc9Qk0TzPY9k7blkbkg0aG5yHTzB9AKrOrb9e22ihFw8GlGWb/S2BKF9sL5XKlBL8dJCC/cPe4hv2bfkMyG8Eh2lbFBUKAiKWGVQSsiOmJ13qKizAKzYMLClmcmFstCC5duK1i4kJJPf7tyDHcmcESTCn1lr1pO1ajDhFOLf815dakErDBGfP2XzkulalIC+6YmzW5dN46URF/i7zeiOKWj1IusQZOYVpmzhwCXTOqOfpeyP3+S7ie5xrQkJU4lRN+XrpUQzEranDdLbXioXgeM7XLsM9jg4ZgD8rwhc+o+eMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KivxT5dTqJSazC5RR8Ppo2I5X+TAyZ3XHQboazUA5KM=;
 b=m8VZeHMZASwopEdfQAxKdqeEJhe7fDLFxAQ48HSnZCJnf4cDQRRgRfJ/1oD6tmJUNfVp67It/9ccDiqxZ++q6wtxjFM9r/gpfJxv/k8g2C5lC85HuswvL+NRUGm88epdpa1an+WD0zPS8sahQ8aFMzSE6ZHljS7TPFHNDMpX4TyL1u316XZZ2Gife5IRU0mkNx1jH999hozPPnhh5UEhKgRLLsJ6c1CfJvfaWp+SEbJy/qIoxxBGNKvJQFMem2o628AWsdZp/8NoCLoICkaDVSvR2bqM5KG7k/KBxkZJ0H4QCkpxW1L8kN+MtfpKLON2Bf/B8tOYH9iCP25DSJt+ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KivxT5dTqJSazC5RR8Ppo2I5X+TAyZ3XHQboazUA5KM=;
 b=ijrSNIfJT3kCLRhlK6c09NzVVnrXTQ0XT6zVoJkWB9TORHWQ2zX3FQ84+pNzauurhJVNIUGCkfIOZ5cAoatH6cr1XSlGCA5AFHLJpDd5gW6l4AcKbFW49oqsWDPsN8v55dezFQ23HHbu5MkCSOCw4Xmhtlm+MFhvr/cUZCr9j18wYmUN0syL2LvcWU7DcC/Bc1sz44n3Wdsjs2EaXL1dfkCCsu+BCZp9wYZXYFCtp0nvdyhiF0GOh1RseLpz9xTKyQ0zwWXZkoX4+c6MGhH+gpKlmNLKYqsgRTGDcidkAws8aorgdXofitB51jA/8HzNy2OXlBNJaRU65cVN3WacYw==
Received: from DM5PR2201CA0016.namprd22.prod.outlook.com (2603:10b6:4:14::26)
 by BY5PR12MB3731.namprd12.prod.outlook.com (2603:10b6:a03:1a7::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.14; Mon, 14 Feb
 2022 09:57:03 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:14:cafe::ac) by DM5PR2201CA0016.outlook.office365.com
 (2603:10b6:4:14::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.19 via Frontend
 Transport; Mon, 14 Feb 2022 09:57:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4975.11 via Frontend Transport; Mon, 14 Feb 2022 09:57:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Mon, 14 Feb 2022 09:57:02 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Mon, 14 Feb 2022
 01:57:01 -0800
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <sagi@grimberg.me>, <james.smart@broadcom.com>, "Chaitanya
 Kulkarni" <kch@nvidia.com>
Subject: [PATCH 1/6] nvme-core: use non-deprecated ida_simple_xxx APIs
Date: Mon, 14 Feb 2022 01:56:34 -0800
Message-ID: <20220214095639.5125-2-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220214095639.5125-1-kch@nvidia.com>
References: <20220214095639.5125-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b695c21-d3ff-4ecc-5471-08d9efa059d1
X-MS-TrafficTypeDiagnostic: BY5PR12MB3731:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3731A9FD840E974BDFCE9941A3339@BY5PR12MB3731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ycuC2vO5wK+RVZaAJnf6mVX7oDhHqYOgz8YCk0xBmwJuflyVCrrDFU21U4kKI0h4E4oLjQFf4K9v4P70FhR+k1Nal1stYnoJPoIz/rSCbJJSp79MIpBObWO5+b84LxgcpVvz3Oeu71rMUKt1Hex25Vgp3PY4nwxM2Be3T0sAqgpKQCp1HYR9DNqJD3LdqlG283iOlTg5G/NYqHWUFkHDfUVeYy7bftqpePF7aOR1cYYGzYnglENC8nl0wMn6oSw0H5eWnmhoyXIENxrH47uj4i55EYxDigGS/wExP5cl87w16csIar5ZjA5PVRfwHxiL4CRYd2GEL/+roRBpE61pzUif37zUU7AUlDCD9p2e25uIFBJag5X6ejvksnTlLRHtIFBKa5sW2A+VCrvJOiV1VzgQGSr5UpDAQzLI3ugZoTrqwhZBj/T//860oS9rofuM8vz0yaXKO6oO65CGHbDgI9kAFfsaKkeIAr+9rTiGt+nI62/bumaM2W3eMeg6ZGgVIqtmxYorGWIGESfPRbTRqL1OGqWCmPX3Mx5q2XY86+7bnULxHg4ylxak7HZ+Dqf/CTCMk9f08TwsYdpzTHJ6Tns82ui8vZ9Q9JPyeaSGbxnxdWBtzJ0nhTe2QesIf56SrbD4ZZ9Q+0xxmCEpVaNYK0bdYZDhGTd/Ni+5u8dANhK2iP4uukYU4LrhXXO8S9eJqqfIVANU1Z+XFFh263rOtQ==
X-Forefront-Antispam-Report: CIP:12.22.5.236; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(2906002)(54906003)(316002)(36756003)(186003)(107886003)(1076003)(2616005)(16526019)(426003)(5660300002)(336012)(8676002)(4326008)(70206006)(6916009)(26005)(70586007)(82310400004)(36860700001)(508600001)(7696005)(6666004)(356005)(81166007)(47076005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 09:57:02.9082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b695c21-d3ff-4ecc-5471-08d9efa059d1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.236];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3731
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220214_021255_340579_66A30C5F 
X-CRM114-Status: UNSURE (   9.89  )
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

As per the documentation present in the file include/linux/idr.h
ida_simple_get() and ida_simple_remove() are deprecated and we should
be using ida_alloc() and ida_free() instead respectively.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd18861f77c0..da0e19148177 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -561,7 +561,7 @@ static void nvme_free_ns_head(struct kref *ref)
 		container_of(ref, struct nvme_ns_head, ref);
 
 	nvme_mpath_remove_disk(head);
-	ida_simple_remove(&head->subsys->ns_ida, head->instance);
+	ida_free(&head->subsys->ns_ida, head->instance);
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
 	kfree(head);
@@ -2565,7 +2565,7 @@ static void nvme_release_subsystem(struct device *dev)
 		container_of(dev, struct nvme_subsystem, dev);
 
 	if (subsys->instance >= 0)
-		ida_simple_remove(&nvme_instance_ida, subsys->instance);
+		ida_free(&nvme_instance_ida, subsys->instance);
 	kfree(subsys);
 }
 
@@ -3616,7 +3616,7 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
 
 static void nvme_cdev_rel(struct device *dev)
 {
-	ida_simple_remove(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
+	ida_free(&nvme_ns_chr_minor_ida, MINOR(dev->devt));
 }
 
 void nvme_cdev_del(struct cdev *cdev, struct device *cdev_device)
@@ -3630,7 +3630,7 @@ int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
 {
 	int minor, ret;
 
-	minor = ida_simple_get(&nvme_ns_chr_minor_ida, 0, 0, GFP_KERNEL);
+	minor = ida_alloc(&nvme_ns_chr_minor_ida, GFP_KERNEL);
 	if (minor < 0)
 		return minor;
 	cdev_device->devt = MKDEV(MAJOR(nvme_ns_chr_devt), minor);
@@ -3693,7 +3693,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head = kzalloc(size, GFP_KERNEL);
 	if (!head)
 		goto out;
-	ret = ida_simple_get(&ctrl->subsys->ns_ida, 1, 0, GFP_KERNEL);
+	ret = ida_alloc_min(&ctrl->subsys->ns_ida, 1, GFP_KERNEL);
 	if (ret < 0)
 		goto out_free_head;
 	head->instance = ret;
@@ -3732,7 +3732,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 out_cleanup_srcu:
 	cleanup_srcu_struct(&head->srcu);
 out_ida_remove:
-	ida_simple_remove(&ctrl->subsys->ns_ida, head->instance);
+	ida_free(&ctrl->subsys->ns_ida, head->instance);
 out_free_head:
 	kfree(head);
 out:
@@ -4429,7 +4429,7 @@ static void nvme_free_ctrl(struct device *dev)
 	struct nvme_subsystem *subsys = ctrl->subsys;
 
 	if (!subsys || ctrl->instance != subsys->instance)
-		ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+		ida_free(&nvme_instance_ida, ctrl->instance);
 
 	nvme_free_cels(ctrl);
 	nvme_mpath_uninit(ctrl);
@@ -4488,7 +4488,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		goto out;
 	}
 
-	ret = ida_simple_get(&nvme_instance_ida, 0, 0, GFP_KERNEL);
+	ret = ida_alloc(&nvme_instance_ida, GFP_KERNEL);
 	if (ret < 0)
 		goto out;
 	ctrl->instance = ret;
@@ -4529,7 +4529,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	nvme_put_ctrl(ctrl);
 	kfree_const(ctrl->device->kobj.name);
 out_release_instance:
-	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
+	ida_free(&nvme_instance_ida, ctrl->instance);
 out:
 	if (ctrl->discard_page)
 		__free_page(ctrl->discard_page);
-- 
2.29.0


