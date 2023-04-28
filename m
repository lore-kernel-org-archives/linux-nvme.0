Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C4F0C77B61
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Apr 2023 07:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zUwD1cfzm0x86rVLTV9Wd2dLY9Qmy8ssqNNZDxEHiwk=; b=Jz/+MWTdBRihzeUZkSSdS6MSgc
	PwHxU6RVwFYgSAHTKK4zJ3T679W79C9fH/3s88MLxFL6DeqSac1LuR4hvm97/2p9tWqdsfXlsWBh8
	zuaewxmGEW7HpG3u7sVVTtzcunPhARR5OoPdh89GpUheJbudtDiv1SBs8+UDlsVIbFmwz5YMKz8OJ
	lm8t5ambuVQRztcQoQG4S1EYU7M6lqb2SOYT2ywOMztWzBiSMB4pV2t27/K0wpz/s9bisFSh85Hq4
	qYcRUhnCq7IGS5kxy7hmf8B/QG+LYpDe2IYpzUSWMHwB6a2riMtybemg15zreYhtACd4w814VjPvS
	zurHR3HQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1psIaa-008QST-1T;
	Fri, 28 Apr 2023 07:32:20 +0000
Received: from mail-bn8nam12on20604.outbound.protection.outlook.com ([2a01:111:f400:fe5b::604] helo=NAM12-BN8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1psIaX-008QRc-34
	for linux-nvme@lists.infradead.org;
	Fri, 28 Apr 2023 07:32:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IU/739wR0+W8uT8rtWEv0OZwmcNpujbLe3JIzCXKI/CW5gfc/iyMdn6a9WV/GatGPoaQZ5KqwcOa/43mC97qXtVfkzbdnDWWPkVMBIarGe2zgfeoTpy2ttB4pySQAfxn0uZX0evmGyc65YdA0ZXWZIo2t4JhrSEa6dmMYMMc7xBDeDWYheQA9Ia2CBVowukoM3g4L2YPmWD+rlWf88L788i0IpRD+p/Uw0RKfIhw3lhR/PgxCIyCXHZbpZpFonIrP3NvGmfQbz46QZemij6o/gKpCuU0CDuKzd7xkmQaP/lnT50eUw/CDYUK23pBnMnmJo1JF4t/ld4hCFhgMXaxPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUwD1cfzm0x86rVLTV9Wd2dLY9Qmy8ssqNNZDxEHiwk=;
 b=AtizsV35yjpIy8Qc3mSxKXAKpRT/7BwbS3i1LZSsvaRlHTYdj6qmdLveofqmsYVhMgqJh6XnmmPd8MRFT8aTCDdteqIiuufD/pk2uqByax1OTfty2kdZQUJjO1s/FuCXejnBoeDMQXqR742cB5KNNW8SlYFuonkVMK7uHoifNsjAmy7hIt/jYXGETOwTCHZwJ0as0ShZzigiTaCPipY5GNDjQAgKyAIhrUSvQ0E3gaLf9XdEvMvdBmt6bxkv4t7ELfdVHJeVXYLSJAzbXHB5Zhh9rQDhwWPWzazzd12KA3fr6nRrVVVPL54GukFGUm5EF1cy0Z8bkbwXEZ1BPNaLgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zUwD1cfzm0x86rVLTV9Wd2dLY9Qmy8ssqNNZDxEHiwk=;
 b=iQZxi0gJ4xEvH0kWYEEHxosXrk8Ans+JfgMLCcrRD5zJ8k5dZEMhZP5P8aVx/wjq+3YGBQU32wD81LTjXO9W3VsvIhpybYMHEQ3Idc1SO1NtRXqAJM4LaazpgnN6DBNywyhR14kTLvRamBEUsalmVsNIbqB7eLRxzOy3eKwJ/npDUsfCEgW1yDhXA25Dbzz///NP50Ms6ArjhtQmJLl0bo8/3U9zRFsHaxRoyDgzMVrDSrn2nF9DCAmt4jvSbT6OfrMv0XO0IWTmjDotPBOJtIYlB9y5JCP3hpzIuoIeXkBjd6zT9FXfui23gft1bCl04QT8EBopJpPWKe2wQqcktQ==
Received: from MW4PR04CA0327.namprd04.prod.outlook.com (2603:10b6:303:82::32)
 by MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.21; Fri, 28 Apr
 2023 07:32:13 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::f8) by MW4PR04CA0327.outlook.office365.com
 (2603:10b6:303:82::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.24 via Frontend
 Transport; Fri, 28 Apr 2023 07:32:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6340.24 via Frontend Transport; Fri, 28 Apr 2023 07:32:12 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 28 Apr 2023
 00:31:58 -0700
Received: from dev.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 28 Apr
 2023 00:31:58 -0700
From: Chaitanya Kulkarni <kch@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hare@suse.de>, <kbusch@kernel.org>, <hch@lst.de>, <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH V2 3/4] nvme-core: add missing fault-injection cleanup
Date: Fri, 28 Apr 2023 00:31:14 -0700
Message-ID: <20230428073115.22987-4-kch@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230428073115.22987-1-kch@nvidia.com>
References: <20230428073115.22987-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT041:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 28405125-dcf8-41db-d0a6-08db47baaec6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	zog7lFMR/3jeZ4mjK499v96HUjnPwooguS+4mhcGrtBAtV9UPHM/cqAIWSRp2hXgReDkzjZoAjB4w3pi48l4/Yp/dQAO7fEllkGbQTylvH/NAOF+ToXaPNlwfUm1S3Dh0sJfbb03a8K3PoeokIT7tzy6xYARGbtQ5SrnSalfaT0NjDJV5TO5nSfPPSCyZrqzRNv9rEQpLeLHBiHckZP+9+4RsuidzJvXUlqxtnXduV2Xouumab1lGStJBjDR8xJilHJXP5D6s9yizfm2daMhH4ToSSsTBF5+g0NB4fhCCfeTN5yIexXH6fAfWxTTg21pjWPcyCBVErFy3F7ZnnDatAPGsRFzWCCVwCqWqa8aFP3GYGiwnxO4Sc3zzAmlhmHCO1y+3ivJpjp5Iu7FGETkKjn3GafGfWVQOCQF1FPrbVLan8UasvrDoMwtarUyQKI70tG9x3tI8s5ri4vxyqiGNvBk+HfP3me3zxy064OVDY0rW8YQab27VxQezDbkKw3SAqTMo5UMUpv4+D7OI+RCHMmsTl3PxaglhBdsvQvTuD+1GZmjMXcqHaNYVn4hnRtX67FaD/t/L6ONAdUast3nv6AOr9ecpMzqSXTX98RHl6O282FvO/UodAL3D93VmOaznM9wapP6tdR7Ssr9K8aWECR6kwn6otaYQ8ikUYBNSQc01kT2SfpFvgJhoKaFg493iWbzvnDUJKFfYK+jT0yg82P91sh0bdOSJVuxg6elTeM=
X-Forefront-Antispam-Report: 	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(136003)(346002)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(47076005)(82740400003)(4326008)(2616005)(316002)(70206006)(6916009)(336012)(70586007)(186003)(36860700001)(16526019)(426003)(83380400001)(7696005)(6666004)(478600001)(54906003)(8676002)(7636003)(356005)(41300700001)(34020700004)(8936002)(5660300002)(26005)(1076003)(107886003)(2906002)(36756003)(82310400005)(40460700003)(40480700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 07:32:12.3249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28405125-dcf8-41db-d0a6-08db47baaec6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: 	CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230428_003217_993686_275B9CAE 
X-CRM114-Status: UNSURE (   8.20  )
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

Add missing fault-injection cleanup in nvme_init_ctrl() in the error
unwind path that also fixes following message for blktests:-

linux-block (for-next) # grep debugfs debugfs-err.log
[  147.853464] debugfs: Directory 'nvme1' with parent '/' already present!
[  147.853973] nvme1: failed to create debugfs attr
[  148.802490] debugfs: Directory 'nvme1' with parent '/' already present!
[  148.803244] nvme1: failed to create debugfs attr
[  148.877304] debugfs: Directory 'nvme1' with parent '/' already present!
[  148.877775] nvme1: failed to create debugfs attr
[  149.816652] debugfs: Directory 'nvme1' with parent '/' already present!
[  149.818011] nvme1: failed to create debugfs attr

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 42e90d00fc40..15607281baaa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -5201,6 +5201,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 
 	return 0;
 out_free_cdev:
+	nvme_fault_inject_fini(&ctrl->fault_inject);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 out_free_name:
 	nvme_put_ctrl(ctrl);
-- 
2.40.0


