Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 075BCC27C52
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 20:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OD9OjMUq1p2jj7Lj3WfaT1NhfaNSRKvGVlURanYtV0Y=; b=ADWDfNlS4wyo6DbJlsNCBF9pWN
	v2pZhmMUrm7uMUZxR1HI+uYYNZ4IKiMbBKIhAXGEErpykAK+zM53D5PSOA2gSeARbrYkVvUBEuUvD
	oeYiomj7kEzeO3Qd1XLfiYKWUNZlIy1h0OzDPYL9IrmOXYPK/9m+ax8KGsP52XEGvlJAWpxIB70GI
	1Ac932b/8N+csdy9+2NBNBWvYAJxW6gH+gYn/kVFb4nTsauu8UjoJOsF+05oHZyBHMMR+Gosq/xSF
	G8V7jUbp/ZbJRjzwe6iuNQzol+9M/8Cawn8i84yKQ8HCpiWAS7jO20XNsWwmivXIYI+bymQ1xxybJ
	wRdSDtow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sExQa-00000007Tjm-0c2Q;
	Wed, 05 Jun 2024 20:40:12 +0000
Received: from mgamail.intel.com ([192.198.163.11])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sExQW-00000007TjJ-3bgB
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 20:40:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717620008; x=1749156008;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DZKCfW/N/v1MY6ehNNqCGkaYfE3qQdeGAYwy/tGjUTk=;
  b=mHPs1sz7veGeqs2Mpto3Qz5kpgnU4CJM/NjKQZlmp379npqi2Sa99bTS
   dvk5dYJucvSkBHqBO1wUW8KE1RrLtRzyX8Ne8T/N16m0deIHmHfsOIrxj
   nWInEvsKuSbwu2IR/u7xk1sk1QKZqP2vq8W+SCpF6rw5r9xbsDJ0X7Cdp
   VdOgMBZMZ9D8bBGqYrB4hoQlMz7y0oH+ZUHUDSw/cw04tE15XDHYQcob0
   CHTeuEWUCd9KO7RtjvVytiLA8vCh81CC8YDLD/TWmEhlF3RzYTDSJvNVx
   dYYkWhevD2/wKEP/a/1JLea5SeaBbzPZaGVb8SXana7l2mZQLy/jKSwTd
   A==;
X-CSE-ConnectionGUID: qbiJCXrVRregEge0u1NEVg==
X-CSE-MsgGUID: PgyLXqyhSKupMukFOm6HJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="24887164"
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="24887164"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2024 13:40:07 -0700
X-CSE-ConnectionGUID: GqqQ3gOkSzC/TDc3nSFSZg==
X-CSE-MsgGUID: K3LEcDf6QLOQZRFiBi/dkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,217,1712646000"; 
   d="scan'208";a="42286660"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 05 Jun 2024 13:40:06 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sExQR-0002E0-2V;
	Wed, 05 Jun 2024 20:40:03 +0000
Date: Thu, 6 Jun 2024 04:39:36 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: [linux-nvme:nvme-6.11 2/10] drivers/nvme/host/apple.c:1547:27:
 error: 'dev' undeclared; did you mean 'pdev'?
Message-ID: <202406060424.PAp4EYR8-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_134008_943735_B3C10515 
X-CRM114-Status: GOOD (  12.93  )
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
commit: cfafcbf5792d9d7e5120c3acb78a8afad8878459 [2/10] nvme: apple: fix device reference counting
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20240606/202406060424.PAp4EYR8-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240606/202406060424.PAp4EYR8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406060424.PAp4EYR8-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/nvme/host/apple.c: In function 'apple_nvme_probe':
>> drivers/nvme/host/apple.c:1547:27: error: 'dev' undeclared (first use in this function); did you mean 'pdev'?
    1547 |         nvme_uninit_ctrl(&dev->ctrl);
         |                           ^~~
         |                           pdev
   drivers/nvme/host/apple.c:1547:27: note: each undeclared identifier is reported only once for each function it appears in


vim +1547 drivers/nvme/host/apple.c

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
  1534		anv->ctrl.admin_q = blk_mq_alloc_queue(&anv->admin_tagset, NULL, NULL);
  1535		if (IS_ERR(anv->ctrl.admin_q)) {
  1536			ret = -ENOMEM;
  1537			anv->ctrl.admin_q = NULL;
  1538			goto out_uninit_ctrl;
  1539		}
  1540	
  1541		nvme_reset_ctrl(&anv->ctrl);
  1542		async_schedule(apple_nvme_async_probe, anv);
  1543	
  1544		return 0;
  1545	
  1546	out_uninit_ctrl:
> 1547		nvme_uninit_ctrl(&dev->ctrl);
  1548		nvme_put_ctrl(&dev->ctrl);
  1549		return ret;
  1550	}
  1551	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

