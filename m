Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55827CEDDB8
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2024 03:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=U6WU4UmRZ7x/Nv7M+v0aiQJwaxfFDy++Cy/Xp6Jrpfw=; b=WXhrHBC1ergcYXmq1giPpUZfck
	AYhwSty7STQzxTehhFQrI7mYDYt+olT5v/m02REZOBRUvLfBzYBGaxyWHfBoFG9vpASaZAgYRmLdz
	a3N6eQ3t2mL+U0yQdV6aY3nxiVFw5csPFik/5pK3tUcFC+xcShtZOq2Y/odzDh1ENS+uRYhfCUnZ/
	NSmNeryX4bRxvb5txHOK7zugEvoQxHXmPMA3n0Mn3iZHOhyHskbBewMOV4IheXlLTJTvAFIxBo87m
	OMfFLZFXIDCHIb7C+bimmgidtLd0TnA8hfRZrp0BqJqoA6PwgQN8nIZFRnX8Xihq7k5oxrQRHC1lz
	1Clr/pPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syjwz-0000000BPDu-00Vx;
	Thu, 10 Oct 2024 03:34:53 +0000
Received: from mgamail.intel.com ([192.198.163.16])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1syjwv-0000000BPDR-2g58
	for linux-nvme@lists.infradead.org;
	Thu, 10 Oct 2024 03:34:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728531289; x=1760067289;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1EQymhFoo7PHNAi1pb9KlKlTNVRwRgpT1OKIX53OvQM=;
  b=hBlPVv1TFR5lZSZW2H6Ab/U+EQvOeVg8ncNt/AbY7dmvzpKAStOIhaRh
   mG/7hZdEqCHSS8qaXp4VpelqEDQJRYIBORkdaaX5Srfj+1o/2JQeYiS8B
   siKFbEGMmSrVLYpG3t8ZWWM1Xiq1tYmb9m99kQfAzH+zbN8+VJVV9oh/I
   UpCdIE3Y7/kI4DbIxy8G0X5GCpTq34p7HLtN6SRjNUN57RpKckKxZ5bki
   l79H0AVaQgCtHg8GO1RXPkrZ1jhA0fJq7zYkI5WzVa7kEIwvsMjGy466Z
   qbvaQeH949KCV47CHSPgtEk9yNUsv6Ds23mKMjfu+AXj4n1T/+xuFw61d
   g==;
X-CSE-ConnectionGUID: sqLw58H1QZOx0AYaunE3fg==
X-CSE-MsgGUID: fTRcBnXiSkOyAJ2aNYUW5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="15489273"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="15489273"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 20:34:46 -0700
X-CSE-ConnectionGUID: DB5MoxZZSQyKXrxo/VzL2w==
X-CSE-MsgGUID: 1Tc8r3y4SYGxU3b9GPge2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="76451659"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 09 Oct 2024 20:34:42 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1syjwm-000A7B-1L;
	Thu, 10 Oct 2024 03:34:40 +0000
Date: Thu, 10 Oct 2024 11:33:49 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-pci@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
Message-ID: <202410101139.m5gNkCfL-lkp@intel.com>
References: <20241007044351.157912-5-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007044351.157912-5-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241009_203449_749092_87660713 
X-CRM114-Status: GOOD (  13.01  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.12-rc2 next-20241009]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvmet-rename-and-move-nvmet_get_log_page_len/20241007-124428
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241007044351.157912-5-dlemoal%40kernel.org
patch subject: [PATCH v1 4/5] PCI: endpoint: Add NVMe endpoint function driver
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241010/202410101139.m5gNkCfL-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241010/202410101139.m5gNkCfL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410101139.m5gNkCfL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/endpoint/functions/pci-epf-nvme.c:81:21: error: field has incomplete type 'struct pci_epc_map'
      81 |         struct pci_epc_map      pci_map;
         |                                 ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:81:9: note: forward declaration of 'struct pci_epc_map'
      81 |         struct pci_epc_map      pci_map;
         |                ^
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:415:21: error: variable has incomplete type 'struct pci_epc_map'
     415 |         struct pci_epc_map map;
         |                            ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:81:9: note: forward declaration of 'struct pci_epc_map'
      81 |         struct pci_epc_map      pci_map;
         |                ^
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:419:8: error: call to undeclared function 'pci_epc_mem_map'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     419 |         ret = pci_epc_mem_map(epf->epc, epf->func_no, epf->vfunc_no,
         |               ^
>> drivers/pci/endpoint/functions/pci-epf-nvme.c:438:2: error: call to undeclared function 'pci_epc_mem_unmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     438 |         pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no, &map);
         |         ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1021:8: error: call to undeclared function 'pci_epc_mem_map'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1021 |         ret = pci_epc_mem_map(epf->epc, epf->func_no, epf->vfunc_no,
         |               ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1034:3: error: call to undeclared function 'pci_epc_mem_unmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1034 |                 pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no,
         |                 ^
   drivers/pci/endpoint/functions/pci-epf-nvme.c:1047:2: error: call to undeclared function 'pci_epc_mem_unmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    1047 |         pci_epc_mem_unmap(epf->epc, epf->func_no, epf->vfunc_no,
         |         ^
   7 errors generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MODVERSIONS
   Depends on [n]: MODULES [=y] && !COMPILE_TEST [=y]
   Selected by [y]:
   - RANDSTRUCT_FULL [=y] && (CC_HAS_RANDSTRUCT [=y] || GCC_PLUGINS [=n]) && MODULES [=y]


vim +81 drivers/pci/endpoint/functions/pci-epf-nvme.c

    69	
    70	/*
    71	 * Queue definition and mapping for the local PCI controller.
    72	 */
    73	struct pci_epf_nvme_queue {
    74		struct pci_epf_nvme	*epf_nvme;
    75	
    76		unsigned int		qflags;
    77		int			ref;
    78	
    79		phys_addr_t		pci_addr;
    80		size_t			pci_size;
  > 81		struct pci_epc_map	pci_map;
    82	
    83		u16			qid;
    84		u16			cqid;
    85		u16			size;
    86		u16			depth;
    87		u16			flags;
    88		u16			vector;
    89		u16			head;
    90		u16			tail;
    91		u16			phase;
    92		u32			db;
    93	
    94		size_t			qes;
    95	
    96		struct workqueue_struct	*cmd_wq;
    97		struct delayed_work	work;
    98		spinlock_t		lock;
    99		struct list_head	list;
   100	};
   101	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

