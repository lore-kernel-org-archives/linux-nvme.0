Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB772FA3740
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Oct 2022 15:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uyWqy7uHIc7mBgvRQ500Iier3iz2OAx4o9eZyzb7XFY=; b=INcyiEt414hbGBLopYJDLRHudi
	Wll70VSDq4QQS2lmuXTYoRKRphYok8j1JSX+1jTZk0sh6THbI+eetKSC8x6bj8TmSM76xXGPvBkRP
	In1w5eZwsPZupx/NJL6jIOFXuux7EUHR1hMdJZkXLOulAsUZ60NLz0vPLU3IC567+yvhQU460yrXU
	aTLWccL+ECGH4IAzA/gmg/KGre1oAJXytaLIsFuqecYcJFcW6nc/OjjRxHVlY551qmOqaCf2BDgFf
	4Fz3guH+5l5LxRZ3fYrxFArF+23DP1T1uxfWllc/pvIcwV6pMUVbn9iexDcIe34eyDw2pYuTwVhJq
	GosFesQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onM3q-0069tS-3E; Tue, 25 Oct 2022 15:41:50 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onM3n-0069sl-PC
	for linux-nvme@lists.infradead.org; Tue, 25 Oct 2022 15:41:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5313B68B05; Tue, 25 Oct 2022 17:41:43 +0200 (CEST)
Date: Tue, 25 Oct 2022 17:41:43 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v11 3/9] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
Message-ID: <20221025154143.GA25128@lst.de>
References: <20221021174116.7200-1-logang@deltatee.com> <20221021174116.7200-4-logang@deltatee.com> <929ac68b-cf07-8df6-e589-49b0576a50c5@nvidia.com> <41e621bb-e836-4a86-e6db-0beed19f5ddc@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41e621bb-e836-4a86-e6db-0beed19f5ddc@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221025_084147_980935_F0498469 
X-CRM114-Status: GOOD (  13.29  )
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

> > Just one minor question why not make following functions
> > EXPORT_SYMBOL_GPL() ?
> > 
> > 1. iov_iter_get_pages2()
> > 2. iov_iter_get_pages_alloc2()
> 
> They previously were not GPL, so I didn't think that should be changed
> in this patch.

Yes.  While they should have been _GPL from the start, rocking that
boat is a bit pointless now.  We just need to make sure to do the
right thing for the pinning variants that are going to replace them soon.

