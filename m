Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8490CCA0EDC
	for <linux-nvme@archiver.kernel.org>; Sun, 17 Aug 2025 11:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Z1CFrWb4l1P3vBMSmP6h2aBCsMLffmmJDEsMJ59wit8=; b=h49PV+tUgSkNirBwTOw7FqAq/N
	y3ZZpykOlZmizrd9cO8DY2j7XI8ebBzQ4FHavwgFe9otIkcLEVr6wLXFcvP71Km3ztopOTWEIwP9y
	aQPPdFjpR4NHqPAFUjV08yYhO/vr5eJ73OMrRgWxFk3z7fFv7Q679IEsk9XJ9a6TJlfmeWqJ7vneG
	93OVGTVreSOHD/Hbr+hbaE60jNGrhnP+QJgk5sXw91NPFEFf7qz7P9G69MBhnTkq4R2CsRfSQzknH
	ZGTKHhWnhSYuOeDRJ9ik5LRBNHN9Fm6aFJ5BdMNGg8YIkz8zWhj9xMLl/rQ3UJcGozVKguVdihdEQ
	vTfg1Edg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1unbNH-00000005aOA-3Kzy;
	Sun, 17 Aug 2025 11:16:31 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umbzI-00000000Edl-1YOi
	for linux-nvme@lists.infradead.org;
	Thu, 14 Aug 2025 17:43:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7FB4F601D8;
	Thu, 14 Aug 2025 17:43:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66588C4CEED;
	Thu, 14 Aug 2025 17:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755193419;
	bh=NtGaXEt/rCXZbH6AhRXhKag5AQfcAprg8g7HcBf4fa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qET8o0XvKzXdUiWMSbCsLL3eECdWZ/AbT+J3b7auosgo7K/gf6rt6x3D6UTI76iqO
	 ti/iGG5xkCHTOQimoWMmFfEnk9qKFL2quOO5nh0SiN+AtdcIknOOMaCwhWCHlP4gMD
	 ykB+wRt62M5cjTVShpIgxGBKujUJevNaAvQmESCXsgTaz6eSAmBzP6Np2+HWgacd/i
	 ptn2QT+kSVgRjXKbq92+rFZQUf9rAqUBC2DFgoqq/jRE8er78UlpXtOrVW/WVebQgm
	 oscioXsT1akK/vdGGIJZToP0KYoeWZGwANzuVPBNp0BvFFlINHo65cmqBExc85Nyt2
	 XqGc4T1I2WbCQ==
Date: Thu, 14 Aug 2025 20:43:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	iommu@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Jens Axboe <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, Juergen Gross <jgross@suse.com>,
	kasan-dev@googlegroups.com, Keith Busch <kbusch@kernel.org>,
	linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-nvme@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-trace-kernel@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, rust-for-linux@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	virtualization@lists.linux.dev, Will Deacon <will@kernel.org>,
	xen-devel@lists.xenproject.org
Subject: Re: [PATCH v2 01/16] dma-mapping: introduce new DMA attribute to
 indicate MMIO memory
Message-ID: <20250814174333.GA8427@unreal>
References: <cover.1755153054.git.leon@kernel.org>
 <f832644c76e13de504ecf03450fd5d125f72f4c6.1755153054.git.leon@kernel.org>
 <c855a4f9-4a50-4e02-9ac6-372abe7da730@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c855a4f9-4a50-4e02-9ac6-372abe7da730@infradead.org>
X-Mailman-Approved-At: Sun, 17 Aug 2025 04:16:29 -0700
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

On Thu, Aug 14, 2025 at 10:37:22AM -0700, Randy Dunlap wrote:
> Hi Leon,
> 
> On 8/14/25 3:13 AM, Leon Romanovsky wrote:
> > diff --git a/Documentation/core-api/dma-attributes.rst b/Documentation/core-api/dma-attributes.rst
> > index 1887d92e8e92..58a1528a9bb9 100644
> > --- a/Documentation/core-api/dma-attributes.rst
> > +++ b/Documentation/core-api/dma-attributes.rst
> > @@ -130,3 +130,21 @@ accesses to DMA buffers in both privileged "supervisor" and unprivileged
> >  subsystem that the buffer is fully accessible at the elevated privilege
> >  level (and ideally inaccessible or at least read-only at the
> >  lesser-privileged levels).
> > +
> > +DMA_ATTR_MMIO
> > +-------------
> > +
> > +This attribute indicates the physical address is not normal system
> > +memory. It may not be used with kmap*()/phys_to_virt()/phys_to_page()
> > +functions, it may not be cachable, and access using CPU load/store
> 
> Usually "cacheable" (git grep -w cacheable counts 1042 hits vs.
> 55 hits for "cachable"). And the $internet agrees.
> 
> > +instructions may not be allowed.
> > +
> > +Usually this will be used to describe MMIO addresses, or other non
> 
> non-cacheable
> 
> > +cachable register addresses. When DMA mapping this sort of address we
> 
> > +call the operation Peer to Peer as a one device is DMA'ing to another
> > +device. For PCI devices the p2pdma APIs must be used to determine if
> > +DMA_ATTR_MMIO is appropriate.
> > +
> > +For architectures that require cache flushing for DMA coherence
> > +DMA_ATTR_MMIO will not perform any cache flushing. The address
> > +provided must never be mapped cachable into the CPU.
> again.

Thanks, I will fix.

> 
> thanks.
> -- 
> ~Randy
> 
> 

