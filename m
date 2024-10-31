Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA1EE6F063
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Nov 2024 14:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fPdzghOCCuw7btylJtg39ro/fYH6tFP/dvjwHa8zWMM=; b=0uM9OgYLu76SIuGtkC4rheVCKr
	X8MMNYcvZdJ3eVzXMAh/1vnOiiX2Lmg4X+JYOgTWLiy4Ob1T5PQsbxwyf6R3iVxuungvNctEEdmZM
	4xFEGbAivKhRpF5XJSQ8pW/qsOciwDUhNZDMUd9dOV8L6ilzCqaQjv8orZ1Bv1uLmpx0YABMUSk8H
	/m69siA5O14a4V7h3TQZnB+KK3znbUz9XQRR97mnr1Z9cFak8tDw6qC5wAsMiUGzeFSO9qRikd06n
	uumCMcF7mxINiFnr0KaYP77qc9/TGg/TeOLhnH6+sdG40XH2IgxWwEo/3AkQBjXA8GfXbjD5Um8vJ
	e4Pz07rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6sWa-00000007JEr-1Ed7;
	Fri, 01 Nov 2024 14:21:16 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s96-00000007FnU-2NpL
	for linux-nvme@bombadil.infradead.org;
	Fri, 01 Nov 2024 13:57:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fPdzghOCCuw7btylJtg39ro/fYH6tFP/dvjwHa8zWMM=; b=N/oGyAgjBau6Vt2e+SE0bKnjS3
	NB/gyXagxrnvL0pLcSxFoX9WwTtPNmeTKyhdniRx101mCNW6I5r/Kek2JQVWeYxA042BH2SCTn1Rj
	T0HzX6LsLe+eZzw+4yCF33X3cSoSYVwoQ4dEMqxu8DXB+TG8YIdjPVpUGeffmiNvJ2r/+qYhvnn1y
	LrYfs60HmNWW147m+dH6SM3zj4/XyYZLLaLIzRi5WJuRydxiwIj+DPv2Ngt53eD6F1q59UzCaZz+U
	cl99I2arfGs3FdaaLeZW0zL5V8LlQwoCS9+fidjDKQmgUBEVdxmVPU2yKxX++HJNSxnLuqGvG3rhB
	sfS5/HOA==;
Received: from dfw.source.kernel.org ([139.178.84.217])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6s92-0000000Aizq-3Q3u
	for linux-nvme@lists.infradead.org;
	Fri, 01 Nov 2024 13:56:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 580F05C87E1;
	Thu, 31 Oct 2024 07:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A22C4CEC3;
	Thu, 31 Oct 2024 07:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730361574;
	bh=r4WvFfTJfMdRUmFzrlSoIGEf8BKQg/IhRD4qnokJQvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YSE0qfi9lLOBn1EH9BGdBYxYLpBIBHIK0QaNCb5Z2f/3ZU0SiPGduT5S8BZpZzVhE
	 QsE8znEvky7HGyINHWNHZtUimXc0OyWjetPBBGPw4IpeX6whHRZ0Squq75I9D2OXoh
	 Dj4A2PcDjtD53WxZ8CfoENNGNXS3uZ1vTjYJ05qe8rdIM0RAaKg01VZUsT2btH90gN
	 3IfJ20Y+iAFHW1y+lpY5HZMEPNs5tEjpoTUkB7qMwux7hxpqN1+o4tJ7RVpOBKxrIT
	 w9KRIYFGI2KFLA4w2wF7IkinK0w9y+ewKYwfXPBFWw7JG53t4IL192NVOKYAlQAK8j
	 0+j+mdz3I8PxQ==
Date: Thu, 31 Oct 2024 09:59:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 09/17] docs: core-api: document the IOVA-based API
Message-ID: <20241031075928.GA7473@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <881ef0bcf9aa971e995fbdd00776c5140a7b5b3d.1730298502.git.leon@kernel.org>
 <19cf7d58-4a28-4ce8-9524-8c99fdc79062@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19cf7d58-4a28-4ce8-9524-8c99fdc79062@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241101_135657_059316_4662B06F 
X-CRM114-Status: GOOD (  16.99  )
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

On Wed, Oct 30, 2024 at 06:41:21PM -0700, Randy Dunlap wrote:
> (nits)
> 
> On 10/30/24 8:12 AM, Leon Romanovsky wrote:
> > From: Christoph Hellwig <hch@lst.de>
> > 
> > Add an explanation of the newly added IOVA-based mapping API.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  Documentation/core-api/dma-api.rst | 70 ++++++++++++++++++++++++++++++
> >  1 file changed, 70 insertions(+)

<...>

> > +These APIs allow a very efficient mapping when using an IOMMU.  They are an
> > +optional path that requires extra code and are only recommended for drivers
> > +where DMA mapping performance, or the space usage for storing the DMA addresses
> > +matter.  All the consideration from the previous section apply here as well.
> 
>                     considerations

<...>

> > +is used to unmap a range previous mapped, and
> 
>                             previously

Thanks

