Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB69BD6207C
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Nov 2024 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P2RZbmw8j/hv2SNzaAYY1BO4WuVS0Sj8NBeQ9Pxkopo=; b=mwaDf8fAt//aIW5kna6wpUC+Is
	qc6QGX6zStvmq77MvswUktU87zfUwD0gxHVS8vOY2VngA/RrlKP5hlmhWH9EGQ0UvI4Rqg/eS3nPp
	lVens0ZJPGXrvrljjgggJ3caLM08ARbsgGNlwhKmzKnJTumHt+PxH0qGfxHUDRbDlQIvqK70FDxmt
	nQqGeH9pCT0ZxNI6z2lpyOOMHliTx4BP2Ty+ujc4Hace8Calml5ioVTml6vuxZR/xgMnIDGfmmrKv
	v0l8DUvkrw6R/KTUctVNwQ0Mvob1JGBTyCjY8xWJJGLSG9w7rLL+6a+fG8iyljzzX78wTOqLxM4Ze
	nNlSkS3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tDS3H-0000000DDhH-0T1X;
	Tue, 19 Nov 2024 17:30:11 +0000
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tDS3D-0000000DDg6-3VUt
	for linux-nvme@lists.infradead.org;
	Tue, 19 Nov 2024 17:30:10 +0000
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-7b147a2ff04so252544585a.3
        for <linux-nvme@lists.infradead.org>; Tue, 19 Nov 2024 09:30:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1732037406; x=1732642206; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P2RZbmw8j/hv2SNzaAYY1BO4WuVS0Sj8NBeQ9Pxkopo=;
        b=fp/GJ4kQDkPO/TYJVTOAgMkQWItrHg7ZkN6SGIiIS8AA9ha8Lc1Z6Uv1rPR5BhgE3R
         eDQRrLlDToK+HAX0RqFKVcHS3HeBSJDT8bbEDTTXATo/RF6AiP2Ve8VITi6Y5oOOsaI4
         HffQvm8Icw746KRsL000mT2wEN7cWaEGU5d/PKcUprSyOFC/st/lLtst6G2uT5u4Tglb
         lAAxbRCk/oLKzp3NREWm2mCdbtxErBJhSK+NngRWWdBrPg3qQWZq5Syj53Mg85NT3Qdy
         1NjWTk3Qg/z547zUB2oP5vugS96TlBDrRVGnLViZ7Hkfj8dMc03oclkL//m4B7jemWbj
         SDkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732037406; x=1732642206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2RZbmw8j/hv2SNzaAYY1BO4WuVS0Sj8NBeQ9Pxkopo=;
        b=hk7KyFu8tDY+9mq4m3dyGMbEQgTXIIYechm4P0qQFMAIqMdqyNPiYo28DwNKNy+3cr
         HxHJ7mmO89IlqLIZDLWk872kR3VfvHMoS7R+rzlXCcxmoz9qcxoehJuNo48jOJZeY374
         4TnFhc98kPuCCr5qFX2HVHds66+YXBXejb98mPNMx6NQ4zys8QxB2Z6rlyIGWEgVNSER
         xFL6gzxxOkrkwcjGL+vKqX6WH3usbVrgr7Q6thKYx0RR0wCQZv8AWQ9nIT0fw6ELnFKQ
         5sqItcYmPjCbVk2P6wFyfve6Fyd2tlBskhCc02eu5gAvPep5ijZP+r4qb7sUzQwYGRlQ
         X/Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWAFwIzUIBGozg0c4CsJ/vYHRAgc4K1M5W3JpeedFr91p6uwpys2r972CEnb/TgUjkMHWjDEnPvbHMq@lists.infradead.org
X-Gm-Message-State: AOJu0YyHRssAiN0c5jNH+42/HHMl35xzNMxcWfePs6+s83oVauTC4a2g
	ArDwrkBdkbY4RtlxKgEvWHqjTDfxXVJAaZqE3i3sbQcEJta1sdFmEfDOjrnNEQM=
X-Google-Smtp-Source: AGHT+IEw2hhta4tF97+ZTqDEn97k4/qPKPWIxcDYewixCIGPDLkcCaqZGpK5GII/9x88g1PJnE+WXg==
X-Received: by 2002:a05:620a:1992:b0:7b1:4330:634f with SMTP id af79cd13be357-7b362384ee1mr2344165985a.61.1732037405973;
        Tue, 19 Nov 2024 09:30:05 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b37a866319sm113013385a.69.2024.11.19.09.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 09:30:04 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tDS3A-00000003GSP-14at;
	Tue, 19 Nov 2024 13:30:04 -0400
Date: Tue, 19 Nov 2024 13:30:04 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 07/17] dma-mapping: Implement link/unlink ranges API
Message-ID: <20241119173004.GA773835@ziepe.ca>
References: <cover.1731244445.git.leon@kernel.org>
 <f8c7f160c9ae97fef4ccd355f9979727552c7374.1731244445.git.leon@kernel.org>
 <20241118145929.GB27795@willie-the-truck>
 <20241118185533.GA24154@unreal>
 <20241119090507.GB28466@willie-the-truck>
 <20241119135743.GB26101@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119135743.GB26101@unreal>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241119_093007_876316_A20A47E2 
X-CRM114-Status: GOOD (  19.37  )
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

On Tue, Nov 19, 2024 at 03:57:43PM +0200, Leon Romanovsky wrote:

> > > dma_iova_link/dma_iova_unlink() don't have any assumptions in addition
> > > to already existing for dma_map_sg/dma_unmap_sg(). In reality, it means
> > > that all calls to unlink will have same size as for link.
> > 
> > Ok, great. Any chance you could call that out in the documentation patch,
> > please?
> 
> Can you suggest what should I add there, as it is not specific to new
> API, but general note applicable to all __iommu_unmap() callers?

This is what I wrote:

+/**
+ * iommu_unmap() - Remove mappings from a range of IOVA
+ * @domain: Domain to manipulate
+ * @iova: IO virtual address to start
+ * @size: Length of the range starting from @iova
+ *
+ * iommu_unmap() will remove a translation created by iommu_map(). It cannot
+ * subdivide a mapping created by iommu_map(), so it should be called with IOVA
+ * ranges that match what was passed to iommu_map(). The range can aggregate
+ * contiguous iommu_map() calls so long as no individual range is split.
+ *
+ * Returns: Number of bytes of IOVA unmapped. iova + res will be the point
+ * unmapping stopped.
+ */

Jason

