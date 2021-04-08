Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45325C43460
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 17:02:11 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0297610A2
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 17:02:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0297610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GR6i5qmMYZjjjl8AwcfYH4RR2eq1YlnksLa3Oepura4=; b=BNAiyJSY1oMoXh
	JzBNTbGDt5yLNzR5uc0O5L2R5v9K0Xk0LmKBo5mfCwH/jDKFQCj485NBYlMybLfpq59mThb6/DOQO
	DG7ijiTtwQNdmCuCO2PIWhtjdT6dB1/2tNSPY4k05vApTdoKUKaSNRR4fKQj0+WiiTytl46EKRjtp
	Rk6TH0ySFbxMRsclS/TzUjScUh9PhgX7aSpgkYMiUNfAJk+x+AfdVhi4yZFxvvIarm7/MggoZOBPT
	soURUjtmk2hse6JQlGk0NOT+x+sjItt/Iqd5KyG6isG3BdBka+1KT9IkfEsDOyLAyvcRsJNzpqoDb
	d4N+pn2guhN06bIc/JMA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUY2g-008iqC-Ud; Thu, 08 Apr 2021 17:02:07 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUY2B-008icz-Gp
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 17:01:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=q42f3RP8YxSKlLASvQrub4QicRt4obzkCWQptw1s/bQ=; b=kXyTEPPotnflh+zWBXl2Iehl9D
 0JdSBY8CkkL9kXlGbfl4zLzCReI+PGIGewQdzXSu5RKocOdU3v89xBBqgAv93jmTxNDfZjD8Z+NgN
 MqBQRd9NtPhZw6pnqlxWWI91KOAH6uyQr3wRqB/O3QKIdFcosiU3E81lHIxFV5RYVJdV3Rw+JMp1D
 bkmNVEW8NCB2IXsZ8GxC1Wu8KRXXGEXl/imA7i/ThUs9lN47wdP6Q/1iMk9e0FwVpMISiw5sPXWVi
 6woZoSnJsMxyO5Du3hg9DpRBMtGEb8UkxpFH0X2pbBBXn22jeFhqheJ1QOv5nX+EO1aB5jUchfguH
 KbBGIVrw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lUY26-0002Ll-Kj; Thu, 08 Apr 2021 11:01:32 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lUY25-0002Io-7a; Thu, 08 Apr 2021 11:01:29 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org
Cc: Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Logan Gunthorpe <logang@deltatee.com>
Date: Thu,  8 Apr 2021 11:01:09 -0600
Message-Id: <20210408170123.8788-3-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
References: <20210408170123.8788-1-logang@deltatee.com>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com,
 ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch,
 jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org,
 dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com,
 jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com,
 logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH 02/16] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210408_180135_927061_AA0C1CAB 
X-CRM114-Status: GOOD (  19.44  )
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

In order to use upstream_bridge_distance_warn() from a dma_map function,
it must not sleep. However, pci_get_slot() takes the pci_bus_sem so it
might sleep.

In order to avoid this, try to get the host bridge's device from
bus->self, and if that is not set, just get the first element in the
device list. It should be impossible for the host bridge's device to
go away while references are held on child devices, so the first element
should not be able to change and, thus, this should be safe.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index bd89437faf06..473a08940fbc 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -311,16 +311,26 @@ static const struct pci_p2pdma_whitelist_entry {
 static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 				    bool same_host_bridge)
 {
-	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
 	const struct pci_p2pdma_whitelist_entry *entry;
+	struct pci_dev *root = host->bus->self;
 	unsigned short vendor, device;
 
+	/*
+	 * This makes the assumption that the first device on the bus is the
+	 * bridge itself and it has the devfn of 00.0. This assumption should
+	 * hold for the devices in the white list above, and if there are cases
+	 * where this isn't true they will have to be dealt with when such a
+	 * case is added to the whitelist.
+	 */
 	if (!root)
+		root = list_first_entry_or_null(&host->bus->devices,
+						struct pci_dev, bus_list);
+
+	if (!root || root->devfn)
 		return false;
 
 	vendor = root->vendor;
 	device = root->device;
-	pci_dev_put(root);
 
 	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
 		if (vendor != entry->vendor || device != entry->device)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
