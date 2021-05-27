Return-Path: <SRS0=/NUg=KW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384BFC47089
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:28:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA54E611AE
	for <linux-nvme@archiver.kernel.org>; Thu, 27 May 2021 18:28:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA54E611AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UTDuV1sVEnSvR3j+SJDG8hGAF/98dK+cwuwkVbNzfCc=; b=EAQacWosOM54iV
	vL1qH20JL05W9RqVkaG540WYZwAsgjv6fPAIKo6k0MBKIddijA/TEzSjDIekt3N9R7MWO5iSMur42
	Z/CllGJcN38pLd9GLprB0ri1XfptRskGZIIhT6dE4RrnYd9qtN/bqrh9LOZGNHdYB8f/iezdLVk7f
	RKUzr560xDoAliio6eudPfRH4nWt2P+P3MPXM0uGTcvyQ84GGxGSKb4CDXz/jHxVn3Y50/gzKlM4W
	yR0IwT1kDiAqFFcj9thWwklRRrwZ78FiDKpomQrGYJiCx6ZXPD8jZbGb4VoPj2vMh9SSd1C1emuUV
	lv4EVWr+zLBxOvVW2aTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lmKk6-008UKQ-C8; Thu, 27 May 2021 18:28:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lmJLL-007rUM-SQ
 for linux-nvme@lists.infradead.org; Thu, 27 May 2021 16:58:49 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A617F60241;
 Thu, 27 May 2021 16:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622134727;
 bh=0RC6GSU8LuON4SqInbYMOeGDzbVzPFtQaHz/4GUHa38=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TyT3Co54Vsn1bXygH+6O3f2IsMUo8QHvVqvsF7MzII8HUTQHFOk6w4uXxk+BcFqyS
 LStOSGg1HvvrwwP7UmDf2EEc7UT6fEnWDEcDHKjBwbSzXvRF8gy0uPsmY56TCARk57
 DyfadZuvnfGaEg2+lNMN8xhoya+Dk7Kag4ekP9li470t6nVrxL60PlzNgoSpLLPwrr
 Qd34/0W9KegdKQLBMfB8MRHrav5H7QSEqq6SaQB0rM6IO/wIUJRLBhUgEHLmjMdqRq
 ocVEyGrFZb6PdeGG7+Y8GST89otDTNTnmAPGyF9Ty8lY63veBK3RKLrjyYYjsxuVQb
 65deNdy7//DOQ==
Date: Thu, 27 May 2021 09:58:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Limonciello, Mario" <mario.limonciello@amd.com>,
 Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@fb.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 Prike Liang <Prike.Liang@amd.com>, rrangel@chromium.org,
 "David E. Box" <david.e.box@linux.intel.com>,
 Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>
Subject: Re: [PATCH v2] nvme: Look for StorageD3Enable on companion ACPI
 device instead
Message-ID: <20210527165844.GC3706388@dhcp-10-100-145-180.wdc.com>
References: <20210527135941.7634-1-mario.limonciello@amd.com>
 <20210527143548.GA32170@lst.de>
 <c911ed05-071f-ddcd-7f76-9cb7535dd01b@amd.com>
 <CAErSpo5za0x1fXm18YNzdNRFdaucVs=9Hhh2kqRS_baWos5Vgg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAErSpo5za0x1fXm18YNzdNRFdaucVs=9Hhh2kqRS_baWos5Vgg@mail.gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210527_095848_009090_01354BB0 
