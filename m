Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 660CAC2BD09
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Jul 2024 10:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VQ0x5M8745iJdoh6tHN0tzYonslhz7xwJWvLxeue+x0=; b=l3udHXiG9f2fHxCfV9scxb1+iI
	etaMiG9h19eBfBkzVeyTfIB7ioxgmCSLKUtvdjnhxY9r13NfV5juv43lOC+YbNUKomLXCc4j1UxWa
	zQSWRsfORVCJmSvzb49S3TKhoMiqPzSXYT6Ir0EPDHYeYbE+RsE+Uy5TPWLddN1aal8txMmXUzfsX
	MvG8BKvWs/zy3T/2g1wbCsOlRn9ZsR4f8G0NEhpgVM8HS03+thUgQsDuUijgUlL7As/Ym7u4tn17k
	1XuxuIn6KqgaTaaDTwu7jTIoNeoN4y/KhCwMVMkCIENsK0wew+0zLHRSF8ykleQLlI0Mxn8oJwGE5
	XIfF1twQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOxS5-00000009r9M-1ttC;
	Wed, 03 Jul 2024 10:43:05 +0000
Received: from out-172.mta1.migadu.com ([95.215.58.172])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOxS2-00000009r7L-0wxg
	for linux-nvme@lists.infradead.org;
	Wed, 03 Jul 2024 10:43:04 +0000
X-Envelope-To: hch@lst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720003375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VQ0x5M8745iJdoh6tHN0tzYonslhz7xwJWvLxeue+x0=;
	b=UGo3+dYatV3+LHOqZstdITsJeOnkGNrjjKudxHxps7f66nrP6L2jPec8eQh+kgocd01E++
	5ZH9rxoshew0yf6Kc3Deyv+ijw/nOCWKOnj/sPJHL/iD1p19uxG1dh3GI+QQiruFD8TsYh
	lVwQS8zKiifLTR0s/1tHh0utloLHppM=
X-Envelope-To: leon@kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: jgg@ziepe.ca
X-Envelope-To: robin.murphy@arm.com
X-Envelope-To: joro@8bytes.org
X-Envelope-To: will@kernel.org
X-Envelope-To: kbusch@kernel.org
X-Envelope-To: oak.zeng@intel.com
X-Envelope-To: kch@nvidia.com
X-Envelope-To: sagi@grimberg.me
X-Envelope-To: bhelgaas@google.com
X-Envelope-To: logang@deltatee.com
X-Envelope-To: yishaih@nvidia.com
X-Envelope-To: shameerali.kolothum.thodi@huawei.com
X-Envelope-To: kevin.tian@intel.com
X-Envelope-To: alex.williamson@redhat.com
X-Envelope-To: m.szyprowski@samsung.com
X-Envelope-To: jglisse@redhat.com
X-Envelope-To: akpm@linux-foundation.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-rdma@vger.kernel.org
X-Envelope-To: iommu@lists.linux.dev
X-Envelope-To: linux-nvme@lists.infradead.org
X-Envelope-To: linux-pci@vger.kernel.org
X-Envelope-To: kvm@vger.kernel.org
X-Envelope-To: linux-mm@kvack.org
Message-ID: <f781c3ea-8097-4e5f-84b2-0cd1f49bdb96@linux.dev>
Date: Wed, 3 Jul 2024 18:42:42 +0800
MIME-Version: 1.0
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
To: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Jason Gunthorpe <jgg@ziepe.ca>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
 "Zeng, Oak" <oak.zeng@intel.com>, Chaitanya Kulkarni <kch@nvidia.com>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240703054238.GA25366@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240703_034302_723252_E61A2C3A 
X-CRM114-Status: GOOD (  11.07  )
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

在 2024/7/3 13:42, Christoph Hellwig 写道:
> I just tried to boot this on my usual qemu test setup with emulated
> nvme devices, and it dead-loops with messages like this fairly late
> in the boot cycle:
> 
> [   43.826627] iommu: unaligned: iova 0xfff7e000 pa 0x000000010be33650 size 0x1000 min_pagesz 0x1000
> [   43.826982] dma_mapping_error -12
> 
> passing intel_iommu=off instead of intel_iommu=on (expectedly) makes

I also confronted this problem.IMO, if intel_iommu=off, the driver of 
drivers/iommu can not be used.

If I remember correctly, some guys in the first version can fix this 
problem. I will check the mails.

To me, I just revert this commit because I do not use this commit about 
nvme.

Zhu Yanjun

> it go away.
> 


