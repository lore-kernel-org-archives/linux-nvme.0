Return-Path: <SRS0=3vHZ=KJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10208C43600
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 13:49:31 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7F50610FC
	for <linux-nvme@archiver.kernel.org>; Fri, 14 May 2021 13:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7F50610FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ceadMxDIM7Kg4mb0Z2qa5vaY9DAX3IA8vxrSFVI8FUI=; b=aQ0va5Gt6cOn/ytTDoyVn2/RJ
	jTrwy2HoATIvy2JdbQ8z7VYHKQHoL4rlPR8FwfQa2t8U9Jf19Cp6EFFET8ZBENTephTIPrktIMzKI
	JMtBo9DVWtrXXSLm7If0C5wPXE9gJPdgQ7d2Qrr5pOshvJPPR5RORiLKrsgJdM0gfomxspdcx+3sJ
	GQ4c5MoXGPnaFDKd87ka/K1Di9MPQv4z0KUOfazYcd+PDcXEFttieU4GSKJW3nzs7CqPFguQ7jZx3
	defFSpMWmDaZzIh85B0mKE+lR9K3niSp2O1VPNdQL4oPbaSLwuAgZq5zQxjeLwX5Q1g338sQhRE+a
	2RvnStEPQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lhYBo-008CB6-KN; Fri, 14 May 2021 13:49:16 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYBk-008CAQ-UO
 for linux-nvme@desiato.infradead.org; Fri, 14 May 2021 13:49:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=T04WYniGI4x3hbahY86XzwWHll+OsBZsVxEANmECMRI=; b=xE8Yc82l1Hm5cnn903SIYrLnoz
 aCy0xbroYpnyp5MR8W42WJayg//Dys6kLBub/Ou6tw6DJ0ToK9Qri9ehGlD0IrtKmFbMf2uDFN6iL
 7rk3O/luFg3GBeI+i5mblSWNWyZLsxxlm++1Y4sGkFJ9nvCVLt0fiJDY5zbTz2fCV7iEvNp26PMZI
 N+XaFlKsfJAzSEg8WejXgzpev8A9CX4tpyaEAx/dUjpgCcYkObooOMKtzyCa2UhAULFWk+fTOAcdM
 Kw5mAZZI1KmUsAeRkGkbykJRVtSkNXssGdW0RyAmfLUpZ6rcxpFzzmFqwgxO63zlgwtV5DkrfcKKO
 oKrploYg==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lhYBh-00C0tJ-V8
 for linux-nvme@lists.infradead.org; Fri, 14 May 2021 13:49:11 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 2A43F6736F; Fri, 14 May 2021 15:49:01 +0200 (CEST)
Date: Fri, 14 May 2021 15:49:00 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 06/22] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
Message-ID: <20210514134900.GA4715@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com>
 <20210513223203.5542-7-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210513223203.5542-7-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210514_064910_166956_24044C32 
X-CRM114-Status: GOOD (  13.67  )
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

On Thu, May 13, 2021 at 04:31:47PM -0600, Logan Gunthorpe wrote:
> Attempt to find the mapping type for P2PDMA pages on the first
> DMA map attempt if it has not been done ahead of time.
> 
> Previously, the mapping type was expected to be calculated ahead of
> time, but if pages are to come from userspace then there's no
> way to ensure the path was checked ahead of time.
> 
> With this change it's no longer invalid to call pci_p2pdma_map_sg()
> before the mapping type is calculated so drop the WARN_ON when that
> is the case.

Why?

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
