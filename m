Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B18ECAAD1
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 18:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1AT1S+3qhBfI4/31yANv2bvnScixdjnjUQEHEM7f9Bc=; b=ExRevltsz1Pcffm+alIGSnNRAH
	onfU4UrJU5TyQlzH3SFyEFKAT80vSJNjQ8q5P23qVlaXSsLCkbsK3YPejpud/QUBmLEIJM/X1VJI+
	546cOmxnZi61zWg7vOmFwFzeru1/WFdRTyn3AKBfM9NhJMiV//Zx9XGljJ5G727r13yDyzozYWKur
	2dh49b5EL0fbZfvZgLcravPBObvUoM/o8wKhBVB7VfIhg+fK9PzdfZUkXQua7100AkDCWiW9/thMl
	QB2b1h+zkDg74tfCCDtLynrmQS1SLdm8GrhHy5V3rF18GXCppofQ/heHrY+Nv0Vw12eT1WSuNZiKa
	m0umV2JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTp5d-00E0Or-3u; Thu, 01 Sep 2022 18:38:57 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTp3V-00DzCD-J8
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 18:36:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8DB9C61CFB;
	Thu,  1 Sep 2022 18:36:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68479C433D6;
	Thu,  1 Sep 2022 18:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1662057404;
	bh=4EGc98ePtGVoW/OVpl29pIB0Xv/vWLpMdUFKeCItABY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xFeGxXLUUQuSqZdVXhkzgw5JZFhnJkqiyA7MU8ELHe3FJve40mXqCLp9o6Fh+/lAf
	 yijiTz3pzHkV1ZEn5hg/537CIQ4D8j2AVuE8Pd8EnOW7zd0tEDyU+ODP2GX+/Dt8iD
	 Xilxi4k7yFbvYeFd6jE9lPw3HjO8pop87qrBfh24=
Date: Thu, 1 Sep 2022 20:36:41 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
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
Message-ID: <YxD7uZYaV75gJS9d@kroah.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-8-logang@deltatee.com>
 <YxDb2MyRx6o/wDAz@kroah.com>
 <4a4bca1e-bebf-768f-92d4-92eb8ae714e1@deltatee.com>
 <YxDhEO9ycZDTnbZm@kroah.com>
 <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9a24a8-dd3a-9d21-d9a7-5ee4b0ad7a57@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_113645_740739_F26AF958 
X-CRM114-Status: GOOD (  24.23  )
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

On Thu, Sep 01, 2022 at 12:14:25PM -0600, Logan Gunthorpe wrote:
> 
> 
> 
> On 2022-09-01 10:42, Greg Kroah-Hartman wrote:
> > On Thu, Sep 01, 2022 at 10:32:55AM -0600, Logan Gunthorpe wrote:
> >> On 2022-09-01 10:20, Greg Kroah-Hartman wrote:
> >>> On Thu, Aug 25, 2022 at 09:24:24AM -0600, Logan Gunthorpe wrote:
> >>>> +	/*
> >>>> +	 * Removing the alloc attribute from sysfs will call
> >>>> +	 * unmap_mapping_range() on the inode, teardown any existing userspace
> >>>> +	 * mappings and prevent new ones from being created.
> >>>> +	 */
> >>>> +	sysfs_remove_file_from_group(&pdev->dev.kobj, &p2pmem_alloc_attr.attr,
> >>>> +				     p2pmem_group.name);
> >>>
> >>> Wait, why are you manually removing the sysfs file here?  It's part of
> >>> the group, if you do this then it is gone for forever, right?  Why
> >>> manually do this the sysfs core should handle this for you if the device
> >>> is removed.
> >>
> >> We have to make sure the mappings are all removed before the cleanup of
> >> devm_memremap_pages() which will wait for all the pages to be freed.
> > 
> > Then don't use devm_ functions.  Why not just use the manual functions
> > instead as you know when you want to tear this down.
> 
> Well we haven't plugged in a remove call into p2pdma, that would be more
> work and more interfaces touching the PCI code. Note: this code isn't a
> driver but a set of PCI helpers available to other PCI drivers.
> Everything that's setup is using the devm interfaces and gets torn down
> with the same. So I don't really see the benefit of making the change
> you propose.

The issue is the classic one with the devm helpers.  They do not lend
themselves to resource management issues that require ordering or other
sort of dependencies.  Please do not use them here, just put in a remove
callback as you eventually will need it anyway, as you have a strong
requirement for what gets freed when, and the devm api does not provide
for that well.

thanks,

greg k-h

