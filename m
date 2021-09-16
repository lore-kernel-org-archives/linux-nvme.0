Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2015DC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 23:48:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD4F66120D
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 23:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD4F66120D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=Df1hKJat7NCaDoiJIdu4bHTYpV28nf89xp3EAid+L1M=; b=B6TQgHP9pAE65Ek8Fpji2JEVl8
	TuMsqkBpOkRx8WRydedAG1yjtsboEdSA+pdHCghghKasRIDXMhTZPQmmXOHlBY6wVUYqDoJEuNAit
	g/KQw3ktqs3WUWNk3MNFCi4kztPBAVyo7CT38sglR4JtvCJiNIX01qMz4rdsCFGPOk3si/XWIvuk2
	NnweUuIk9FxTvpJaqI9O42eTn53A5t0RRKTL1Mampxe1gNYnYtg/SRsBcnOmw7SekkuHSOJNIAr35
	5sqfREOyiXwH4uhhwkwhxWbW36Li0GVWhEnG7qyR8xCOvMZz8U/kd5vJTh1jvAmUFAnDehabc0Ifo
	d8Fw0wVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mR176-00CkYI-G2; Thu, 16 Sep 2021 23:48:20 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR10G-00CiSu-1d
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 23:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=xu7RSYLSljbvAHrIsQ+0jbijIDTDseCYnM10p+UoCDw=; b=Vmzky1ijjHNHMVGmCDNrU5JhF2
 /be1hUwF7caE/oOmUlrxvGVdNZ7rrRKaVZd821he9A3A4kyJ4YJGZsunxw0r7wk5VPlMS1CchrkLi
 h3ARtjuy/fCQxmYASGb+5ZfMOVD5ycXWPh2rfP1a0+DNSvoiIK2X/MpUNxU/0cM7UFyYevm8+Tbth
 AcyjO8qf8h4MZgxEPADtIiukv1P9KC8lm9oj4/DM+d5TX4BtkH7uULL1zoP0oFo4fxFGLf7usM+5b
 NbofpLayZLfwPJWD5lUyag+Ym7LQtSlXr3LpcXJ4T7fHNXdOT0ol5E8eN+P+DZ5R/J7zbYn2ORZH5
 TyXvjsyQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1mR10E-0008I1-4I; Thu, 16 Sep 2021 17:41:14 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mR105-000VrO-5X; Thu, 16 Sep 2021 17:41:05 -0600
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
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
 Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 16 Sep 2021 17:40:51 -0600
Message-Id: <20210916234100.122368-12-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
References: <20210916234100.122368-1-logang@deltatee.com>
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
 martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v3 11/20] RDMA/core: introduce ib_dma_pci_p2p_dma_supported()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_164116_425195_3372D473 
X-CRM114-Status: GOOD (  15.24  )
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

Introduce the helper function ib_dma_pci_p2p_dma_supported() to check
if a given ib_device can be used in P2PDMA transfers. This ensures
the ib_device is not using virt_dma and also that the underlying
dma_device supports P2PDMA.

Use the new helper in nvme-rdma to replace the existing check for
ib_uses_virt_dma(). Adding the dma_pci_p2pdma_supported() check allows
switching away from pci_p2pdma_[un]map_sg().

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/rdma.c |  2 +-
 include/rdma/ib_verbs.h    | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 891174ccd44b..9ea212c187f2 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -414,7 +414,7 @@ static int nvmet_rdma_alloc_rsp(struct nvmet_rdma_device *ndev,
 	if (ib_dma_mapping_error(ndev->device, r->send_sge.addr))
 		goto out_free_rsp;
 
-	if (!ib_uses_virt_dma(ndev->device))
+	if (ib_dma_pci_p2p_dma_supported(ndev->device))
 		r->req.p2p_client = &ndev->device->dev;
 	r->send_sge.length = sizeof(*r->req.cqe);
 	r->send_sge.lkey = ndev->pd->local_dma_lkey;
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 4b50d9a3018a..2b71c9ca2186 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -3986,6 +3986,17 @@ static inline bool ib_uses_virt_dma(struct ib_device *dev)
 	return IS_ENABLED(CONFIG_INFINIBAND_VIRT_DMA) && !dev->dma_device;
 }
 
+/*
+ * Check if a IB device's underlying DMA mapping supports P2PDMA transfers.
+ */
+static inline bool ib_dma_pci_p2p_dma_supported(struct ib_device *dev)
+{
+	if (ib_uses_virt_dma(dev))
+		return false;
+
+	return dma_pci_p2pdma_supported(dev->dma_device);
+}
+
 /**
  * ib_dma_mapping_error - check a DMA addr for error
  * @dev: The device for which the dma_addr was created
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
