Return-Path: <SRS0=xhFb=KI=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A1C433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:49:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA635610E6
	for <linux-nvme@archiver.kernel.org>; Thu, 13 May 2021 22:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA635610E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5PYdtXAR6i1z0C3Wopq2Y34QLc+tt9hYaq1ATMh7Tzc=; b=Zf8DhSH1d5pwJS
	Iu2GzS3vYNgCGxLqEvRHFJoOFRR0UJWw3ZK8hQA85oyLUp9rgmCdnac8ACUKQ33fYpzcvSx3tPVHO
	LmqVzo/BCPz88DAGJ14Qvb2nvShXWO6TWSlgQzzkk2YW2YT60NHVBZeY3/UIDMJnD9l22qtvr2c67
	JOo9jpp5fdyqJHaMJqbr1GN4fYNkLLi5+sM/jp/kpcDNOarOUsAiyGVdMlo9wDPZDGz7EMGNjXuNl
	9ck7hhk0ZqMixwbhQf+dEtquPCntwzXXXsKpHm61ySigHEL2kgzYbUrhp2dVp44vl6mlyFQRTpKLx
	YEDzFkF2vTwPMbQqfXJw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhK90-006aqQ-MR; Thu, 13 May 2021 22:49:28 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsa-006Ydu-4U
 for linux-nvme@desiato.infradead.org; Thu, 13 May 2021 22:32:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Subject:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Cc:To:From:Sender:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=0So9SX+KFL5UGdS3JALTvYX2o53SL7VRdq+tjhsTXy0=; b=yD6X3biRWw/qn3fRFd8eUrGwZ6
 gI3f+DsdFyx5tILQ8BD00Gzl/hkyvxI5rH3cOnb294t+fveZbTA3tKcLxdEuIbUFWjpFofrBPIF12
 UTIDz+STBSSzBA7rd0lZrutetZjiUUoHbZJRH8AVJfz2x8vmKGwCHS+8Dw4B+iK8lWzhioOYWCp6z
 qblkQojxyKLppMpOmMIBhf3vaYIBcEFXJRBnCiQyH+sN51snFZrix67tKQvdWz19g9nJh5hWsZIcs
 whcz+uUlinN9UNchGs7aIsH6mjswuZ22IVICOI8GMGY27qaa3DuxfG+HTi/O193W9HVV6yOwaIEG2
 fxs0InYw==;
Received: from ale.deltatee.com ([204.191.154.188])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhJsX-00BZEj-NF
 for linux-nvme@lists.infradead.org; Thu, 13 May 2021 22:32:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Cc:To:From:content-disposition;
 bh=0So9SX+KFL5UGdS3JALTvYX2o53SL7VRdq+tjhsTXy0=; b=I4gtimz4ShXoyX5SWboyQE7w9W
 kswCvfBAelapFKYy/VPPbAd+QkaSuIAqHlXoTcAipI2SaLnx+SDRzveGPiIcMUB2G5CoYuZnBiUoK
 cu7iuEkqkWIX94CubpeWjdBSdOBEtxInnOWWGpZYeh2fTtHzv2DX0RLaoxvszUNHOBXykRVaHV6QD
 absF9Bc5hfqjFj0ZdNxXNkltgm9NTg4CaRK3DsGrUC+8wsLJm+BB++pNBn4hKlWSX9qI6taQGPqWr
 Bx62ylIINBEFIDpk3SjxAVzcVvEAlntfW9pr65kzz0z3wVqv2rZZkVz+M9yxmGuHDi6JPsTV0KHU0
 pKR3doDA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsW-0000nF-GA; Thu, 13 May 2021 16:32:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1lhJsG-0001St-Vi; Thu, 13 May 2021 16:32:09 -0600
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
Date: Thu, 13 May 2021 16:31:50 -0600
Message-Id: <20210513223203.5542-10-logang@deltatee.com>
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
Subject: [PATCH v2 09/22] dma-direct: Return appropriate error code from
 dma_direct_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210513_153225_775571_92C2956A 
X-CRM114-Status: GOOD (  12.34  )
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

Now that the map_sg() op expects error codes instead of return zero on
error, convert dma_direct_map_sg() to return an error code. The
only error to return presently is EINVAL if a page could not
be mapped.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f737e3347059..803ee9321170 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -411,7 +411,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 
 out_unmap:
 	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
-	return 0;
+	return -EINVAL;
 }
 
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
