Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B76FC48BF6
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Mar 2024 18:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FxwODZennJNefQwpj7Aeio+tQm70ziCAweHsnKX+SF8=; b=tqZNdoa1lAoU0n5KOpKEByXegn
	351vaWbgcXn2k+UzInrA2VxOLbMB7XC4isJMVzkSuvBzK+RoGaaBAQ0d0ZIdeOqvO8WDNPaL+Ncdy
	HoShaS+tIaMGBlNo/OEKh7mXbUmR2x+nEm9452hFo1kCVYNvOeFDPh8afkmWcnQaVWFDXjKErU+LH
	UYKDmp1ufWSPjWpL146VfgJeX035OF1+uWIAo/ZV3Kqp0HEchyrtOzqDUyCXrSq54GO40NDil3Xf7
	iJ7OmZWahXO7tuC1F+KUJZSX61ONSLeshw/0z72X5H7goYdf+BUDz35k9S6WU3VlQTNMM0jWCgjOF
	AX3qoOJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhD6H-0000000ACM5-2fJ8;
	Mon, 04 Mar 2024 18:31:45 +0000
Received: from mail-dm6nam11on20601.outbound.protection.outlook.com ([2a01:111:f403:2415::601] helo=NAM11-DM6-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rhD6B-0000000ACJL-0RcE
	for linux-nvme@lists.infradead.org;
	Mon, 04 Mar 2024 18:31:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVJkr4ohxm2RdRKZw6rh9iXUoS+zO6z1jEMQL8D1nzJjAYb8WOLx7zkK13eG733RPidy/FSseSZkXHuKCFiq/D7Pttngq5BiCl5vnSY542XK92DdrIJ5F78+zD8FhGbl+4DMFmMzNCEpBjjrHEo/xrANC8gp6hQbh2Jtzx/lqm2c1fWobbOTq6Ncn0IJSRuhyvGfxwaVhCHtgok5EblFaTVIMamTiL5bp72YS94hJf67Oq3Dw0b3IZxHLKddeQm9Y0hy4mmiRkLziyILhbyzvptq/+QbwmElJQEvOBQeGQB0EQSXqYrkBhwHsyAUXqeIR0UgUH8ket8K73+D4MsYcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FxwODZennJNefQwpj7Aeio+tQm70ziCAweHsnKX+SF8=;
 b=BtO7fpPfLtFClV7vbuLVb/R800my2pzR2NtXLYctrjS6nYA12K4kjIBETbRBtamMORJQGXcoIQW/rPxttUEJH/grZOuZ//wkuR6OIYpHgQj1FiYQquhYUdFxystTn5dtdVom/TmKBNWcO17HS/flU0/6PdPkEkg7IAVjAesIOcMjFYZ80HHRVIU2WBCsC/oksDRV82aDrhKlbc1GtuRwOKd+JVW6Os9FHmquZJqlE/XD5qaWIAePolNmCakd8BkULYtiOpHS0IWnrYY0886Q2RcWsH2IOLUk5b93M9eQsrYijwURzUTrE4jBJ1bYGjBhm1/8wfJ14tJsZAcWcZlqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.80.128.242) smtp.rcpttodomain=lists.infradead.org
 smtp.mailfrom=solidigm.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=solidigm.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=solidigm.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FxwODZennJNefQwpj7Aeio+tQm70ziCAweHsnKX+SF8=;
 b=ZYjFf7DoXcjhr1979XYVoSeXDBcA7Ykn77Kl8Bw40Y+r5vMJo5tQWxcKOk/RTueHvoTbnAwFhp+vU80Ql0YtrJik7Fq+ohTtKAokb4+J4rK8W+AXM66JiDdukzJAtP2IajmUcGUvP+WsFK5RuOjNU83qvri8IDDT+X7mGvZvzoIKnJgMS78H0zmGyDksNNFlFphz+BekXz24a9f+z6JoErxKrPIpo/vaSdR6Auxlfz0OpkyKP9lKiPANpqeIk4S8j2EBMAfIegSw6iib5UI/2XAqeU9+UkuOwfqN4RvEQnoZgypE7g+9CtU8PzlTdR/zcu6Zjbj7mPs7Xep9WqFjpw==
Received: from MW4PR04CA0226.namprd04.prod.outlook.com (2603:10b6:303:87::21)
 by SA1PR10MB6295.namprd10.prod.outlook.com (2603:10b6:806:252::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 18:31:30 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:87:cafe::ec) by MW4PR04CA0226.outlook.office365.com
 (2603:10b6:303:87::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 18:31:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.80.128.242)
 smtp.mailfrom=solidigm.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=solidigm.com;
Received-SPF: Pass (protection.outlook.com: domain of solidigm.com designates
 20.80.128.242 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.80.128.242; helo=sd-SMTP2-Intel.corp.nandps.com; pr=C
Received: from sd-SMTP2-Intel.corp.nandps.com (20.80.128.242) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 18:31:30 +0000
Received: from sd-SMTP2-Intel.corp.nandps.com (10.249.4.8) by
 sd-SMTP2-Intel.corp.nandps.com (10.249.4.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 4 Mar 2024 18:31:29 +0000
Received: from remlabumq.elements.local (10.74.96.33) by relay.solidigm.com
 (10.249.4.8) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Mon, 4 Mar 2024 18:31:29 +0000
From: Michael Kropaczek <michael.kropaczek@solidigm.com>
To: <linux-nvme@lists.infradead.org>
CC: Michael Kropaczek <michael.kropaczek@solidigm.com>, Keith Busch
	<kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v2 0/1] nvme: Fix problem when booting from NVMe drive was leading to a hang.
Date: Mon, 4 Mar 2024 10:25:07 -0800
Message-ID: <20240304182507.2601387-1-michael.kropaczek@solidigm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SA1PR10MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 28ae838a-c1a0-4a0f-d351-08dc3c794f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wTPUXGP16K/0TlYISi4LcwW7MX/tFQ8uH47lmmPXRVKSkONdxTBiYpMaI7B9aHa4OhSmCtLbEwoV+nP6dDF8WvviyZEQDUt1OSpZuvANdjuA6xTsQYYPtlxIxz1aYJORZ4YY69VXEsaXICCZk+Uh4oy5YXf1odlNlgQ10BRNriyHTCewWgfx/AxQGmNEHODwuR1fkH8Z2QZknRpPDzBYfSfA9xybh+r0xsozxp3lEkf8vXwIZeNbwMqhQfbttjcgqDDuqy8HjPGCx9kr+eQFoy8/mhdFpmcYVqb+mfcecK9yeZeIJL33FqXvg1B4MLAe/DYGAl88HUTM6lFHTu3/GOJmjpHpN8tVr1n4H8yJ2qCJxv++Kr1/+Ok143C977LRX87yryJlCLajjnbZFvzgvF732dzLJcGD2jSgrKT7FI2iMPBCdksxv1M6ekXVVipgPEZGHH0ND1IyTI6lSTorIGwR/SO5HXpdbRA+61b8fBViB/YqZlz+8lVoxIFWEzle4oqbiv2OX+/Q/NKT9ZuRdbJzAt+jIgAB0Py6lI1NMYsCpMF6sBePUzu6xAp7PKH5UcwZTsZnWuUygGS2XMrYRgP7gOR/fwFC2xkAVu+XLZ6MjR3pKUaTdeLOOHo8kiyf7uSzlF/zFDGxjPzMG9eFc5DPS8XhWUM4LHhTTDuOjc+6EmsvpweY5id6jUVtat7TpHNUJ1YrMxlVmd59NcP1mVQgEpaEu4niWDF39nDDYHy+9lCOQ7l8KGZ7fR1K/k/X
X-Forefront-Antispam-Report: CIP:20.80.128.242;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sd-SMTP2-Intel.corp.nandps.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: solidigm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 18:31:30.1029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28ae838a-c1a0-4a0f-d351-08dc3c794f7d
X-MS-Exchange-CrossTenant-Id: 4bb44aac-867a-4be0-aa34-30794e8470dd
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=4bb44aac-867a-4be0-aa34-30794e8470dd;Ip=[20.80.128.242];Helo=[sd-SMTP2-Intel.corp.nandps.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6295
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240304_103139_309856_976BCC3E 
X-CRM114-Status: GOOD (  14.33  )
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
Adding of the call to nvme_set_host_mem(dev, 0) when in shutdown
fixed the issue.

Michael Kropaczek (1):
  nvme: Fix problem when booting from NVMe drive was leading to a hang.

 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)


base-commit: 8d30528a170905ede9ab6ab81f229e441808590b
-- 
2.34.1

From 9eec234181015af624d8e5cd8670ba5d82d0ce7e Mon Sep 17 00:00:00 2001
From: Michael Kropaczek <michael.kropaczek@solidigm.com>
Date: Thu, 29 Feb 2024 15:33:27 -0800
Subject: [PATCH v2 1/1] nvme: Fix problem when booting from NVMe drive was
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
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6267a6aa380..e5292c7b301f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2593,6 +2593,14 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 			nvme_wait_freeze_timeout(&dev->ctrl, NVME_IO_TIMEOUT);
 	}
 
+	/*
+	 * On certain host architectures/HW, DRAM was keeping memory contents over reboot-cycles.
+	 * It was observed that certain controllers were accessing host memory after
+	 * resetting which led to undefined state preventing proper initialization.
+	 */
+	if (shutdown && dev->hmb)
+		nvme_set_host_mem(dev, 0);
+
 	nvme_quiesce_io_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-- 
2.34.1


