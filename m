Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D0AC79FAF
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Jan 2026 17:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nPXCpaMeKr8anhQvykVWaeOhAh4K2CJRGmcFaO12UK0=; b=0MDtJSVenaBRIx
	UfuzfsLSeg8Br+fI8eUTF7Cd1YdynSMaS24gSzW618ZmVTr7fE2jOspWITh2uu17/ZJG5dJeepXPZ
	d45fVR1hTXfHqjkiFnFTJHji9KNgl66EloTf0r0SxGn5bo1gnImfc3Xyv4kOIufk15WrcjaIp5NLU
	uekM2ZFriKK37WXcEThYnKgl/TF13uI7Qlk7+jt6yqUO2R4GJ4eQrJ8ltEP7wHoWLSBN8OQmJFh5i
	w9vR0CSQqfir0hdNsgbf9PrSG/42LsFCsA9H67WIPlzgWA6Z4Ju89wQN6FGWyqYMbntdNKWxgX/PS
	XCQqURO6P7m/baidPzjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcoKF-0000000BpDu-10DQ;
	Mon, 05 Jan 2026 17:25:03 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcoKD-0000000BpCp-075M
	for linux-nvme@lists.infradead.org;
	Mon, 05 Jan 2026 17:25:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=nPXCpaMeKr8anhQvykVWaeOhAh4K2CJRGmcFaO12UK0=; b=Jap+phMRmtmaCkqb9qwsgwj7JI
	nMb91j6DyoHvobSJzXUHGruB3Md3M3d+UdUDnY8fFM6Y5JkrTYHdUS2o9O6mpHaDQTTc0u/yInpwo
	AYAaUQQgA9xT5m6foMA/rc4K/cc8QTvc9kZKNSpiT04fGCUVkkKn6cyZr+yyC+UAkbXMP8D/oajbc
	RmXXZoikMBxNLvXL0mdn+hM0em/4gcWamJK4HCbXZbeMe+bpjqXZ5NpCPt6E0HzlOIBdwy9FJpwPQ
	KsZt6XtHv/FPrBYPCBxljHV5iyzEuLykHtPMXVOR7zpqsmVQ0nDXEPdkFH5tZ9nr0hmCI4iEHwHL1
	vZdU8p+A==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vcoK6-00000000l4E-1xnz;
	Mon, 05 Jan 2026 10:24:55 -0700
Message-ID: <1a6ff388-c282-42c7-a0a2-d8b2f5ed720b@deltatee.com>
Date: Mon, 5 Jan 2026 10:24:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org
Cc: linux-pci@vger.kernel.org, linux-mm@kvack.org,
 linux-nvme@lists.infradead.org, Bjorn Helgaas <bhelgaas@google.com>,
 Alistair Popple <apopple@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Danilo Krummrich
 <dakr@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Keith Busch
 <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 houtao1@huawei.com
References: <20251220040446.274991-1-houtao@huaweicloud.com>
 <20251220040446.274991-11-houtao@huaweicloud.com>
 <07a785e5-5d2e-4c81-a834-1237c79fdd51@deltatee.com>
 <beb61666-020a-d99e-e84f-c16111039e66@huaweicloud.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <beb61666-020a-d99e-e84f-c16111039e66@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 10/13] PCI/P2PDMA: support compound page in
 p2pmem_alloc_mmap()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260105_092501_078149_DF6E595C 
X-CRM114-Status: GOOD (  21.12  )
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

>> I'm a bit confused by some aspects of these changes. Why does the
>> alignment become a property of the PCI device? It appears that if the
>> CPU supports different sized huge pages then the size and alignment
>> restrictions on P2PDMA memory become greater. So if someone is only
>> allocating a few KB these changes will break their code and refuse to
>> allocate single pages.
>>
>> I would have expected this code to allocate an appropriately aligned
>> block of the p2p memory based on the requirements of the current
>> mapping, not based on alignment requirements established when the device
>> is probed.
> 
> The behavior mimics device-dax in which the creation of device-dax
> device needs to specify the alignment property. Supporting different
> alignments for different userspace mapping could work. However, it is no
> way for the userspace to tell whether or not the the alignment is
> mandatory. Take the below procedure as an example:

Then I don't think the approach device-dax took makes sense for p2pdma.

> 1) the size of CMB bar is 4MB
> 2) application 1 allocates 4KB. Its mapping is 4KB aligned
> 3) application 2 allocates 2MB. If the allocation from gen_pool is not
> aligned, the mapping only supports 4KB-aligned mapping. If the
> allocation support aligned allocation, the mapping could support
> 2MB-aligned mapping. However, the mmap implementation in the kernel
> doesn't know which way is appropriate. If the alignment is specified in
> the p2pdma, the implement could know the aligned 2MB mapping is appropriate.

Specifying a minimum alignment as a property of the p2pdma device makes
no sense to me.

I think the p2pdma code should just make the best effort to get the
highest aligned buffer for the allocation it can. If it can not, it
falls back to just getting page aligned buffers. We might have to make
some minor modifications to genalloc to create an aligned version of the
allocator (similar to gen_pool_dma_alloc_align()).

Logan

