Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAB1CC6FA82
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 08:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kUO+Fp+pzKZHoXvYPYaduxOMt+i5KtLfXs5w+dTjrMg=; b=jLY2zbDiAZELys9Ie6Ae39sxow
	UIp0jG0Avm/he75bStPxx20jhLXLuO1KDYPAXODv7Vg55m2uA8/DPQC+DOi93abcUVL+ryDPAFk44
	kvK9uMOiN40j91iBbCm60qvu25wlFylZculOtD8TqSfxvFy9uQW7FmOEPlkOARX2JKS27EKrgMYca
	plm878nH9XPfKDUNzTpR70PjY9TRm1pVsCACPFGPDfbwj96Ymqc6IHn6Gifo8px80kn8FQrLAvqAF
	Rlc42iatKdtekZH/nkMEhFLDq6cJfH/ohTfA/14yC3N0uusblgDG7jcmn+kJYdYvGuMy6a7ENp2rd
	NuqAbhIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdqy-002spZ-IZ; Fri, 23 Sep 2022 08:16:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obdqw-002snM-4D
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 08:16:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 5AFCB61491;
	Fri, 23 Sep 2022 08:16:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18903C433C1;
	Fri, 23 Sep 2022 08:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1663920962;
	bh=bPVCAPpOlqysgdRjqbXO/X4KjONzytDj+4d25vTPS08=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFCgceMrCjNaFpcCwlwlTgsF5RM4Z41Qsy5jLwSHgDt/de2BtGvojz58AaIfL8ZfS
	 BBIcjTSAQLPym+hEvSSlQCoy0aOYUD9ckT2A1iu+syML9qBDSBSsKumT85+IjlnHq8
	 z+IReMS4RejydfYZfHdLonAiTZ7nMggb2glIqDvs=
Date: Fri, 23 Sep 2022 10:15:59 +0200
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
Subject: Re: [PATCH v10 8/8] ABI: sysfs-bus-pci: add documentation for p2pmem
 allocate
Message-ID: <Yy1rP4JwzxqwMGhc@kroah.com>
References: <20220922163926.7077-1-logang@deltatee.com>
 <20220922163926.7077-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922163926.7077-9-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_011606_210714_5C23193D 
X-CRM114-Status: GOOD (  11.01  )
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

On Thu, Sep 22, 2022 at 10:39:26AM -0600, Logan Gunthorpe wrote:
> Add documentation for the p2pmem/allocate binary file which allows
> for allocating p2pmem buffers in userspace for passing to drivers
> that support them. (Currently only O_DIRECT to NVMe devices.)
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

