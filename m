Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDEAC6FA82
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Sep 2022 16:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Cc:To:From:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yEbEthdEqMoR6vIi3uu8gJTStkK9xaZth0zL3JgYr6M=; b=XHiOwXsYgxY66Y
	iyuvvZoldzXsbZfUa+VJDtJV+efyhaK4gutNJT72PndmylcjeZ67PnMyQkb3pGMtSgxcIcNsMcqpA
	o+Yugx6z51V+miXWgwleGcSOc+Sxhr8sDodquUPQHTX8RSMzFHw6k3huqzmz905v1ubrqRI36mtkz
	fkc1OePwjx9tgMl0lFQSYrioQBvGNbuvHTwpkyhe95rKCLCl5hTI/eG7xzu/CHlUavn2BhJcAOCD4
	ImOi1qGMGWnhKxz2/4P6x8TltiRdujGbg2KGIO8jdt4dKo9heX4GorFLxHI0331drbcKJSqKzFYo0
	JkeFuj4Zx2C6HlGOWbrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obPGK-00Gq9U-0X; Thu, 22 Sep 2022 16:41:20 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obPEl-00Gp5j-55
	for linux-nvme@lists.infradead.org; Thu, 22 Sep 2022 16:39:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
	:references:content-disposition:in-reply-to;
	bh=yEbEthdEqMoR6vIi3uu8gJTStkK9xaZth0zL3JgYr6M=; b=HifliSh6mq7K6mv42Jxq4CspDZ
	PkfMY8i6TXWHUNH9Z7BsQdRo98oHauuGD9OK2FxaBH9ZUI7u5U0ZI+N1IHu2w0GMw0/7+qWfFMftP
	hEIfoXcx1Fly+YRtzCoLOEAozIs/P8m6VHdqGDDLcbj8XfGUi3ry4QtwCI1qa45J5i7LIMWfjoe33
	+nr1T0dc+PHilZ37pf3KFAWa35qRHgp2qQH2xgytuwRQkgXHHFJ6xh7i7mtad2u+JP8Mco19YfnYF
	9o06j4joMdjFys+iEYyk/ajwU6F8vR6nqX2olmK+uVF1E5YS3fesLcwJm6NEZnko2XLzLwe2Oor09
	A88X9GAQ==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
	by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1obPEf-00862a-HO; Thu, 22 Sep 2022 10:39:39 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
	(envelope-from <gunthorp@deltatee.com>)
	id 1obPEa-0001rh-MA; Thu, 22 Sep 2022 10:39:32 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-mm@kvack.org
Cc: Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Don Dutile <ddutile@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Minturn Dave B <dave.b.minturn@intel.com>,
	Jason Ekstrand <jason@jlekstrand.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Xiong Jianxin <jianxin.xiong@intel.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Ira Weiny <ira.weiny@intel.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Martin Oliveira <martin.oliveira@eideticom.com>,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	Ralph Campbell <rcampbell@nvidia.com>,
	Stephen Bates <sbates@raithlin.com>,
	Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 22 Sep 2022 10:39:18 -0600
Message-Id: <20220922163926.7077-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, hch@lst.de, gregkh@linuxfoundation.org, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, jhubbard@nvidia.com, rcampbell@nvidia.com, sbates@raithlin.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v10 0/8] Userspace P2PDMA with O_DIRECT NVMe devices
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220922_093943_313296_5A8F1D79 
X-CRM114-Status: GOOD (  13.41  )
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

Hi,

This is the latest P2PDMA userspace patch set. This version includes
some cleanup from feedback of the last posting[1].

This patch set enables userspace P2PDMA by allowing userspace to mmap()
allocated chunks of the CMB. The resulting VMA can be passed only
to O_DIRECT IO on NVMe backed files or block devices. A flag is added
to GUP() in Patch 1, then Patches 2 through 6 wire this flag up based
on whether the block queue indicates P2PDMA support. Patches 7
creates the sysfs resource that can hand out the VMAs and Patch 8
adds brief documentation for the new interface.

Feedback welcome.

This series is based on v6.0-rc6. A git branch is available here:

  https://github.com/sbates130272/linux-p2pmem/  p2pdma_user_cmb_v10

Thanks,

Logan

[1] https://lkml.kernel.org/r/20220825152425.6296-1-logang@deltatee.com

--

Changes since v8:
  - Rebased onto v6.0-rc6
  - Reworked iov iter changes to reuse the code better and
    name them without the _flags() prefix (per Christoph)
  - Renamed a number of flags variables to gup_flags (per John)
  - Minor fixups to the last documentation patch (from Greg and John)

Changes since v7:
  - Rebased onto v6.0-rc2, included reworking the iov_iter patch
    due to changes there
  - Drop the char device mmap implementation in favour of a sysfs
    based interface. (per Christoph)

Changes since v6:
  - Rebase onto v5.19-rc1
  - Rework how the pages are stored in the VMA per Jason's suggestion

Changes since v5:
  - Rebased onto v5.18-rc1 which includes Christophs cleanup to
    free_zone_device_page() (similar to Ralph's patch).
  - Fix bug with concurrent first calls to pci_p2pdma_vma_fault()
    that caused a double allocation and lost p2p memory. Noticed
    by Andrew Maier.
  - Collected a Reviewed-by tag from Chaitanya.
  - Numerous minor fixes to commit messages

--

Logan Gunthorpe (8):
  mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
  iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
  block: add check when merging zone device pages
  lib/scatterlist: add check when merging zone device pages
  block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
  block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
  PCI/P2PDMA: Allow userspace VMA allocations through sysfs
  ABI: sysfs-bus-pci: add documentation for p2pmem allocate

 Documentation/ABI/testing/sysfs-bus-pci |  10 ++
 block/bio.c                             |  11 ++-
 block/blk-map.c                         |   7 +-
 drivers/pci/p2pdma.c                    | 124 ++++++++++++++++++++++++
 include/linux/mm.h                      |   1 +
 include/linux/mmzone.h                  |  24 +++++
 include/linux/uio.h                     |   6 ++
 lib/iov_iter.c                          |  32 ++++--
 lib/scatterlist.c                       |  25 +++--
 mm/gup.c                                |  22 ++++-
 10 files changed, 240 insertions(+), 22 deletions(-)


base-commit: 521a547ced6477c54b4b0cc206000406c221b4d6
--
2.30.2

