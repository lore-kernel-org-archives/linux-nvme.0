Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A943C3DA64
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Aug 2024 22:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zKxdujakf6YMppYWaiGZVKGi5i9Sag+/WTvW2KwVi8Q=; b=Zb7GuWqxlo8XlEZOY/B7tHz0Xv
	39LOcBkjBgr6yID036eg6hzU7VbkFU9mbOUvZRG8tSV7Z3qqczTIlOX6fgDnKsv4mUaPBzG1HCe8J
	051c3EtDsyNe6w9/kOtAHhcCYystTO+KwYGu6iN+hOS4s3xk2+uYsBhxdCITzkfWGYIS+TCLCoM/c
	dPYRL3olEeNe2oULR5TwQPxDfVhmZ9QrJmzeS2NuB9xmhqe8jaf8PcQeR9oZE6A5AyV3jvPiSTjWy
	tb3CNSMIPpVV3Yh5+HX7C4/MUG4qBpCtgXWPFC+3M9Ni22JF5vToXqYAcU04Pv2CGLgq8RWadmcIK
	bZuaR25w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sak60-0000000E5hP-1vFH;
	Sun, 04 Aug 2024 22:53:00 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sak5w-0000000E5gf-2fBX;
	Sun, 04 Aug 2024 22:52:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722811977; x=1754347977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SC6pWjsNLdf8Ha0Xw9lyvFenqRq2ilvJTWh9TexvBZI=;
  b=cVfVDobxZ8IxSK8hM2ijyIhY0lLphx/Tct9dQz5IIMXX8Uq1/N5hEJ2t
   mSh9fp7Xx+rzCPsOsnkDdMZu4wueLWW/CFjt1w3c87I9sAi7fu74aOZzH
   SSraKUdC7DZgQWH7tlkLsd09wZ4VjSSvJOoGBtSrEq+4wmzQ+sKHwhRPF
   JkxhUGSMy1LAIzvX6U3/miOApNUQI6HYWhnCgv1WMEn4nmz1ChdzH9GnV
   86uoXBCCty40Pa5lYzUXYcP6b8QxBWL2o7+k/0Fw/gDJ/iDUO1V8ejpCG
   FCEmHbJ5qxlVswf5E30s8UcU72mlgaaLEFHqQ5n81abXJqHGG+5aOFI2V
   w==;
X-CSE-ConnectionGUID: Jx0aTAoXSTK1v6cCMiLYWQ==
X-CSE-MsgGUID: t4Sn6ISQRUWmMmTr6pYTyw==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="20922614"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="20922614"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 15:52:55 -0700
X-CSE-ConnectionGUID: BjEKeAYSTFOLZIjIvaRe3A==
X-CSE-MsgGUID: VFBeEUHhSLuwRTbWMoIdOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="56720569"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 04 Aug 2024 15:52:49 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sak5h-0001dc-0C;
	Sun, 04 Aug 2024 22:52:42 +0000
Date: Mon, 5 Aug 2024 06:52:04 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v2 6/6] mtd: parser: add support for Airoha parser
Message-ID: <202408050612.Ya1m6REu-lkp@intel.com>
References: <20240804174414.18171-7-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240804174414.18171-7-ansuelsmth@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240804_155256_927583_06AA2A67 
X-CRM114-Status: GOOD (  16.21  )
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
config: xtensa-allyesconfig (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240805/202408050612.Ya1m6REu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408050612.Ya1m6REu-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/mtd/parsers/ofpart_airoha.c: In function 'airoha_partitions_post_parse':
   drivers/mtd/parsers/ofpart_airoha.c:33:16: error: implicit declaration of function 'kzalloc' [-Wimplicit-function-declaration]
      33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
         |                ^~~~~~~
>> drivers/mtd/parsers/ofpart_airoha.c:33:14: error: assignment to 'struct property *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
      33 |         prop = kzalloc(sizeof(*prop), GFP_KERNEL);
         |              ^


vim +33 drivers/mtd/parsers/ofpart_airoha.c

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

