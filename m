Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9141AC25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 21:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=56G0S/rlVQwbbRkNvVuB6VFfsNK7b8ZQDzeYAdkl8sc=; b=seDt87DNok6LUP6zdkwLYJMoyO
	mv8dJ7UFsfJjHlfe6XcKlyQoyirn8CFhdkUcHoRV5majSVYqVT5O2FRogQlZMMrAaHuzmZNGHtWvB
	YbhD8+P9Bw4KIqkvRK0Jla391OJ/bJsXavQ8JGdayAVwqXLEJlsYEsifoPO4o958YuhaPHjr30bWw
	LsRg4Zn3HRVZxNojI7anUuX3PBaqmY4qZ38PwFSYlVTKt56AfJk48BVLsHJ2eg/UR9wqkY4Bo89kf
	NwmRGCu8PH1UIEEyrHsoWFfj3SDAtYHXiBzmcodULelcIq09ogIQS6qzpqdB8llCDZry2XvaN5qqB
	hvjsuvMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEyG4-00000007d6N-1cdD;
	Wed, 05 Jun 2024 21:33:24 +0000
Received: from mgamail.intel.com ([198.175.65.14])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEyG1-00000007d5m-1gmZ
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 21:33:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717623202; x=1749159202;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aJdXo0eF9RbXYZ7pLnemDZX+OFNV/FzTHOGwF9Y11AA=;
  b=Xi2jM2ybaVUI4zsICvvYQl8ros9dimF/fw39wMORw+QelIdX2q2Sl8h6
   U1DyMKCdNVMqv+WQTWkxpFSop7DLij7izyNaYQ6aITxz/d2Dksnl/5dcu
   exJBqxhMHB/T5dTQZ0YTgisq7DVWHir8drsCIu6oBrnm9rjRR/iI3Pk+Q
   Zihtf1ATPwbh7XQ/FTVX0px2UfJygKiJBRm025hV4iECnzbfBKw2ru6U/
   Uh3FyEUnC4r+iigXhrpwXLMGiY3FbGqi/PiHjnCsrtS/B3+DDTzEEov7A
   DtOLPLvzod5bdLsbIxiDUmGroaXznL1j6lG7U/DgOd7h3ssazaA1j6ui6
   Q==;
X-CSE-ConnectionGUID: 6dQIfFO9T8OsDpJ5CNliMA==
X-CSE-MsgGUID: sPGvjIM2R+2W7HClepCYyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="18082587"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="18082587"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 14:33:20 -0700
X-CSE-ConnectionGUID: je+Rs4WRQWSkLCi+lWWWOg==
X-CSE-MsgGUID: i8uitXinQ2CHw1uUGqFm2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="75204967"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 05 Jun 2024 14:33:18 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sEyFv-0002HI-2k;
	Wed, 05 Jun 2024 21:33:15 +0000
Date: Thu, 6 Jun 2024 05:32:26 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [linux-nvme:nvme-6.11 6/10] drivers/nvme/host/apple.c:1534:9: error:
 'result' undeclared
Message-ID: <202406060540.s0O7hkb5-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_143321_542293_214A61AD 
X-CRM114-Status: GOOD (  13.71  )
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

tree:   git://git.infradead.org/nvme.git nvme-6.11
head:   fd83bacbbc06c5f3e38d8d79784ca1f7bd9cba68
commit: ff5ff45d19d8b13ceef35948204b08a51000f15f [6/10] nvme: split device add from initialization
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240606/202406060540.s0O7hkb5-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240606/202406060540.s0O7hkb5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406060540.s0O7hkb5-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/apple.c: In function 'apple_nvme_probe':
>> drivers/nvme/host/apple.c:1534:9: error: 'result' undeclared (first use in this function)
    1534 |         result = nvme_add_ctrl(&anv->ctrl);
         |         ^~~~~~
   drivers/nvme/host/apple.c:1534:9: note: each undeclared identifier is reported only once for each function it appears in
   drivers/nvme/host/apple.c:1551:27: error: 'dev' undeclared (first use in this function); did you mean 'pdev'?
    1551 |         nvme_uninit_ctrl(&dev->ctrl);
         |                           ^~~
         |                           pdev


vim +/result +1534 drivers/nvme/host/apple.c

  1524	
  1525	static int apple_nvme_probe(struct platform_device *pdev)
  1526	{
  1527		struct apple_nvme *anv;
  1528		int ret;
  1529	
  1530		anv = apple_nvme_alloc(pdev);
  1531		if (IS_ERR(anv))
  1532			return PTR_ERR(anv);
  1533	
> 1534		result = nvme_add_ctrl(&anv->ctrl);
  1535		if (result)
  1536			goto out_put_ctrl;
  1537	
  1538		anv->ctrl.admin_q = blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL);
  1539		if (IS_ERR(anv->ctrl.admin_q)) {
  1540			ret = -ENOMEM;
  1541			anv->ctrl.admin_q = NULL;
  1542			goto out_uninit_ctrl;
  1543		}
  1544	
  1545		nvme_reset_ctrl(&anv->ctrl);
  1546		async_schedule(apple_nvme_async_probe, anv);
  1547	
  1548		return 0;
  1549	
  1550	out_uninit_ctrl:
  1551		nvme_uninit_ctrl(&dev->ctrl);
  1552	out_put_ctrl:
  1553		nvme_put_ctrl(&dev->ctrl);
  1554		return ret;
  1555	}
  1556	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

