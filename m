Return-Path: <SRS0=Ydhk=OG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9513C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 23:56:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FC7E60EE2
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Sep 2021 23:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FC7E60EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Subject:MIME-Version:References:
	In-Reply-To:Message-Id:Date:Cc:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=+/nHpw6Ew869BlbQN7hZmtu9Ws/5Z8uml6srJn6Ygb0=; b=yASivQrf/xlatM9HpDAVfFtn7f
	9xtIJI8mS36S3UY5BMJy1dIdSHQBqzGykFJMD7/lvqO4F2ZE6sCNSzovGDIj7BnZCoNIiwCOhx1Re
	k7snpZ04MH4SczMYFjhg5HiOXeemx5QNAZELcsHSt7GH6/NpJm/RsYCWRFH0USTxZ3Jfy7S+RiY9l
	os57xMMEwW4RIAXkDGmgvFT6xxwmjL/vSZAlTPoWG8tF94J/mixQDy2mJQb1Imo2iZYPZSKTOFrtY
	LXQRxYWZbki3VRIe9gx0fcIOrpFdnocFz5vv/Cj+GkGMABQ44gCfO3fIBLEvJEBz3ajw0ZKcPgb0/
	TboK6jyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mR1Ev-00Clqw-5u; Thu, 16 Sep 2021 23:56:25 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mR10I-00CiVV-SG
 for linux-nvme@lists.infradead.org; Thu, 16 Sep 2021 23:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=Yz7/Dg6RG5uFdKEWz7fCfOIaPt94X46Gov2AZcvx1yo=; b=Zs5M0NYfy/xXFIpoRhIv/Q09ZY
 ZNc/ktEXRqFRUQ+RWdFANpv1kwCS8ebErssaGlf7W80S5v4VxCqpX8RXs9LKkKbngodxeBilCfs5e
 CsjCMmoIudLnULI2ucZuyWZu1VJfOutGm7bhiIuXdjAXF8SnCtNM5TVY25JlXwPjkskE+Ks7mxijw
 53vbhVCYOixN7WhIzEfOTo1VcRJet7jxCqs8dGnKkVqyx+aiA/RPQsEPYPPEWgn4+cGJ0kksM+vhV
 fQjwR64UCzxdbE/QXaFFwtchbj0IzuJ8j8PuKTF3bP28hlTQS/NsojchbXUwKQn8+6YayRpq1UHsl
 JEwRTA/Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1mR10H-0008I1-GG; Thu, 16 Sep 2021 17:41:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim
 4.94.2) (envelope-from <gunthorp@deltatee.com>)
 id 1mR104-000Vr1-5i; Thu, 16 Sep 2021 17:41:04 -0600
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
Date: Thu, 16 Sep 2021 17:40:45 -0600
Message-Id: <20210916234100.122368-6-logang@deltatee.com>
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
Subject: [PATCH v3 05/20] dma-mapping: allow EREMOTEIO return code for P2PDMA
 transfers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210916_164119_266443_45D4463D 
X-CRM114-Status: GOOD (  12.68  )
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

Add EREMOTEIO error return to dma_map_sgtable() which will be used
by .map_sg() implementations that detect P2PDMA pages that the
underlying DMA device cannot access.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/dma/mapping.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 7ee5284bff58..7315ae31cf1d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -197,7 +197,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	if (ents > 0)
 		debug_dma_map_sg(dev, sg, nents, ents, dir);
 	else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
-			      ents != -EIO))
+			      ents != -EIO && ents != -EREMOTEIO))
 		return -EIO;
 
 	return ents;
@@ -248,12 +248,14 @@ EXPORT_SYMBOL(dma_map_sg_attrs);
  * Returns 0 on success or a negative error code on error. The following
  * error codes are supported with the given meaning:
  *
- *   -EINVAL - An invalid argument, unaligned access or other error
- *	       in usage. Will not succeed if retried.
- *   -ENOMEM - Insufficient resources (like memory or IOVA space) to
- *	       complete the mapping. Should succeed if retried later.
- *   -EIO    - Legacy error code with an unknown meaning. eg. this is
- *	       returned if a lower level call returned DMA_MAPPING_ERROR.
+ *   -EINVAL	- An invalid argument, unaligned access or other error
+ *		  in usage. Will not succeed if retried.
+ *   -ENOMEM	- Insufficient resources (like memory or IOVA space) to
+ *		  complete the mapping. Should succeed if retried later.
+ *   -EIO	- Legacy error code with an unknown meaning. eg. this is
+ *	          returned if a lower level call returned DMA_MAPPING_ERROR.
+ *   -EREMOTEIO	- The DMA device cannot access P2PDMA memory specified in
+ *		  the sg_table. This will not succeed if retried.
  */
 int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
 		    enum dma_data_direction dir, unsigned long attrs)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
