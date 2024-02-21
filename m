Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98BEEC48BC3
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Feb 2024 08:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y1LQMnu9gKPOePMRs4RqBVRFPb7b9WV0gK0+KDUa6t0=; b=XcvQUNPBZNFxhl+jxwwWg7BOxe
	jvzdN8DbRRLfElH4pbMo5AA5/vQ+5boirnNysPpNjAsWMJu+Ctca9UQ8gu3JJ21dvZjn6gqRwesxQ
	LQiBfi6IjFtIg3lf30DfiXlzpVgCXSj7zBFdjzANjCg3oLD4SaLpGzEXyWgCPd4cUEfBo8J6TPFCP
	nwUoG7Y5raWNCaLh3klgwr/QvJdxZ5J4AZv/c1sad9CRb5ApeDJpypAEesuhhXazafZUYKEHmWBTc
	sgZfRryYkiTbCGIA6H9AUNwDwdBATK5gPHWF4KkFbbhaUKcOD+8AM96AoegwxYpMD7j7tLoTVU0N2
	QtzHZd9A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rciK0-000000008JT-1sVr;
	Wed, 21 Feb 2024 08:51:20 +0000
Received: from mail-dm6nam10on2060f.outbound.protection.outlook.com ([2a01:111:f400:7e88::60f] helo=NAM10-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rciJy-000000008IW-0sPr
	for linux-nvme@lists.infradead.org;
	Wed, 21 Feb 2024 08:51:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CuXu7Yhovee/1f/JcXc7XJ/eRG5lLcEoKc0RZh4Xa5/nv4XiGPexHp2/uEvb3ekkYCjizoB+PJ+jSW0QMdRZCmsB7n5005tdXBV+nQQicvsuvVGj+rJyXSt1PgKYgCiW6QC0v20I8Aud6CDHwe/Psa+vsj3H6UbVetuIt/S60uJn6Hh6FjKrfpHym8W9MQOWRF2+STuBCl6kf+ylSWDWxbdXK1DHMj9TJ56ujhHSsv6kCf1PhwIg8BuuXlq8uKT++YWXzhr5SwA1d85n/gt8ohixuXM8eGzDxOPf2RLzIOr2TKbUeaYcFgcM64W1oHwCo8RTqUDiw/+sj6368nwJnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y1LQMnu9gKPOePMRs4RqBVRFPb7b9WV0gK0+KDUa6t0=;
 b=Jvn2+Cf0ALDhmsE/XspPyojJnZja7qiiUISvBMmKjELJ9uNMA2ZWB7W6jP6Fe6CUzO9yA8+JWKOPCuJU8Mngyb+O75dWhAxYkcrTiGFg/lOQwKRJS2R1R6kUN6F7Pyg9NvuzEZG4M5Jlq2E+GpYtjUgA3FIs/e0E6C8luK1Ox7QPrSxUVePqW+Ub4wE40MkxcNJTAeIPFHuyoGY9DBhSs78+j2sTSP0/i4ETIaaUpigiiuf9NEnUCL2J0yQcHss56F+8oFPcRETSYrfz/6TOkYrp+n7vDQ94JMl4Oixo1GinqgM/KdwnmIc+QPgMPXEM1F0VXbM6D72ywRxboWhftQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.80.128.242) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=solidigm.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=solidigm.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidigm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y1LQMnu9gKPOePMRs4RqBVRFPb7b9WV0gK0+KDUa6t0=;
 b=vIh/IFnnSrUofEMdLVpvwiCaiPgneV1HNEShDZl8Ti+SL0ReFYkwkR++p3DhpQlYWD2ydp/vH44C2KTEC3OrPgIWWv9zwF9DVLNCndqztVMotrYocG1LzeWvNoXovLnR2iRAzbz8rNlQvo1GgfBcSZ74j1aMXWbBH8daEpTQNqunEjWWd4au/iUwLJglNDaRWQ9kkuZJAMHeig5Wr5CwktWwb2xg9Nf1RpvtHUbtyBPVynrSB+OzdHAin7CLEjORegjs7BeYxMa2SgG8xxwyIk5t9F/6Wz1jkBQJWv35hTlOS5UV/NJ5yIn6DihlX0yWWa0A+tv9dCHSJRD/in4kcw==
Received: from DS7PR05CA0023.namprd05.prod.outlook.com (2603:10b6:5:3b9::28)
 by BN0PR10MB4981.namprd10.prod.outlook.com (2603:10b6:408:12d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 08:51:04 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::5a) by DS7PR05CA0023.outlook.office365.com
 (2603:10b6:5:3b9::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.15 via Frontend
 Transport; Wed, 21 Feb 2024 08:51:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.80.128.242)
 smtp.mailfrom=solidigm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=solidigm.com;
