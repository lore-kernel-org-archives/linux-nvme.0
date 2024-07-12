Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F10C2BD09
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Jul 2024 12:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=; b=j991C4pgH093+gGgCA1RX53HLZ
	9rBXt6YzhiEt3D9Np+heIQwa+zmBBQwuYUae4mnIZyr0Ijf1TFcqcmKnieUD7h9bY9A81A3PsNoXT
	D3QeaXRN20/0n3cYmhIXukzYw5lNeBsNPMCqCcHTJ6MRvmS6SIgMFaWNcDmWkTngRTXhTFrIjNgyo
	qzNj5MljhQUyKNil/sbu9TTRiBqa+S63nKfYcKzvuHgj0VDxIkOKX1U/B4vBEdboJo55gxOEboJTS
	TKPSlveyzo/XsjLvbmizFGfhepj0EsKy6c/f94zQ5Jnb+yMpGfIiMOuEtEhxd7FSxN/qE0st1QGTb
	kQTMYBzw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSFbr-000000000W8-04Ms;
	Fri, 12 Jul 2024 12:42:47 +0000
Received: from mail-qk1-x736.google.com ([2607:f8b0:4864:20::736])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sSFbk-000000000VZ-3axD
	for linux-nvme@lists.infradead.org;
	Fri, 12 Jul 2024 12:42:42 +0000
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-79f1828ed64so121794085a.1
        for <linux-nvme@lists.infradead.org>; Fri, 12 Jul 2024 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720788159; x=1721392959; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
        b=b62iDl5wTzQaLLaEXIvpETRWVdB4XU6FqHKJ9cRgBij26laC26lk/eDEMG+2qbUrnC
         bgVBdBzM/FCRPWalxRHTLYa0fZZVxAthx3KsE5tAOtR4eeYf5TqTnemYNRbYbBoXHhEX
         X4bTcoiPN43mm7tI0beHOjYTIfK11eW+GXTAqJEnpcPUN10X7MfFuKg9d8Xl4K/sGvQR
         RxVaamSH7YLFNMdudZcNGOEhUjJsJ1+mUrXhQ01+QW1eWiTarp6W0XXgfNBD/3nFTXNT
         knrXXh1T76pyLZROedTB/xtqK4Z2VAuEH8HEfpn6F9u6L+ZO0TQDTsiup45I/goV0G38
         wX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720788159; x=1721392959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kBJT8YbrNHkTssvswA9gJLT8aMBMcBvE6Xo16vVg1no=;
        b=KXc0+KwTt0dePAOOxsr1AGbB8mxMDT3OzphtBmjHEHxTHuE4c8UCvgbM7aSM9pcRu0
         z9eFn8Fre4N0Xc6pGd2cPDdbC2quBnNVE4hmMHWnQxvjgTb40yp15tvz5M0cM4T5ISMz
         SmKJK8sKKcFUoJ/MqkYsLejw4cMpK41fJUbnsnKfp+s5Eneg0kEv8hJJXEDNUSqwZKvt
         CmoeDa0enc8BNBjr9bYBfMSYRnjMOUmzLRIcPRWn1Zw3dWnbjdDFwarpR+ZGIG9luvCM
         xJYOQ9ZUJedPgJJSwPAQ4nfeW66TJjy1c+ERLAbgL1aj5hQwmDnpd8f4kzLnICmskg3c
         oXIg==
X-Forwarded-Encrypted: i=1; AJvYcCXWkwiNzQ+mzxSaMv0BQfArlCLHW/yJ/NPu1cvxMQSyw7GE+VgGkZBEYpS54jOz54wGesxLgdjGyvHNm9FOEA1ZKyXOs/+vvdeeqxS10Nw=
X-Gm-Message-State: AOJu0YxN3f9R0+HqzIsUSfl1Mq2m+aR6O8s3dm5nf14i2kuo/3e53fki
	GViiNlPBhCq+Gsb2L/GVPotyaj4VX1s2sQZrOrxI5Wji0EayV4oNUBgahwhMwvQ=
X-Google-Smtp-Source: AGHT+IFNcSNXyjLCUq4DHk3R2ij71BFERvS9sNsM3zBakmLtTWzYOjs3C+yBv/o3LvcwnsHGWOmY4Q==
X-Received: by 2002:ae9:e315:0:b0:79f:1836:b143 with SMTP id af79cd13be357-79f19ae5454mr1218368285a.50.1720788159083;
        Fri, 12 Jul 2024 05:42:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f1902ac2esm394037485a.59.2024.07.12.05.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 05:42:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sSFbh-000FUg-Ne;
	Fri, 12 Jul 2024 09:42:37 -0300
Date: Fri, 12 Jul 2024 09:42:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240712124237.GX14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
 <20240709190320.GN14050@ziepe.ca>
 <20240710062212.GA25895@lst.de>
 <20240711232917.GR14050@ziepe.ca>
 <20240712045422.GA4774@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712045422.GA4774@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240712_054241_019551_DFFD81A9 
X-CRM114-Status: GOOD (  12.78  )
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

On Fri, Jul 12, 2024 at 06:54:22AM +0200, Christoph Hellwig wrote:

> This is all purely hypothetical, and I'm happy to just check for it
> and reject it for it now.

I do know a patch set is cooking to allow mixing ZONE_DEVICE P2P and
anon memory in the same VMA ala HMM with transparent migration of
ZONE_DEVICE to anon.

In this situation userspace will be generating IO with no idea about
any P2P/!P2P boundaries.

Jason

