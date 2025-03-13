Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA57C282DE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Mar 2025 06:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fsptvyupqT4HezJdsbgsBSbqFBBJekreNhBT3K+r3DU=; b=BePPtawpa/UNjmUDFsLr8yNSB4
	U0XqVG7w+KpRAJ8hNbbG7E+pTCQSOoCcfgh2WBuXtJVdqxT0XT90tITv3JlfUzn5AghLCru+ujAKE
	6EyTLqBXjJrTlWoetxnTA5EqE8oYiBHJ4iwRPRgJBz8fREVMOK/77/6ny2RWojHX4EcW1/CGJ/RbE
	KeQ+Bsaf971XyKZoBI1gpmLfGsZJ5GFoZhsIrSRu+2oi5UG+H4xyStmWEN7sLX0QU5BdPYrU8d8jP
	cxgu3XB6PsUTfeSlKMp3Vitss/sPz57CXi7WCl8UVh/JRMCD5LXKQZMAfR0yY4HmwE7EEq8Wmz3O6
	kgDL0JFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tscHC-0000000AFGB-3emi;
	Thu, 13 Mar 2025 06:42:42 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tscHA-0000000AFFE-0UBY
	for linux-nvme@lists.infradead.org;
	Thu, 13 Mar 2025 06:42:41 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 349BF68C4E; Thu, 13 Mar 2025 07:42:36 +0100 (CET)
Date: Thu, 13 Mar 2025 07:42:36 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mike Christie <michael.christie@oracle.com>
Cc: chaitanyak@nvidia.com, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
	joao.m.martins@oracle.com, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, kwankhede@nvidia.com,
	alex.williamson@redhat.com, mlevitsk@redhat.com
Subject: Re: [PATCH RFC 10/11] nvmet: Add addr fam and trtype for mdev pci
 driver
Message-ID: <20250313064236.GE9967@lst.de>
References: <20250313052222.178524-1-michael.christie@oracle.com> <20250313052222.178524-11-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313052222.178524-11-michael.christie@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250312_234240_293837_2F2D821E 
X-CRM114-Status: GOOD (  24.09  )
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

On Thu, Mar 13, 2025 at 12:18:11AM -0500, Mike Christie wrote:
> This allocates 253 for mdev pci since it might not fit into any
> existing value (not sure how to co-exist with pci-epf).
> 
> One of the reasons this patchset is a RFC is because I was not sure
> if allocating a new number for this was the best. Another approach
> is that I could break up pci-epf into a:
> 
> 1. PCI component - Common PCI and NVMe PCI code.
> 2. Interface/bus component - Callouts so pci-epf can use the
> pci_epf_driver/pci_epf_ops and mdev-pci can use mdev and vfio
> callouts.
> 3. Memory management component - Callouts for using DMA for pci-epf
> vs vfio related memory for mdev-pci.
> 
> On one hand, by creating a core nvmet pci driver then have subdrivers
> we could share NVMF_ADDR_FAMILY_PCI and NVMF_TRTYPE_PCI. However,
> it will get messy. There is some PCI code we could share for 1
> but 2 and 3 will make sharing difficult becuse of how different the
> drivers work (mdev-vfio vs pci-epf layers).

I think we'll need to discuss this more based on concrete code proposals
once we go along, but here's my handwavy 2cents for now:

  - in addition to the pure software endpoint and mdev I also expect
    hardardware offloaded PCIe endpoints to show up really soon, so
    we'll have more than just the two
  - having common code for different PCIe tagets where applicable is
    thus a good idea, but I'd expect it to be a set of library
    functions or conditionals in the core code, not a new layer
    with indirect calls
  - I had quite a lot of discussions with Damien about the trtype and
    related bits.  I suspect by the time we get to having multiple
    PCIe endpoints we just need to split the configfs interface naming
    from the on-wire fabrics trtrype enum to not need trtype assignments.


