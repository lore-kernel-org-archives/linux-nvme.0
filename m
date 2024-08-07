Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0AF2C3DA7F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Aug 2024 21:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ruwTAj3D9XWkETMzAnkpM6U/B28FpiNVG0xBS7q7En0=; b=e+g4oDf0gcbMf3rAf8QBv3sdYq
	Hm0LByyBLy2Djg8nQahSgkb1jMAD34Vr/TMvnjcNdjLdNvrA6sCseRnQ9kmfDiDD5ilio5BKr7m+E
	eXLWY1Dltl7JuIh4xDPatR7rnnVYJbrN3HvUOYxfaqBbCikLblBgksbSNSyUu28AQBEbosK/lRA0k
	LqpLadB1vMG/gjzdm9tPyBgIJ+73hv9W4BMzmskOH5QYq+yDZHJDvV9ZRy4VQzSW/vcedA2wZsyxg
	zZlsmJ0Uy1CVPIvBm/EGob+sIgFNc5poV4ms0mlfemUqYSrVnDUY168Q1uBgLDH0A02Ydk+ZIZSeq
	rxzqVTjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sboDr-00000006Klj-0gCM;
	Wed, 07 Aug 2024 21:29:31 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sboDl-00000006KjH-3xWv;
	Wed, 07 Aug 2024 21:29:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723066166; x=1754602166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qzOKWUz41TYDR4cdz3l1k0/R2WuyA/BV//cD3NYMHPA=;
  b=X2jr41G3XqJNaZQz1HpI5Q7wnD1FioeLOxpPfxD/LyTe1nUkqy1b+kWn
   W8fyQbvFhppJGXUTUeH2Up/9ePbLARu94LhJv6B6W099VjdWn5Sei4Fn8
   EMpbj4y9EbsYoLmFCRYkLz9g9jFqGBAb9ulSjV0iRJKr3w/FAkSHyC3T2
   RiYiv7sHgMIzbI7AZA1muiPsdY59fh1Auj4qbKvk4X9sh2t7zSXJkZIns
   HoNeJ56/nDslGxxBJ5BylZKxK14jeNa2reP2C8KJvK7TgE1JaIjfFYlJs
   PY7Woz60qer7WGmk8nfVZzsvlrAyOPTDUBv/WgelddJhWaGwSQNkN7rKF
   A==;
X-CSE-ConnectionGUID: ShL5oFQ4TuWSOGu3AxQx+g==
X-CSE-MsgGUID: 2GvjaooiTbyQGEF5Poh8Ig==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21286287"
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="21286287"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 14:29:16 -0700
X-CSE-ConnectionGUID: VO5TdQLCThqYeLxhxHYGww==
X-CSE-MsgGUID: iSgMtuprRgqN7ExnMuFUDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,271,1716274800"; 
   d="scan'208";a="56947521"
Received: from unknown (HELO b6bf6c95bbab) ([10.239.97.151])
  by fmviesa008.fm.intel.com with ESMTP; 07 Aug 2024 14:29:08 -0700
Received: from kbuild by b6bf6c95bbab with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sboDM-0005jV-21;
	Wed, 07 Aug 2024 21:29:02 +0000
Date: Thu, 8 Aug 2024 05:27:46 +0800
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
Subject: Re: [PATCH v3 6/6] mtd: parser: add support for Airoha parser
Message-ID: <202408080559.nVw5Qez6-lkp@intel.com>
References: <20240806114118.17198-7-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806114118.17198-7-ansuelsmth@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240807_142926_056690_064EA958 
X-CRM114-Status: GOOD (  12.78  )
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
[also build test ERROR on mtd/mtd/fixes linus/master v6.11-rc2 next-20240807]
[cannot apply to mtd/mtd/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-nvme-Document-nvme-card-compatible/20240806-195029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
patch link:    https://lore.kernel.org/r/20240806114118.17198-7-ansuelsmth%40gmail.com
patch subject: [PATCH v3 6/6] mtd: parser: add support for Airoha parser
config: arc-randconfig-r121-20240807 (https://download.01.org/0day-ci/archive/20240808/202408080559.nVw5Qez6-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20240808/202408080559.nVw5Qez6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408080559.nVw5Qez6-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/devfreq/governor_performance.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-core.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-hub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/fsi/fsi-master-gpio.o
>> ERROR: modpost: "of_update_property" [drivers/mtd/parsers/ofpart.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

