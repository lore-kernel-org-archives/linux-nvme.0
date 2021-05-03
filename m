Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674F3C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:24:53 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DB4A6105A
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB4A6105A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GnL+0EVd+YuSeybTflPEF4d/rZ0wsRrjuQohvRj9CZA=; b=aBL4JLb1dNCW7zCn1p9ZFbtg2
	68XEyoxtoHh/+GgW67ytrMB+08PDI/dRN3rnIOZb4StF5NHI9dN+Dewp542pBRalocRoWw90nGzP4
	E9jR9bVDt6palZwglbFmgez7rpy2zY8q6R2/zXwKtXg6VhXGtbMpr37j4MO8XoXlU770Tgcq/2Rc0
	26WturQbpLc0iiEMFkzYl5xx4ilDS0/9RmYUzh0UrpdkMOxaZNy5zHm7pjcA1NehS49pKSR7DSG5x
	TFNcaEKHNHTVNCARyt66wBmSqWWaAZb131h8SGZSpipfw9x1Ehrf+QS2weUVvq5XmwlpZ+ulh1Arc
	m8/wbUzAA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lddFP-00Eayn-9m; Mon, 03 May 2021 18:24:47 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddFM-00EayW-7c
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 18:24:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=VWzmuLJTmzLuM2un7VPLyFpmu+BkfmdPzonNPGyGNwA=; b=A8AmedywFrB/TFVMhcNsR9Z44Q
 bjxBpiabOe+418mLjMSvSJ3wNEIm4oCfiU4AaqX58DWFhfYgT868CArfQMS5eY6UrEcZXl29ositD
 mjaNrecTUW5uN8o8Emo333ReC67qnNKc4oSylXag0CIAdsiCSWGwJN57+Fp5LA7LmBjH0tBUXh2oi
 fjav2a4+6ZQkp/1FqHk+kqnzYhB66pdP8XS2yHNWlvB4jjfXIN4QsYxBYyy9wHjIFLcajoCqeEbYx
 pJUfhRKd3dksetXezJUDni9ifHxS4v+kD9RCvf+Gh7m40eM5cilZtwvEnuMRxAS4aPztzUjeSr0p4
 4GDykrGw==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddFJ-003OPf-HY
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 18:24:42 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6C9EA68B05; Mon,  3 May 2021 20:24:35 +0200 (CEST)
Date: Mon, 3 May 2021 20:24:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Don Dutile <ddutile@redhat.com>, Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 01/16] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
Message-ID: <20210503182434.GA17174@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-2-logang@deltatee.com>
 <d8ac4c84-1e69-d5d6-991a-7de87c569acc@nvidia.com>
 <8ea5b5b3-e10f-121a-bd2a-07db83c6da01@deltatee.com>
 <3bced3a4-b826-46ab-3d98-d2dc6871bfe1@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3bced3a4-b826-46ab-3d98-d2dc6871bfe1@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_112441_745089_7B8FC700 
X-CRM114-Status: GOOD (  15.14  )
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

On Mon, May 03, 2021 at 11:17:31AM -0700, John Hubbard wrote:
> That's the thing: memory failure should be exceedingly rare for this.
> Therefore, just fail out entirely (which I don't expect we'll likely
> ever see), instead of doing all this weird stuff to try to continue
> on if you cannot allocate a single page. If you are in that case, the
> system is not in a state that is going to run your dma p2p setup well
> anyway.
>
> I think it's *less* complexity to allocate up front, fail early if
> allocation fails, and then not have to deal with these really odd
> quirks at the lower levels.

Agreed.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
