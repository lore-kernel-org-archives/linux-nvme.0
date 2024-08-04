Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1BB1C52D6F
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 22:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EV2GDWeNf4KRzCfedF1k2L4xDK+cICC5/G+T7NTxPIo=; b=Lk1Q1Hsda8d5n+FBFWO1aeyqa7
	aadslpzJirFDqjhmb+N1RiBOohPuIasIL8EQCX5ZSSDL/WNDHnQFx8QpX6IB4GSj9ALb3B8F8eW4/
	zc91x3mCpRfq0ViGYdcZRvl1xijq2NUup+iH0XcCkMml2lJt7j4vMWx2/XNuiKjpSZfDE1IvAW/Nq
	GuOrNDeN9ruFVwc6hBRrMUh2kr807gVwNPNsvr8nOx0zB6pvjhV4wnTAnHyXDcD0L7JBjvmwJXAzT
	OudW84FP5UKgrM/XXegK+287/etDJ7b1ErnCjzL1pDvnfZOq9yY/lQk01ye0/ZNF0TVr0f2KRApJi
	/jvz7+9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sajvF-0000000E4rN-2SfK;
	Sun, 04 Aug 2024 22:41:53 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sajvC-0000000E4qa-0SYv;
	Sun, 04 Aug 2024 22:41:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722811310; x=1754347310;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=x9dFSWS1m5DZ+vMj98CnMITJsEa4MZFFF5i1ylpdm6s=;
  b=Qfgejkp5f/dczpOhfNo/Pw3mnNYkqzL1MXXC22XzVQwwb7l1eAeC3fqR
   fvJcBWc+uBXUA7DEZeqRcooRCDkKw1XxSwFATYZmovwpnjQmFZ7Ljd9IC
   N3k3MX5hTjdLJ+VhKkufaKW1SKJY7T/lvT7uP21rAaARJY4t6GuxopHN9
   aaCKIfjiLI+8PSwNjSBbHICosA0rLdE/IniEB+WFSPdD1fhM0lp0VMd4p
   HUQgtWPA/iNav7Unc9UpJpTHLU/x8Z1Dh7GA5+TXdi3WQ9Z3bUNJV0YxQ
   0yczmKtfIvmLx4nTx8XT0jUpooSt8pnMi8yl4XSSkJYAnDFvLgnUsizG4
   g==;
X-CSE-ConnectionGUID: ibnriSGnT1qcFkU7vhjUgg==
X-CSE-MsgGUID: MmJwIH12Svaj4XR8/1A1Cg==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="31386653"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="31386653"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 15:41:49 -0700
X-CSE-ConnectionGUID: SXBm/78uSyGywqYaNiDvMg==
X-CSE-MsgGUID: hVdafZAcTHmgjknCPHoUew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="60811074"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa005.jf.intel.com with ESMTP; 04 Aug 2024 15:41:44 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sajv3-0001dT-01;
	Sun, 04 Aug 2024 22:41:41 +0000
Date: Mon, 5 Aug 2024 06:41:40 +0800
From: kernel test robot <lkp@intel.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Joern Engel <joern@lazybastard.org>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Wolfram Sang <wsa-dev@sang-engineering.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
Message-ID: <202408050650.ScFbLl34-lkp@intel.com>
References: <20240804174414.18171-7-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804174414.18171-7-ansuelsmth@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_154150_194604_D2CCCD85 
X-CRM114-Status: GOOD (  16.47  )
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

Hi Christian,

kernel test robot noticed the following build errors:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v6.11-rc1 next-20240802]
[cannot apply to mtd/mtd/next mtd/mtd/fixes]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240805-014740
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240804174414.18171-7-ansuelsmth%40gmail.com
patch subject: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
config: arm-randconfig-003-20240805 (https://download.01.org/0day-ci/archive/20240805/202408050650.ScFbLl34-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 423aec6573df4424f90555468128e17073ddc69e)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050650.ScFbLl34-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408050650.ScFbLl34-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/mtd/parsers/ofpart_airoha.c:33:9: error: call to undeclared function 'kzalloc'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
      33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
         |                ^
>> drivers/mtd/parsers/ofpart_airoha.c:33:7: error: incompatible integer to pointer conversion assigning to 'struct property *' from 'int' [-Wint-conversion]
      33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
         |              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/kzalloc +33 drivers/mtd/parsers/ofpart_airoha.c

    10	
    11	int airoha_partitions_post_parse(struct mtd_info *mtd,
    12					 struct mtd_partition *parts,
    13					 int nr_parts)
    14	{
    15		struct mtd_partition *part;
    16		int len, a_cells, s_cells;
    17		struct device_node *pp;
    18		struct property *prop;
    19		const __be32 *reg;
    20		__be32 *new_reg;
    21	
    22		part = &parts[nr_parts - 1];
    23		pp = part->of_node;
    24	
    25		/* Skip if ART partition have a valid offset instead of a dynamic one */
    26		if (!of_device_is_compatible(pp, "airoha,dynamic-art"))
    27			return 0;
    28	
    29		/* ART partition is set at the end of flash - size */
    30		part->offset = mtd->size - part->size;
    31	
    32		/* Update the offset with the new calculate value in DT */
  > 33		prop = kzalloc(sizeof(*prop), GFP_KERNEL);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

