Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3916FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Mar 2022 07:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Aj55LV23IrQVnS1JIWgQjYe+OWRDGoTYduCmXbrohUQ=; b=PiPAW9OcKEH24ZEDYPIP3ctPkL
	PPAHYLCme0SVnRWQJFnUAySGvUgxw+NuTT0IuNS/6GdkfJtU33asHF3Z6YO68gYKzooQ7HYMn9ZRF
	TJ3bjDU15g/eFHlFeY0N+0aShvVbJ7cjqq+8SXtGS4HcUQWUCMy2awqcVPUdTZ14pQ8+9xCP/qUek
	ilwYhayHWb0f9J/3XHuSeg9cyQHUqC+YojgJ7A9jSjvvSciSCpSH67ifT58ar4o+al6+koT4OVjo4
	VcqRGZkm7LYQS21F/FN0wQivYA4AqlIwiBhQ9k1niXHVI2NcLX9Hb7B8LXurrHYbs22liq0RGsr04
	baVNtHAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nUORj-00C1Hf-G9; Wed, 16 Mar 2022 07:51:51 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUORg-00C1G8-Cz
 for linux-nvme@lists.infradead.org; Wed, 16 Mar 2022 07:51:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1647417108; x=1678953108;
 h=from:to:cc:subject:date:message-id;
 bh=vKvbQwYgcjb2VBnqEZFgMX1Gx5eolCjtlW5mckiZ48U=;
 b=LVlE0CZDKRte74/+XeePiQiGHyGYdBhdbMzCa2famxBYNPknMAjN1wFu
 leBi9QOXCL6dcVXU05wzs7BY/W1Hb6Bqm/BgWOYFATOQ4uj+gB7rncbQo
 sqh/sfkwmKJFmQg33rpFcu8Qn4jogUaTMdm1CS9Aukqb302fmSqNR7wNi
 O5MFacpjduRcUxUwPqWJ8Vn+fDhFYG4vtcQDiNTYvQtHoFhEgL6K4ntwk
 0sVcOhsAd9whu0pVngmeDUUUQwHDY6izlA3ZvFm+36C5QgXyEhpp2thBL
 cO1WXVHFOr55546rjOE4agEfunoIXYfuoF8URcpSX4DhWSlRV52JBBa08 A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256706417"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; d="scan'208";a="256706417"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 00:51:46 -0700
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; d="scan'208";a="557328291"
Received: from basccgtest09.gar.corp.intel.com (HELO localhost.localdomain)
 ([10.223.165.104])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2022 00:51:23 -0700
From: monish.kumar.r@intel.com
To: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: abhijeet.rao@intel.com,
	monish.kumar.r@intel.com
Subject: [PATCH] Revert "Adding quirk changes for Samsung X5 device"
Date: Wed, 16 Mar 2022 13:23:12 +0530
Message-Id: <20220316075313.18853-1-monish.kumar.r@intel.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220316_005148_508619_127BB6B6 
X-CRM114-Status: UNSURE (   8.24  )
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

From: Monish Kumar R <monish.kumar.r@intel.com>

This reverts commit 1c1b18c97b441cb1a4eb9c6e95d9c357b687cdd0.
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c01cb381c3ff..8bb184a7479c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3463,10 +3463,14 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_128_BYTES_SQES |
 				NVME_QUIRK_SHARED_TAGS |
 				NVME_QUIRK_SKIP_CID_GEN },
+<<<<<<< HEAD
 	{ PCI_DEVICE(0x144d, 0xa808), /* Samsung X5 */
 		.driver_data =  NVME_QUIRK_DELAY_BEFORE_CHK_RDY|
 				NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+=======
+
+>>>>>>> parent of 1c1b18c97b44... Adding quirk changes for Samsung X5 device
 	{ PCI_DEVICE_CLASS(PCI_CLASS_STORAGE_EXPRESS, 0xffffff) },
 	{ 0, }
 };
-- 
2.17.1


