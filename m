Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B725E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 05:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yQuPgZN4fbLUefFN9izY0e2M28klsAm2+NoBZZX7cJU=; b=ei2pJ3ICKxm9vqFabCSNt8UToX
	VJCu3uiFXe4nFAdkfjMd3Q3nlwooiLHwJuRr2X1O+AftnXcXmSLuxWgXsOYcN2cvXYMyYdXrGTieu
	iJpn7IewdTVYPIDivrE3DLBp8MQ4GClZbBUjmQ97tmvCKTGU8HPz7qS3EAa6JLlQSCLO1VOE/7VRM
	OubzlzG3K7lRKrIeW11oXCu3mxSifBkIu1rnw5DjqcBcohdADbYT11ZJBuBskmSAFcITmSYma3mQO
	nQ2cX3T35S5KcZ/21QYQixpZyPVH2QNiqirH3MQZH9CEepquPKjEG5Fveub6jo7pI//uf7nTpe7w5
	si0jQp3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJQsg-00000000cN3-0OOw;
	Fri, 06 Dec 2024 05:27:58 +0000
Received: from mgamail.intel.com ([198.175.65.9])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJQsc-00000000cLc-41vD
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 05:27:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733462875; x=1764998875;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X9VFMKr7/fJOGLXPS8atTYCy0j+P7k6TXaVhXB6yhIM=;
  b=U4vTsxrbIeAgCPZD9jyCrJRjxxYMiVaTuvuijUjW27vHYebhJE3yhabR
   Vw+SS9FLUOW1nBysIubSvmUZ0xNI+pkp6YYyJRTr9BJFVdf11SaBu7XOA
   6YKdoXMFET0osRP0C7v5rgwc+TOYg6IOxIKU7mVgqC72T9SdLCK1L6qJO
   FpQ94TQUHLbdhaIoU/i2YLDKmyqk4/rBj1d1FVACRs+oFYiJxdhL+2VFR
   jO2pgdVO2khMpeUeK8dl4mn9O/+eB3Y8VDwrTumeLDIPvrVKNitCJf+bV
   vev7lIiof26RmcM+3pUl0Xy+MAOZcDO3jivbSI6May3OfKCFM9y5ohFWV
   w==;
X-CSE-ConnectionGUID: q5SHIg+yQEyqwbWC0nyeDQ==
X-CSE-MsgGUID: TCswiJbmThuNrD2TbrvBrA==
X-IronPort-AV: E=McAfee;i="6700,10204,11277"; a="56299064"
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="56299064"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 21:27:50 -0800
X-CSE-ConnectionGUID: 46M0KqbPSFGW7xrYdXXJNA==
X-CSE-MsgGUID: DsKRuo40THuu3yk9bYd+6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,212,1728975600"; 
   d="scan'208";a="131724228"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 05 Dec 2024 21:27:48 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJQsT-0000jD-1x;
	Fri, 06 Dec 2024 05:27:45 +0000
Date: Fri, 6 Dec 2024 13:26:59 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, sagi@grimberg.me,
	asml.silence@gmail.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv11 09/10] nvme: register fdp queue limits
Message-ID: <202412061328.YMG9MZn5-lkp@intel.com>
References: <20241206015308.3342386-10-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206015308.3342386-10-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241205_212755_047963_A51D91E6 
X-CRM114-Status: GOOD (  13.03  )
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
[also build test WARNING on next-20241205]
[cannot apply to brauner-vfs/vfs.all hch-configfs/for-next linus/master v6.13-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/fs-add-a-write-stream-field-to-the-kiocb/20241206-095707
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241206015308.3342386-10-kbusch%40meta.com
patch subject: [PATCHv11 09/10] nvme: register fdp queue limits
config: i386-buildonly-randconfig-003 (https://download.01.org/0day-ci/archive/20241206/202412061328.YMG9MZn5-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412061328.YMG9MZn5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412061328.YMG9MZn5-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/nvme/host/core.c:8:
   In file included from include/linux/blkdev.h:9:
   In file included from include/linux/blk_types.h:10:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/x86/include/asm/cacheflush.h:5:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/nvme/host/core.c:2178:18: warning: variable 'h' is uninitialized when used here [-Wuninitialized]
    2178 |         n = le16_to_cpu(h->numfdpc) + 1;
         |                         ^
   include/linux/byteorder/generic.h:91:21: note: expanded from macro 'le16_to_cpu'
      91 | #define le16_to_cpu __le16_to_cpu
         |                     ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   drivers/nvme/host/core.c:2157:36: note: initialize the variable 'h' to silence this warning
    2157 |         struct nvme_fdp_config_log hdr, *h;
         |                                           ^
         |                                            = NULL
   2 warnings generated.


vim +/h +2178 drivers/nvme/host/core.c

  2153	
  2154	static int nvme_check_fdp(struct nvme_ns *ns, struct nvme_ns_info *info,
  2155				  u8 fdp_idx)
  2156	{
  2157		struct nvme_fdp_config_log hdr, *h;
  2158		size_t size = sizeof(hdr);
  2159		int i, n, ret;
  2160		void *log;
  2161	
  2162		info->runs = 0;
  2163		ret = nvme_get_log_lsi(ns->ctrl, 0, NVME_LOG_FDP_CONFIG, 0, NVME_CSI_NVM,
  2164				   (void *)&hdr, size, 0, info->endgid);
  2165		if (ret)
  2166			return ret;
  2167	
  2168		size = le32_to_cpu(hdr.sze);
  2169		log = kzalloc(size, GFP_KERNEL);
  2170		if (!log)
  2171			return 0;
  2172	
  2173		ret = nvme_get_log_lsi(ns->ctrl, 0, NVME_LOG_FDP_CONFIG, 0, NVME_CSI_NVM,
  2174				   log, size, 0, info->endgid);
  2175		if (ret)
  2176			goto out;
  2177	
> 2178		n = le16_to_cpu(h->numfdpc) + 1;
  2179		if (fdp_idx > n)
  2180			goto out;
  2181	
  2182		h = log;
  2183		log = h->configs;
  2184		for (i = 0; i < n; i++) {
  2185			struct nvme_fdp_config_desc *config = log;
  2186	
  2187			if (i == fdp_idx) {
  2188				info->runs = le64_to_cpu(config->runs);
  2189				break;
  2190			}
  2191			log += le16_to_cpu(config->size);
  2192		}
  2193	out:
  2194		kfree(h);
  2195		return ret;
  2196	}
  2197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

