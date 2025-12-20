Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8347BE67487
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Dec 2025 22:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=b5CFWlDMqsIScBlEIMUKaG7tzcNFXOWKVBL9cRce8VM=; b=Wv4SIaa6dribxcm1o3r8oEbpOm
	A8zKGpHvBfDUL8HYr0eMmueoDCB5JAmwbZF0mwK54UxobSLaamtJutrDVXAOZl3WktsU20VzvUmsv
	3K/fkMjMa3Wc7mgzlCpr5ziviuON7SskzggM7d2SqEhRLinhhe6uhv7TzcKtGCIxM5TDsz/rNN/Un
	gtf8XuWMH8Y5x2tCa7zIPL/fyi0VgFj3lQGf2F0zmLwUzSuuRfHbpuuQsDl1EGztQxfz2BUIjcGSB
	gJQK1uh7hn2kSSWk2nWrOFH99l3XjEqPJIwFnsWy2CgFOTdggM6FhLnG66GqfTxiDB9lZRrAgsyZm
	6BKFi9eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vX5Lo-0000000BwYa-0UDR;
	Sat, 20 Dec 2025 22:23:00 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vX5Lj-0000000BwYA-394z
	for linux-nvme@lists.infradead.org;
	Sat, 20 Dec 2025 22:22:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766269376; x=1797805376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R1Jaj/KasLrmbIdCFUgBGCNzU9HfFfRLRQd1chPkPq0=;
  b=MyxX/oZNGgbR3bNe0M/GVqu+2yl0YjEFUo/hHRojtWPaUxwV4mJaRDUt
   sEQBpHgA2UYdl6lyygNoiOLggU7coXw44e1AF7nuvpCbkW6XYl1Qc55Xg
   /lIXu2TF646+fUsH7DrVy+THlH8kig4dq1KEeERekuBZB1rTmZghjeNqV
   S1qzvoM5Nd7Gqs9o/Hem5C3UlhLZbRAvp6z8P1Vpj35w+iw9k1EtEb8TN
   cad2F7xHNBbpeAINMECJN/GkWo0C45BCmA2h1kvFkoc8mQDmjK5RAagvv
   igBOAz2pZVISFElaETNTjkfrygXss4UpnJvGZDwslLOHG8u/fwVMppbEg
   w==;
X-CSE-ConnectionGUID: seYUqaRMT2qRz48S3rSZRg==
X-CSE-MsgGUID: dqTmE/PUQP6eUpwlXfy1hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11648"; a="78823170"
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="78823170"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2025 14:22:52 -0800
X-CSE-ConnectionGUID: qLYGld/lTLavhGxUh1bGbQ==
X-CSE-MsgGUID: 4olp1ytkSrKr/eW1miFBHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,164,1763452800"; 
   d="scan'208";a="199211875"
Received: from lkp-server01.sh.intel.com (HELO 0d09efa1b85f) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 20 Dec 2025 14:22:46 -0800
Received: from kbuild by 0d09efa1b85f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vX5LX-000000005AD-3uuB;
	Sat, 20 Dec 2025 22:22:43 +0000
Date: Sun, 21 Dec 2025 06:22:10 +0800
From: kernel test robot <lkp@intel.com>
To: Hou Tao <houtao@huaweicloud.com>, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-mm@kvack.org, linux-nvme@lists.infradead.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Alistair Popple <apopple@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	houtao1@huawei.com
Subject: Re: [PATCH 12/13] nvme-pci: introduce cmb_devmap_align module
 parameter
Message-ID: <202512210635.b7EdhXBT-lkp@intel.com>
References: <20251220040446.274991-13-houtao@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220040446.274991-13-houtao@huaweicloud.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251220_142255_834078_B2CA6953 
X-CRM114-Status: GOOD (  15.32  )
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

Hi Hou,

