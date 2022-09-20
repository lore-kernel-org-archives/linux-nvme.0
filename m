Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 621B4C6FA90
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 06:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0eI6bLgn3/DJJ8ZOqBOldBpi+03tuH4j/rw5ztudXR4=; b=sDyg68H44+WgOF9aThr3nU23ZQ
	S+bNbBo14wH+o1VCo6r/uxsEK0NR8irWD1clQyXRYTIdBu91qqAAPQTyaJguW1J/QUNeI1FGDzm4R
	ZoK7Rxu24ZcZIUxKy2aTtbcNjfnY+PdmrJJ+/hJ2Uy2m1G43dYvliD+mibxOGZxqy1NNIjpR0jw5u
	eDA4J6liPBzQTrn+odm1Rt3lxmhTrYZuDE6oEaXifQiV/bXYwnrQKjkrOrtuI4nedJnA8OgNq09Uq
	vVki/czJL0lVNgXjdXf1YPMf3pBX24rHXLaD6IKHR4YPIQ9yZN9ZTu0LDVmc+PuB+EzM3PjBXTOcc
	jPNdKeIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaX1Z-0017bt-3M; Tue, 20 Sep 2022 06:46:29 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oaX1S-0017Ww-KP
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 06:46:25 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8272368BEB; Tue, 20 Sep 2022 08:46:14 +0200 (CEST)
Date: Tue, 20 Sep 2022 08:46:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20220920064613.GB17325@lst.de>
References: <20220825152425.6296-1-logang@deltatee.com> <20220825152425.6296-8-logang@deltatee.com> <YxDb2MyRx6o/wDAz@kroah.com> <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com> <YxDhEO9ycZDTnbZm@kroah.com> <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com> <YxD7uZYaV75gJS9d@kroah.com> <fb9d7948-43fe-87c5-5275-70f280181ad1@deltatee.com> <YxGad5h2Nn/Ejslc@kroah.com> <db8cd049-c78b-1aa0-dcd0-0feb8c6cb25c@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db8cd049-c78b-1aa0-dcd0-0feb8c6cb25c@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220919_234622_964200_A1349776 
X-CRM114-Status: GOOD (  13.98  )
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

On Fri, Sep 02, 2022 at 12:46:54PM -0600, Logan Gunthorpe wrote:
> See the diff at the bottom of this email. I can apply it on top of this
> patch, but IMO it is neither easier to follow nor maintain. Unless you 
> have a different suggestion...

Greg, can you chime in on this?  Besides this item we just have a few
cosmetic bits left I think, and I'd really like to get the series into
this merge window.


