Return-Path: <SRS0=U7R3=J6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B568C433B4
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:35:32 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265E061175
	for <linux-nvme@archiver.kernel.org>; Mon,  3 May 2021 18:35:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265E061175
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ypbFLXfCqTUVBltOqv7/0aMuyZqvY9e/oUaEW+N78ME=; b=YrnlGYHnJc90HTgUwiwz+cbUW
	bSUUqaiX7klYv1yCZbk26ODEZnaMPqbrxXFimagoG8by38Oos7CBFGrIz8fQECVQWca/qQGLISXzu
	Qp86NpPWeznOsni4HFNoO0CtoSaLJVJsFFC1YLwlzFtLwZU272FfNe3FrO6G90+now3smL8Z7srN2
	6Pvov/LChNaCMgoUg/ha24sDRzU7isFKBm2v95CTOSrKYA8nM65647fJswWahe0NxRlBXp03MaOMg
	6z5TzVCY3T0tm25xl4J1Fazgytk+9mDtjHTTU38ePBDkgt8QL4gTC6RJhqqQGFgsSmXD4cH0Xpr8I
	zzd/5CkBg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lddPg-00Ec3v-Rl; Mon, 03 May 2021 18:35:24 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddPc-00Ec2r-IB
 for linux-nvme@desiato.infradead.org; Mon, 03 May 2021 18:35:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=QWCEuUj9SkxEPUxIBvCdQzpgssYlz2kq38ASVS7IH4Q=; b=OmLnaiTdAuRdAfwgghGBD53YS2
 WGO6bmPDCL/KodbbYS4y0VmZWRkpKkUx2zlgvAKaPOSoFDyhl1RtSVEstkiVNS0YWYXWw8+k9ezJy
 Fu4ijbl9UAk0Ec5YFMaPy0yafhAvatIshYD3G2lrybGj9v40Y9lClTeCg9AO4G1cav0flzdD+eGZ9
 DooXlMhC48p6I/TmXbG1+I3csk9mj7RvgsrJmRGUB3hKg7m8gkJc3kiFIu5fbf93964ea++NV16Ec
 QZDZpBjMC1QErreMWL347r8BIjIZDzqkNm8HDcjmFWYUbSlk33MvXFguLwH+7yVW5WgX+0iElw0IU
 MYrPGcSQ==;
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lddPV-003Owp-Hx
 for linux-nvme@lists.infradead.org; Mon, 03 May 2021 18:35:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id A773768B05; Mon,  3 May 2021 20:35:09 +0200 (CEST)
Date: Mon, 3 May 2021 20:35:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
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
 Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
Message-ID: <20210503183509.GA17971@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-4-logang@deltatee.com>
 <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com>
 <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210503_113513_746870_4C5E8869 
X-CRM114-Status: GOOD (  14.53  )
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

On Mon, May 03, 2021 at 10:17:59AM -0600, Logan Gunthorpe wrote:
> I agree that some of this has evolved in a way that some of the names
> are a bit odd now. Could definitely use a cleanup, but that's not really
> part of this series. When I have some time I can look at doing a cleanup
> series to help with some of this.

I think adding it to the series would be very helpful.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
