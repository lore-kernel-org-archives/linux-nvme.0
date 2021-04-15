Return-Path: <SRS0=SWCy=JM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C4C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 22:26:13 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A19C6610FB
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Apr 2021 22:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19C6610FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4tRrTVL+sjKgNbfP/Zzp0P0J2Z061ZtvB52FMnMt6Tg=; b=JnwGUZn2F4NYM7K44++tiuoMW
	DWOC4BZkl7Y+vjsz5FSOUrv+p5o1wyiB/cdhaTG2dPhkn4hQTW8q/FJUHhyn3Zq54PES1U4Yo1aXc
	94zH6BrsTo23MNTg1itcWsbd901RmLnJ4OrG2KNxcRP4M6/fio5Yp5OpnbL526TuazjhABVwl0eWs
	olOuPNRKLAl9xiDe5UxTqB9heOiQqsAUBfDbBSgeRxRu9WIPC2JYxW0AQ2OuVCFbg12j6RmDcB8JR
	xkSsX9T4dQoKYRxwDvDjMd1QUF57ugV9siBPpb89Sl9yMVAxEx8nJy7ZTlmlwrr638ejyjWwSyCNL
	onMUUqzqA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXAQs-00HWkP-6u; Thu, 15 Apr 2021 22:25:54 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXAQo-00HWjk-Ev
 for linux-nvme@desiato.infradead.org; Thu, 15 Apr 2021 22:25:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=tWQYyJkg9d0pxVQu6IFMOnwG4boqxyuw5XxXs4CXjaY=; b=NcEnS8rDPoAICvNGieEowqq/+j
 43KdR2bXwVRmjKwiw6se3cOU7FJ646Wi3fx/ZHWuUH1SHi9GiXWsGnYFo7llFk2wo6HeJ2IQG9kPi
 Gf5YEwp6nYiZKSFYEH7cubSKbnSmyTMyGsyP8P73679Qpv98VCTgltONMU6GQKAqHSeRoYeXHifJf
 0AFD8SI0316g3qpuzWGhqG6hB0MxiGRIIKN9JKzuZOAmmTF0TTt2sjQ8Cj+XFZ9tA0cQXCTpKmXaq
 Zn6nUXl1TM7qSCP7YV6vk+PhNEj1tmrLKvN+TdRPbais6pixAzf+/6lvirOfP7O4XlktQncNF8EAN
 aC/aJqvw==;
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXAQl-008wRs-U6
 for linux-nvme@lists.infradead.org; Thu, 15 Apr 2021 22:25:49 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 73361610FB;
 Thu, 15 Apr 2021 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1618525547;
 bh=LhgPQdxtm2TuyLQmnpd+X9aucQm6TK194UjDevkccTI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=cb6CE8XsxzgtdZq3EJsrZpJJmJxJwW7YU473Oa2JydY2hWGj+iK19zD4y3PT2tDU9
 yTw9r7Z7z7aaP/4z3Xr9tvw6sXDu/gUGXKsGnoyEp8Wu7Nny/ldRFoybOZ6blfs/pc
 RaU3LcYKLw7xUD3qwTy6Orljl/fNQ8ytYJX2FZUzVq/LDsPwd1O9XfQ4RaKbKjXSZr
 my3Ygs+eyJlLQUGQz6IVF37+ciSL4n4j5p74fYDWSoXcBhGamtUjbxWxTitzMjGqzB
 mHZSasgzJbAR5JGUb8E66aTzRgV7dWYKOJ3sW+LVb4iU2nCH+oB5pthwmCmC0orDaR
 L/7H0BdoSM4vg==
