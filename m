Return-Path: <SRS0=nS76=OS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08BD4C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:44:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C684D61157
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Sep 2021 19:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C684D61157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=G0z+BGfetq8SAsiIk+hwlNZz36F+KFuJyCwJNt0FBEk=; b=W5oeYjjn69TgOe
	EWjEd/zbfKG4pqz4AFo5L7yxp4xt4VUWz2tjnp8ILiUsMC56+AydX6vnOFKqvWElhzFsXYZo7XyZ/
	iUumXWJzeriyQQDwv76Mkhg/UI3PqllEjPbulGpnXueIPG5c9lhqXKApF8V5XYLEbrlW1hVnUx6db
	Q3Z+PhPMvJ/H0y7oDGzelGhSvMZh3fHqaOfVXPzBh8EyPBogbNJaEwJdZNF5v9m2qUe/PQ3ThqcKy
	wu4cUoSkcA6xJHvRKx3KIQ9EwQsbWUhKt0k0SMQ/s9Df5JLkpynXXLVlSCMAhM9kUYQPpOKJqdbAc
	agwst4Uw1oQNfv4s+0Qg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVJ0l-008gvE-J2; Tue, 28 Sep 2021 19:43:31 +0000
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVJ0i-008gu7-Ie
 for linux-nvme@lists.infradead.org; Tue, 28 Sep 2021 19:43:29 +0000
Received: by mail-io1-xd2d.google.com with SMTP id n71so151006iod.0
 for <linux-nvme@lists.infradead.org>; Tue, 28 Sep 2021 12:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rjLk0h/mLxEL3Q6/W9L7mqQkVvY6tzCz4tgaLSgLx3s=;
 b=hhjthCUJo5WhNKDnLCpo+MVqy6n87T1pJjZguVrbGVB7rs1TEqj8vSzkH1OSVJ4aHY
 Y4CBMG1r9Rmy0NZyrlH5NzTg+Y8qxZoKLG0AvCFUREnWT/psrYWEBqSqvzXvNv5yTDIr
 on4+mWLbQe9rhU1sJ0QNKudA3/36oLT7Zw6sZzQBD1xnoS8UNH2nV0XaX4yDc24jjF2F
 7QkD0f5nx2AT5EawBHny0YCDHI8greowW1MBzYmGKp/2RhkC/7+QDf784bbYh0ttqPja
 SIBG9NG6TFsrj3x8A3HpfCET+Sjd2Z1Hfpwi/GMS9Z23rUtCt6WAlr+9cdU9alzqPn1Q
 1OpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rjLk0h/mLxEL3Q6/W9L7mqQkVvY6tzCz4tgaLSgLx3s=;
 b=IHeuTbpVpOobz68IlfAQsoLrkG6jrJ/0FiIUqOY8lh0I6Lz1npELG7/W8mdUWg00XG
 TonVICoTaNgGbbVwReqlwzRl/7gMWJXXwg3lOD6WjwQrpbZv2XtY9G7q684gkcTjyHBq
 BVZVvQDbbCWc8xKEIxB+bmVnPj56BUpt9440IseXwx3Wi5OLW6Kccom58Og94czsNJg2
 TKfvlzi2Ypbd2zVb4lJyfpEasPOIlV8+rluy7oXlYsPIHYSEDK7zk3dkq+zWTEOa3AyK
 vfbZlmAZiXKkrPmy8oldh7oSuIROmIPuEPC2uw9RF7KX073+Vn6Ty2sNqh1aj0F98uom
 qYvA==
X-Gm-Message-State: AOAM531sSZJ0mIih8/10mRuoLRY8NXuxe7S1WQ9G/QMqkxWYin2iFfL1
 n7iv1x5UGp7xvOGmNl3NCypxgw==
X-Google-Smtp-Source: ABdhPJxTc9Esg662iHYF19mOveiU9FtR9gwP3ZO8mFkHuFuDP2iiQ1yQeLzvOs2cq2YVQPchFaVZug==
X-Received: by 2002:a02:b91a:: with SMTP id v26mr6047050jan.78.1632858207605; 
 Tue, 28 Sep 2021 12:43:27 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
 by smtp.gmail.com with ESMTPSA id a11sm12090741ilm.36.2021.09.28.12.43.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Sep 2021 12:43:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1mVJ0f-007GWk-Q4; Tue, 28 Sep 2021 16:43:25 -0300
Date: Tue, 28 Sep 2021 16:43:25 -0300
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
Subject: Re: [PATCH v3 12/20] RDMA/rw: use dma_map_sgtable()
Message-ID: <20210928194325.GS3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-13-logang@deltatee.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-13-logang@deltatee.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_124328_651486_968B36CB 
X-CRM114-Status: GOOD (  15.25  )
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

On Thu, Sep 16, 2021 at 05:40:52PM -0600, Logan Gunthorpe wrote:
> dma_map_sg() now supports the use of P2PDMA pages so pci_p2pdma_map_sg()
> is no longer necessary and may be dropped.
> 
> Switch to the dma_map_sgtable() interface which will allow for better
> error reporting if the P2PDMA pages are unsupported.
> 
> The change to sgtable also appears to fix a couple subtle error path
> bugs:
> 
>   - In rdma_rw_ctx_init(), dma_unmap would be called with an sg
>     that could have been incremented from the original call, as
>     well as an nents that was not the original number of nents
>     called when mapped.
>   - Similarly in rdma_rw_ctx_signature_init, both sg and prot_sg
>     were unmapped with the incorrect number of nents.

Those bugs should definately get fixed.. I might extract the sgtable
conversion into a stand alone patch to do it.

But as it is, this looks fine

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
