Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1744C5475B
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Mar 2024 22:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ouq2rbqTBs3SIEjzs1fUOkqFZkDxNUnqdiYIFx4vf2Y=; b=sCJXMFYHnY2o8KNAJqn00ikySS
	bp35IkCGC1MNiZw85BihOfCPBpdCWYbiLcWeS8jlSJqv7eBYFkjypfJSO/sVIPM9rRZeYbQGbCQnH
	H7V9aqY/vc/qnsLJRe5n/lQM4whC227G4UCiek/VkAgeWiuAyOG1XhSzFWBHRGtONupWR3yW85UrE
	YK3H8feRCMmw5kwIOWcIk9F3nOyohVt+jW92gyXXvLbRV9A0xAVJG3kx1zkGgUN1t78rpqcWRakT1
	spUbK8j3OjfSUcXGiXJIjqy2zPzhRJGrj8e1qvJIN5voDW2ddogvSYLvj2bY6/lg3SYhNo5ecJTRB
	KySgD8ZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjnw5-00000003NOW-43hu;
	Mon, 11 Mar 2024 22:15:57 +0000
Received: from mail-dm6nam11on20600.outbound.protection.outlook.com ([2a01:111:f403:2415::600] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rjnw1-00000003NNl-2ck9
	for linux-nvme@lists.infradead.org;
	Mon, 11 Mar 2024 22:15:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hRfgrYTJDPLO9Q3WhfwjxUQy6QZVXbBpI4iV3jwxeWcaOsPpL5gqhXA0Ybf0dSwJGRkuon699ylWj8YYTR817xroeDdaPjzLuvTVWdL9/cg6pV2eMerDPzTQu59zy3SoPhHFbtVeQ7WIEtCQX9T4BdPfo7lkeNRJ+vrjcSkm552bzaA/hsXCgEGVPvxBdfi8J9kR0rW9A+lZiWZSkNIwJ28j4VvJJIqgJviRb05zqxp1CfTk9MemSnh8YlXsAs1uhPwtAoHhs1UGae9S+Aa0scJlopAvhfDph4Kz/waKLXPGQLTCMoeq8KVWfyqfJtKfvufqyypRz56r/DxqIcvG4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouq2rbqTBs3SIEjzs1fUOkqFZkDxNUnqdiYIFx4vf2Y=;
 b=InwB2d3Ps7aFeBeAaELhZqIhMUzXpHE5okkIO32PllHJuu1T7DSkBY37KjI6y0HVNXMqSZGBec7h4EcixtFU8oWO2GLoXIoQ1s6XmC4HGGKW2dCe2uAUhB7ZnqjoF8IGACUN3mpaX00hZ6nivrF3ny0vQk05Aw3N79wZzW1hjJZMGCeHDxyI5I9tK7XwC9Zw8/RW0zTmqx1Pg3Q02XYyJPP8FK4zV6U6j/e3KHTpHn6iHvqZ5LOMKBTW6ywvuU+hcLfD3f8WRrjTyHvfno3ybVtIHmjm/QspP0rdgnCZ6sRVCGyWmr6NNKtETnh2BzVhoO2qEVtFxM2WlhZdEjvy7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.80.128.242) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=solidigm.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=solidigm.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidigm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouq2rbqTBs3SIEjzs1fUOkqFZkDxNUnqdiYIFx4vf2Y=;
 b=EsSfGTnvb04vNhe0L5mNSDvIwdJzUi8KEl/ATy4dIJJ2ZXujJmFSkjzdexx2bDMxVYhBdRZGUVrUvKy9XLOchSdMQeIncjoyAhfTCwTet7iInbo95A8GrTL/PZtOddI2OLWCaAHY33x5xvfEztMvEk/2Kp1KydeT0E5i5UoeE9fC7YtoIeLeeBqrTHmmJJXsreL/UqOtedUFkFL2mLDH1douRrq019dA4iHyq+AjDe1A9ggT2V5WiG+Vl/KdItUfHyf+/bqBdcOTS3FK6oH/rBFMTKlzbD9wkWBHcOIdviXCiLmZVAg/O0E/KiXZE8JLTDfobzH7xLwrPBQVbqDDCA==
Received: from BN9PR03CA0625.namprd03.prod.outlook.com (2603:10b6:408:106::30)
 by PH7PR10MB5675.namprd10.prod.outlook.com (2603:10b6:510:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 22:15:40 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:106:cafe::89) by BN9PR03CA0625.outlook.office365.com
 (2603:10b6:408:106::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 22:15:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.80.128.242)
 smtp.mailfrom=solidigm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=solidigm.com;
