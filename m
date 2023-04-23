Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 619DAC77B60
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Apr 2023 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=stjSR68vrxUPsiM5fZXYriee4glo+LAkndAF9+ngUu8=; b=e4TgYr2VJR1Nb31fp9eA8TwrbY
	x96O/vN1MIJ1nRLkAFCSGDWKJiEl24HBKhuUI6t8gQUp8SGqAimorr/S2B5EBhOzgZiK7c9XZQPVx
	F5aewFsQpxAh5ZOFJ2OSia2G+AIzoEbtb4vY8pdMZgLr3RnGSXcZOPykK+dBOGx7vrt/WNSo05u4t
	XSql/G1mVKsgP/3uiD9ZEDfQoYsqYtBIID158jtGyxuDajmRNghfYdlZiKqrZSBPOSfum/aA415Gg
	rN8PZ1EVU/fwEi8zS2QJBwv8ElvQAGjWSkHm9T0eVhPJMw3IO2pt/uUz6HtbS2b20vJ9eMfRf7+YH
	knCN628A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pqcgS-00EVZn-0z;
	Sun, 23 Apr 2023 16:35:28 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pqcgP-00EVYf-0W
	for linux-nvme@lists.infradead.org;
	Sun, 23 Apr 2023 16:35:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682267725; x=1713803725;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OWz9rtPgJTTHL93sX+efb11H9SigKy4vznwwIU2qdhc=;
  b=glqeLAZt2BYlfXWFFH4soSAzv/1h+YTdigsK2X3ULkExhbR8d6vivmK9
   1b0X7IoTTTs9ibL06Sn4UvtpZJDPqAsxS67QoX5kPK6JwmexT1msLFDrp
   k4AjxFOkH2RZ2GbWqJZoqyFi6dA7KAjAxTC9MqNOjh+FZ3FN8aSHricdY
   5wqRtLTgqJKatVQj8YTAPg/UqkaqNZ1yFt6cj6H49r0MU8uNKhdebFz6h
   5eeD45GH92WgVouz0f0JNUqtCiRVKYppTpdsq8e6zoZtZYKHJU/zA/t2B
   l+R/0sjED3yyVz69q/OGFkh0QSp2lt9DWfnyTLEb+zuMi+Uuub+u4yyKk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="349095263"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="349095263"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2023 09:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="686471140"
X-IronPort-AV: E=Sophos;i="5.99,220,1677571200"; 
   d="scan'208";a="686471140"
Received: from lkp-server01.sh.intel.com (HELO b613635ddfff) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 23 Apr 2023 09:35:12 -0700
Received: from kbuild by b613635ddfff with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1pqcgC-000hyO-0H;
	Sun, 23 Apr 2023 16:35:12 +0000
Date: Mon, 24 Apr 2023 00:34:29 +0800
From: kernel test robot <lkp@intel.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, martin.petersen@oracle.com,
	hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, kbusch@kernel.org, axboe@kernel.dk,
	linux-block@vger.kernel.org, oren@nvidia.com, oevron@nvidia.com,
	israelr@nvidia.com, Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: Re: [PATCH v1 1/2] block: bio-integrity: export bio_integrity_free
 func
Message-ID: <202304240037.LakzPMU9-lkp@intel.com>
References: <20230423141330.40437-2-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423141330.40437-2-mgurtovoy@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230423_093525_267643_BECFA532 
X-CRM114-Status: GOOD (  11.26  )
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

Hi Max,

kernel test robot noticed the following build errors:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on hch-configfs/for-next linus/master v6.3-rc7 next-20230421]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Max-Gurtovoy/block-bio-integrity-export-bio_integrity_free-func/20230423-222054
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20230423141330.40437-2-mgurtovoy%40nvidia.com
patch subject: [PATCH v1 1/2] block: bio-integrity: export bio_integrity_free func
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20230424/202304240037.LakzPMU9-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/1459ddb310ef47b008de7669cc2c57e02edf4edb
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Max-Gurtovoy/block-bio-integrity-export-bio_integrity_free-func/20230423-222054
        git checkout 1459ddb310ef47b008de7669cc2c57e02edf4edb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/lib/

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Link: https://lore.kernel.org/oe-kbuild-all/202304240037.LakzPMU9-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/libnvdimm.h:14,
                    from arch/powerpc/lib/pmem.c:9:
>> include/linux/bio.h:768:6: error: no previous prototype for 'bio_integrity_free' [-Werror=missing-prototypes]
     768 | void bio_integrity_free(struct bio *bio)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/bio_integrity_free +768 include/linux/bio.h

   767	
 > 768	void bio_integrity_free(struct bio *bio)
   769	{
   770	}
   771	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests

