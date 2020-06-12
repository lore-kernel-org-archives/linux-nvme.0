Return-Path: <SRS0=+Z1J=7Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E5C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 20:48:33 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B150F20835
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jun 2020 20:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="m5c3l7pf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B150F20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XaWN2SJCBMJv1KMCxzSJPZHT3qz0n3y3Q+KThULDa4Y=; b=m5c3l7pfMUozwI
	Y/tdXCBg0y/gWKgDslsC31cINIHzlBxugJ4VXNOyUjifxRHFYDFmuDLtYuyySNMM5Ph/uGh3Tf9Gy
	wiFdjOQbWRE6jP6yyh1xYVYsVbvnOEmaM8mfqf1ebm+qkTw4rpWM70DjIkrw06k+tUW7wMS/u3c1r
	Vi/EPIPwS3W+59eEQ1joaElDEq7UHAiezWB3DEV53fxZd2ZAymU2piDhMSJcdyb0nDKPB91m5Ty0f
	DprZ0cbF7VXOON58VVOS3h6TCeqy5M7sYU7SRrBg1qYldwzGfa26nB6nAlGun7TJ+nr7KG6l+5qrc
	yU9rG3dT58rXyiyUpXTA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jjqbG-0008Ay-K6; Fri, 12 Jun 2020 20:48:30 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jjqb4-0007zD-7o
 for linux-nvme@lists.infradead.org; Fri, 12 Jun 2020 20:48:19 +0000
IronPort-SDR: 9vk+7X+8/cW8rNSs/iXpeuv6UZVgwkDaEy/Hf5GHHF4accF8ghxdNU2zxDfQ92JsWh3QdlwK6D
 RCez+9EBNypQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2020 13:48:17 -0700
IronPort-SDR: 3MfeTCozN7FPSQrnsX3nzouD+Rf998ENV6PE36NyhpvxXUaau82Z14vNnqGRZYkZULZiFrq52M
 dLP7f54KZ0jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; d="scan'208";a="275863120"
Received: from linux.intel.com ([10.54.29.200])
 by orsmga006.jf.intel.com with ESMTP; 12 Jun 2020 13:48:17 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com
 [10.54.75.16])
 by linux.intel.com (Postfix) with ESMTP id 516885803C5;
 Fri, 12 Jun 2020 13:48:17 -0700 (PDT)
From: "David E. Box" <david.e.box@linux.intel.com>
To: shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
 bhelgaas@google.com, dan.j.williams@intel.com, kbusch@kernel.org,
 axboe@fb.com, hch@lst.de, sagi@grimberg.me
Subject: [PATCH V2 2/2] drivers/nvme: Add support for ACPI StorageD3Enable
 property
Date: Fri, 12 Jun 2020 13:48:20 -0700
Message-Id: <20200612204820.20111-3-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428003214.3764-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200612_134818_310616_6F78DF5F 
X-CRM114-Status: GOOD (  13.17  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-acpi@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, "David E. Box" <david.e.box@linux.intel.com>,
 linux-pci@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch implements a solution for a BIOS hack used on some currently
shipping Intel systems to address issues with power management policy
decisions concerning PCIe NVMe drives. Some newer Intel platforms, like
some Comet Lake systems, require that PCIe devices use D3 when doing
suspend-to-idle in order to allow the platform to realize maximum power
savings. This is particularly needed to support ATX power supply shutdown
on desktop systems. In order to ensure this happens for root ports with
storage devices, Microsoft apparently created this ACPI _DSD property as a
way to override their driver policy. To my knowledge this property has not
been discussed with the NVME specification body.

Though the solution is not ideal, it addresses a problem that also affects
Linux since the NVMe driver's default policy of using NVMe APST during
suspend-to-idle would lead to higher power consumption for these platforms.

The patch uses the previously added pci_acpi_storage_d3 function to check
for the StorageD3Enable property during probe and enables D3 as a quirk if
set.  It also provides a 'noacpi' module parameter to allow skipping the
quirk if needed.

Tested on:
PM961 NVMe SED Samsung 512GB
INTEL SSDPEKKF512G8

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvme/host/pci.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4e79e412b276..427505c47e79 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -78,6 +78,10 @@ static unsigned int poll_queues;
 module_param(poll_queues, uint, 0644);
 MODULE_PARM_DESC(poll_queues, "Number of queues to use for polled IO.");
 
+static bool noacpi;
+module_param(noacpi, bool, 0444);
+MODULE_PARM_DESC(noacpi, "disable all acpi bios quirks");
+
 struct nvme_dev;
 struct nvme_queue;
 
@@ -2777,6 +2781,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
+	if (!noacpi && pci_acpi_storage_d3(pdev)) {
+		/*
+		 * Some systems use a bios work around to ask for D3 on
+		 * platforms that support kernel managed suspend.
+		 */
+		dev_info(&pdev->dev,
+			 "platform quirk: setting simple suspend\n");
+		quirks |= NVME_QUIRK_SIMPLE_SUSPEND;
+	}
+
 	/*
 	 * Double check that our mempool alloc size will cover the biggest
 	 * command we support.
-- 
2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
