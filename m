Return-Path: <SRS0=15Zf=IO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B1C4C433DB
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:01:01 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 159D160240
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Mar 2021 08:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 159D160240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=jBMommuIyVjA2uodu7sdDsjGQ9uhbM8i7TrgJuVgPpc=; b=qr5RjzwWJRXr3JZPhYBi2zueC
	Jde/q/TzxSwyhlXjmFqxV4Pthw+dL51I3dLeFUxw6bKoMyH2pIYbGnkGt/Ns2qbhvsezMA+6rqEWa
	0GiYcajrcaJa5rYdjwkS6bDgiqlouw6wGivJgaNu8aGliMMLRhCMlIStgRUgCugXDr/hd9YIvgdXK
	7psVuT7fKGzemY7UM0aqHEh4o37fpnzYOhUbMOJr3E2kK8a5MEu1tS0R1SaNOfw+NOP+LsJpgTR/E
	74/y3ZEnFyJqFxz+OFbl1wu25+OaX/Z9jSlL2D58eDrFowpK5EJEDlSEyMZNkOZzouKOib+bndudP
	Ma3x+eJAQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lM4d9-0003Jr-5h; Tue, 16 Mar 2021 08:00:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lM4cg-0003Bh-OG
 for linux-nvme@lists.infradead.org; Tue, 16 Mar 2021 08:00:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 75A4D68C4E; Tue, 16 Mar 2021 09:00:09 +0100 (CET)
Date: Tue, 16 Mar 2021 09:00:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Ira Weiny <iweiny@intel.com>, John Hubbard <jhubbard@nvidia.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 07/11] dma-mapping: Add flags to dma_map_ops to
 indicate PCI P2PDMA support
Message-ID: <20210316080008.GC15949@lst.de>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-8-logang@deltatee.com>
 <20210313023657.GC3402637@iweiny-DESK2.sc.intel.com>
 <e9a6689a-3cb7-aa30-33e7-b27015754b73@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e9a6689a-3cb7-aa30-33e7-b27015754b73@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210316_080015_546564_9872F71D 
X-CRM114-Status: GOOD (  16.36  )
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

On Mon, Mar 15, 2021 at 10:33:13AM -0600, Logan Gunthorpe wrote:
> >> +	return !ops || ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
> > 
> > Is this logic correct?  I would have expected.
> > 
> > 	return (ops && ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED);
> 
> 
> If ops is NULL then the operations in kernel/dma/direct.c are used and
> support is added to those in patch 6. So it is correct as written.

It is not quite that easy. There also is the bypass flag and for the
specific case where that is ignored the code needs a really good
comment.  And to assist that formatted so that it makes sense.  The
above line is indeed highly confusing even if it ends up being correct.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
