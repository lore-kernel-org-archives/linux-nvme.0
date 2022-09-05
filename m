Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A03CECAAD5
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Sep 2022 17:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y4/jKaf/eLcqZPk6lC+3R154Ru296Ee+lt5Q6AOm3dE=; b=V6uyUXbXv5SloqGMke3Qm/PkIe
	Yr8H1gESj7Kvg2lXNFluMzu3RpLsF7L9ohKy3se/kQapYdAdcoxx5mJiZzN9WTyQi7Un+Y+e4Z+LC
	yRMaVHZh0Hqc51ZAv97nU9PQdjG3F0VOE03msnbbBZwQ7rCKPKdOKrxRTJUSz5teh3eGTF53NhQnJ
	uYUuLyl44y6oeQA0gG3fwZXg+VFpgK89m0JaTDAEIxW5/yidgv2jjXtYR9Pikh3+D08I4hkdXnCdt
	kM8G/3wnIv3BfjBSDsti/SXOc5CVOseS/rfAvHecu05G1WX1u3Xxt0sI30A3+OEF1+JiYd5AmHWvf
	Q5Jg1ssA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVFZR-007Gat-GJ; Mon, 05 Sep 2022 17:07:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oVDAn-004VZI-3r
	for linux-nvme@lists.infradead.org; Mon, 05 Sep 2022 14:34:29 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3D5E668AA6; Mon,  5 Sep 2022 16:33:51 +0200 (CEST)
Date: Mon, 5 Sep 2022 16:33:51 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [PATCH v9 2/8] iov_iter: introduce
 iov_iter_get_pages_[alloc_]flags()
Message-ID: <20220905143351.GA5813@lst.de>
References: <20220825152425.6296-1-logang@deltatee.com> <20220825152425.6296-3-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825152425.6296-3-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220905_073426_520882_CB042F89 
X-CRM114-Status: GOOD (  12.58  )
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

On Thu, Aug 25, 2022 at 09:24:19AM -0600, Logan Gunthorpe wrote:
> Add iov_iter_get_pages_flags() and iov_iter_get_pages_alloc_flags()
> which take a flags argument that is passed to get_user_pages_fast().
> 
> This is so that FOLL_PCI_P2PDMA can be passed when appropriate.

Any reason why iov_iter_get_pages2 doesn't call iov_iter_get_pages_flags
and same for the __alloc version?

Also with the "main" version now having the 2 postfix, we can just
use the iov_iter_get_pages name for the flags version, and maybe
eventually just convert all users over to it.