kernel test robot noticed the following build errors:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on driver-core/driver-core-next driver-core/driver-core-linus akpm-mm/mm-everything linus/master v6.19-rc1 next-20251219]
[cannot apply to pci/next pci/for-linus]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Hou-Tao/PCI-P2PDMA-Release-the-per-cpu-ref-of-pgmap-when-vm_insert_page-fails/20251220-121804
base:   driver-core/driver-core-testing
patch link:    https://lore.kernel.org/r/20251220040446.274991-13-houtao%40huaweicloud.com
patch subject: [PATCH 12/13] nvme-pci: introduce cmb_devmap_align module parameter
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20251221/202512210635.b7EdhXBT-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512210635.b7EdhXBT-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512210635.b7EdhXBT-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/pci.c: In function 'nvme_map_cmb':
>> drivers/nvme/host/pci.c:2319:54: error: passing argument 1 of 'pci_p2pdma_max_pagemap_align' makes integer from pointer without a cast [-Wint-conversion]
    2319 |                 align = pci_p2pdma_max_pagemap_align(pdev, bar, size, offset);
         |                                                      ^~~~
         |                                                      |
         |                                                      struct pci_dev *
   In file included from include/linux/blk-mq-dma.h:6,
                    from drivers/nvme/host/pci.c:10:
   include/linux/pci-p2pdma.h:232:67: note: expected 'resource_size_t' {aka 'long long unsigned int'} but argument is of type 'struct pci_dev *'
     232 | static inline size_t pci_p2pdma_max_pagemap_align(resource_size_t start,
         |                                                   ~~~~~~~~~~~~~~~~^~~~~
>> drivers/nvme/host/pci.c:2319:25: error: too many arguments to function 'pci_p2pdma_max_pagemap_align'; expected 3, have 4
    2319 |                 align = pci_p2pdma_max_pagemap_align(pdev, bar, size, offset);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~                  ~~~~~~
   include/linux/pci-p2pdma.h:232:22: note: declared here
     232 | static inline size_t pci_p2pdma_max_pagemap_align(resource_size_t start,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/pci_p2pdma_max_pagemap_align +2319 drivers/nvme/host/pci.c

  2267	
  2268	static void nvme_map_cmb(struct nvme_dev *dev)
  2269	{
  2270		u64 size, offset;
  2271		resource_size_t bar_size;
  2272		struct pci_dev *pdev = to_pci_dev(dev->dev);
  2273		size_t align;
  2274		int bar;
  2275	
  2276		if (dev->cmb_size)
  2277			return;
  2278	
  2279		if (NVME_CAP_CMBS(dev->ctrl.cap))
  2280			writel(NVME_CMBMSC_CRE, dev->bar + NVME_REG_CMBMSC);
  2281	
  2282		dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
  2283		if (!dev->cmbsz)
  2284			return;
  2285		dev->cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
  2286	
  2287		size = nvme_cmb_size_unit(dev) * nvme_cmb_size(dev);
  2288		offset = nvme_cmb_size_unit(dev) * NVME_CMB_OFST(dev->cmbloc);
  2289		bar = NVME_CMB_BIR(dev->cmbloc);
  2290		bar_size = pci_resource_len(pdev, bar);
  2291	
  2292		if (offset > bar_size)
  2293			return;
  2294	
  2295		/*
  2296		 * Controllers may support a CMB size larger than their BAR, for
  2297		 * example, due to being behind a bridge. Reduce the CMB to the
  2298		 * reported size of the BAR
  2299		 */
  2300		size = min(size, bar_size - offset);
  2301	
  2302		if (!IS_ALIGNED(size, memremap_compat_align()) ||
  2303		    !IS_ALIGNED(pci_resource_start(pdev, bar),
  2304				memremap_compat_align()))
  2305			return;
  2306	
  2307		/*
  2308		 * Tell the controller about the host side address mapping the CMB,
  2309		 * and enable CMB decoding for the NVMe 1.4+ scheme:
  2310		 */
  2311		if (NVME_CAP_CMBS(dev->ctrl.cap)) {
  2312			hi_lo_writeq(NVME_CMBMSC_CRE | NVME_CMBMSC_CMSE |
  2313				     (pci_bus_address(pdev, bar) + offset),
  2314				     dev->bar + NVME_REG_CMBMSC);
  2315		}
  2316	
  2317		align = cmb_devmap_align;
  2318		if (!align)
> 2319			align = pci_p2pdma_max_pagemap_align(pdev, bar, size, offset);
  2320		if (pci_p2pdma_add_resource(pdev, bar, size, align, offset)) {
  2321			dev_warn(dev->ctrl.device,
  2322				 "failed to register the CMB\n");
  2323			hi_lo_writeq(0, dev->bar + NVME_REG_CMBMSC);
  2324			return;
  2325		}
  2326	
  2327		dev->cmb_size = size;
  2328		dev->cmb_use_sqes = use_cmb_sqes && (dev->cmbsz & NVME_CMBSZ_SQS);
  2329	
  2330		if ((dev->cmbsz & (NVME_CMBSZ_WDS | NVME_CMBSZ_RDS)) ==
  2331				(NVME_CMBSZ_WDS | NVME_CMBSZ_RDS))
  2332			pci_p2pmem_publish(pdev, true);
  2333	}
  2334	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

