Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A8EC83F1A
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 15:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GI+JXygN5U5M/N6ED92DZAHfTChOi9pdxkrISHrxZBc=; b=hnxwPYYLmUcsF961BS1cPO+PnJ
	he+ztwtxtz0J6dHwEw4Tr/Q6sJ09e/eijz4AXWTudPUjUychpbMeWLvcruMBXuHis5SzlUC59u3uW
	o5ef+uf+re73h9uCDm2RoBL480zgDXPBWRJXBNE4BqUiXR5c7YN7nM+IlKwvmjNxfafmY8WHfYPnE
	4ggwpr/cYS22TXj9PQfoS6kJVuz3vBH3NLPlssxdf9t4a7jhNNV2ptgxYVM7lgio9VgtA4P4xDe+Q
	cmu4m6sIKuHFSRmdiKuJQQZNd8frwB/FFjvpXg6Uo8U53FyPr0cUn7r4oFaFhaqOf4PRwBY+15HQo
	/6NdM1kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQhN-0000000AWVW-0Cna;
	Thu, 17 Jul 2025 15:39:05 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQDL-0000000ATdz-2oLJ
	for linux-nvme@bombadil.infradead.org;
	Thu, 17 Jul 2025 15:08:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=GI+JXygN5U5M/N6ED92DZAHfTChOi9pdxkrISHrxZBc=; b=ZSFQmarlzYZ57KvIpNABKaPt8P
	KOzdFe5Z4TmOyy5SDqZgcQkwLyhzHc5VvSyEfbXCe/QNyaKYsHvplLrKk+SMkobP4d/buRdKHpC//
	UPgFfWyS3qy5xPEKEusFK4Bn4VxAvHeJwUT7DkMldERKASy5JhVNLxVziUBjfRcvzziAzEtzkabC1
	1zI/dwjHXDcglcy3aGYJJjazH2vbKCxL0BWnxfC58mW3gXzt9WrJLsdLxFJwPCd0zguQVTsAJ1sOW
	JDdcE8EP1Jz6OIeGFmfixEN/HRwFXg2UPVXhOgJl2//vUqOfpFrs6T+P26f3BW5m9k+zcPxUkPFRN
	KqxkKklw==;
Received: from mgamail.intel.com ([198.175.65.16])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucQDH-0000000AIEO-3En0
	for linux-nvme@lists.infradead.org;
	Thu, 17 Jul 2025 15:08:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752764880; x=1784300880;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=gDtbsHccbGCjgR2YEojc/A+klQME8+brY5v68iysq58=;
  b=HIMkvKDiPu6+T7WGMCnpJwSWX79u/QEHwruiKASQLalATmZ1DHaAPULp
   Co3vgcFXcco7ohMdv+IUX2Yv7H02n7qAemwwlrCwcNnC+NqYUH2OUrg1j
   GjxZdJEABYJyESizQBZBib/BGWvTziwWrnuyTmG4kghhDrCpcYMDjYmvO
   0tQHhVr/MFtNbKOlcBwmvqMrlZ0hgBfXCVWOkrFq2PJhTb/uJQ6Pr30H2
   Hul56SIl5uu4DJUD//VNNXQQ4Hz0HzBkL7QgI7Kuimn6eMqko2eP/HuQn
   XvFrgrSwCN2E28Raq9nBe7dE8eIeugOLhFMM8gsbyjJya4/jHpXlqJhuD
   A==;
X-CSE-ConnectionGUID: Z03G/hHmR0uZy64+sZfQhg==
X-CSE-MsgGUID: K4IRU8iBTuaNafpkKU9dlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11495"; a="55195166"
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="55195166"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2025 08:07:56 -0700
X-CSE-ConnectionGUID: Oez6G63uTii/XtWyc/7zXw==
X-CSE-MsgGUID: adQXDjSPQ4mUpDqzSG6BcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,319,1744095600"; 
   d="scan'208";a="181522588"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 17 Jul 2025 08:07:54 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ucQDA-000DkF-0i;
	Thu, 17 Jul 2025 15:07:52 +0000
Date: Thu, 17 Jul 2025 23:06:57 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: [linux-nvme:nvme-6.17 8/8] drivers/nvme/host/pci.c:2086:26: error:
 passing argument 1 of '_dev_info' from incompatible pointer type
