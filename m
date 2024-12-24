Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF833E77188
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 23:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W4fMlJoPyAMUD3E8zRT8tc88Js9UranPAz7HKoikRR0=; b=TE9RvYGFAFpUYoCM6Q/UG1NS7d
	OJBzd1cLk0R6X4Ezd7HcIaAnHA0iyAxtfqQ5HFR+BaHMUNHgN1mJ+L2/Uiw0wUjYW4t+ZJMcTOQ/8
	N/WT5+v0AAeG7RUeoglnchufxDohcDUYL5n59yOY1+d7bSbxErTiAYHbm3TgcM/IPdhb8/bYW2Ni1
	qOeef7x6DBwS5QFxmtzKauTPrVO0T1/IQK8Z0mHs4LrAekjSsJRXhstBsNC5VXT3rFQqQRQTjwn24
	/m0JS0SE7Q3IfHaeqFoLP4YPYKNQDjEnk8nRoFDMcbCOcWhzu1cnMOhM5ef92Gth9QYgL6uUKwnaU
	6VvmaQyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQEQA-0000000Cwov-1wL5;
	Tue, 24 Dec 2024 23:34:38 +0000
Received: from mgamail.intel.com ([198.175.65.18])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQEQ7-0000000Cwo7-1g8N
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 23:34:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735083275; x=1766619275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YcX2ncLPxYqtSquQR7sTFscPhSUP9EFkasX0QohzZyw=;
  b=SLBzUs84WuNptBJGZ9NP9g98jmPsZtHgxdpDN7Tud72O4fXz2J1qN8D/
   yfz76Cwu+pDhVAvTwyaqjQu0jhSB/vNzl/mCXc6Gpm/ihGlnH05S8pcNs
   4vFEnw7MFhU7zdqZs0sRPVrltq3D4kGPfaWY+DHQ5oTnl5cEcprf0yh33
   +0egqSrjfRSMrGOzrHhIpupC/bSVHOvyXW/uyH1hEgRFL5TfEMmtTYXQ0
   HHaaMl25JDXOrhikIGjTxc/IhTvWlBon4f1yppxmwEdq00jnoOKtS2w9R
   4UnxkYz8ItbAhYa9k2WgFcO6nHNU3CCMe2N8XMAv8yr6vr+dBRlVY3XLU
   A==;
X-CSE-ConnectionGUID: hQwr3WCbTUGaNp3YLHgYjQ==
X-CSE-MsgGUID: tr2yAEcIQv+U0H/XICaX4w==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35666616"
X-IronPort-AV: E=Sophos;i="6.12,261,1728975600"; 
   d="scan'208";a="35666616"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Dec 2024 15:34:29 -0800
X-CSE-ConnectionGUID: qGB9eT7LRHaBVTor91LYvQ==
X-CSE-MsgGUID: 7+Y8jl4KTa+zdQR9fHs2tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="100057210"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Dec 2024 15:34:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tQEPu-0001X1-2j;
	Tue, 24 Dec 2024 23:34:22 +0000
Date: Wed, 25 Dec 2024 07:34:19 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v7 17/18] nvmet: New NVMe PCI endpoint function target
 driver
Message-ID: <202412250700.WqUH4KaL-lkp@intel.com>
References: <20241220095108.601914-18-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220095108.601914-18-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_153435_524018_ACE1A566 
X-CRM114-Status: GOOD (  13.78  )
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

