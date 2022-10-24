Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3873ECAAA1
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Oct 2022 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gHdxohgx99EHtkBH+aYtTknDrbPtrwJAuaizmc0RZRg=; b=TKOFze/n6xM6d8CMKGoqyeIA/h
	PtAF/yQO0+KKHu6jW2yio63Hq+CnY4o4MqbdUm8xt5nLVq1Qvn0jUjCPWS3qBlgzk22hGMeDdVEfW
	oFKYzAxJqvE6bFr8sZ1FvzifIBvb5KUIP+qcj+d7iMTnoYmTia/kgMhnGDQhw01LCi90k4KWJbukV
	6o4atelAOeMM/XHGxmxQYUJCkLVkDC2fMx2m9Ap2TO4i8aV+MtUjFr2vzuxmNnx9YdDKWytzey78H
	t9R2hmtO37QKxHQ72msJaJxsrxLbOzQtdzytAHWO3A3u5nGVwHDcRTQh9Y4BV3kID/uEaLB329K8d
	bK3BXOnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omywC-0021jc-Ib; Mon, 24 Oct 2022 15:00:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1omyw9-0021h6-Uc
	for linux-nvme@lists.infradead.org; Mon, 24 Oct 2022 15:00:23 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 87F2B68B05; Mon, 24 Oct 2022 17:00:12 +0200 (CEST)
Date: Mon, 24 Oct 2022 17:00:11 +0200
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
Subject: Re: [PATCH v11 1/9] mm: allow multiple error returns in
 try_grab_page()
Message-ID: <20221024150011.GA26338@lst.de>
References: <20221021174116.7200-1-logang@deltatee.com> <20221021174116.7200-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021174116.7200-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221024_080022_146760_2A305FD1 
X-CRM114-Status: GOOD (  13.36  )
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

On Fri, Oct 21, 2022 at 11:41:08AM -0600, Logan Gunthorpe wrote:
> In order to add checks for P2PDMA memory into try_grab_page(), expand
> the error return from a bool to an int/error code. Update all the
> callsites handle change in usage.
> 
> Also remove the WARN_ON_ONCE() call at the callsites seeing there
> already is a WARN_ON_ONCE() inside the function if it fails.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

