Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E447C369DC
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Apr 2025 18:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=40qnOm9mTXtPG1vqoiNFNvehk4lGHdTUmkFA0VZ14ec=; b=BaC2k73xNFlOKaPHcckwxrlh5d
	qmoMLrfoT0W/MntPog8dGhf9/uSNiTuBRT7tra2GWiBldLyvSksvibp+13HVeeB7iJUsu7XSrP9KY
	jpmbBYZ1lEMDq8CBAm5ApfLKaHh8NRwuFeIFRBuEbeSDLCBluXen9k+VW89/IRbJDeZVytbOnZyKj
	9ba7DlFLQNTFN/444JcnDxBw71942lV7C3O+5PTV7lHKQj3EUAn5PpwGLxZxUpTP3qk02qh6aH6Vq
	7r9O3X7epUu23gZr7CNl7IqscKnMOEo2Uosp7TQimDNJ2HbyOk+XpcXNiJxRJvMUi58QOoKHyUJRa
	8mCoXCog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9pbY-0000000AW71-1Zni;
	Tue, 29 Apr 2025 18:22:52 +0000
Received: from mgamail.intel.com ([198.175.65.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9avD-000000087Co-3pqH
	for linux-nvme@lists.infradead.org;
	Tue, 29 Apr 2025 02:42:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745894532; x=1777430532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JEB13Q6qCJ3b8dvOA+ykH/XIbk5dBywfURD7c4iY0Ts=;
  b=Q8QhjQYS24waaN/SWgpvOP0bm6SkSh6m9QIOTyXOwxAQkSGvaaUNhlE2
   xIc2K0zbFWQxC9e89+wglhnGRCLjOvftQjBzZnn+CSXhK0WagBOyjdkF7
   9iByWTKjuTeahNIZjEl5u7SBlXW4IyQ0Bfr3YzM6tz7oha6GA+tso3Kyd
   4pwc359bRKvoTOpG7QiYLnzZ7+5knPWlYrZaSoByyZDqYOTIVfrwVW+Mp
   oIIjfiopIKBUGtRqaSkc+o82ZsVJh9UzPfVujcwv5dS9zjEb0k0OYysbv
   kUJ+oinmQWgpgOtkxMi9X2SSJ3Ug1ngND9aJxCYFfwGjQCSqubNqcOzgz
   Q==;
X-CSE-ConnectionGUID: JBrYST2sRQKcQKnn6oqThQ==
X-CSE-MsgGUID: jA4ktoqxS/i+RWt3OCldTg==
X-IronPort-AV: E=McAfee;i="6700,10204,11417"; a="58492546"
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="58492546"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 19:42:11 -0700
X-CSE-ConnectionGUID: cHWLk+ReRtiizI2k9hpzsQ==
X-CSE-MsgGUID: QL4CnKgYSfSVf8FrilpuPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,247,1739865600"; 
   d="scan'208";a="134208058"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2025 19:42:03 -0700
Message-ID: <73184520-4853-49cb-a3e2-8bb7311c91e1@linux.intel.com>
Date: Tue, 29 Apr 2025 10:37:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 04/24] iommu: add kernel-doc for iommu_unmap_fast
To: Leon Romanovsky <leon@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jake Edge <jake@lwn.net>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, Bjorn Helgaas <bhelgaas@google.com>,
 Logan Gunthorpe <logang@deltatee.com>, Yishai Hadas <yishaih@nvidia.com>,
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
 Chaitanya Kulkarni <kch@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
References: <cover.1745831017.git.leon@kernel.org>
 <6c4bbb539bec7b827b9e9cc24779c9e9c43fc3ed.1745831017.git.leon@kernel.org>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <6c4bbb539bec7b827b9e9cc24779c9e9c43fc3ed.1745831017.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250428_194211_995033_1F19FC75 
X-CRM114-Status: UNSURE (   8.07  )
X-CRM114-Notice: Please train this message.
X-Mailman-Approved-At: Tue, 29 Apr 2025 11:22:51 -0700
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
> From: Leon Romanovsky<leonro@nvidia.com>
> 
> Add kernel-doc section for iommu_unmap_fast to document existing
> limitation of underlying functions which can't split individual ranges.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Acked-by: Will Deacon<will@kernel.org>
> Reviewed-by: Christoph Hellwig<hch@lst.de>
> Tested-by: Jens Axboe<axboe@kernel.dk>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Luis Chamberlain<mcgrof@kernel.org>
> Signed-off-by: Leon Romanovsky<leonro@nvidia.com>

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

