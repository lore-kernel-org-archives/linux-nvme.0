Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B06FD12D42
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Nov 2024 15:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bZXP2yihv6IerTKJaFvhM4c7I5X+7QFebNGRQrBrpL8=; b=22HJA/U/Fo8Ko7Z7Ji69Sm5/VX
	wEfNehBtnn6zERnQwv+nXvG3zcHSUZrVVIcC1nwO2oINkxuKZxgWW5vWy0wOmCOmhGENKg66oLkIm
	idCSnFWnbT9W13iAEgmsmDNNKOiBX78LTSiWwR7kjP1scwrLpeOmDICuaMfOe1HrZyls8dVjom7Lr
	OEWOOOjKSUCdxeo3AJNzU2XaIJ5VTOFbcsynGdDPOtinyvtBLxvcQWIQtTaMyEMkkWgzmhEHPZHuu
	K5/jQMSrS2os+jhp3bOJInH9NQv1CCjOO6jYQjR6e8k5u7yMt3zsIoFtPqxj9OQhrObB8j3UcbakZ
	ZZCw1/xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tA9jC-0000000F6lh-0M0q;
	Sun, 10 Nov 2024 15:19:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tA9j9-0000000F6l7-06v7
	for linux-nvme@lists.infradead.org;
	Sun, 10 Nov 2024 15:19:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 5D0A85C57BD;
	Sun, 10 Nov 2024 15:19:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533D2C4CECD;
	Sun, 10 Nov 2024 15:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731251985;
	bh=+nLpqVqlmI0rwfYB+x9XOLb4b4JCkJV7DCNS7yvGo5Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OEubWIUHaUCtjGJxYJ5nWYcTl4O7jXvmZxRC78OdoHXOSPdpN7Yve6E8unqrE3xw7
	 noGkSTSEj5WPLytJfdaJwps42VXBFU7yRdOMwjAgfBjhgBg0Dd/EC2D8tewNsUak80
	 h12aWQlWql/HCLFHYJOCSy2Bgc3Sbx2TdUGdPaz5txbu3gg84O+qg0yKH/aU32e81v
	 7eKJu7lxrjbuPwLHgJwoib4PK0Ffn2owR8TwOlpUaUruiqAVwpjo6Q1dbyJlxpXA3X
	 03rsXv5Mmeha22biNs41oOfjNv3RZB8IxRhyqfLwzMScjSb64oiAJc2mVMc/sMWUE8
	 X3YK8Swfv+C7Q==
Date: Sun, 10 Nov 2024 17:19:38 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
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
Subject: Re: [PATCH v1 04/17] dma-mapping: Add check if IOVA can be used
Message-ID: <20241110151938.GA71181@unreal>
References: <cover.1730298502.git.leon@kernel.org>
 <9515f330b9615de92a1864ab46acbd95e32634b6.1730298502.git.leon@kernel.org>
 <5ea594b3-7451-4553-92c1-2590c8baef20@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5ea594b3-7451-4553-92c1-2590c8baef20@linux.dev>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241110_071947_135742_3A7CD88B 
X-CRM114-Status: GOOD (  20.97  )
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

On Sun, Nov 10, 2024 at 04:09:11PM +0100, Zhu Yanjun wrote:
> 在 2024/10/30 16:12, Leon Romanovsky 写道:
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > This patch adds a check if IOVA can be used for the specific
> > transaction.
> > 
> > In the new API a DMA mapping transaction is identified by a
> > struct dma_iova_state, which holds some recomputed information
> > for the transaction which does not change for each page being
> > mapped.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >   include/linux/dma-mapping.h | 33 +++++++++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> > 
> > diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> > index 1524da363734..6075e0708deb 100644
> > --- a/include/linux/dma-mapping.h
> > +++ b/include/linux/dma-mapping.h
> > @@ -76,6 +76,20 @@
> >   #define DMA_BIT_MASK(n)	(((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> > +struct dma_iova_state {
> > +	size_t __size;
> > +};
> > +
> > +/*
> > + * Use the high bit to mark if we used swiotlb for one or more ranges.
> > + */
> > +#define DMA_IOVA_USE_SWIOTLB		(1ULL << 63)
> 
> A trivial problem.
> In the above macro, using BIT_ULL(63) is better?

You already asked same question and the answer is also the same.
https://lore.kernel.org/all/20241103151946.GA99170@unreal/

> 
> Zhu Yanjun