Message-ID: <202507172219.3GZVetEC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250717_160800_469056_2C4B0031 
X-CRM114-Status: GOOD (  15.63  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.17
head:   1ab5ce2790f41c2966a549eeafde8f3abd46d46d
commit: 1ab5ce2790f41c2966a549eeafde8f3abd46d46d [8/8] nvme-pci: try function level reset on init failure
config: csky-randconfig-001-20250717 (https://download.01.org/0day-ci/archive/20250717/202507172219.3GZVetEC-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250717/202507172219.3GZVetEC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507172219.3GZVetEC-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/acpi.h:14,
                    from drivers/nvme/host/pci.c:7:
   drivers/nvme/host/pci.c: In function 'nvme_pci_configure_admin_queue':
>> drivers/nvme/host/pci.c:2086:26: error: passing argument 1 of '_dev_info' from incompatible pointer type [-Wincompatible-pointer-types]
    2086 |                 dev_info(&dev->ctrl.device,
         |                          ^~~~~~~~~~~~~~~~~
         |                          |
         |                          struct device **
   include/linux/dev_printk.h:110:25: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                         ^~~
   drivers/nvme/host/pci.c:2086:17: note: in expansion of macro 'dev_info'
    2086 |                 dev_info(&dev->ctrl.device,
         |                 ^~~~~~~~
   include/linux/dev_printk.h:56:37: note: expected 'const struct device *' but argument is of type 'struct device **'
      56 | void _dev_info(const struct device *dev, const char *fmt, ...);
         |                ~~~~~~~~~~~~~~~~~~~~~^~~


vim +/_dev_info +2086 drivers/nvme/host/pci.c

  2041	
  2042	static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
  2043	{
  2044		int result;
  2045		u32 aqa;
  2046		struct nvme_queue *nvmeq;
  2047	
  2048		result = nvme_remap_bar(dev, db_bar_size(dev, 0));
  2049		if (result < 0)
  2050			return result;
  2051	
  2052		dev->subsystem = readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 1, 0) ?
  2053					NVME_CAP_NSSRC(dev->ctrl.cap) : 0;
  2054	
  2055		if (dev->subsystem &&
  2056		    (readl(dev->bar + NVME_REG_CSTS) & NVME_CSTS_NSSRO))
  2057			writel(NVME_CSTS_NSSRO, dev->bar + NVME_REG_CSTS);
  2058	
  2059		/*
  2060		 * If the device has been passed off to us in an enabled state, just
  2061		 * clear the enabled bit.  The spec says we should set the 'shutdown
  2062		 * notification bits', but doing so may cause the device to complete
  2063		 * commands to the admin queue ... and we don't know what memory that
  2064		 * might be pointing at!
  2065		 */
  2066		result = nvme_disable_ctrl(&dev->ctrl, false);
  2067		if (result < 0) {
  2068			struct pci_dev *pdev = to_pci_dev(dev->dev);
  2069	
  2070			/*
  2071			 * The NVMe Controller Reset method did not get an expected
  2072			 * CSTS.RDY transition, so something with the device appears to
  2073			 * be stuck. Use the lower level and bigger hammer PCIe
  2074			 * Function Level Reset to attempt restoring the device to its
  2075			 * initial state, and try again.
  2076			 */
  2077			result = pcie_reset_flr(pdev, false);
  2078			if (result < 0)
  2079				return result;
  2080	
  2081			pci_restore_state(pdev);
  2082			result = nvme_disable_ctrl(&dev->ctrl, false);
  2083			if (result < 0)
  2084				return result;
  2085	
> 2086			dev_info(&dev->ctrl.device,
  2087				"controller reset completed after pcie flr\n");
  2088		}
  2089	
  2090		result = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
  2091		if (result)
  2092			return result;
  2093	
  2094		dev->ctrl.numa_node = dev_to_node(dev->dev);
  2095	
  2096		nvmeq = &dev->queues[0];
  2097		aqa = nvmeq->q_depth - 1;
  2098		aqa |= aqa << 16;
  2099	
  2100		writel(aqa, dev->bar + NVME_REG_AQA);
  2101		lo_hi_writeq(nvmeq->sq_dma_addr, dev->bar + NVME_REG_ASQ);
  2102		lo_hi_writeq(nvmeq->cq_dma_addr, dev->bar + NVME_REG_ACQ);
  2103	
  2104		result = nvme_enable_ctrl(&dev->ctrl);
  2105		if (result)
  2106			return result;
  2107	
  2108		nvmeq->cq_vector = 0;
  2109		nvme_init_queue(nvmeq, 0);
  2110		result = queue_request_irq(nvmeq);
  2111		if (result) {
  2112			dev->online_queues--;
  2113			return result;
  2114		}
  2115	
  2116		set_bit(NVMEQ_ENABLED, &nvmeq->flags);
  2117		return result;
  2118	}
  2119	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

