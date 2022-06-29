Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AF5C43334
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jun 2022 06:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JrjO8tBU/JzWiQQVO/ztz9PRUNAKEwkNcVzGxTEVVNE=; b=rfFhZlhQXd342Rxwmohbb3pm95
	yExgx8DVSh4jHPeTATX0//EifeSRBCSfQrW2ivMo//+t+Utwc6DSgvrV7+J8n6URLtj5q/2aZpiJ+
	SUODFhSnpPLQ1rt3YiHoraI1OzCmJK6CSjIfQpOICSJFw2kZtNOfksudXeI2QqbZS7GN8hR7S9YHw
	yhKUrrzF/X8JEpfWzMQ3AUS5Jpaism8SZj82CyU+ZwaZYylLnL8aGJXKWntsQOG2zTFrrUY4O43lN
	IZibmuNA/34EMMPa4cmZODj7h/LJtmOJoufM1M0K8mmbr0AGOacMNPHa9ruCzFjAfPwWCdt9+VnXk
	3L4DA7RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6RTA-009sMN-Fm; Wed, 29 Jun 2022 06:46:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o6RT6-009sJM-Lk
	for linux-nvme@lists.infradead.org; Wed, 29 Jun 2022 06:46:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id DA93F67373; Wed, 29 Jun 2022 08:46:29 +0200 (CEST)
Date: Wed, 29 Jun 2022 08:46:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux-foundation.org,
	Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
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
	Ralph Campbell <rcampbell@nvidia.com>
Subject: Re: [PATCH v7 16/21] block: add check when merging zone device
 pages
Message-ID: <20220629064629.GC17576@lst.de>
References: <20220615161233.17527-1-logang@deltatee.com> <20220615161233.17527-17-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615161233.17527-17-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220628_234632_932538_D45F4880 
X-CRM114-Status: GOOD (  14.31  )
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

On Wed, Jun 15, 2022 at 10:12:28AM -0600, Logan Gunthorpe wrote:
> Consecutive zone device pages should not be merged into the same sgl
> or bvec segment with other types of pages or if they belong to different
> pgmaps. Otherwise getting the pgmap of a given segment is not possible
> without scanning the entire segment. This helper returns true either if
> both pages are not zone device pages or both pages are zone device
> pages with the same pgmap.
> 
> Add a helper to determine if zone device pages are mergeable and use
> this helper in page_is_mergeable().

Any reason not to simply set REQ_NOMERGE for these requests?  We
can't merge for passthrough requests anyway, and genrally don't merge
for direct I/O either, so adding all this overhead seems a bit pointless.

