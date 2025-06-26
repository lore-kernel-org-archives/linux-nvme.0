Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5262C7EE33
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Jun 2025 13:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4GEQtP36hhHB+FAQZflaz2XpvW6l60fUy+SAtsk5Y58=; b=uDaRPiiG6QiZXC3ck1quYC+LKv
	KhHoG3/e3Hu/LOcWXls4OT/ex+z+LH2uio+DdseOuQ9QQjCvxZ5z0EhTIK9l1BwUma/gI9GtESEvK
	Ymrwlnxb71vBy1OQ5W9V1PkfRFbPyFPR5O9NgPcquT6DoKFgUv/Boc/PP0h7djrkm1C6QDFrHlLl1
	pvmfY1b7wZwQarXuD04AQ8IxMWu32DJegq2OWC5KcuuctVNEIOETMwV67sv7ekYmBaYl+3P0NW2rr
	C2HsuqmukjEN+d18epi/fBzIVMN5nJw2+Eu24Fl9bO7iRVTrROjuCyu7qefLb9zA8FG7+2abtgACH
	8XU7oQrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUn72-0000000BpWV-2aa0;
	Thu, 26 Jun 2025 13:58:00 +0000
Received: from mgamail.intel.com ([192.198.163.13])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUn5Q-0000000BoRd-2Daf
	for linux-nvme@lists.infradead.org;
	Thu, 26 Jun 2025 13:56:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750946180; x=1782482180;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0vH2/a2V/VmECZw9K44tTUEb5rQkCM220FNYyTlA5C4=;
  b=RDI55s+QE17je5BPmTfs5/KEGcDydDOe9OIGL25uXiJ9kYmrItRZ+0qs
   v+9axcdM1S7z7iAtNyRgUD9/Ikt489cdnxGS7M5KIw0ltEbnJYgrbi3jz
   8fnXPRFujdFqYig1hOTbEoyQpwjX4vDf7LNpmC9uii1oSGaPmPgtnT8ly
   Z9mOL+uXIZkydLsrNr9FAevGRUcrvyWKuV++F6OSm0MrL+s1K6OE7pqO0
   8A9Zx7fru2oJDDb0aSt+hmvOvfNdOL4GaC7jYGIO4lCZbgtho2/iZJHA7
   TBqKunPCeVqgcBPQfsPR25L/ckWl7h94bua7lDXvNHUSqxCiv1VE2gN8O
   Q==;
X-CSE-ConnectionGUID: iVc1cGSQTCOZiSkZJtbu2A==
X-CSE-MsgGUID: 2fJRNT2ySgSx6DnY1ToYyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="55867920"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="55867920"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 06:56:20 -0700
X-CSE-ConnectionGUID: +PyM5SRpQpuX+koisJ8KSQ==
X-CSE-MsgGUID: Jdwi+C/aSXWmjvua9Le/Jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="152683922"
Received: from lkp-server01.sh.intel.com (HELO e8142ee1dce2) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 26 Jun 2025 06:56:17 -0700
Received: from kbuild by e8142ee1dce2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uUn5K-000U70-2O;
	Thu, 26 Jun 2025 13:56:14 +0000
Date: Thu, 26 Jun 2025 21:55:27 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, hch@lst.de,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, axboe@kernel.dk,
	leon@kernel.org, joshi.k@samsung.com, sagi@grimberg.me,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
Message-ID: <202506262136.WXl2reWF-lkp@intel.com>
References: <20250625204445.1802483-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625204445.1802483-1-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250626_065620_575157_5D60F82D 
X-CRM114-Status: GOOD (  11.93  )
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

Hi Keith,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on next-20250626]
[cannot apply to linux-nvme/for-next hch-configfs/for-next linus/master v6.16-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/nvme-convert-metadata-mapping-to-dma-iter/20250626-044623
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20250625204445.1802483-1-kbusch%40meta.com
patch subject: [PATCH 1/2] blk-integrity: add scatter-less DMA mapping helpers
config: x86_64-buildonly-randconfig-002-20250626 (https://download.01.org/0day-ci/archive/20250626/202506262136.WXl2reWF-lkp@intel.com/config)
compiler: clang version 20.1.7 (https://github.com/llvm/llvm-project 6146a88f60492b520a36f8f8f3231e15f3cc6082)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250626/202506262136.WXl2reWF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202506262136.WXl2reWF-lkp@intel.com/

All errors (new ones prefixed by >>):

>> block/blk-integrity.c:194:19: error: use of undeclared identifier 'blk_rq_integrity_map_iter_start'
     194 | EXPORT_SYMBOL_GPL(blk_rq_integrity_map_iter_start);
         |                   ^
   1 error generated.


vim +/blk_rq_integrity_map_iter_start +194 block/blk-integrity.c

   165	
   166	bool blk_rq_integrity_dma_map_iter_start(struct request *req,
   167			struct device *dma_dev, struct blk_dma_iter *iter)
   168	{
   169		struct bio_integrity_payload *bip = bio_integrity(req->bio);
   170		struct phys_vec vec;
   171	
   172		iter->iter.bio = req->bio;
   173		iter->iter.iter = bip->bip_iter;
   174		memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
   175		iter->status = BLK_STS_OK;
   176	
   177		if (!blk_rq_integrity_map_iter_next(req, &iter->iter, &vec))
   178			return false;
   179	
   180		switch (pci_p2pdma_state(&iter->p2pdma, dma_dev,
   181					phys_to_page(vec.paddr))) {
   182		case PCI_P2PDMA_MAP_BUS_ADDR:
   183			return blk_dma_map_bus(iter, &vec);
   184		case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
   185		case PCI_P2PDMA_MAP_NONE:
   186			break;
   187		default:
   188			iter->status = BLK_STS_INVAL;
   189			return false;
   190		}
   191	
   192		return blk_dma_map_direct(req, dma_dev, iter, &vec);
   193	}
 > 194	EXPORT_SYMBOL_GPL(blk_rq_integrity_map_iter_start);
   195	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

