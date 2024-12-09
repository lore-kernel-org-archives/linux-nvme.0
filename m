Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86CC9E77173
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Dec 2024 04:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1lrzwlSdR5bdqBvMIOXJGGnMX/9Q8h1KukoMil649wE=; b=04SRBhLRqtg1eyqhnxPr8zo0Q3
	rLcOk0lysATmUFdtP30fijHe64CxjbCZJwFtD7zEe4fwp0zzDRESxjHq6Mi4OyodNQogEq1m6+6EP
	mODgHAEuUr3gTIrQS6HcI+x/ruzeunljrBTgi6/2StB/AnKQ6BfBlfxJEc/4ish+/ejyK44DAoBdi
	WuPaS9zvCJk6csDut+EJLqGQjI/vsbCwMwWAXEE7ka63s+T6jP09i6gR78qXesgl4QK13aL5Wbsbk
	1ZoPZ4U5nHTk1os7JbARGk7/Y0OF8WDrKaztoo707QFUDFSUes9MN/AY/H8cguO0YyrDB5lAYjvXw
	eD2PE7xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tKV2J-00000006NGA-33sy;
	Mon, 09 Dec 2024 04:06:19 +0000
Received: from mgamail.intel.com ([192.198.163.7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tKV28-00000006NEv-3xVn
	for linux-nvme@lists.infradead.org;
	Mon, 09 Dec 2024 04:06:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733717169; x=1765253169;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BZ3Vp8ClbzYwVR5+MOqxWZF2tgpKKxLlNgbbyHpqPA=;
  b=KIlV67hi4vDPp9ni0omCPcxDQpXydCqQnbVcOyUlaB3KS9O0ZPlJlY+q
   xbO3Wrtjpr0Tp4QyFwE7IAk4ykKvwPasb0zub2MJJeZLYea5jOjd6QuqE
   CcEFgRr7tnaj1oTYy5EfTuUprs3y/x53NPF2clUICMQErzHYLiZtpnO7t
   eLkzZ1wlD9dretD+3PBFJqWMCzXSv/8Fkd/5HVh0bM1RQ199r1kI2EKcH
   ywDYka2nHLL3CaUJqBv08bWD9xC+f0Tu1mWRFk+0FZX70avASQS3y8Kep
   bqsSxn32nqDv1dHabQKfdFJWLA00pQKmKk6EFe2Qg5vD+P84JbhJXS3G9
   w==;
X-CSE-ConnectionGUID: MCNriFyIT6q7Rvi2hrnIOA==
X-CSE-MsgGUID: tiJd3n+6QtWPea6a6/OigA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="59402290"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="59402290"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 20:06:08 -0800
X-CSE-ConnectionGUID: 5VScRe/8TWaEic8tbsZI0A==
X-CSE-MsgGUID: 0aG8DFmkSZ6aaWljP+LPYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="100003027"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 08 Dec 2024 20:06:05 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tKV22-0003mr-0s;
	Mon, 09 Dec 2024 04:06:02 +0000
Date: Mon, 9 Dec 2024 12:05:27 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, sagi@grimberg.me,
	asml.silence@gmail.com, anuj20.g@samsung.com, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv12 11/12] nvme: register fdp parameters with the block
 layer
Message-ID: <202412071144.9uXFLnls-lkp@intel.com>
References: <20241206221801.790690-12-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206221801.790690-12-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241208_200609_010896_1262A1AA 
X-CRM114-Status: GOOD (  12.48  )
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
[also build test WARNING on next-20241206]
[cannot apply to brauner-vfs/vfs.all hch-configfs/for-next linus/master v6.13-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/fs-add-write-stream-information-to-statx/20241207-063826
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20241206221801.790690-12-kbusch%40meta.com
patch subject: [PATCHv12 11/12] nvme: register fdp parameters with the block layer
config: i386-buildonly-randconfig-001-20241207 (https://download.01.org/0day-ci/archive/20241207/202412071144.9uXFLnls-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241207/202412071144.9uXFLnls-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412071144.9uXFLnls-lkp@intel.com/

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
>> drivers/nvme/host/core.c:2187:11: warning: variable 'i' is uninitialized when used here [-Wuninitialized]
    2187 |         } while (i++ < fdp_idx);
         |                  ^
   drivers/nvme/host/core.c:2160:7: note: initialize the variable 'i' to silence this warning
    2160 |         int i, n, ret;
         |              ^
         |               = 0
   2 warnings generated.


vim +/i +2187 drivers/nvme/host/core.c

  2153	
  2154	static int nvme_check_fdp(struct nvme_ns *ns, struct nvme_ns_info *info,
  2155				  u8 fdp_idx)
  2156	{
  2157		struct nvme_fdp_config_log hdr, *h;
  2158		struct nvme_fdp_config_desc *desc;
  2159		size_t size = sizeof(hdr);
  2160		int i, n, ret;
  2161		void *log;
  2162	
  2163		info->runs = 0;
  2164		ret = nvme_get_log_lsi(ns->ctrl, 0, NVME_LOG_FDP_CONFIGS, 0, NVME_CSI_NVM,
  2165				   (void *)&hdr, size, 0, info->endgid);
  2166		if (ret)
  2167			return ret;
  2168	
  2169		size = le32_to_cpu(hdr.sze);
  2170		h = kzalloc(size, GFP_KERNEL);
  2171		if (!h)
  2172			return 0;
  2173	
  2174		ret = nvme_get_log_lsi(ns->ctrl, 0, NVME_LOG_FDP_CONFIGS, 0, NVME_CSI_NVM,
  2175				   h, size, 0, info->endgid);
  2176		if (ret)
  2177			goto out;
  2178	
  2179		n = le16_to_cpu(h->numfdpc) + 1;
  2180		if (fdp_idx > n)
  2181			goto out;
  2182	
  2183		log = h + 1;
  2184		do {
  2185			desc = log;
  2186			log += le16_to_cpu(desc->dsze);
> 2187		} while (i++ < fdp_idx);
  2188	
  2189		info->runs = le64_to_cpu(desc->runs);
  2190	out:
  2191		kfree(h);
  2192		return ret;
  2193	}
  2194	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