Received-SPF: Pass (protection.outlook.com: domain of solidigm.com designates
 20.80.128.242 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.80.128.242; helo=sd-SMTP2-Intel.corp.nandps.com; pr=C
Received: from sd-SMTP2-Intel.corp.nandps.com (20.80.128.242) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Wed, 21 Feb 2024 08:51:04 +0000
Received: from sd-SMTP1-Intel.corp.nandps.com (10.249.4.7) by
 sd-SMTP2-Intel.corp.nandps.com (10.249.4.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 21 Feb 2024 08:48:15 +0000
Received: from remlabumq.elements.local (10.74.96.33) by relay.solidigm.com
 (10.249.4.7) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Wed, 21 Feb 2024 08:48:15 +0000
From: Michael Kropaczek <michael.kropaczek@solidigm.com>
To: <linux-nvme@lists.infradead.org>
CC: Michael Kropaczek <michael.kropaczek@solidigm.com>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v1 0/1] nvme: Fix problem when booting from NVMe drive was leading to a hang.
Date: Wed, 21 Feb 2024 00:43:40 -0800
Message-ID: <20240221084340.825068-1-michael.kropaczek@solidigm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|BN0PR10MB4981:EE_
X-MS-Office365-Filtering-Correlation-Id: 98df1358-ccca-43d7-a166-08dc32ba3c94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jnqHmnBgctUsNMg71G1D1A4CaUZ54cUPOgcah1SGpypfRNaaVr/5dzN3y0W9Ac5qBqvVbhQ4HrFnOBILr9yhxCrSaHSbgqjehjsM0HoxLOZB0unH8r/NQqpeYVe4m0KpF52p5BoyPbCCCxVzyp2a2L9XNABrMujJeD7geGVC7qqyRTSdcEcbfjcOmmvTZ5YVxwgQHfJ2xxAflkaIcWafCNc5f+DNRJaLeJWTFgAXkL6vDDJV1FTGgNB+hZuv7nMs/VygmXMnVDM8URITNmOn31UUPRyEDxC135plyJNasd16kuhqt6zOD3b2490hE+uxAC5Qz9iNWgTR/Bc1tAJtRxS/lhdX4Kx95U30w2+zIoVDDV6gDdkmUxzawnX2Zny4gF8dlfUlPGHzeIbZmH08EH1xf5xMSyUhlqTilQi2Z7BYeCno/kHRTB2au1PxKjTxZ3Ec2nO2K0UMK5Ks26VJNiQAOKnTz5wm++d1/0iCq0HgzJwkfmH3AHiHLTWVBOelpijGjpQFheVJq6DnL74cG6/hHvzF7/nXex5pOIAXvaMEDFgewdn0D+LXhZiXEBTSUfjy5CptM01OFCpJIu9E9hLgyUEVCb43RKKB7PdGbNVae18npZC3IQLRXHoi8sja3tDPVcNHi/Lpy+fVk3JrMhhFK+jd4dugVdXUwbW5b5U=
X-Forefront-Antispam-Report: CIP:20.80.128.242;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sd-SMTP2-Intel.corp.nandps.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(46966006)(40470700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: solidigm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 08:51:04.0041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 98df1358-ccca-43d7-a166-08dc32ba3c94
X-MS-Exchange-CrossTenant-Id: 4bb44aac-867a-4be0-aa34-30794e8470dd
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4bb44aac-867a-4be0-aa34-30794e8470dd;Ip=[20.80.128.242];Helo=[sd-SMTP2-Intel.corp.nandps.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB4981
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240221_005118_351725_ECCC66CC 
X-CRM114-Status: GOOD (  13.81  )
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

Description:

During endurance test, when a system was rebooted from NVMe drive, boot
process hung occasionally. The number of reboot cycles was set to 1000,
with interval of 120s. Hang occurred after ~300 reboot cycles.
After investigating the cause, it was established that NVMe driver
did not disable host memory during shutdown leaving NVMe controller
in a state preventing proper initialization in BIOS pre-boot stage.
Adding of the nvme_free_host_mem(dev) call fixed the issue.

Michael Kropaczek (1):
  nvme: Fix problem when booting from NVMe drive was leading to a hang.

 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)


base-commit: 8d30528a170905ede9ab6ab81f229e441808590b
-- 
2.34.1

From 1506c5099def8ecdd489d681033230492fa65bb2 Mon Sep 17 00:00:00 2001
From: Michael Kropaczek <michael.kropaczek@solidigm.com>
Date: Tue, 20 Feb 2024 23:40:36 -0800
Subject: [PATCH v1 1/1] nvme: Fix problem when booting from NVMe drive was
 leading to a hang.
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
    Jens Axboe <axboe@fb.com>,
    Christoph Hellwig <hch@lst.de>,
    Sagi Grimberg <sagi@grimberg.me>,
    Michael Kropaczek <michael.kropaczek@solidigm.com>

On certain host architectures/HW, DRAM was keeping memory contents over reboot
cycles. Certain NVMe controllers were accessing host memory after startup which
led to undefined state, preventing proper initialization in BIOS boot stage.
Freeing host memory during host's shutdown prevents the problem from occurring.

Signed-off-by: Michael Kropaczek <michael.kropaczek@solidigm.com>
---
 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..ccddb7c379e3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2593,6 +2593,16 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
+	/*
+	 * On certain host architectures/HW, DRAM was keeping memory contents over reboot-cycles.
+	 * It was observed that certain controllers were accessing host memory after
+	 * resetting which led to undefined state preventing proper initialization.
+	 */
+	if (dev->hmb)
+		nvme_set_host_mem(dev, 0);
+
+	nvme_free_host_mem(dev);
+
 	nvme_quiesce_io_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-- 
2.34.1


