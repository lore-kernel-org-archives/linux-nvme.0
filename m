Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1724C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Apr 2022 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qwHhhptcjs675dAW5wV9iUf/ZWGXFcOtu4sOGzEzFjs=; b=xh4wKXCmN1kDtIGok2ZQi4Z9+r
	Wq727HVogvskQCTDF0dcdPSPx5JBWAOdJ6BzWeKJq70oPDDeeX01j/bjnADJys+SLMhkZd1/apYNS
	lvmmMueRxxYufKDKG8uDPsfJ2TgOCzLBd/P0rqPeA0RMB8y/zweDr/VBgyhge8qseSq8E3hId5KCL
	bf7BEluFDZbY1/sO+CK0QIpRi88RCbTPKVccFjahRvUEpJ0mo0En5eUEKD1PwxhlykYs+aaetQyWP
	HAaLawD69dzPDFzC+N62hTacyqNxVcs4QrMA45At2e7pDtJpNin+83PN+zJ7roYzYysKFub2TL6TH
	XcT40S2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ncUrg-00D14w-0m; Thu, 07 Apr 2022 16:20:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncUMh-00Co7d-Dh
 for linux-nvme@bombadil.infradead.org; Thu, 07 Apr 2022 15:48:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=qwHhhptcjs675dAW5wV9iUf/ZWGXFcOtu4sOGzEzFjs=; b=cne2yNU8yeR+3385JYzuBVd+LK
 ZeJbUNB2BIzGMQiVI01BntSidPUh4Zb/V2JyOtge++dBg6XDoxqFTB/GRdggVfd52/9fyOFJ9DamA
 PQYBeMEDHN5nFT1B7FVkqBsyUXcxV2uR0/z/afmjQkZBnN09gR7mt4tZQ185LPkz0zJ44A6w5EJcZ
 HA04HkDdG8HBK1Ij3mYEhNNEAhb57eotQG6+gB/+6eA2cDhlwWc/WtEvgbFdrYyCE7wASwewpFBiQ
 +gVy1u/heLtct7yagM8OwSObAMe9D618EFRfrL1Cwc4FLwARp+YVEUWzpQQnU7/A3f4aIdqyzYNPH
 RCalXRCA==;
Received: from ale.deltatee.com ([204.191.154.188])
 by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ncUMc-002Xlh-BM
 for linux-nvme@lists.infradead.org; Thu, 07 Apr 2022 15:48:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=qwHhhptcjs675dAW5wV9iUf/ZWGXFcOtu4sOGzEzFjs=; b=EOT6Ow6UdVvIY4DKNDl28DKbdr
 XL5XBU0ol/6KJ5yyMeQNVEigE3hI5Hq4vvc9uqb7OcthVIfXm8w4RQpIMDrwoU1JA19vDtZcFnUxv
 l7jAKiqD9ealgWX/ab89zuM+BD85MGrlTeWGSadgaMFatmmm0Y/RkNARI8eHFX1+dzqYiaQLyxl20
 9DAAC0pIu2lI1X5Vo1nT8DW41LqG5BDQMmtDKYwT0g3x/8xszhQy7g+abnKiSf+qEbhvQuOU1qe3o
 SeUkhbs0C0A1KQMoBspjKBQVeW2vsuXxkiX5n3YFsn8s+JEHD0SNW9Y5gMID8PeWk3yZlXoJd2PpH
 ZryrM0ug==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMM-002BBg-He; Thu, 07 Apr 2022 09:47:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1ncUMC-00021T-0m; Thu, 07 Apr 2022 09:47:36 -0600
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
 Ralph Campbell <rcampbell@nvidia.com>,
 Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@nvidia.com>
Date: Thu,  7 Apr 2022 09:47:01 -0600
Message-Id: <20220407154717.7695-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
References: <20220407154717.7695-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de,
 jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com,
 willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net,
 dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com,
 andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com,
 ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com,
 ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com,
 rcampbell@nvidia.com, jgg@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v6 05/21] dma-mapping: allow EREMOTEIO return code for P2PDMA
 transfers
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220407_164803_088601_1F170C07 
X-CRM114-Status: GOOD (  11.37  )
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

Add EREMOTEIO error return to dma_map_sgtable() which will be used
by .map_sg() implementations that detect P2PDMA pages that the
underlying DMA device cannot access.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 kernel/dma/mapping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index db7244291b74..9f65d1041638 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -197,7 +197,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	if (ents > 0)
 		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 	else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
-			      ents != -EIO))
+			      ents != -EIO && ents != -EREMOTEIO))
 		return -EIO;
 
 	return ents;
@@ -255,6 +255,8 @@ EXPORT_SYMBOL(dma_map_sg_attrs);
  *		complete the mapping. Should succeed if retried later.
  *   -EIO	Legacy error code with an unknown meaning. eg. this is
  *		returned if a lower level call returned DMA_MAPPING_ERROR.
+ *   -EREMOTEIO	The DMA device cannot access P2PDMA memory specified in
+ *		the sg_table. This will not succeed if retried.
  */
 int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
 		    enum dma_data_direction dir, unsigned long attrs)
-- 
2.30.2


