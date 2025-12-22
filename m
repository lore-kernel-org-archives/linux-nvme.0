Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90157E677F6
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Dec 2025 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Subject:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Kg190DLkPKaiJohQI6jqmDPUrKa96yp2xevLyMH3St0=; b=KOFW3Az6+MGh3W
	dt7uzKp55RyIVus6uCjmk1fYL/aIU8fJNv59zPNkoyOvoE08bvVr6x+BxJWeKa0iSxX8t9w6DIlI/
	Tk6syFeaKkQGVRWdR0g2L3xB3j5jP28eqrKy8uqQmbtaXMYdYyicN22syMDkcrmXP477Pb4uxTSFf
	/ICn06908XucTKrt3tcQfPvljh6JPETPOxMN4MjQAQSnva3cQjzIWImVftfsA9Zd9GQB9B2eBjcaO
	vPPLHOEibcV2IYrkj7LnMu/FSIZ38/e2j5/w0Ri0aTSY090yYwjNMf+mJ7jHujVNBdoGTL0mZUTmh
	jIWvhIKQPXjlApdmwloQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXj6r-0000000Dz6C-2JX4;
	Mon, 22 Dec 2025 16:50:13 +0000
Received: from ale.deltatee.com ([204.191.154.188])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXj6o-0000000Dz50-13tY
	for linux-nvme@lists.infradead.org;
	Mon, 22 Dec 2025 16:50:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Kg190DLkPKaiJohQI6jqmDPUrKa96yp2xevLyMH3St0=; b=ee8WmXunPJLOsQa4E7AD0Qn0/W
	CJseKOSYhTHpdSF3EIwXXjV0QzPZFAOy9hUJChrTEzpfA7nmQ9UeMhrgoJmyyOnkjwB7IRUVLyobP
	zO5/D77jRsl6BgVBDnzdECyg7Gfr1rcES7bXQAIEOHiG0zUJZTPhAQatgzPN0ZvO5VBglFlXHZh5E
	zP/wqKqGoD7/BLOf5J4trN1m/sRkvSkoAbe4rHTGFj8bmGM0n30zAHBo+GEpIE+zDYGUOBx49vEXW
	2QPhSmMNSQIReNrNkFDZtzuh2uEXXd+/+JNvdyCTrs2ol95Nt0H/hs+5EkslWz28fs3K52AdQtVdH
	FXi0e4UA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vXj6h-00000008Jae-1nLB;
	Mon, 22 Dec 2025 09:50:03 -0700
Message-ID: <7ee29764-487a-4b23-8580-a9f45d73e088@deltatee.com>
Date: Mon, 22 Dec 2025 09:49:41 -0700
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
 <20251220040446.274991-2-houtao@huaweicloud.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20251220040446.274991-2-houtao@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: houtao@huaweicloud.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, linux-nvme@lists.infradead.org, bhelgaas@google.com, apopple@nvidia.com, leonro@nvidia.com, gregkh@linuxfoundation.org, tj@kernel.org, rafael@kernel.org, dakr@kernel.org, akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com, kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, houtao1@huawei.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 01/13] PCI/P2PDMA: Release the per-cpu ref of pgmap when
 vm_insert_page() fails
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251222_085010_363868_B609FA81 
X-CRM114-Status: UNSURE (   9.19  )
X-CRM114-Notice: Please train this message.
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



On 2025-12-19 21:04, Hou Tao wrote:
> From: Hou Tao <houtao1@huawei.com>
> 
> When vm_insert_page() fails in p2pmem_alloc_mmap(), p2pmem_alloc_mmap()
> doesn't invoke percpu_ref_put() to free the per-cpu ref of pgmap
> acquired after gen_pool_alloc_owner(), and memunmap_pages() will hang
> forever when trying to remove the PCIe device.
> 
> Fix it by adding the missed percpu_ref_put().
> 
> Fixes: 7e9c7ef83d78 ("PCI/P2PDMA: Allow userspace VMA allocations through sysfs")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
Nice catch, thanks:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


Logan