Hi Damien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvme-Move-opcode-string-helper-functions-declarations/20241220-175304
base:   78d4f34e2115b517bcbfe7ec0d018bbbb6f9b0b8
patch link:    https://lore.kernel.org/r/20241220095108.601914-18-dlemoal%40kernel.org
patch subject: [PATCH v7 17/18] nvmet: New NVMe PCI endpoint function target driver
config: i386-randconfig-011-20241225 (https://download.01.org/0day-ci/archive/20241225/202412250700.WqUH4KaL-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241225/202412250700.WqUH4KaL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412250700.WqUH4KaL-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/target/pci-epf.c:12:
   In file included from include/linux/dmaengine.h:12:
   In file included from include/linux/scatterlist.h:8:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/nvme/target/pci-epf.c:1854:19: warning: shift count is negative [-Wshift-count-negative]
    1854 |         pci_addr = acq & GENMASK(63, 12);
         |                          ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/pci-epf.c:1864:19: warning: shift count is negative [-Wshift-count-negative]
    1864 |         pci_addr = asq & GENMASK(63, 12);
         |                          ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/target/pci-epf.c:1961:16: warning: shift count >= width of type [-Wshift-count-overflow]
    1961 |         ctrl->cap &= ~GENMASK(35, 32);
         |                       ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:8:31: note: expanded from macro '__GENMASK'
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^  ~~~
   drivers/nvme/target/pci-epf.c:1961:16: warning: shift count is negative [-Wshift-count-negative]
    1961 |         ctrl->cap &= ~GENMASK(35, 32);
         |                       ^~~~~~~~~~~~~~~
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^  ~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/nvme/target/pci-epf.c:753:19: warning: unused function 'nvmet_pci_epf_prp_addr' [-Wunused-function]
     753 | static inline u64 nvmet_pci_epf_prp_addr(struct nvmet_pci_epf_ctrl *ctrl,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   6 warnings generated.


vim +1854 drivers/nvme/target/pci-epf.c

  1817	
  1818	static int nvmet_pci_epf_enable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
  1819	{
  1820		u64 pci_addr, asq, acq;
  1821		u32 aqa;
  1822		u16 status, qsize;
  1823	
  1824		if (ctrl->enabled)
  1825			return 0;
  1826	
  1827		dev_info(ctrl->dev, "Enabling controller\n");
  1828	
  1829		ctrl->mps_shift = nvmet_cc_mps(ctrl->cc) + 12;
  1830		ctrl->mps = 1UL << ctrl->mps_shift;
  1831		ctrl->mps_mask = ctrl->mps - 1;
  1832	
  1833		ctrl->io_sqes = 1UL << nvmet_cc_iosqes(ctrl->cc);
  1834		ctrl->io_cqes = 1UL << nvmet_cc_iocqes(ctrl->cc);
  1835	
  1836		if (ctrl->io_sqes < sizeof(struct nvme_command)) {
  1837			dev_err(ctrl->dev, "Unsupported IO SQES %zu (need %zu)\n",
  1838				ctrl->io_sqes, sizeof(struct nvme_command));
  1839			return -EINVAL;
  1840		}
  1841	
  1842		if (ctrl->io_cqes < sizeof(struct nvme_completion)) {
  1843			dev_err(ctrl->dev, "Unsupported IO CQES %zu (need %zu)\n",
  1844				ctrl->io_sqes, sizeof(struct nvme_completion));
  1845			return -EINVAL;
  1846		}
  1847	
  1848		/* Create the admin queue. */
  1849		aqa = nvmet_pci_epf_bar_read32(ctrl, NVME_REG_AQA);
  1850		asq = nvmet_pci_epf_bar_read64(ctrl, NVME_REG_ASQ);
  1851		acq = nvmet_pci_epf_bar_read64(ctrl, NVME_REG_ACQ);
  1852	
  1853		qsize = (aqa & 0x0fff0000) >> 16;
> 1854		pci_addr = acq & GENMASK(63, 12);
  1855		status = nvmet_pci_epf_create_cq(ctrl->tctrl, 0,
  1856					NVME_CQ_IRQ_ENABLED | NVME_QUEUE_PHYS_CONTIG,
  1857					qsize, pci_addr, 0);
  1858		if (status != NVME_SC_SUCCESS) {
  1859			dev_err(ctrl->dev, "Failed to create admin completion queue\n");
  1860			return -EINVAL;
  1861		}
  1862	
  1863		qsize = aqa & 0x00000fff;
  1864		pci_addr = asq & GENMASK(63, 12);
  1865		status = nvmet_pci_epf_create_sq(ctrl->tctrl, 0, NVME_QUEUE_PHYS_CONTIG,
  1866						 qsize, pci_addr);
  1867		if (status != NVME_SC_SUCCESS) {
  1868			dev_err(ctrl->dev, "Failed to create admin submission queue\n");
  1869			nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
  1870			return -EINVAL;
  1871		}
  1872	
  1873		ctrl->sq_ab = NVMET_PCI_EPF_SQ_AB;
  1874		ctrl->irq_vector_threshold = NVMET_PCI_EPF_IV_THRESHOLD;
  1875		ctrl->enabled = true;
  1876	
  1877		/* Start polling the controller SQs */
  1878		schedule_delayed_work(&ctrl->poll_sqs, 0);
  1879	
  1880		return 0;
  1881	}
  1882	
  1883	static void nvmet_pci_epf_disable_ctrl(struct nvmet_pci_epf_ctrl *ctrl)
  1884	{
  1885		int qid;
  1886	
  1887		if (!ctrl->enabled)
  1888			return;
  1889	
  1890		dev_info(ctrl->dev, "Disabling controller\n");
  1891	
  1892		ctrl->enabled = false;
  1893		cancel_delayed_work_sync(&ctrl->poll_sqs);
  1894	
  1895		/* Delete all IO queues */
  1896		for (qid = 1; qid < ctrl->nr_queues; qid++)
  1897			nvmet_pci_epf_delete_sq(ctrl->tctrl, qid);
  1898	
  1899		for (qid = 1; qid < ctrl->nr_queues; qid++)
  1900			nvmet_pci_epf_delete_cq(ctrl->tctrl, qid);
  1901	
  1902		/* Delete the admin queue last */
  1903		nvmet_pci_epf_delete_sq(ctrl->tctrl, 0);
  1904		nvmet_pci_epf_delete_cq(ctrl->tctrl, 0);
  1905	}
  1906	
  1907	static void nvmet_pci_epf_poll_cc_work(struct work_struct *work)
  1908	{
  1909		struct nvmet_pci_epf_ctrl *ctrl =
  1910			container_of(work, struct nvmet_pci_epf_ctrl, poll_cc.work);
  1911		u32 old_cc, new_cc;
  1912		int ret;
  1913	
  1914		if (!ctrl->tctrl)
  1915			return;
  1916	
  1917		old_cc = ctrl->cc;
  1918		new_cc = nvmet_pci_epf_bar_read32(ctrl, NVME_REG_CC);
  1919		ctrl->cc = new_cc;
  1920	
  1921		if (nvmet_cc_en(new_cc) && !nvmet_cc_en(old_cc)) {
  1922			/* Enable the controller */
  1923			ret = nvmet_pci_epf_enable_ctrl(ctrl);
  1924			if (ret)
  1925				return;
  1926			ctrl->csts |= NVME_CSTS_RDY;
  1927		}
  1928	
  1929		if (!nvmet_cc_en(new_cc) && nvmet_cc_en(old_cc)) {
  1930			nvmet_pci_epf_disable_ctrl(ctrl);
  1931			ctrl->csts &= ~NVME_CSTS_RDY;
  1932		}
  1933	
  1934		if (nvmet_cc_shn(new_cc) && !nvmet_cc_shn(old_cc)) {
  1935			nvmet_pci_epf_disable_ctrl(ctrl);
  1936			ctrl->csts |= NVME_CSTS_SHST_CMPLT;
  1937		}
  1938	
  1939		if (!nvmet_cc_shn(new_cc) && nvmet_cc_shn(old_cc))
  1940			ctrl->csts &= ~NVME_CSTS_SHST_CMPLT;
  1941	
  1942		nvmet_update_cc(ctrl->tctrl, ctrl->cc);
  1943		nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CSTS, ctrl->csts);
  1944	
  1945		schedule_delayed_work(&ctrl->poll_cc, NVMET_PCI_EPF_CC_POLL_INTERVAL);
  1946	}
  1947	
  1948	static void nvmet_pci_epf_init_bar(struct nvmet_pci_epf_ctrl *ctrl)
  1949	{
  1950		struct nvmet_ctrl *tctrl = ctrl->tctrl;
  1951	
  1952		ctrl->bar = ctrl->nvme_epf->reg_bar;
  1953	
  1954		/* Copy the target controller capabilities as a base */
  1955		ctrl->cap = tctrl->cap;
  1956	
  1957		/* Contiguous Queues Required (CQR) */
  1958		ctrl->cap |= 0x1ULL << 16;
  1959	
  1960		/* Set Doorbell stride to 4B (DSTRB) */
> 1961		ctrl->cap &= ~GENMASK(35, 32);
  1962	
  1963		/* Clear NVM Subsystem Reset Supported (NSSRS) */
  1964		ctrl->cap &= ~(0x1ULL << 36);
  1965	
  1966		/* Clear Boot Partition Support (BPS) */
  1967		ctrl->cap &= ~(0x1ULL << 45);
  1968	
  1969		/* Clear Persistent Memory Region Supported (PMRS) */
  1970		ctrl->cap &= ~(0x1ULL << 56);
  1971	
  1972		/* Clear Controller Memory Buffer Supported (CMBS) */
  1973		ctrl->cap &= ~(0x1ULL << 57);
  1974	
  1975		/* Controller configuration */
  1976		ctrl->cc = tctrl->cc & (~NVME_CC_ENABLE);
  1977	
  1978		/* Controller status */
  1979		ctrl->csts = ctrl->tctrl->csts;
  1980	
  1981		nvmet_pci_epf_bar_write64(ctrl, NVME_REG_CAP, ctrl->cap);
  1982		nvmet_pci_epf_bar_write32(ctrl, NVME_REG_VS, tctrl->subsys->ver);
  1983		nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CSTS, ctrl->csts);
  1984		nvmet_pci_epf_bar_write32(ctrl, NVME_REG_CC, ctrl->cc);
  1985	}
  1986	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

