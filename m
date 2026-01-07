Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0CBFD0D176
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Jan 2026 21:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UkZv5onkyAXg00ymNzmBDBe0GBLZo5D/WkzgMa+G8aE=; b=SLsoa/t2fI3SAb
	H1eAG4SHjaO4LljBcR/ypUUwJe5PGagQoQBX41xEWgmdSc5mfI6I42kYsEwLB0m5zKKOfswlEz3KQ
	HdYbjKz3FrGBfhdowAKDVZtjcYh700gQTXrMezbD4z2eggqxQRzwDqT/ncu6q/+AJB9uuSDzDNz4C
	vc5kOd9GIdAHbtFkFdbCrTMoixybGbETxAqXc7eqrgUrOYNGPiVTFS/65Pnjg3e/bbCa8p+D3zgdP
	lnZCqKMybTv3qnsxT50XmX98t15IM/wNu7tdYdvEHcxICnQsPDdrCp1P0f0jvLSNtOhmaTbmMUIhd
	r9dE/kCDb1LsUoMmMwLQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdazy-0000000Ff6D-2s1w;
	Wed, 07 Jan 2026 21:23:22 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdazv-0000000Ff5E-3ZNl
	for linux-nvme@lists.infradead.org;
	Wed, 07 Jan 2026 21:23:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=UkZv5onkyAXg00ymNzmBDBe0GBLZo5D/WkzgMa+G8aE=; b=sAs7KK643BWbWhoo6dF6UQ1/hT
	ZLLmOL/LPVznRjY+5D4R/1OIBjEGbBOAKimg/TrjMiTYbZ9Suqs5NKYOv2oYJIaV0Rx5hzGUkn6vd
	/9KjuYX4IPOeSz5EF/TriHk3wHFgOz6Sz/lAmLXfLaejw2/5GozSnvKBlFB7DlrSzk59G/tHTLq1E
	85vfcq1tY1L6TJ8DUK2kGelCJqhlxt4crpt5Tck1bCOssOIZo0Mu3hk1t5Fg8EUxOgsx11R8LDK6e
	e9kT6VK8iumDWsc2JoHZLObgto8LS/BXGS0VnuqYEirj8o55U+UXAMOFyVcUMXldKifXSan0zEErN
	nzh97lrw==;
Received: from d142-179-236-232.abhsia.telus.net ([142.179.236.232] helo=[192.168.11.155])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vdazo-00000002GOe-3sYV;
	Wed, 07 Jan 2026 14:23:13 -0700
Message-ID: <1d2714eb-f5fc-4e73-9114-8d644deccdcc@deltatee.com>
Date: Wed, 7 Jan 2026 14:22:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-mm@kvack.org,
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
 <20260107202424.GC340082@ziepe.ca>
Content-Language: en-US
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260107202424.GC340082@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 142.179.236.232
X-SA-Exim-Rcpt-To: jgg@ziepe.ca, houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 10/13] PCI/P2PDMA: support compound page in
 p2pmem_alloc_mmap()
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260107_132319_970438_C55BF009 
X-CRM114-Status: GOOD (  19.51  )
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



On 2026-01-07 13:24, Jason Gunthorpe wrote:
> On Mon, Dec 22, 2025 at 10:04:17AM -0700, Logan Gunthorpe wrote:
>> I would have expected this code to allocate an appropriately aligned
>> block of the p2p memory based on the requirements of the current
>> mapping, not based on alignment requirements established when the device
>> is probed.
> 
> Yeah, I think this is not right too.
> 
> I think the flow has become confused by trying to set a static
> vmemmap_shift when creating the pgmap. That is not how something like
> this should work at all.
> 
> Instead the basic idea should be that each mmap systemcall will
> determine what folio order it would like to have, it will allocate an
> aligned range of physical from the genpool, and then it will alter the
> folios in that range into a single high order folio.
> 
> Finally the high order folio is installed in one shot with the mm
> dealing with placing it optimally in the right page table levels.

This all sounds the same as what I was advocating for. genpool does
still need to be modified to support the specified alignment
requirements for the allocation.

If there is more help from the VM layer to insert different orders of
memory, that would be fantastic too.

Logan

