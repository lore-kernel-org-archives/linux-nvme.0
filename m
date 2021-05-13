Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436A7C2B9F9
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:32:58 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3FEB61435
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3FEB61435
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jX/ikFPQLBbQk6ZzRM8re2QDnRTJbiX8ODvwe8wWaLE=; b=jCRKbcTXXWWdyA
	XXkxeGMFXC3VcmqJpLJuqVbapWZIN+JB7Kh+DGjqSIyc4jcyzErsMzeIi10IKKHYa70x45VcJ4QwJ
	RihNpdTF6no74UL8m8fayavzadRAf5Xk5Yewo1rrm1XSG1bEVpXrLfzPcr/u9KWDkNP/9lbQ8F+hJ
	TKvcpVEFtYGqBlSeklMhQZXfCSGIfWvUAUgadwHSsc/IKnOazdqkZFCkjaYc1ZjsgQ6hbwwdUuHwb
	cB0jsKYJAh6iYDhtpPyPAPqpo4D6Tp+WPgoJ87kJOW5d0MtQz4m9kjU/vIjZ6BguYu5GuyICVX3MO
	dghlD8Egea5NI2psUZTQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhJt0-006Yi3-Va; Thu, 13 May 2021 22:32:55 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsT-006YcG-I5
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=RHKX0JViuXrszDPT9ENKjwACXQHnqdf/mlZV6OtxZMk=; b=zYg0TJs2qcTVqR+M6LNfQtr3ZE
 CIDcngyc6kxACzJS1ckIwsRJUtJfT0AjaI2StVtsm9aW7NwAHtOgdwhY3YLFfFOVxcjwq+4M6R2S6
 B4RCT/afmBsfnU3kKK7rrQFZcjM9BMl8DIuiUmVCo3EBnqcjGf6ZfstU6HLOx7IXdheDvkFDtz/jj
 0odpBfVG5FhBcLnEKu9A6rNUJvX9UFTd3J3UQi0jsj0w9twKi7wzG5cDuoG870div5dG4EJ6NOkwv
 P+VDG7L9z5hSeBU7k0bimVtni+QC4o69i62XOmrX/RLltsr8z8SL7qhJMMqM7Qko8czDk3hVU8rTZ
 sCKjYdwg==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsP-00BZ9K-SI
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=RHKX0JViuXrszDPT9ENKjwACXQHnqdf/mlZV6OtxZMk=; b=suRMeNmUAK4D1LCjGjVPlBd7EG
 Uo0gPsu2BtUSYYWXhwNC5F5Rbe17tCB/jkhL6RSKRPfEbCcKxlvpJCsnMT7LhniM6WqF3OORunboL
 puYGUBidipQZtVozVDY/b2nIAZvAwBo+d84tQ8pWse1lWxTktrjC6V8bhEDjljeYLdHqQzEt4TBy+
 cFX7fRYRi7vBwhdMcl0EdpPDnIpiNqEeiAGsdc5nvVPnsPigJZ0QOQBGQeincxBOjawQNOY+I4GEU
 zfivxltZK8E3rcV7kTeK0e5HZSy5UY9q7EJ/41o7kQ7CmB0bc1LV1UJNaRK6FfxwWB3xmtELpqLqg
 sGCfBXyQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsL-0000nE-QQ; Thu, 13 May 2021 16:32:14 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsG-0001Sb-2K; Thu, 13 May 2021 16:32:08 -0600
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
Date: Thu, 13 May 2021 16:31:44 -0600
Message-Id: <20210513223203.5542-4-logang@deltatee.com>
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
Subject: [PATCH v2 03/22] PCI/P2PDMA: Cleanup type for return value of
 calc_map_type_and_dist()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153218_009675_AF1701F2 
X-CRM114-Status: GOOD (  12.44  )
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

Instead of using an int for the return value of this function use the
correct enum pci_p2pdma_map_type.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/p2pdma.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 3a5fb63c5f2c..09c864f193d2 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -544,11 +544,11 @@ calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
 int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			     int num_clients, bool verbose)
 {
+	enum pci_p2pdma_map_type map;
 	bool not_supported = false;
 	struct pci_dev *pci_client;
 	int total_dist = 0;
-	int distance;
-	int i, ret;
+	int i, distance;
 
 	if (num_clients == 0)
 		return -1;
@@ -563,15 +563,15 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 		}
 
 		if (verbose)
-			ret = calc_map_type_and_dist_warn(provider, pci_client,
+			map = calc_map_type_and_dist_warn(provider, pci_client,
 							  &distance);
 		else
-			ret = calc_map_type_and_dist(provider, pci_client,
+			map = calc_map_type_and_dist(provider, pci_client,
 						     &distance, NULL, NULL);
 
 		pci_dev_put(pci_client);
 
-		if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED)
+		if (map == PCI_P2PDMA_MAP_NOT_SUPPORTED)
 			not_supported = true;
 
 		if (not_supported && !verbose)
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
