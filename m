Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45FDCC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Jul 2022 07:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1gje+7JJywl8z+hojDQ/CdCFHPcNXeAmo9Z1tbQVDz0=; b=zsR8K3/A73gVakh7KHQr/D8sQr
	Ag5ElsbKUOOUdP+LgGGYBcJ/W8U3iKkuXLuV5xcIxgjVPCu5DuimhtiiDz49SPLsq8mDUVRpFvrXS
	wfMoGntw+J/wZVkjQ2r/HfmE0wOE5QlH7lSIgzDSBLkJXeLSLsCRPF4Gdyz26zbtroAZy8H/wtVT0
	GelsWFGU23tUq4BO3NAOEF/qtkV1yxYG/bGI2CreZeoYg5oIhbaObzUP1H0SZMAYMdLTkFS/a0dpj
	AtsU+VMYcY3p+x2dmpt3m57ZRyXxrVvue296Ng4dLuuquGeK57Tn5Su4U6MaxSAGz4KKCCJb2yz9Y
	FeLfRJlA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z8N-006xhc-MA; Wed, 06 Jul 2022 07:07:39 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o8z5a-006vVv-ER
	for linux-nvme@lists.infradead.org; Wed, 06 Jul 2022 07:04:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D3633B81AF2;
	Wed,  6 Jul 2022 07:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1095EC3411C;
	Wed,  6 Jul 2022 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1657091083;
	bh=yFTTCN8eLFI/FFSUip2r6VUaWUpwukK1oykDBvVFoaw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvQpbiTHwHtxiL7mhpAUqPcIfklC3uMq+eSlq7Dn3j9ZoCfEt8bXAghrDvZr0IVL+
	 IVo2VVD6El337SyTT90L4wo/hIPFCt8NLQgPrX4IoEu6OyCSHbBsNvDzbu6ja4urNO
	 b9ykds4BGL4/msxrju07lSQ9srOtvpaXTx1taFYM=
Date: Wed, 6 Jul 2022 09:04:41 +0200
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
Message-ID: <YsU0Cb0rRbW8FGPX@kroah.com>
References: <20220705161240.GB13721@lst.de>
 <a509b13c-244b-23fc-f989-339750a733a5@deltatee.com>
 <20220705164315.GB14484@lst.de>
 <acb91f37-0470-8ce4-19e4-426903cbc3a1@deltatee.com>
 <20220705165039.GB14566@lst.de>
 <YsRzNqmZYlgkL7fI@kroah.com>
 <1bd43ef7-0403-bd25-087c-d54d5af677e4@deltatee.com>
 <YsR4CNDgtt4JWonv@kroah.com>
 <b3deacdd-cb76-6ebb-0e29-ef6a5a426a0d@deltatee.com>
 <20220706065127.GA27132@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706065127.GA27132@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220706_000446_681336_CD9E750F 
X-CRM114-Status: GOOD (  22.40  )
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

On Wed, Jul 06, 2022 at 08:51:27AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 05, 2022 at 12:16:45PM -0600, Logan Gunthorpe wrote:
> > The current version does it through a char device, but that requires
> > creating a simple_fs and anon_inode for teardown on driver removal, plus
> > a bunch of hooks through the driver that exposes it (NVMe, in this case)
> > to set this all up.
> > 
> > Christoph is suggesting a sysfs interface which could potentially avoid
> > the anon_inode and all of the extra hooks. It has some significant
> > benefits and maybe some small downsides, but I wouldn't describe it as
> > horrid.
> 
> Yeah, I don't think is is horrible, it fits in with the resource files
> for the BARs, and solves a lot of problems.  Greg, can you explain
> what would be so bad about it?

As you mention, you will have to pass different things down into sysfs
in order for that to be possible.  If it matches the resource files like
we currently have today, that might not be that bad, but it still feels
odd to me.  Let's see an implementation and a Documentation/ABI/ entry
first though.

thanks,

greg k-h

