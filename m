Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617E5C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Jan 2022 07:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8ju7GHo6L3HASaq5Kc2hk/AvEHgNJjSMNc84ylA7DZg=; b=lgpSASx2Wx5xixZ+s3e3oO/nUQ
	vzcwwSLAzVmlN0UxLFt67IuE/idvJ7KKC458700m4nj06ERWYfryja33TiRbK0tU+zsJtqLpBSUkL
	tcv1QpYJgZq3OHP+rYjaJgUm5VBZeyPKOpkpnHxfixaR/DIzE4jYFzfpMIERvQNgdyiLSQQ1FDSDK
	xGZKEyI5mzBzO8lRrWhllrqVHrI+dTJi4GgYZkw7L1rP5uXT+VaJgsDGsguBAWymJhtKQLcDi4s1u
	Oa30xqbLLTRW5tVFsQujGgaP5QYY+BnRqbaYXaXn5mmgz1/lEVbpxZVzkXgNO7ythT1TZ/nCL1SCv
	soClFiXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nA5Hr-0048aw-QC; Wed, 19 Jan 2022 07:21:43 +0000
Received: from mail-bn8nam08on2054.outbound.protection.outlook.com
 ([40.107.100.54] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nA5Hb-0048TI-0J
 for linux-nvme@lists.infradead.org; Wed, 19 Jan 2022 07:21:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ji1dez2bfXuJJ4RNG8ta8/VScpCJG6+116WNLnWVBrhVLf7uctU16Wzp0r9Otf7Hvd1PrgoQQzbCXfZ/cPD5RjYtTAgs+3umyCl7gEU4Vw/ogjfR6kDk3h2R0f/s1Vncc+IIkFanHc3uqlhkM4+66s9oNSkDH9srURCKjKziPti9Irv3diDTSs3fYZk8Mhld51p3I8cboM6UOThrgGM3SB+bm1ArdKD9eoIk0GagZuj2y8IfRmc4Otk/IXvqgzLp20H7dhRlXPq5mxG0WXEPTkLGPdNnaO52Huu7H4msp783/Ino+xr7aA4mr1QEV3lh4xgM3ey4PnebavwPeIW8Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ju7GHo6L3HASaq5Kc2hk/AvEHgNJjSMNc84ylA7DZg=;
 b=Ae7OauHFqvf4r1qa99ipYT7cyu23j+7uQwq9u3n/IHvCHFx+7rEm1CNvqvsFCBuELh2cnFr04TbIDTUMot61YOWBNzIDgidiFxe7TVJfnK6OmMpX/EEZoBqTd8TS/MG/ilK+J2U73ye88h4+vw+Ko3WR/mOzZRpWdf0ghBMyt1JN0pNbhLWDKVqHQ4YBbXH71HA6esEBf9t8LaQttQ64qFKao4YLtmXxY8AMBbiFlF+m/FKTMJ7u3zhLqxRRklOnMd8o9GZMz/kvbky50ty2yOo++3ldZbhW3WbK50H9tLGmzpBESWUFGzAz3UYyRlzQT9Jy1iVTYJpnF3BJEY901A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ju7GHo6L3HASaq5Kc2hk/AvEHgNJjSMNc84ylA7DZg=;
 b=ZYTl73tY5GtyjElwx2KGj7mH2LGrW00axWz5sggdU5PWCO9YomxsFx/Kj6KHCE2MXrAxPH72hSPLKvdQk/9lOG3dV8z6qABJ5sOSfHJpjF81z6ewyGf+56WDNndwOVb0iV4plynv53CUfXQkA95X7HkjBmpS5rnq/w1PwfcngKTTx/jvAxKRWQHeNb6BOTYYzpAuPcpIgPr5kW6D4iXwv25Vgdy9lVpXkT14/bp9hWtSnDQ0jsxnQF3dylbPL4tXDgFR0GotjJtaODgcv3HquHcN0qsq8bUSjsEu3EqH5F62GCiAJWapUJ0eE5+lgIAk78xnQyrABEPr8JwIhyq1qA==
Received: from DM5PR21CA0032.namprd21.prod.outlook.com (2603:10b6:3:ed::18) by
 BN9PR12MB5308.namprd12.prod.outlook.com (2603:10b6:408:105::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.14; Wed, 19 Jan
 2022 07:21:24 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::58) by DM5PR21CA0032.outlook.office365.com
 (2603:10b6:3:ed::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.4 via Frontend
 Transport; Wed, 19 Jan 2022 07:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4909.7 via Frontend Transport; Wed, 19 Jan 2022 07:21:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.18;
 Wed, 19 Jan 2022 07:21:23 +0000
Received: from dev.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Tue, 18 Jan 2022
 23:21:22 -0800
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: <linux-nvme@lists.infradead.org>
CC: <hch@lst.de>, <kbusch@kernel.org>, <sagi@grimberg.me>, Chaitanya Kulkarni
 <kch@nvidia.com>
Subject: [PATCH 3/3] nvmet: allow bdev in buffered_io mode
Date: Tue, 18 Jan 2022 23:20:38 -0800
Message-ID: <20220119072038.3942-4-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220119072038.3942-1-chaitanyak@nvidia.com>
References: <20220119072038.3942-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9a56655-ebef-45a8-451d-08d9db1c4ca8
X-MS-TrafficTypeDiagnostic: BN9PR12MB5308:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB530894085BC57E5A661C6F53A3599@BN9PR12MB5308.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KooD76tvJXal4xZ55vVUWCIJaVxhcSr7JcPQeNj0YnplcVwp8vXaIHpTJgD+3imZKkpo7cL92JNJJw271pHYPJrHwcFUFcrsA0W/bzRUfZnamox7k3KYXQqssM/EtIG/4BTNxwavLemdshflMppGxgIcR6x4czhSY5/mrIkyFa+rtSmtIqW5ZddTqt8bRMMKerA6ngO5qd6WGtPZUjwLAYYCsvrvuEuIL4qkjHFyKZBCnzLK35v1ivC7L4AB0bOPyJ+SMpEmVoBFYGn4EujFip3lB4qD6G7aosEGbzHevIpjn3ZVzBJ5noK+ZYy0JFeYr6fTBE3jLiXR8zk0Eo+aU4oRUT9keF4N4D+wolyUMGnYKqQKxEMjdUzlps8qqnLBNNJBDWovxviIgT4tmqRCs5vHQWMALs78eQmm2zDh8wX+KkuIxElcQcH13erLrdGo46a+mu1dbY3kiRMYCEsV5AW9bH/nmTKorSDtpZRFUY5wchq9VgXmFFvfWlm6Fl5crS3GD8ci/gqF3r/1O1gjedmLinj7XpRg8MdzzI4q1+4JBWFcm3HYB/6Gq7CRfJJJfZsgPw6ebcTd5ScR9S5KidpXzCZdvDOjYriBaZMPG3t0E9kfivDhg/fH8ZNM3APfJbdDbnlPOXsOz+/Yd9y9HShAalAVgZmhxdv59p/tDNth3aKAVa+j3niF2aQ3YMULQYOYaPX55N5bdX/apgdBtE2R2Z6HYzD1FFrWoSo70aXmTV6KmiGEAP+xlJ2qFLdNsz4+DpjkiiRRu0M6yTCf9hhDNuIdD8WE6rxcRZjmhek=
X-Forefront-Antispam-Report: CIP:12.22.5.234; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:mail.nvidia.com; PTR:InfoNoRecords; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700002)(2616005)(83380400001)(426003)(508600001)(186003)(81166007)(26005)(82310400004)(36860700001)(2906002)(356005)(7696005)(316002)(47076005)(8936002)(8676002)(36756003)(6916009)(336012)(40460700001)(70586007)(70206006)(16526019)(107886003)(4326008)(1076003)(6666004)(86362001)(54906003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2022 07:21:23.9893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a56655-ebef-45a8-451d-08d9db1c4ca8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[12.22.5.234];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5308
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220118_232127_098822_B79861D3 
X-CRM114-Status: GOOD (  16.15  )
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

From: Chaitanya Kulkarni <kch@nvidia.com>

Allow block device to be configured in the buffered I/O mode by using
the file backend. In this way now we can use cache for the block
device namespace which shows significant performance improvement.

We update the block device ns enable function and return early when
buffered_io flag is set, when revalidating the file backed namespace
open block device handle and consider block device size, use
previously exported block device API to set the namespace size and
blksize_shift value, and call nvmet_bdev_ns_disable() when disabling
file backed namespace. 

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/io-cmd-bdev.c |  8 ++++++++
 drivers/nvme/target/io-cmd-file.c | 17 ++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 58907304587e..5e5eb49a0255 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -96,6 +96,14 @@ int nvmet_bdev_ns_enable(struct nvmet_ns *ns)
 {
 	int ret;
 
+	/*
+	 * When buffered_io namespace attribute is enabled that means user want
+	 * this block device to be used as a file, so block device can take
+	 * an advantage of cache.
+	 */
+	if (ns->buffered_io)
+		return -ENOTBLK;
+
 	ret = nvmet_bdev_ns_open(ns);
 	if (ret)
 		return ret;
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 7aa4cdcb80ce..067c45b23bba 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -22,12 +22,25 @@ int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 	ret = vfs_getattr(&ns->file->f_path, &stat, STATX_SIZE,
 			  AT_STATX_FORCE_SYNC);
 	if (!ret)
-		ns->size = stat.size;
+		ns->size = ns->bdev ? bdev_nr_bytes(ns->bdev) : stat.size;
+
 	return ret;
 }
 
 static int nvmet_file_ns_set_blkshift(struct nvmet_ns *ns)
 {
+	struct kstat stat;
+	int ret;
+
+	ret = vfs_getattr(&ns->file->f_path, &stat, STATX_MODE,
+			  AT_STATX_FORCE_SYNC);
+	if (ret)
+		return ret;
+
+	/* nvmet_bdev_ns_open() sets size & blksize_shift values for ns->bdev */
+	if (S_ISBLK(stat.mode) && ns->buffered_io)
+		return nvmet_bdev_ns_open(ns);
+
 	/*
 	 * i_blkbits can be greater than the universally accepted upper bound,
 	 * so make sure we export a sane namespace lba_shift.
@@ -45,6 +58,8 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 		ns->bvec_pool = NULL;
 		kmem_cache_destroy(ns->bvec_cache);
 		ns->bvec_cache = NULL;
+		/* if block device is configured with buffered_io */
+		nvmet_bdev_ns_disable(ns);
 		fput(ns->file);
 		ns->file = NULL;
 	}
-- 
2.29.0


