Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A951C3DA42
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 19:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0eX7Wo0KTUJfWUHtxoHH+B23ObEinslGP6IJ1acrkRc=; b=BHJ6ySBNlxaP+76Bx7RzaqHgnP
	y5SXXvqqi6f9WmSHcEOLgGrqcxxmNwbxFiZdeJQRYl6vEJIyiWAlRL1ksx1lyPOVOlKFLR29mDB2C
	QjEwwpk8l7Qo4Ddb9OZJmRjDJsoYBcVCrvhXXXNQD+kLcju5bKC4GjcW+hRtjCizJKfJdSPSqFGIQ
	5Z22oGLrvlhynuNQT4siQivlOFFkPlUCg5nOuPvjOAvulmqZkdtlEJhjdAFj/rwibd0m50xOZ8PLD
	SA+gPg+XLh2tedPdOYOGaMsp+RwNtvoI4u8Hf/eDnlGqfG4gIV4qdE1Ghxt5mTbxad/33WvpOFcqw
	TJhrcUtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRG7a-00000008Lxe-2rql;
	Tue, 09 Jul 2024 19:03:26 +0000
Received: from mail-qv1-xf34.google.com ([2607:f8b0:4864:20::f34])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRG7Y-00000008LwG-1Db0
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 19:03:25 +0000
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-6ad86f3cc34so26108256d6.1
        for <linux-nvme@lists.infradead.org>; Tue, 09 Jul 2024 12:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720551803; x=1721156603; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0eX7Wo0KTUJfWUHtxoHH+B23ObEinslGP6IJ1acrkRc=;
        b=eiBA/pSRKgZGLgK6Bd/Zw6KdFop8OqCEyyHGKMpZbpudspDzV7UkFVMnJQmwUCYxch
         UHnLNfKi5InuTx5/gQ2jkgWJhIKaLdCf8EeeZZBvykmVgOGx6NXcfVoPoUJgzZ6PZ3HS
         q1nLgA9n/xOjfrK3lXOo9mzjVFSsgM6g10iEAgx7vgu6DtJ2FDA2PiOjrUdPo+MJyuD/
         +4hrAZsWF+yeeFT4gAs4FsaX5Q7+SvJVQe6ia6uDZ2ZeBoahTCahEiBv0MrpK908xLfw
         xm3V7tYt7qsx2dhLjbLwvJQysubIG/Q6h2QRqESUmsPGiq3WUmMc12bER1khxi8nzp6Z
         gzLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720551803; x=1721156603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eX7Wo0KTUJfWUHtxoHH+B23ObEinslGP6IJ1acrkRc=;
        b=tFyFsU5R2fJO3VF0JmtKUGezG5ZmIUkbso9YYKHhNxMgy9IH9g+/vv/clxY+II3Q55
         bDoZcG8sgaaoqIfVzp/jvSjzeQasljRdTyqapzv0fZEorabNtrKJs326speV9rQOBxhA
         VMAYWTExg+XJRzNIlBtMLlq2mCcW9coAguMe8xFFUbNOartXp4gpIDK3kC8oLArKlBlB
         FAWAdx1D+fqlz3IkgJat6VbsIKspSHvuUOPiUZllrQA28qOdMOPewVNQLc1PH15S19KM
         GpO6ENhLQAxKucwx4yGUpAfFaY8ZfKyjeUjW8l5ySTjixp4hrw2ZJ0KokGKsaW3qZFuE
         wBKg==
X-Forwarded-Encrypted: i=1; AJvYcCVN8y0vDOn2+4QXHM4EmxMxPJgJ/K7ooPtKMaH18oSI/wMDjb6VxSxmmiLxXsiF24Lo7Nwg5whbl6g195osfvRu695fXR5l3lm5Yi2hQOI=
X-Gm-Message-State: AOJu0Yx+U+GcrnHeR4sS8w+dnbP7T1QqVwgRn7Ppfvu1p/kX3edH/FUL
	NaIjuAY7Q0EZQk2nDreoHtlJy9gGyBmVGedzjn/hszk8mOflg0ABvzSwDgMwTA8=
X-Google-Smtp-Source: AGHT+IE9wk6d6lAYU4tvyeORxb5NkdX/FMtkoFI0Rc5O+LsyZzi6JOQvD31sQUESKmTir4qJcqoy3Q==
X-Received: by 2002:a05:6214:250d:b0:6b4:4470:81a5 with SMTP id 6a1803df08f44-6b61bc7f74bmr43617486d6.2.1720551802811;
        Tue, 09 Jul 2024 12:03:22 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61b9c4a1fsm11278546d6.12.2024.07.09.12.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 12:03:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sRG7U-002tXL-BB;
	Tue, 09 Jul 2024 16:03:20 -0300
Date: Tue, 9 Jul 2024 16:03:20 -0300
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
Message-ID: <20240709190320.GN14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
 <20240708235721.GF14050@ziepe.ca>
 <20240709062015.GB16180@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709062015.GB16180@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_120324_352565_282B03B9 
X-CRM114-Status: GOOD (  18.57  )
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

On Tue, Jul 09, 2024 at 08:20:15AM +0200, Christoph Hellwig wrote:
> On Mon, Jul 08, 2024 at 08:57:21PM -0300, Jason Gunthorpe wrote:
> > I understand the block stack already does this using P2P and !P2P, but
> > that isn't quite enough here as we want to split principally based on
> > IOMMU or !IOMMU.
> 
> Except for the powerpc bypass IOMMU or not is a global decision,
> and the bypass is per I/O.  So I'm not sure what else you want there?

For P2P we know if the DMA will go through the IOMMU or not based on
the PCIe fabric path between the initiator (the one doing the DMA) and
the target (the one providing the MMIO memory).

Depending on PCIe topology and ACS flags this path may use the IOMMU
or may skip the IOMMU.

To put it in code, the 'enum pci_p2pdma_map_type' can only be
determined once we know the initator and target struct device.

PCI_P2PDMA_MAP_BUS_ADDR means we don't use the iommu.

PCI_P2PDMA_MAP_THRU_HOST_BRIDGE means we do.

With this API it is important that a single request always has the
same PCI_P2PDMA_MAP_* outcome, and the simplest way to do that is to
split requests if the MMIO memory changes target struct devices.

Jason

