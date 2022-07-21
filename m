Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE831C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jul 2022 15:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FebgSSWjZNZiBZUj/oW1wIkH3ThRv98fDR0x74MhkXQ=; b=ltnifsuI88aZAqF4MID3/oo88B
	rk65Y6U2wTQZCH5SE/8VulGyOjlDSA9kfucAYAhMfR9+e9fpKFMcXaJWuVqP/P/S+Nm3aB1Pj5zlt
	BrbS5RhHkMhwINmiZn5pRb3/a2kTFMVCz3fCLllvnSMshTzBIvCDTAU5SLA8Cu+fNIeFr/QkJPg4b
	vDGJZU+tJ7/7Y2sdom+msIRfXwIWY8/UsWnDPPkWI3ZqmSviqwTMHvfn9/qHSal5X2HcESSahQCkL
	bLkuAwrrCye/LkZTSZ2Sr7GyoPhZYEoN1IzWiqVuhkNKWd1wTp0HLRY6dBeRYec/vzxNa5QnZFS5e
	IjeHWYiA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEYDj-009BHG-Tg; Thu, 21 Jul 2022 15:36:11 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEYDG-009Ao9-SS
	for linux-nvme@lists.infradead.org; Thu, 21 Jul 2022 15:35:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658417742; x=1689953742;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cjyH62mMuNHUIRXZOg8uyLdue7IdDR+BOHe9/MIqalc=;
  b=SfkD8YGMrC2Rh3mB86nSw54gdEQXx7CK+CVwL2eKbow2UmE2Fb6+QK9n
   JHGRG+W/sz6WJrC4FKRH3N76V/B8uOAge9SK0KyIC3n/yY2H9/EFTJehy
   8P/UxQSrnHTrXWUbwG5yTkr20DOIR1+bqWAciJrHe9Zn/5nqbUtbiIUYI
   gs3o5gSYwrzGLtX88w63ZqcAB/wqGEnMJw71IegXlehB+OLiWClfpzdw+
   QGfzdjnMXdFyaeQQY4nIPTmDuOV3xaffwb6N4U8BECQ7I9teIS0Ljv3Fz
   umENZvKZV3oKA5SuupMX3LgHwVNw0fP3EqmhhGnzHrHHfwHR0DGz0C4nv
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="273929567"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="273929567"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 08:35:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="626166677"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 21 Jul 2022 08:35:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oEYDB-0000IS-20;
	Thu, 21 Jul 2022 15:35:37 +0000
Date: Thu, 21 Jul 2022 23:35:24 +0800
From: kernel test robot <lkp@intel.com>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: kbuild-all@lists.01.org, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>
Subject: [linux-nvme:nvme-5.20 6/14] drivers/nvme/host/pci.c:3540:41: error:
 'nvme_dev_pm_ops' undeclared here (not in a function); did you mean
 'nvme_dev_map'?
Message-ID: <202207212326.SB1C57On-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220721_083543_025552_0482E13C 
X-CRM114-Status: GOOD (  12.97  )
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

tree:   git://git.infradead.org/nvme.git nvme-5.20
head:   750e34232a1152375907f28b6dd0262477a31f87
commit: 91d3073ff2f0b1a6a6d0629df7bcfacb226a204b [6/14] nvme-pci: use pm_sleep_ptr macro to declare nvme_dev_pm_ops
config: arm64-buildonly-randconfig-r001-20220721 (https://download.01.org/0day-ci/archive/20220721/202207212326.SB1C57On-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add linux-nvme git://git.infradead.org/nvme.git
        git fetch --no-tags linux-nvme nvme-5.20
        git checkout 91d3073ff2f0b1a6a6d0629df7bcfacb226a204b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from drivers/nvme/host/pci.c:7:
>> drivers/nvme/host/pci.c:3540:41: error: 'nvme_dev_pm_ops' undeclared here (not in a function); did you mean 'nvme_dev_map'?
    3540 |                 .pm     = pm_sleep_ptr(&nvme_dev_pm_ops),
         |                                         ^~~~~~~~~~~~~~~
   include/linux/kernel.h:57:44: note: in definition of macro 'PTR_IF'
      57 | #define PTR_IF(cond, ptr)       ((cond) ? (ptr) : NULL)
         |                                            ^~~
   drivers/nvme/host/pci.c:3540:27: note: in expansion of macro 'pm_sleep_ptr'
    3540 |                 .pm     = pm_sleep_ptr(&nvme_dev_pm_ops),
         |                           ^~~~~~~~~~~~


vim +3540 drivers/nvme/host/pci.c

  3532	
  3533	static struct pci_driver nvme_driver = {
  3534		.name		= "nvme",
  3535		.id_table	= nvme_id_table,
  3536		.probe		= nvme_probe,
  3537		.remove		= nvme_remove,
  3538		.shutdown	= nvme_shutdown,
  3539		.driver		= {
> 3540			.pm	= pm_sleep_ptr(&nvme_dev_pm_ops),
  3541		},
  3542		.sriov_configure = pci_sriov_configure_simple,
  3543		.err_handler	= &nvme_err_handler,
  3544	};
  3545	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

