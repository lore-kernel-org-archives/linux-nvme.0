Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A08DC369D9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 02:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7/l9GVH8oaZ2x/wZmAE07T5nSKXUblPl9jjY8D/XDzM=; b=zm9Nq6hrl4KTIBprJPWsqgNyf/
	rjiy7CLn1i7hXiOztTshSppTnNlZY3gDnKZ49YGtwLOla4ArBzdsMqfxY+6f8pikojZ37d+fgSPF/
	sGwKJeA1ENUirAteecnXYDpsjvcLeCouY7B1AxMD1XF8aWFz26dedo06ihtf9NUW3g8mzHA0sGLLZ
	SbSfzpmY3X0x38xR2ftZiJNvQONqydLFwZdTsJA+JYUrdi4iZ9vEthszzzwqSrivGZtlul9TE+i8o
	kGlZgwLLGjO7MwKXEcsfEhFsFvYbIzfXP6EaEZhpJNYW0DBDEMHrp3b0uCzSZrdOPpwdEOjGmS6an
	qLnT3BdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9ajs-000000086BT-2VwU;
	Tue, 29 Apr 2025 02:30:28 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9aSy-000000083pe-0lyO
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 02:13:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745892780; x=1777428780;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zIBZEkzEz0qHWJg5nnrZmToWJe3AlL91ty8mA9UxuEk=;
  b=LSDNZsQouSEkXKczHes+btHFr3AAbHDchDCTiKcNyHK0cDB20RXiZS1G
   fsZVgQ6mAzFtluSC92b6eYYqttpFVNQaDPzdvmnZw5k2xcBYaRheDUscL
   sgeccaqzdFxDXB6DlniDnt8gJMOORlfKA1y7jmT6qisuvNUUDHm6Oj7Ua
   SEmrEhI+854bTqPiDUpQplCyKtjVkNhxy6f8s8gx+9FFBM9d9bbAVdJ0H
   0sr1UsgdFfuKib7+DhnHA/lvnT6tH5vUN/uL7giKcQcFnxYWyD/rqcSYe
   RWIgnKwwCfUXgyutH+bd3uspW+Gz3oa3M1JAlesgD7NM6Ve+/07o2QKOu
   Q==;
X-CSE-ConnectionGUID: Rvxo7KnbSOuEjfqQl5YFxQ==
X-CSE-MsgGUID: nUo2zfBNTASkK8YQ9hmCsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="47641271"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="47641271"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 19:12:58 -0700
X-CSE-ConnectionGUID: PgtT/sVnTcyJIj7GTIKVrA==
X-CSE-MsgGUID: VBjHGcPQSj2zSMxum7MGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="137721801"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 19:12:50 -0700
Message-ID: <c0d729e4-1082-486c-9aac-39ae1a2bbd41@linux.intel.com>
Date: Tue, 29 Apr 2025 10:08:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 01/24] PCI/P2PDMA: Refactor the p2pdma mapping helpers
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Jake Edge <jake@lwn.net>, Jonathan Corbet <corbet@lwn.net>,
 Jason Gunthorpe <jgg@ziepe.ca>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
 Yishai Hadas <yishaih@nvidia.com>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 Kevin Tian <kevin.tian@intel.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 kvm@vger.kernel.org, linux-mm@kvack.org,
 Niklas Schnelle <schnelle@linux.ibm.com>,
 Chuck Lever <chuck.lever@oracle.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, Dan Williams
 <dan.j.williams@intel.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
References: <cover.1745831017.git.leon@kernel.org>
 <3ad16e0fc3b8f66593a837c9cdcd34bda1e1ab22.1745831017.git.leon@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3ad16e0fc3b8f66593a837c9cdcd34bda1e1ab22.1745831017.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_191300_240819_342A2A48 
X-CRM114-Status: GOOD (  14.71  )
X-Mailman-Approved-At: Mon, 28 Apr 2025 19:30:27 -0700
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

On 4/28/25 17:22, Leon Romanovsky wrote:
> From: Christoph Hellwig<hch@lst.de>
> 
> The current scheme with a single helper to determine the P2P status
> and map a scatterlist segment force users to always use the map_sg
> helper to DMA map, which we're trying to get away from because they
> are very cache inefficient.
> 
> Refactor the code so that there is a single helper that checks the P2P
> state for a page, including the result that it is not a P2P page to
> simplify the callers, and a second one to perform the address translation
> for a bus mapped P2P transfer that does not depend on the scatterlist
> structure.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Logan Gunthorpe<logang@deltatee.com>
> Acked-by: Bjorn Helgaas<bhelgaas@google.com>
> Tested-by: Jens Axboe<axboe@kernel.dk>
> Reviewed-by: Luis Chamberlain<mcgrof@kernel.org>
> Signed-off-by: Leon Romanovsky<leonro@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

