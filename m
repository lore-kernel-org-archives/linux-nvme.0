Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D63ECAAD1
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 16:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBlfWlyRQ+h9QHakEYRpcZl50yqDUUS4vbKUJMYf9d0=; b=BKT7DQfYlbMF5Ar0d51OS/wEY5
	FU/agl2ZBzP1rt5ZWfv6qZ+xrJobTJDZ7b+4qcepj6rxPWTGlIzn5WB0Gf3E0ig7R/2skThB0x31J
	53sc0pZR8gMTQjMO0/F3ACT5uaUezz4qHpcB+1M3LQxTg0hUsoUZAlqqqGYJQc/4vV8rBcV46TH2q
	bVxR2Y94+Mnh/7pnGNZMHbnJFwwJvUGaZJOGHzca/5zwAqBvRwmijtb8g+aLVufCD/omYChSKTdzT
	kj8kWjLG7Id2tD8/FH4J6Ap2s+tSEQ8rCg+13t9a7M4aVsXAxtHYwc8fViNK/b1Znsvqa3a4pX0hD
	eQ5u3kuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTmtW-00DGPO-Qe; Thu, 01 Sep 2022 16:18:18 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTmtU-00DGDz-3E
	for linux-nvme@lists.infradead.org; Thu, 01 Sep 2022 16:18:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 417EE61F80;
	Thu,  1 Sep 2022 16:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AEBEC433C1;
	Thu,  1 Sep 2022 16:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1662049094;
	bh=NYM7sZ2xl4aspZzJ8vDD56tOIY1cw4rh2fH+IWisKvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vk7bd013YZBndDkC6u1hHwjyPSLgZwEhGaSre8lB4d5OB/iKfVYyTcmmhsUZd+szp
	 suVrTZxlEK/OdoGCIDQykwJs5S3XsNTpdjq4TJW3U4u+Mq8QTaeOvlEnLY9/B/bPPj
	 J0S+HoAvYvdfMd8uvBngOMihI6IhXwSNUAD1F6p8=
Date: Thu, 1 Sep 2022 18:18:11 +0200
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
Subject: Re: [PATCH v9 8/8] ABI: sysfs-bus-pci: add documentation for p2pmem
 allocate
Message-ID: <YxDbQ3CBlQVvQFIW@kroah.com>
References: <20220825152425.6296-1-logang@deltatee.com>
 <20220825152425.6296-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825152425.6296-9-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220901_091816_196800_1CEC71B9 
X-CRM114-Status: GOOD (  19.43  )
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

On Thu, Aug 25, 2022 at 09:24:25AM -0600, Logan Gunthorpe wrote:
> Add documentation for the p2pmem/allocate binary file which allows
> for allocating p2pmem buffers in userspace for passing to drivers
> that support them. (Currently only O_DIRECT to NVMe devices.)
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-pci | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
> index 6fc2c2efe8ab..dca5e032b4fa 100644
> --- a/Documentation/ABI/testing/sysfs-bus-pci
> +++ b/Documentation/ABI/testing/sysfs-bus-pci
> @@ -171,7 +171,7 @@ Description:
>  		binary file containing the Vital Product Data for the
>  		device.  It should follow the VPD format defined in
>  		PCI Specification 2.1 or 2.2, but users should consider
> -		that some devices may have incorrectly formatted data.  
> +		that some devices may have incorrectly formatted data.
>  		If the underlying VPD has a writable section then the
>  		corresponding section of this file will be writable.
>  

Not relevant change :(

thanks,

greg k-h

