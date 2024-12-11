Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2535E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 15:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LWV1glRr3EfD6Ab4uf1goyVkMB2GZ+AFX3sh9HcBNyA=; b=12GoShQ14X4J2HhwG6mBk+6Ixh
	x6efvhzWpLPC2RgMpZGOOLlUmsUcojNOsitc9c96LrDcVN6WGXg2K0fHWVlgwoIFnu44xhUdzYk1h
	y9Vqa/xnvV9EkRDCh8GdqtPGpaly11O3VZk2g+u3pIH+G8kK/R+Yb9ABHcMyBKxtt+d4339vQ5DpG
	RzbuhXuyHap/tT9rp0G8V7AQPugTj2rHEcYV+TpGKQ5L3XrfSR8nZQkD06LbJU5akYqOogC1seBnN
	LXGlsHJb2VpIodzodfUf4Z3LPAwZfa8urUbEZuZdsMnVO6PwsswLcXpxkTubSGH75gCi3f70RNzG3
	38THuuIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLOiL-0000000FGi6-42yM;
	Wed, 11 Dec 2024 15:33:25 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLOiJ-0000000FGhj-1nXP
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 15:33:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733931203; x=1765467203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eX9tYjMf8PVgk1Kntv2I21r8w/dOQxwnYgzCNfeVSRw=;
  b=AAJH4wy48oYKwSc61OPXbUndAvhsVhunrufCoEVva2xVyJWKngcyA81Y
   RH0UUi37LK7KwJPD+K6bcc4meTBb2sYk3bWXZFF+n4b4WuF3g0Ca9YIwv
   9UluwZ8FfbAvVUL6o2A3LxKuabfTnNFkQ0YlERAxAuUQunAA2lQx7VDnS
   pe/lSQeZZ6G2hGCRq+lvVyFmpfTvXjW8kXkj3iBOTAeMcOQWiUEa10Yq6
   TGEkysSjPHUiInoDKSuz47D8OAlzPuWqgWN97rn2zzPXpWBGQCOCRqL5Q
   pynY2MnarwFTT91PnhNnW7+3qGHJ2w0NJ7Wf3vgxYo4NDCxF0n08Ciy0j
   g==;
X-CSE-ConnectionGUID: xZ3jlAZSRdaRizBpgwUAEQ==
X-CSE-MsgGUID: N688PJvqSTKQ+j99U+KA7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="44986103"
X-IronPort-AV: E=Sophos;i="6.12,226,1728975600"; 
   d="scan'208";a="44986103"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 07:33:21 -0800
X-CSE-ConnectionGUID: /cd+RTSiT+SCBCAGJYCUWA==
X-CSE-MsgGUID: 41lWl8bQTumt/0R2Mj+x6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="133230725"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 11 Dec 2024 07:33:18 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLOiB-0006oT-1R;
	Wed, 11 Dec 2024 15:33:15 +0000
Date: Wed, 11 Dec 2024 23:32:52 +0800
From: kernel test robot <lkp@intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>, linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3 16/17] nvmet: New NVMe PCI endpoint target driver
Message-ID: <202412112307.uOdX4fWx-lkp@intel.com>
References: <20241210093408.105867-17-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210093408.105867-17-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_073323_485960_69893469 
X-CRM114-Status: GOOD (  12.13  )
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
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20241211/202412112307.uOdX4fWx-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412112307.uOdX4fWx-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412112307.uOdX4fWx-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/target/pci-ep.c: In function 'nvmet_pciep_iod_name':
>> drivers/nvme/target/pci-ep.c:658:16: error: implicit declaration of function 'nvme_opcode_str'; did you mean 'nvme_opcode_name'? [-Wimplicit-function-declaration]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~
         |                nvme_opcode_name
>> drivers/nvme/target/pci-ep.c:658:16: error: returning 'int' from a function with return type 'const char *' makes pointer from integer without a cast [-Wint-conversion]
     658 |         return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +658 drivers/nvme/target/pci-ep.c

   655	
   656	static inline const char *nvmet_pciep_iod_name(struct nvmet_pciep_iod *iod)
   657	{
 > 658		return nvme_opcode_str(iod->sq->qid, iod->cmd.common.opcode);
   659	}
   660	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