Date: Thu, 15 Apr 2021 15:25:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: "Liang, Prike" <Prike.Liang@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Chaitanya.Kulkarni@wdc.com" <Chaitanya.Kulkarni@wdc.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH v4 1/2] PCI: add AMD PCIe quirk for nvme shutdown opt
Message-ID: <20210415222544.GA2760247@dhcp-10-100-145-180.wdc.com>
References: <1618458725-17164-1-git-send-email-Prike.Liang@amd.com>
 <20210415082057.GA1973565@infradead.org>
 <BYAPR12MB3238E0366477A6CDE7AC9B94FB4D9@BYAPR12MB3238.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3238E0366477A6CDE7AC9B94FB4D9@BYAPR12MB3238.namprd12.prod.outlook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_152548_032037_3C6C7F21 
X-CRM114-Status: GOOD (  17.98  )
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

On Thu, Apr 15, 2021 at 09:41:53AM +0000, Liang, Prike wrote:
> > From: Christoph Hellwig <hch@infradead.org>
> 
> > I'd also much prefer if the flag is used on every pci_dev that is affected by the
> > broken behavior rather than requiring another lookup in the driver.
> Sorry can't get the meaning, could you give more detail how to implement this?

The suggestion is child devices of the pci bus inherit the quirk so
drivers don't need to look up the parent device that requires it.

That makes sense for a couple reasons. For one, your hard-coded 0:0.0
probably aligns to actual implementations, but I did't find a spec
requirement that the host bridge occupy that BDf, so not having to look
up a fixed location is more flexible.

If I understand the suggestion correctly, I think it's probably easier
to thread the quirk through the pci_bus->bus_flags. Does the below
(untested) make sense?

---
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d47bb18b976a..022ff6cf202f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2834,6 +2834,9 @@ static bool nvme_acpi_storage_d3(struct pci_dev *dev)
 	acpi_status status;
 	u8 val;
 
+	if (dev->bus->bus_flags & PCI_BUS_FLAGS_DISABLE_ON_S2I)
+		return true;
+
 	/*
 	 * Look for _DSD property specifying that the storage device on the port
 	 * must use D3 to support deep platform power savings during
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 953f15abc850..34ba691ec545 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -558,10 +558,13 @@ static struct pci_bus *pci_alloc_bus(struct pci_bus *parent)
 	INIT_LIST_HEAD(&b->resources);
 	b->max_bus_speed = PCI_SPEED_UNKNOWN;
 	b->cur_bus_speed = PCI_SPEED_UNKNOWN;
+	if (parent) {
 #ifdef CONFIG_PCI_DOMAINS_GENERIC
-	if (parent)
 		b->domain_nr = parent->domain_nr;
 #endif
+		if (parent->bus_flags & PCI_BUS_FLAGS_DISABLE_ON_S2I)
+			b->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
+	}
 	return b;
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 653660e3ba9e..e8f74661138a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -312,6 +312,14 @@ static void quirk_nopciamd(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD,	PCI_DEVICE_ID_AMD_8151_0,	quirk_nopciamd);
 
+static void quirk_amd_s2i_fixup(struct pci_dev *dev)
+{
+	dev->bus->bus_flags |= PCI_BUS_FLAGS_DISABLE_ON_S2I;
+	pci_info(dev, "AMD simple suspend opt enabled\n");
+
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_AMD, 0x1630, quirk_amd_s2i_fixup);
+
 /* Triton requires workarounds to be used by the drivers */
 static void quirk_triton(struct pci_dev *dev)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..7072e2ec88a2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -240,6 +240,8 @@ enum pci_bus_flags {
 	PCI_BUS_FLAGS_NO_MMRBC	= (__force pci_bus_flags_t) 2,
 	PCI_BUS_FLAGS_NO_AERSID	= (__force pci_bus_flags_t) 4,
 	PCI_BUS_FLAGS_NO_EXTCFG	= (__force pci_bus_flags_t) 8,
+	/* Driver must pci_disable_device() for suspend-to-idle */
+	PCI_BUS_FLAGS_DISABLE_ON_S2I	= (__force pci_bus_flags_t) 16,
 };
 
 /* Values from Link Status register, PCIe r3.1, sec 7.8.8 */
--

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