Received-SPF: Pass (protection.outlook.com: domain of solidigm.com designates
 20.80.128.242 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.80.128.242; helo=sd-SMTP2-Intel.corp.nandps.com; pr=C
Received: from sd-SMTP2-Intel.corp.nandps.com (20.80.128.242) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 22:15:39 +0000
Received: from sd-SMTP2-Intel.corp.nandps.com (10.249.4.8) by
 sd-SMTP2-Intel.corp.nandps.com (10.249.4.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 11 Mar 2024 22:15:38 +0000
Received: from remlabumq.elements.local (10.74.96.33) by relay.solidigm.com
 (10.249.4.8) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Mon, 11 Mar 2024 22:15:38 +0000
From: Michael Kropaczek <michael.kropaczek@solidigm.com>
To: <linux-nvme@lists.infradead.org>
CC: Michael Kropaczek <michael.kropaczek@solidigm.com>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 0/1] nvme: Fix problem when booting from NVMe drive was leading to a hang.
Date: Mon, 11 Mar 2024 15:08:11 -0700
Message-ID: <20240311220811.3011800-1-michael.kropaczek@solidigm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|PH7PR10MB5675:EE_
X-MS-Office365-Filtering-Correlation-Id: a1b7baaf-b796-4b10-da85-08dc4218c8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pd9xJ5vy55arnSuUxO532FauZms+gIWEt2CXGpQFamE5kELtBTvunt1AKoZqIAFwRDpPQfFnYC+h6v4lU21BAOSJYImgiE0VinY4LMMCMDvRSOk1/Twgg/Ij5SpDQki/21h2vPKVEsC129p/+C4DRUL90qN8DeTlTN+auVTDzujvSGgu6Cjox7rOUxcOjcicbbQQgxla0tagvy964YiVYYESrjzTPf78erkRqFJ1OeVaefJXGuzoD7cGDV4OC4FU/RbxNHMlTTjV93XGEeteP9ME4yBgBhYPYtwBo7zWaj3TEEZuaaYiH+LDahJrVdbfKH3Li2BYmL5JXuH2MCmQ+V5g7/kY+98cxD5VBSMxIk/3oDARfxuch+SOuxV/9OIcf3W5uI+7ozHYuhslVrkKLngiJ8XlDqyy7mBlcQ3Cl66wYU+StOmoAXuqtj1yvyGQlyGio+hmSTJe0eW6IKQOaibdpPO83VLMPrWznosSPPC3q+pWbn7urkH0Vn1WviqWxmZT/hraQ4n/LjfYd80CcCCviCDfbxB8+UGLSYKYe/c4tOgbNfxQL5Zu9zgoOH8taI3NIFnXKf4OPQpdT3kQy5Z24xN8OzIfk05BwTky7iyk2PO5oxbs/4tUwBvRiHbGTziuMhQ4tTetv5y3zBHUh5H7PDx3lNPe3EYYjCEpumP6ck5DWrnfAjghJf9K2FgUdCj1eX5oZfWpwEdrgmtr1E9Ia5sZmbpel0c+BGp2+Daj4e2UFK8EkFSqmDIMUS58
X-Forefront-Antispam-Report: CIP:20.80.128.242;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sd-SMTP2-Intel.corp.nandps.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: solidigm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 22:15:39.5582
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b7baaf-b796-4b10-da85-08dc4218c8e6
X-MS-Exchange-CrossTenant-Id: 4bb44aac-867a-4be0-aa34-30794e8470dd
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4bb44aac-867a-4be0-aa34-30794e8470dd;Ip=[20.80.128.242];Helo=[sd-SMTP2-Intel.corp.nandps.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5675
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240311_151553_831196_BC796E69 
X-CRM114-Status: GOOD (  13.38  )
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
Adding of the call to nvme_set_host_mem(dev, 0), when in shutdown,
fixed the issue.
In this version redundant comments were removed.

Michael Kropaczek (1):
  nvme: Fix problem when booting from NVMe drive was leading to a hang.

 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)


base-commit: 8d30528a170905ede9ab6ab81f229e441808590b
-- 
2.34.1

From 054a4e846d967b0b37d0f398166c1f56ef536a72 Mon Sep 17 00:00:00 2001
From: Michael Kropaczek <michael.kropaczek@solidigm.com>
Date: Thu, 7 Mar 2024 14:51:30 -0800
Subject: [PATCH v3 1/1] nvme: Fix problem when booting from NVMe drive was
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
 drivers/nvme/host/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..bda7cf5ff674 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2593,6 +2593,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
+	if (shutdown && dev->hmb)
+		nvme_set_host_mem(dev, 0);
+
 	nvme_quiesce_io_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-- 
2.34.1


