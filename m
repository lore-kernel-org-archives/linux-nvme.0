Return-Path: <SRS0=tSwM=QE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E98C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 21:57:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 050EC61265
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Nov 2021 21:57:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 050EC61265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date
	:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3aZ2AYK60CEaIE70gWhhj4/fir+nnPw5quNT7e3qCog=; b=KcB5Xs77mqk1B6NpagwV0J3B+/
	JoLhNZp6yIWFi1Oak19LlLu2+6r8Ig4sAsAxvUy6XzeLx3IaRx5WxOUer2p0fmeQklh+KPMPl2Ick
	Nm/HFgxET2wcx34NS0/GGLVPTDHvVOWP9+871LFC2S6Ww2/wzdAcnxhrcKJX86DlVQMaC8+Y4bonc
	kI0y7L6NED4DiJbkpj+3Z0P86iWxzvJivJypwnltEf2vTyYJsC7Y75TCCXnTwBjQt9GDi4oLcInB5
	QV+AhmQHq38oeTfSgpc6RbBi/Z+do2En8djD2X0jgfNesFOvOMvyyswMDKYyEYJXkvFu4r/G3qM3H
	cWL8XKXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mnSvi-006Mjf-Vg; Wed, 17 Nov 2021 21:57:23 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mnSsv-006LVE-Eo
 for linux-nvme@lists.infradead.org; Wed, 17 Nov 2021 21:54:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=3aZ2AYK60CEaIE70gWhhj4/fir+nnPw5quNT7e3qCog=; b=NJEPejp0LpTJMPJAQBDQ1MYs1+
 3UL1xqlHQNFve4AhubcfvJKHkXFRnbIFuwZ8T2e1///MP9tlXlO+pNXwRGzqvcbNPNKG4mNp/jios
 Q83WLonVf6I8Rsgwt3nmUmvdLiZ9bkPYSIxdIhcuIg8oUL71wZh4T6i412CYWLfvGDfmjM96tej1y
 /7oe4Y7hqf+VYC2Uo+9Oq0Ec8U78z6glajffd7td9yLaKsDHcdY6E5m1ST+5YQH32wUItt0YxBvkx
 b++3RG4kf7n8gFxLoWSWWwW+IiIORy8KMkFbkAFplbYybYTd7KzFgDj8DXHUJxwJKJ4bxEEixnMKk
 oLyUObBQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsr-000Zo3-Jf; Wed, 17 Nov 2021 14:54:27 -0700
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mnSsi-0000z4-N4; Wed, 17 Nov 2021 14:54:16 -0700
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
 Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@nvidia.com>
Date: Wed, 17 Nov 2021 14:53:53 -0700
Message-Id: <20211117215410.3695-7-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211117215410.3695-1-logang@deltatee.com>
References: <20211117215410.3695-1-logang@deltatee.com>
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
 jgg@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v4 06/23] dma-mapping: allow EREMOTEIO return code for P2PDMA
 transfers
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211117_135429_548141_8D302569 
X-CRM114-Status: GOOD (  11.94  )
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
index 9478eccd1c8e..c056a1468189 100644
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


