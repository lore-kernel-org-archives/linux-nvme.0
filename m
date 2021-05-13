Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E68C43618
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:33:25 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36E261440
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:33:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36E261440
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sTo5XfRbIg5KGEGRYvrJkuXFZTzFN236TGdJoRWZXAY=; b=paOA5LAmbxpaqI
	LMdNcGydk9oQ7ewLiMEFaQ41ZtM60YdD0KIKB76ufrPxlz3MeULNF3klGWzYio9mbMTYKqo/McXCv
	bOxuckhSQLhwCFx4qkVJmkT+1WLM9Od99G2ZRuEwN9meLr+ZpHLc2/q8p049+ctp10vOQ/6jzWbWS
	iE8HTPpPEoyVnVKism25gSGDr7Iz8ioASaQLO6Od7RJ+O587njZ3/q5OTCcydUrIjRDTt8n5IiGvv
	h7JDfrjyhhlC/XPcy1Ghli2OEyA4x+D9uqYUyxlT5u50Z2W/H1K5x4yYC80SjPFjGJHLJNdFTDR0t
	HyCq8n3ogEtbkdwI4p3Q==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhJtS-006YmZ-O7; Thu, 13 May 2021 22:33:22 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsU-006YcI-21
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=DGEbO1eDsmi+omtiZtoL8bN3wHWEYyZxOXmeMgj8t5E=; b=W5XmnPn9i+Rur19Hy28DG0rR8Y
 j2WeckGUFNvJ6VTve3OEZHeK+qLZ29iB4+b222LVAYmVlttCwMAXyf/Lb3fbRGVofCW7+AS3j1C0G
 4Zr/GlADKWPgUoCDb58FtcnuwMp2lTItkT9hIU1VBMes1ceLy6LJw0DoVVvujqfkVsHYPD9coVX9Y
 BorCFETINpvMhKkziJ1Ceh7vxYuMNDcxr5lmz+jqyba7SgKZH3s2yIEXsZhIcdkdmWJiDVdg8szuk
 Y/w3F0u88mhMYM3ZyLp7PPIR9BoSvSGKMC6C/XJsvTXDp8R/CjIVx3ZmuSBMZo6p23VsqiJR/sbaO
 PqOsC5EA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsP-00BZ9J-SG
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=DGEbO1eDsmi+omtiZtoL8bN3wHWEYyZxOXmeMgj8t5E=; b=YeD+bra3l3uIf07AwPoKcCDa4Z
 JfnhnF/wgBgfdJ84A3ZDSr+qlE7cCVn2z0uGxlci+fWP7OKTeWw3/yzUEp1ZhC2t9KgFJ0qYmkNKd
 FH9FUq94L7wlEqzzOlnpClMKI2U7IpxFXwQVaGzI7Khfkt9nzLl+RSS8QHlF8nglOnJrADHtYn1Zv
 cIzkZK72rbD+ve6pt291ikLf40mIxO2vGdumHGtH3Ykc+TyNm2TafzntSERgJ2bbZ8OQIDciQWDfg
 QB60+m/XtVqPSUGx7WKmh8O/rFhKxYTYKSdWAyWvClIyOO1Sz74t2kBUCAMGdulRNKr8U11s9LDND
 bDQMd57g==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsL-0000nC-QQ; Thu, 13 May 2021 16:32:14 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsF-0001SV-Pg; Thu, 13 May 2021 16:32:07 -0600
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
Date: Thu, 13 May 2021 16:31:42 -0600
Message-Id: <20210513223203.5542-2-logang@deltatee.com>
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
Subject: [PATCH v2 01/22] PCI/P2PDMA: Rename upstream_bridge_distance() and
 rework documentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153218_022086_55E1DD66 
X-CRM114-Status: GOOD (  26.53  )
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

The function upstream_bridge_distance() has evolved such that it's name
is no longer entirely reflective of what the function does.

The function not only calculates the distance between two peers but also
calculates how the DMA addresses for those two peers should be mapped.

Thus, rename the function to calc_map_type_and_dist() and rework the
documentation some to better describe the two pieces of information
the function returns.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 63 ++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 196382630363..6f90e9812f6e 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -354,7 +354,7 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
 }
 
 static enum pci_p2pdma_map_type
