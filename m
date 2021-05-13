Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64740C4361B
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:32:48 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEEB661354
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:32:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEEB661354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PW3N7orHZNzluk78j04j7IqoYRXM7ieIeuJOU1Uuu8s=; b=Qw5Cl/1EinKVx8
	Jl7Vl4RXMh6VI0JpHrrYy0IG0r+aQLp6tFbXKwvOy6OVHqpd1MkBEu++gBR4n3JVyk7VclVkSM69j
	/REGVTKd+MXo/FMu/Bo+qAcVm3l0nn0J76CDqjParPlj9LAiUHokO7fjGRYv2ymDu2bM2qupcljkT
	wskOblWc/TxDwKCGnNLohOsBUxOvdFwnFyHCwx+SItOzjC3x1IokBIy7SybVX3GlSFXQL50v6Wa5R
	8p6vNZeVtuezA5tQ9zDfikTaFlCzf4XIDoy616F7gPFLvEF6CrCqNjI6RcXdj4go80jEaP5Yg1LN8
	dlQzrsgIbwqPCuqHfkRQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhJsl-006YgB-EO; Thu, 13 May 2021 22:32:40 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsT-006YcH-Nz
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=M9URDKLIjWjYTVDR2jo0iTH/7oGIDWR/L4jsn5dDFEQ=; b=xmWLcoxrj4Y9E2iPYICGAa8cs9
 oLz85a5zdDD2JRsbqyZjfeifFRn/DrOpf82tBeY903B3hKI22Iw9DXlNsBBArHN4At0vCkTMBdSao
 A3lwJZIrBmVVkdkFUjnY68eCG04ehB6RXsmYhWtopnGJqrTjsmlRVjzFzCX9b6L4fKCJUkOaSeN2f
 3ptHQAkKTXLlDO+FCsolaRm2ZB9bRFzl40GDYqxiKFemG0qxiNAtGUJTaPDbRrtHAj8O6sqKWW6/h
 NFR/iID5NbZlN6OY0tAuOTNn9/wsmtxNoXVDoiHMCXrSe2piFmkwATdDoYlrBD2azZQj5rF4F66WJ
 p+QfccyA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsP-00BZ9M-S2
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=M9URDKLIjWjYTVDR2jo0iTH/7oGIDWR/L4jsn5dDFEQ=; b=n061DgFCU9NzN4lKQkcvE0Vgff
 KqhQDsQf0FiHKJh0lpMDW4cqOXRvLM/1rmcyvnVpn/5jOAJSiT/yAzjgyESNl4ZXz+x7ORPlwQVjh
 SSm0Re7Hp1abk1zwbYETKG6X5/K7JsNKOCnjUK3UmCvlBxfkfTH+qwQbextk6lh11y0h6q58XSIQw
 6gOm0v5wVAy8/07ejEh5EqIUurPNcs1vtn25yGx05VbRETmh+h2ex+rOAzXUDibvFm2ryrZdrgWkq
 YeZI+qDF6xJDuqpnUx1/jIX8Tvr5C7DvFVIDvpZsoLK6/v3ulzBnPocYSJspfOD6XijvgJtl+IlbT
 GAESFp5w==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsL-0000nF-QQ; Thu, 13 May 2021 16:32:15 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsG-0001Se-6p; Thu, 13 May 2021 16:32:08 -0600
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
Date: Thu, 13 May 2021 16:31:45 -0600
Message-Id: <20210513223203.5542-5-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
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
Subject: [PATCH v2 04/22] PCI/P2PDMA: Avoid pci_get_slot() which sleeps
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153217_996401_75F2D2D0 
X-CRM114-Status: GOOD (  21.89  )
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

In order to avoid this, try to get the host bridge's device from the first
element in the device list. It should be impossible for the host bridge's
device to go away while references are held on child devices, so the first
element should not be able to change and, thus, this should be safe.

Introduce a static function called pci_host_bridge_dev() to obtain the
host bridge's root device.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 09c864f193d2..175da3a9c8fb 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -308,10 +308,41 @@ static const struct pci_p2pdma_whitelist_entry {
 	{}
 };
 
+/*
+ * This lookup function tries to find the PCI device corresponding to a given
+ * host bridge.
+ *
+ * It assumes the host bridge device is the first PCI device in the
+ * bus->devices list and that the devfn is 00.0. These assumptions should hold
+ * for all the devices in the whitelist above.
+ *
+ * This function is equivalent to pci_get_slot(host->bus, 0), however it does
+ * not take the pci_bus_sem lock seeing __host_bridge_whitelist() must not
+ * sleep.
+ *
+ * For this to be safe, the caller should hold a reference to a device on the
+ * bridge, which should ensure the host_bridge device will not be freed
+ * or removed from the head of the devices list.
+ */
+static struct pci_dev *pci_host_bridge_dev(struct pci_host_bridge *host)
+{
+	struct pci_dev *root;
+
+	root = list_first_entry_or_null(&host->bus->devices,
+					struct pci_dev, bus_list);
+
+	if (!root)
+		return NULL;
+	if (root->devfn != PCI_DEVFN(0, 0))
+		return NULL;
+
+	return root;
+}
+
 static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 				    bool same_host_bridge)
 {
-	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
+	struct pci_dev *root = pci_host_bridge_dev(host);
 	const struct pci_p2pdma_whitelist_entry *entry;
 	unsigned short vendor, device;
 
@@ -320,7 +351,6 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host,
 
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
