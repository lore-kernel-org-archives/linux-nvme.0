Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECF3C6FA8B
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 08:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=trZicizV5RAXoqUClYp5XBQih2RaGE9BTyB7WSRM56c=; b=jyRp8e5jJw+dTJETJCfmEJmaJt
	bU0/OcQCWLse32Sqn6JIG+v3Jl91WCnroGSdHbzyba9q3BhNOK0SIn26rrvb0GJlKXdU0YwYa9Yqg
	yKezc1SV9cJDsm8T8JhwxBDIWlcCHL63TKb+ERtfnNQsKm+CMs5c2gBqoLyjpH2q2ArqEHOREt3aM
	JhYij+YgeEeiQ8XTYKUCKrinTJiNAIYxJgm1cwSmh6gPz+f7MrpwSE+U7aO0Qv/oyBIxiuLXTwSn1
	GpAO60K3aw82nYhwtwxOZsMPrqFzDcy6U8qVcTg3wD9C1jK/2BqDvQOw5NjP/zUA4eJAxBgwqwWl6
	11zVd+oA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHjH-00ED8d-EF; Thu, 22 Sep 2022 08:38:43 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obHiu-00ECzK-Q0
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 08:38:22 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 04615B830E1;
	Thu, 22 Sep 2022 08:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6B2C433D6;
	Thu, 22 Sep 2022 08:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1663835896;
	bh=ZXqrm8nedeHyjJHSE+1GJ5DZF7ttxhR/iupCB+jykP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sLVTqeua8VBBS9O2uBUp1F+RCRb3jzgT/qYn8/Erj5crjgRsyAtxSy76D5wqSuehI
	 ky9/I44ksfKvi5sSHy7PazF5U81CS9thdVN+6Zzm6o2+vNMFMFDT7elLAZup43khua
	 W/eR3vgb0Y3Make/VdghCWlJmdQ8796Skliks+5Q=
Date: Thu, 22 Sep 2022 10:38:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-mm@kvack.org,
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
Subject: Re: [PATCH v9 7/8] PCI/P2PDMA: Allow userspace VMA allocations
 through sysfs
Message-ID: <Yywe9rBMB6hlUwqw@kroah.com>
References: <20220825152425.6296-8-logang@deltatee.com>
 <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
 <YxD7uZYaV75gJS9d@kroah.com>
 <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com>
 <YxGad5h2Nn/Ejslc@kroah.com>
 <db8cd049-c78b-1aa0-dcd0-0feb8c6cb25c@deltatee.com>
 <20220920064613.GB17325@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920064613.GB17325@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_013821_045681_928534DF 
X-CRM114-Status: GOOD (  18.24  )
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

On Tue, Sep 20, 2022 at 08:46:13AM +0200, Christoph Hellwig wrote:
> On Fri, Sep 02, 2022 at 12:46:54PM -0600, Logan Gunthorpe wrote:
> > See the diff at the bottom of this email. I can apply it on top of this
> > patch, but IMO it is neither easier to follow nor maintain. Unless you 
> > have a different suggestion...
> 
> Greg, can you chime in on this?  Besides this item we just have a few
> cosmetic bits left I think, and I'd really like to get the series into
> this merge window.
> 

I don't seem to have this in my inbox at all anymore, sorry.

The original should be fine, Logan, thanks for trying to split it out a
bit more.  So this can be taken as-is for 6.1-rc1.

thanks,

greg k-h