X-CRM114-Status: GOOD (  33.32  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, May 27, 2021 at 10:52:43AM -0500, Bjorn Helgaas wrote:
> On Thu, May 27, 2021 at 9:44 AM Limonciello, Mario
> <mario.limonciello@amd.com> wrote:
> > On 5/27/2021 09:35, Christoph Hellwig wrote:
> > > Adding Raul who has been asking for something like this as well.
> >
> > > I'd also really like to move nvme_acpi_storage_d3 out of the NVMe
> > > driver.  The Microsoft document that the original document references
> > > makes it very clear that this is not NVMe specific, but also covers
> > > at least AHCI.  On top of that the platform simply can't know what kind
> > > of PCIe device is in any given slot.  Last but not least this will also
> > > allow us to add quirks for devices that fail to properly mark this
> > > misfeature in the ACPI tables.
> >
> > +Bjorn
> >
> > Back when this feature was first submitted, that was actually the
> > initial way that it was done, but Bjorn had preferred to see it move
> > into the NVME driver directly:
> >
> > https://lore.kernel.org/linux-nvme/20200625173053.GA2694537@bjorn-Precision-5520/
> >
> > Bjorn, are you OK with this coming "back" to PCI based on Christoph's
> > comments?
> 
> My point was that the PCI core can do nothing with this information,
> so it doesn't seem like putting it in PCI doesn't really gain
> anything.  The Microsoft document you reference ([1]) doesn't mention
> PCI or PCIe.  As far as I know, there's no PCI spec that mentions
> "StorageD3Enable".
> 
> I agree that [1] doesn't seem to be NVMe-specific, since it also
> mentions SATA, so it might make sense to look for "StorageD3Enable"
> somewhere other than the NVMe driver.  I'm just not convinced the PCI
> core is the best place.  I have the impression that it's possible to
> have non-PCI SATA or AHCI devices (correct me if I'm wrong), and
> "StorageD3Enable" could apply to them as well.
> 
> [1] https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro

I agree it doesn't appear to belong in PCI either. This should go in
ACPI. Here's my proposal on top of this patch:

---
diff --git a/drivers/acpi/device_pm.c b/drivers/acpi/device_pm.c
index d260bc1f3e6e..ab8a0dfae2df 100644
--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1340,4 +1340,25 @@ int acpi_dev_pm_attach(struct device *dev, bool power_on)
 	return 1;
 }
 EXPORT_SYMBOL_GPL(acpi_dev_pm_attach);
+
+bool acpi_storage_d3(struct device *dev)
+{
+	struct acpi_device *adev;
+	u8 val;
+
+	/*
+	 * Look for _DSD property specifying that the storage device on the port
+	 * must use D3 to support deep platform power savings during
+	 * suspend-to-idle.
+	 */
+	adev = ACPI_COMPANION(dev);
+	if (!adev)
+		return false;
+	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
+			&val))
+		return false;
+	return val == 1;
+}
+EXPORT_SYMBOL_GPL(acpi_storage_d3);
+
 #endif /* CONFIG_PM */
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d4eef8caa4cc..8fbc4c87a0d8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2828,33 +2828,6 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_ACPI
-static bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	struct acpi_device *adev;
-	u8 val;
-
-	/*
-	 * Look for _DSD property specifying that the storage device on the port
-	 * must use D3 to support deep platform power savings during
-	 * suspend-to-idle.
-	 */
-
-	adev = ACPI_COMPANION(&dev->dev);
-	if (!adev)
-		return false;
-	if (fwnode_property_read_u8(acpi_fwnode_handle(adev), "StorageD3Enable",
-			&val))
-		return false;
-	return val == 1;
-}
-#else
-static inline bool nvme_acpi_storage_d3(struct pci_dev *dev)
-{
-	return false;
-}
-#endif /* CONFIG_ACPI */
-
 static void nvme_async_probe(void *data, async_cookie_t cookie)
 {
 	struct nvme_dev *dev = data;
@@ -2904,7 +2877,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	quirks |= check_vendor_combination_bug(pdev);
 
-	if (!noacpi && nvme_acpi_storage_d3(pdev)) {
+	if (!noacpi && acpi_storage_d3(&pdev->dev)) {
 		/*
 		 * Some systems use a bios work around to ask for D3 on
 		 * platforms that support kernel managed suspend.
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c60745f657e9..dd0dafd21e33 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1004,6 +1004,7 @@ int acpi_dev_resume(struct device *dev);
 int acpi_subsys_runtime_suspend(struct device *dev);
 int acpi_subsys_runtime_resume(struct device *dev);
 int acpi_dev_pm_attach(struct device *dev, bool power_on);
+bool acpi_storage_d3(struct device *dev);
 #else
 static inline int acpi_subsys_runtime_suspend(struct device *dev) { return 0; }
 static inline int acpi_subsys_runtime_resume(struct device *dev) { return 0; }
@@ -1011,6 +1012,10 @@ static inline int acpi_dev_pm_attach(struct device *dev, bool power_on)
 {
 	return 0;
 }
+static inline bool acpi_storage_d3(struct device *dev)
+{
+	return false;
+}
 #endif
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_PM_SLEEP)
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
