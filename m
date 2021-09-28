Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F71C43217
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:15:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238CF61372
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:15:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 238CF61372
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pYZNw6wbFtbGUOWq6JSFwzRNSlJHY6GpZLDo/wcULNI=; b=JBWbwlTJ2sdP+P
	koglrrr4WI1UNZPer5EpbeL3ZzHHxBhBfqdsbdvaXj2a+cSeD0EIzN3qh4qSMY2MgqBoDjhyszuNI
	BDTu5IOL3wYkz5r9fYE3QymHtfCXaUv5LiykP52+rIZh+YprBrC/pm9e/OgUVhSbxUtdzQlo0BxKp
	mPA5t0jG8IdLa95HcGnoyDUSrJPF9qLDlaxg/KzDwLKtQKLveeskyAmCSvhT9WV1RFtqArZvY8KMQ
	bqKUsJSCdKFWcMpoIMdMb79p8+bRuw22ELWs/zjj3VV8FoqFi2WwSc6yDYfix/OC7ubNW4EfvLnnh
	d43HYEWt25zX8FxWPnAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVIa0-008cjD-DH; Tue, 28 Sep 2021 19:15:52 +0000
Received: from mail-qv1-xf2d.google.com ([2607:f8b0:4864:20::f2d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVIZx-008chj-F1
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 19:15:51 +0000
Received: by mail-qv1-xf2d.google.com with SMTP id gs10so14097616qvb.13
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 12:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=tcyMivDSSj98xjcYfl0Ss83FFw70+B/UboxWuutjjDI=;
 b=ZXqOBoW2zcRY/XCsYnDKUJm0jeVb6g6QynSlK5Ml/gYsHIPYVyWznW28IH/m39nrRs
 rG+j+z/VkkqSaLLAsjs0lqXyt+KgS2pwIFFxGvKOTpp6OskwVnUll7c0SZ88LW5r3udd
 0x2by8/0zgW10HXmR0atwW5ZveJ3LbAJ7dsEEUr2Gu8vBnEg7aKaIp30t+n3dbCJEhXZ
 2aFI7yDiqqERTNEfaySqTNHIuhyRB286ED8KYrDS7lbzOda3vmUboyfsyK3esMfGV4a8
 lPty5Chcgd6dyRXlzNl6IVGzK8Mh2KFiv4dYejeXY92N3QfzHRKzIOavZpEbU+UISfzK
 CNNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tcyMivDSSj98xjcYfl0Ss83FFw70+B/UboxWuutjjDI=;
 b=ph9oH/eB18EXW4zmjl+e/3STgBXaNlubMIWFtql/tlEAQ+DTYLICTyW2ZOyi3EQQxS
 o6HDIddfdLsTZBgLizJkINQr2+3JlqO8wtNkEOjAjwj8mBwAfEkrD5OsKebvWgh9F49w
 /TdGlGgeK9MIDidBrwG1udcyzWDxzZ12/3F6KYGTQQ5WWup4U4vEd6S87u3WbdOO4cTO
 LsL/MniFOEx5tHkCkKbxD0M16sUYDZw5C0gtBAt5/LGLGzfkYxNEze1n4cPvko2lSOB8
 +mg6iajEnq+NhhMMZYPTu6tl4X2yeNp0uvQiw2Qi2hx7/FxMxLmUv8hhA0KkPOS1QtGi
 baVA==
X-Gm-Message-State: AOAM533Ps5T/0fTH13294Gv7WeHNe6fJsIgJ8rqshEvkSxdvr49upKMr
 75/Ce3TalQnOKaY3wK0MDFlbyQ==
X-Google-Smtp-Source: ABdhPJwurJl1S4rZ2pOn1DTdiP6TavgJzB4eTygZmyEB+s55pljNt5t0RfW6XCRuHe8/1mcYm0z9gQ==
X-Received: by 2002:a0c:dd92:: with SMTP id v18mr7551030qvk.41.1632856548504; 
 Tue, 28 Sep 2021 12:15:48 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id p9sm6469qkm.23.2021.09.28.12.15.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:15:48 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVIZv-007G30-3V; Tue, 28 Sep 2021 16:15:47 -0300
Date: Tue, 28 Sep 2021 16:15:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux-foundation.org,
 Stephen Bates <sbates@raithlin.com>, Christoph Hellwig <hch@lst.de>,
 Dan Williams <dan.j.williams@intel.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 John Hubbard <jhubbard@nvidia.com>, Don Dutile <ddutile@redhat.com>,
 Matthew Wilcox <willy@infradead.org>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 Jakowski Andrzej <andrzej.jakowski@intel.com>,
 Minturn Dave B <dave.b.minturn@intel.com>,
 Jason Ekstrand <jason@jlekstrand.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Xiong Jianxin <jianxin.xiong@intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Ira Weiny <ira.weiny@intel.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Martin Oliveira <martin.oliveira@eideticom.com>,
 Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 08/20] iommu/dma: support PCI P2PDMA pages in
 dma-iommu map_sg
Message-ID: <20210928191547.GP3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-9-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_121549_556368_4A12320F 
X-CRM114-Status: GOOD (  20.20  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Sep 16, 2021 at 05:40:48PM -0600, Logan Gunthorpe wrote:
> When a PCI P2PDMA page is seen, set the IOVA length of the segment
> to zero so that it is not mapped into the IOVA. Then, in finalise_sg(),
> apply the appropriate bus address to the segment. The IOVA is not
> created if the scatterlist only consists of P2PDMA pages.
> 
> A P2PDMA page may have three possible outcomes when being mapped:
>   1) If the data path between the two devices doesn't go through
>      the root port, then it should be mapped with a PCI bus address
>   2) If the data path goes through the host bridge, it should be mapped
>      normally with an IOMMU IOVA.
>   3) It is not possible for the two devices to communicate and thus
>      the mapping operation should fail (and it will return -EREMOTEIO).
> 
> Similar to dma-direct, the sg_dma_mark_pci_p2pdma() flag is used to
> indicate bus address segments. On unmap, P2PDMA segments are skipped
> over when determining the start and end IOVA addresses.
> 
> With this change, the flags variable in the dma_map_ops is set to
> DMA_F_PCI_P2PDMA_SUPPORTED to indicate support for P2PDMA pages.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/iommu/dma-iommu.c | 68 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 61 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
