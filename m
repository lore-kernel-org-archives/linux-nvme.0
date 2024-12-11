Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BF2E7717D
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Dec 2024 14:41:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HCNMlCgdHEgcBRfolONEzoWrUr+QCEIEqn1ccfVC/xQ=; b=JONhqtgsR48mb4evW9+1pwTf+O
	NR9snxilvFo0+XXOBblxCN9g4zIY7wI9ML5EWpJotl7xNxnmN/3SwL/Yxg6j+SdIGgwn3GJVsFjgH
	skUclGgFPhs+hA38rEygywEidkZ7CPajpD7n8I3tYSMtCVftx0H5Jn5+0NgB+QG76+eohGP1AGsq4
	skEdv9FN4DVqU9tan4jRF+fB8JU5bCJju2BQ//vOo1V4kLxqn2J8QGNPARHpBL50S418NimiOTmII
	m/pjHRrXlfZcBvzXYb2g6p/pX9rQ0xWxICljc/AJq4h1de30uw9l870X+/Z1xU2uZ/JuB0aeh3QzX
	mq4Z+ZUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tLNuA-0000000FAoV-30Zv;
	Wed, 11 Dec 2024 14:41:34 +0000
Received: from mgamail.intel.com ([192.198.163.8])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tLNu8-0000000FAo6-2QP5
	for linux-nvme@lists.infradead.org;
	Wed, 11 Dec 2024 14:41:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733928093; x=1765464093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SwNjv1AC6CVXytqZT3qaDygu0YsKQwsBbZ0nRszYpcs=;
  b=aEbOO/90o6IU+oSHBBv5V5188i1e39geCnwYitucdOtBONIdC/dADEzm
   +ScA/j52YqgY+0fPqq2zfUVxkOshzS4Hc+CL8jGNCYMACNlrqVEsiHaur
   sDkRe4FqnkSKeO8zbD+5RHpV83csL15Hvc+ujIdGaMnx/XxnzKkW23j12
   /OzGtS/ZyBQjl+XtKQdfOiZrzQK6BuZqLcs8i3OnDd1VKgLxKCFly113h
   3B2s/nDtJ18igMNZjRA0k5felyM5ncAdz/xpKsR7vigcye6V64BI3WBVU
   YLuRGRdYfXaaUnUsc8c7qeLpJ9NCYh36EJ8K8UHiNx+RxwBoBiHsXyD9+
   A==;
X-CSE-ConnectionGUID: 8z/B9uReRfaT5m2cxUioIw==
X-CSE-MsgGUID: fuz0XdIPRzmJBb4ouqmA3w==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="51839739"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="51839739"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 06:41:16 -0800
X-CSE-ConnectionGUID: JBQWBMwVS1+WzAKyxRaObw==
X-CSE-MsgGUID: m3HoZaClSMmoSCUCBPb9Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95691366"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 11 Dec 2024 06:41:11 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLNtk-0006kz-0t;
	Wed, 11 Dec 2024 14:41:08 +0000
Date: Wed, 11 Dec 2024 22:40:15 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sagi@grimberg.me, asml.silence@gmail.com,
	anuj20.g@samsung.com, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv13 10/11] nvme: register fdp parameters with the block
 layer
Message-ID: <202412112244.XIKhzaWR-lkp@intel.com>
References: <20241210194722.1905732-11-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241210194722.1905732-11-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241211_064132_632123_E563B27E 
X-CRM114-Status: GOOD (  14.22  )
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

