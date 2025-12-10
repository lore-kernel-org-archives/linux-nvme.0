Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C29DD3E76E
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Dec 2025 19:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMHWfs8vkj+6UQ9dcyX/h3srKGVBDZlwtktqtkh9tjo=; b=o1UdrF+3ILXyLhfUoEx/vDinzX
	xTbxN+vZbMlUqA2c+sRlhP5xdVzKcAvvIFS1Kt/PIGm79h5TTQS/RQ6ELnRBKeXMowvw+q1/V4jjp
	ChEUqZvMDiKZ+onckcJIA5v062HpcP3UBZ7BX3dRkAYV6Gxb4zBKAy29AZyjOGxx/4/MEiT4XimjA
	qg/JiBMExYfZces3CStF93i/1YsbjKIVsJtZQoN9Y+XPxsh4a5MlHofva0uZeSNGgnp+ONN7lHo8b
	yCFwL630e4AzEUvgI6+tp1cZzGcGyrYKOJ2j3QZxmgnJ0zBOIwbOUfaCnQ2ZOz6ovmDyh5QiN/vC/
	n+P8Dl/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTPVe-0000000FleN-2j5J;
	Wed, 10 Dec 2025 19:05:58 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTPVb-0000000Flds-0OtF;
	Wed, 10 Dec 2025 19:05:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765393555; x=1796929555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=boHYArrLfilo5Sv64y0CaCmooWdnIhESwdLtZzAruxg=;
  b=a9PcpBPyDfbPl8XBiPYbX9ATxhCNFMWX/m3PtzW39DGliL3aDrGVqv2b
   MnfxqmLaufS+jty4Us+dkMfe8lCpBRR2QkV+23nCG7DSR8L9nZ1Ro2w7d
   Aejsbowtoyff1W0PifDs5G6NYARfqsD1/drukQy7Boq9YiLW+0eYRaglP
   +6HczP/WyInQvm3JXW2hRRhQbsk8ImJsFJbNP7TwV7e2h10pFBY1CW1jy
   4+6w/ifXThsOOI3VzKSkKsSF6Tv6UfV+nMSNQCdmzdRI3TAu8ZJV7ZMNR
   Rv6bYR6fP6D9LfmX9qziTPFT2Kw0efw0Vqm7XOe/jle4F/VkIqxmw6x8/
   Q==;
X-CSE-ConnectionGUID: FNCBd6biScSyCXkCZ7IZ6w==
X-CSE-MsgGUID: vSE2ouEkTUGyqJnGTIOG8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11638"; a="54917271"
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="54917271"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2025 11:05:53 -0800
X-CSE-ConnectionGUID: Etk4k57vSziwm/yZiYAtjg==
X-CSE-MsgGUID: h4VcFQvCTOSLNUrttT2hvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,264,1758610800"; 
   d="scan'208";a="201029660"
Received: from lkp-server01.sh.intel.com (HELO d335e3c6db51) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 10 Dec 2025 11:05:48 -0800
Received: from kbuild by d335e3c6db51 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vTPVR-000000003fJ-2YeN;
	Wed, 10 Dec 2025 19:05:45 +0000
Date: Thu, 11 Dec 2025 03:05:08 +0800
From: kernel test robot <lkp@intel.com>
To: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Koichiro Den <den@valinux.co.jp>, Niklas Cassel <cassel@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
	mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH 6/8] nvmet: pci-epf: Use
 dmaengine_prep_slave_single_config() API
Message-ID: <202512110249.kCiMC4sb-lkp@intel.com>
References: <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-dma_prep_config-v1-6-53490c5e1e2a@nxp.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251210_110555_219125_BFA4BCA8 
X-CRM114-Status: GOOD (  10.18  )
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

Hi Frank,

kernel test robot noticed the following build warnings:

[auto build test WARNING on bc04acf4aeca588496124a6cf54bfce3db327039]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/dmaengine-Add-API-to-combine-configuration-and-preparation-sg-and-single/20251209-011820
base:   bc04acf4aeca588496124a6cf54bfce3db327039
patch link:    https://lore.kernel.org/r/20251208-dma_prep_config-v1-6-53490c5e1e2a%40nxp.com
patch subject: [PATCH 6/8] nvmet: pci-epf: Use dmaengine_prep_slave_single_config() API
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20251211/202512110249.kCiMC4sb-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251211/202512110249.kCiMC4sb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512110249.kCiMC4sb-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/pci-epf.c: In function 'nvmet_pci_epf_dma_transfer':
>> drivers/nvme/target/pci-epf.c:369:23: warning: variable 'lock' set but not used [-Wunused-but-set-variable]
     369 |         struct mutex *lock;
         |                       ^~~~


vim +/lock +369 drivers/nvme/target/pci-epf.c

0faa0fe6f90ea5 Damien Le Moal 2025-01-04  357  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  358  static int nvmet_pci_epf_dma_transfer(struct nvmet_pci_epf *nvme_epf,
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  359  		struct nvmet_pci_epf_segment *seg, enum dma_data_direction dir)
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  360  {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  361  	struct pci_epf *epf = nvme_epf->epf;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  362  	struct dma_async_tx_descriptor *desc;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  363  	struct dma_slave_config sconf = {};
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  364  	struct device *dev = &epf->dev;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  365  	struct device *dma_dev;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  366  	struct dma_chan *chan;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  367  	dma_cookie_t cookie;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  368  	dma_addr_t dma_addr;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04 @369  	struct mutex *lock;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  370  	int ret;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  371  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  372  	switch (dir) {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  373  	case DMA_FROM_DEVICE:
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  374  		lock = &nvme_epf->dma_rx_lock;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  375  		chan = nvme_epf->dma_rx_chan;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  376  		sconf.direction = DMA_DEV_TO_MEM;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  377  		sconf.src_addr = seg->pci_addr;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  378  		break;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  379  	case DMA_TO_DEVICE:
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  380  		lock = &nvme_epf->dma_tx_lock;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  381  		chan = nvme_epf->dma_tx_chan;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  382  		sconf.direction = DMA_MEM_TO_DEV;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  383  		sconf.dst_addr = seg->pci_addr;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  384  		break;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  385  	default:
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  386  		return -EINVAL;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  387  	}
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  388  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  389  	dma_dev = dmaengine_get_dma_device(chan);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  390  	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  391  	ret = dma_mapping_error(dma_dev, dma_addr);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  392  	if (ret)
f9f42a84df49d9 Frank Li       2025-12-08  393  		return ret;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  394  
f9f42a84df49d9 Frank Li       2025-12-08  395  	desc = dmaengine_prep_slave_single_config(chan, dma_addr, seg->length,
f9f42a84df49d9 Frank Li       2025-12-08  396  						  sconf.direction,
f9f42a84df49d9 Frank Li       2025-12-08  397  						  DMA_CTRL_ACK,
f9f42a84df49d9 Frank Li       2025-12-08  398  						  &sconf);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  399  	if (!desc) {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  400  		dev_err(dev, "Failed to prepare DMA\n");
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  401  		ret = -EIO;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  402  		goto unmap;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  403  	}
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  404  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  405  	cookie = dmaengine_submit(desc);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  406  	ret = dma_submit_error(cookie);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  407  	if (ret) {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  408  		dev_err(dev, "Failed to do DMA submit (err=%d)\n", ret);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  409  		goto unmap;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  410  	}
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  411  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  412  	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  413  		dev_err(dev, "DMA transfer failed\n");
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  414  		ret = -EIO;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  415  	}
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  416  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  417  unmap:
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  418  	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  419  
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  420  	return ret;
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  421  }
0faa0fe6f90ea5 Damien Le Moal 2025-01-04  422  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

