Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26207C43334
	for <linux-nvme@archiver.kernel.org>; Tue,  5 Jul 2022 17:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/LTFAI/rqmR3hwJglOVbPiSwlXYuTcEYmfn8Oa+rUSI=; b=xE1/BQTw4b5GUp2mJwIklWRK3b
	x3w/yIJ2gcIsod9Ba3cmhkoazDid1cE+aLPYDcbF0Tk5cMKX4FzjIT3VUbuDndN9EeSWfwnT7pynp
	gDehTNvVH68Isr++eT3yYF3+doDFcdD5ZJ3bAIE165HtpNi3nJ/t8bQDmX+s5bRdAHIp85e278CrQ
	z68Z06lxbpkd5QzgqxDsSq97vGnAoLaMRZ0TXjHwwxq8QC2O8RcW1m03TCrEuyT5ylUludpo5n8aT
	RW5lYGzRNzZ8Y2crgIHVI6iSWteOfnvQowY9fheBAPfJqeKlSbYmp5Evo8oUBnnrw7GU/BY96pC89
	OWG+usLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8mFU-001pdE-8P; Tue, 05 Jul 2022 17:22:08 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8mFP-001pZ3-RK
	for linux-nvme@lists.infradead.org; Tue, 05 Jul 2022 17:22:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1BA0EB8181F;
	Tue,  5 Jul 2022 17:22:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3CBC341C7;
	Tue,  5 Jul 2022 17:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1657041720;
	bh=2k+PI3826bV0JfafuKOYWZwzEmZ/6OWZBqa+5FOwKKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eW0LSj5OCSMxFTwab7kOj8yB3ANUifdcIyjdDqyqljZ/iy8fnpSDRDB1hx7AhAPR2
	 x0qZP6dDTeDA8ifC5C2gTw8/5BH/5dH8LBx4m8NjuS/wZ8PPrtzbO2zUPRMEQWtCnE
	 Ysh75bL4zKRSbMgqYVPy39v9+8C6x63MzOq+Bpnc=
Date: Tue, 5 Jul 2022 19:21:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	Stephen Bates <sbates@raithlin.com>,
	Dan Williams <dan.j.williams@intel.com>,
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
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v7 20/21] PCI/P2PDMA: Introduce pci_mmap_p2pmem()
Message-ID: <YsRzNqmZYlgkL7fI@kroah.com>
References: <20220629064854.GD17576@lst.de>
 <99242789-66a6-bbd2-b56a-e47891f4522e@deltatee.com>
 <20220629175906.GU23621@ziepe.ca>
 <20220705075108.GB17451@lst.de>
 <20220705135102.GE23621@ziepe.ca>
 <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705165039.GB14566@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220705_102204_092454_A1BA58B8 
X-CRM114-Status: GOOD (  20.88  )
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

On Tue, Jul 05, 2022 at 06:50:39PM +0200, Christoph Hellwig wrote:
> [note for the newcomers, this is about allowing mmap()ing the PCIe
> P2P memory from the generic PCI P2P code through sysfs, and more
> importantly how to revoke it on device removal]

We allow mmap on PCIe config space today, right?  Why is this different
from what pci_create_legacy_files() does today?

> On Tue, Jul 05, 2022 at 10:44:49AM -0600, Logan Gunthorpe wrote:
> > We might be able to. I'm not sure. I'll have to figure out how to find
> > that inode from the p2pdma code. I haven't found an obvious interface to
> > do that.
> 
> I think the right way to approach this would be a new sysfs API
> that internally calls unmap_mapping_range internally instead of
> exposing the inode. I suspect that might actually be the right thing
> to do for iomem_inode as well.

Why do we need something new and how is this any different from the PCI
binary files I mention above?  We have supported PCI hotplug for a very
long time, do the current PCI binary sysfs files not work properly with
mmap and removing a device?

thanks,

greg k-h