Hi Keith,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on next-20241211]
[cannot apply to brauner-vfs/vfs.all hch-configfs/for-next linus/master v6.13-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/fs-add-a-write-stream-field-to-the-kiocb/20241211-080803
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241210194722.1905732-11-kbusch%40meta.com
patch subject: [PATCHv13 10/11] nvme: register fdp parameters with the block layer
config: i386-buildonly-randconfig-002-20241211 (https://download.01.org/0day-ci/archive/20241211/202412112244.XIKhzaWR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412112244.XIKhzaWR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412112244.XIKhzaWR-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/async.h:14,
                    from drivers/nvme/host/core.c:7:
   drivers/nvme/host/core.c: In function 'nvme_query_fdp_granularity':
>> drivers/nvme/host/core.c:2176:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    2176 |                          "failed to allocate %lu bytes for FDP config log\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:156:61: note: in expansion of macro 'dev_fmt'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/nvme/host/core.c:2175:17: note: in expansion of macro 'dev_warn'
    2175 |                 dev_warn(ctrl->device,
         |                 ^~~~~~~~
   drivers/nvme/host/core.c:2176:48: note: format string is defined here
    2176 |                          "failed to allocate %lu bytes for FDP config log\n",
         |                                              ~~^
         |                                                |
         |                                                long unsigned int
         |                                              %u
   In file included from include/linux/device.h:15,
                    from include/linux/async.h:14,
                    from drivers/nvme/host/core.c:7:
   drivers/nvme/host/core.c: In function 'nvme_query_fdp_info':
   drivers/nvme/host/core.c:2254:26: warning: format '%lu' expects argument of type 'long unsigned int', but argument 3 has type 'size_t' {aka 'unsigned int'} [-Wformat=]
    2254 |                          "failed to allocate %lu bytes for FDP io-mgmt\n",
         |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:156:61: note: in expansion of macro 'dev_fmt'
     156 |         dev_printk_index_wrap(_dev_warn, KERN_WARNING, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                             ^~~~~~~
   drivers/nvme/host/core.c:2253:17: note: in expansion of macro 'dev_warn'
    2253 |                 dev_warn(ctrl->device,
         |                 ^~~~~~~~
   drivers/nvme/host/core.c:2254:48: note: format string is defined here
    2254 |                          "failed to allocate %lu bytes for FDP io-mgmt\n",
         |                                              ~~^
         |                                                |
         |                                                long unsigned int
         |                                              %u


vim +2176 drivers/nvme/host/core.c

  2153	
  2154	static int nvme_query_fdp_granularity(struct nvme_ctrl *ctrl,
  2155					      struct nvme_ns_info *info, u8 fdp_idx)
  2156	{
  2157		struct nvme_fdp_config_log hdr, *h;
  2158		struct nvme_fdp_config_desc *desc;
  2159		size_t size = sizeof(hdr);
  2160		int i, n, ret;
  2161		void *log;
  2162	
  2163		ret = nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
  2164				       NVME_CSI_NVM, &hdr, size, 0, info->endgid);
  2165		if (ret) {
  2166			dev_warn(ctrl->device,
  2167				 "FDP configs log header status:0x%x endgid:%x\n", ret,
  2168				 info->endgid);
  2169			return ret;
  2170		}
  2171	
  2172		size = le32_to_cpu(hdr.sze);
  2173		h = kzalloc(size, GFP_KERNEL);
  2174		if (!h) {
  2175			dev_warn(ctrl->device,
> 2176				 "failed to allocate %lu bytes for FDP config log\n",
  2177				 size);
  2178			return -ENOMEM;
  2179		}
  2180	
  2181		ret = nvme_get_log_lsi(ctrl, 0, NVME_LOG_FDP_CONFIGS, 0,
  2182				       NVME_CSI_NVM, h, size, 0, info->endgid);
  2183		if (ret) {
  2184			dev_warn(ctrl->device,
  2185				 "FDP configs log status:0x%x endgid:%x\n", ret,
  2186				 info->endgid);
  2187			goto out;
  2188		}
  2189	
  2190		n = le16_to_cpu(h->numfdpc) + 1;
  2191		if (fdp_idx > n) {
  2192			dev_warn(ctrl->device, "FDP index:%d out of range:%d\n",
  2193				 fdp_idx, n);
  2194			/* Proceed without registering FDP streams */
  2195			ret = 0;
  2196			goto out;
  2197		}
  2198	
  2199		log = h + 1;
  2200		desc = log;
  2201		for (i = 0; i < fdp_idx; i++) {
  2202			log += le16_to_cpu(desc->dsze);
  2203			desc = log;
  2204		}
  2205	
  2206		if (le32_to_cpu(desc->nrg) > 1) {
  2207			dev_warn(ctrl->device, "FDP NRG > 1 not supported\n");
  2208			ret = 0;
  2209			goto out;
  2210		}
  2211	
  2212		info->runs = le64_to_cpu(desc->runs);
  2213	out:
  2214		kfree(h);
  2215		return ret;
  2216	}
  2217	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