-__upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
+__calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
 {
 	struct pci_dev *a = provider, *b = client, *bb;
@@ -433,17 +433,18 @@ static unsigned long map_types_idx(struct pci_dev *client)
 }
 
 /*
- * Find the distance through the nearest common upstream bridge between
- * two PCI devices.
+ * Calculate the P2PDMA mapping type and distance between two PCI devices.
  *
- * If the two devices are the same device then 0 will be returned.
+ * If the two devices are the same device then PCI_P2PDMA_MAP_BUS_ADDR
+ * and a distance of 0 will be returned.
  *
  * If there are two virtual functions of the same device behind the same
- * bridge port then 2 will be returned (one step down to the PCIe switch,
- * then one step back to the same device).
+ * bridge port then PCI_P2PDMA_MAP_BUS_ADDR and a distance of 2 will be
+ * returned (one step down to the PCIe switch, then one step back to the
+ * same device).
  *
  * In the case where two devices are connected to the same PCIe switch, the
- * value 4 will be returned. This corresponds to the following PCI tree:
+ * distance of 4 will be returned. This corresponds to the following PCI tree:
  *
  *     -+  Root Port
  *      \+ Switch Upstream Port
@@ -454,31 +455,31 @@ static unsigned long map_types_idx(struct pci_dev *client)
  *
  * The distance is 4 because we traverse from Device A through the downstream
  * port of the switch, to the common upstream port, back up to the second
- * downstream port and then to Device B.
- *
- * Any two devices that cannot communicate using p2pdma will return
- * PCI_P2PDMA_MAP_NOT_SUPPORTED.
+ * downstream port and then to Device B. The mapping type returned will depend
+ * on the ACS redirection setting of the bridges along the path. If ACS
+ * redirect is set on any bridge port in the path then the TLPs will go through
+ * the host bridge. Otherwise PCI_P2PDMA_MAP_BUS_ADDR is returned.
  *
  * Any two devices that have a data path that goes through the host bridge
- * will consult a whitelist. If the host bridges are on the whitelist,
- * this function will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE.
- *
- * If either bridge is not on the whitelist this function returns
- * PCI_P2PDMA_MAP_NOT_SUPPORTED.
+ * will consult a whitelist. If the host bridge is in the whitelist,
+ * this function will return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE with the
+ * distance set to the number of ports per above. If the device is not
+ * in the whitelist the type will be returned PCI_P2PDMA_MAP_NOT_SUPPORTED.
  *
- * If a bridge which has any ACS redirection bits set is in the path,
- * acs_redirects will be set to true. In this case, a list of all infringing
- * bridge addresses will be populated in acs_list (assuming it's non-null)
- * for printk purposes.
+ * If any ACS redirect bits are set, then the acs_redirects boolean will be
+ * set to true and their pci device name will be appended to the acs_list
+ * seq_buf. This seq_buf is used to print a warning informing the user
+ * how to disable ACS using a command line parameter.
+ * (See calc_map_type_and_dist_warn() below)
  */
 static enum pci_p2pdma_map_type
-upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
+calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
 {
 	enum pci_p2pdma_map_type map_type;
 
-	map_type = __upstream_bridge_distance(provider, client, dist,
-					      acs_redirects, acs_list);
+	map_type = __calc_map_type_and_dist(provider, client, dist,
+					    acs_redirects, acs_list);
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
 		if (!cpu_supports_p2pdma() &&
@@ -494,8 +495,8 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 }
 
 static enum pci_p2pdma_map_type
-upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
-			      int *dist)
+calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
+			    int *dist)
 {
 	struct seq_buf acs_list;
 	bool acs_redirects;
@@ -505,8 +506,8 @@ upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
 	if (!acs_list.buffer)
 		return -ENOMEM;
 
-	ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
-				       &acs_list);
+	ret = calc_map_type_and_dist(provider, client, dist, &acs_redirects,
+				     &acs_list);
 	if (acs_redirects) {
 		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
@@ -565,11 +566,11 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		}
 
 		if (verbose)
-			ret = upstream_bridge_distance_warn(provider,
-					pci_client, &distance);
+			ret = calc_map_type_and_dist_warn(provider, pci_client,
+							  &distance);
 		else
-			ret = upstream_bridge_distance(provider, pci_client,
-						       &distance, NULL, NULL);
+			ret = calc_map_type_and_dist(provider, pci_client,
+						     &distance, NULL, NULL);
 
 		pci_dev_put(pci_client);
 
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
