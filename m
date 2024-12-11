Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C787BE7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 12:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mHfL74yGraHCMIUji97g/fFBGv5R4idTyJ3wRuQAiLg=; b=gxDhLGMLpfd+hu1TIe+SUU72K8
	QwdkIVB+4Bj8u1u35bUSJVpFA9M29lfXsTJYcv4yAop/yVsy5Bq6sr7Naka3WNoYn8o4+v+1+jumI
	pbHu57R3typQ9vMoh5Zq5Kcj6DNGAEHnJa2SEP52fSgERg2vj5fEh/pxEY1HPace1EcfvStJSKl0T
	V/1rwS1mjLv0LWAKaEX1VlLLyhAT1vwbX3pO4Fgk9IPzPwCKRlDerMv1A2sueNo4lpUTKmkDJoHKD
	1Q7JB5s+uXu728dHIwdqHnswIcjBpFSDb5TZoBXkskQqz5lYMhepejMj30TS2Twqb8ebu41eBpbEH
	sad1bKaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLtM-0000000EpeK-26WM;
	Wed, 11 Dec 2024 12:32:36 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLLtJ-0000000Epdq-3Y1g
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 12:32:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733920353; x=1765456353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=71wI1DFvaEWtKNoUNXYVXtT26U3V83DpBv8RT4vrESo=;
  b=lFdD11SSUneQbW2sBKGs22SPf9M7GOscU16TeHnCFBCaTEgdBZVFvP9h
   RJ+V6A7hxrcea1fRPNcN5Zm6pYzpevj4zGGsoZCZ1lTossMeMVG/BOR4A
   xM96GmTj7U8KQacZx7UujAxSW+odKqgQgLCpqfLi6aTFyrfxBsTL/Beve
   yoVUyAc/RhS5Ilz8Jcpnpcv91kKjQFZml3ci5SmxI+NJbyF+t7OkF0iVI
   kstDmcrGuHFW6VrIihSxUPBZXKZZ1A58iv48Qk52A5I2J3JQ4Tv/ExZkw
   nqSNmPhBDe5mEq3y8g379Uj17kLEZf59HyA+uCG11K7TVCak36jkXbjFn
   g==;
X-CSE-ConnectionGUID: nNBYn70hRB6CBpd937+QjQ==
X-CSE-MsgGUID: AXtF/rsgTdK61vtZOAlYcg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34197461"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34197461"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 04:32:33 -0800
X-CSE-ConnectionGUID: UDtcslNASIWMgW0uxxZpQg==
X-CSE-MsgGUID: xxzsp89jQZOVGtVWxIutiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95856342"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 11 Dec 2024 04:32:29 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLLtD-0006dx-13;
	Wed, 11 Dec 2024 12:32:27 +0000
Date: Wed, 11 Dec 2024 20:32:16 +0800
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
Subject: Re: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
Message-ID: <202412112016.qpAKrNxI-lkp@intel.com>
References: <20241210093408.105867-17-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093408.105867-17-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_043233_895128_840E497A 
X-CRM114-Status: GOOD (  13.20  )
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
[also build test ERROR on pci/for-linus linus/master v6.13-rc2 next-20241211]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Damien-Le-Moal/nvmet-Add-vendor_id-and-subsys_vendor_id-subsystem-attributes/20241210-174321
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20241210093408.105867-17-dlemoal%40kernel.org
patch subject: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20241211/202412112016.qpAKrNxI-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412112016.qpAKrNxI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412112016.qpAKrNxI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/nvme/target/pci-ep.c:11:
   In file included from include/linux/dmaengine.h:8:
   In file included from include/linux/device.h:32:
   In file included from include/linux/device/driver.h:21:
   In file included from include/linux/module.h:19:
   In file included from include/linux/elf.h:6:
   In file included from arch/s390/include/asm/elf.h:181:
   In file included from arch/s390/include/asm/mmu_context.h:11:
   In file included from arch/s390/include/asm/pgalloc.h:18:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> drivers/nvme/target/pci-ep.c:658:9: error: call to undeclared function 'nvme_opcode_str'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^
>> drivers/nvme/target/pci-ep.c:658:9: error: incompatible integer to pointer conversion returning 'int' from a function with result type 'const char *' [-Wint-conversion]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   4 warnings and 2 errors generated.


vim +/nvme_opcode_str +658 drivers/nvme/target/pci-ep.c

   655	
   656	static inline const char *nvmet_pciep_iod_name(struct nvmet_pciep_iod *iod)
   657	{
 > 658		return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
   659	}
   660	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

