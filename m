Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044E7E77173
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Dec 2024 13:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ExX9apMsPjpO+/uUvpjRGZdsPlZyfXcJqsY8OlqA8WU=; b=enkx/tyx9Sy/aHTZ/TLIAmWGHB
	VVo9dAjn+xfoUO910aP2yDQuBwrgtoILIhW3npGvZnc9aYQkEFAK3PDdsZpHSFfHS6FikYnx1+u9Y
	inpPnplp1ERhwAlDEhpb5WwA9BgZwwL1//OtTdeIF+4hCQO4nB5+Pk3WDMZd99g7NmR9DHS4ZR6Fw
	s4wJOET5T66XaVSdB6uMXe//cBC+c8yKrseWq7/uKH0S3GnhCHgXe6AMqqD3Xp90ZhuIn9K6VFmeJ
	QAFWQHiT5OQ0L2Jd28TZEimekEREvDiTrZZ5kTRnIw0XWN/9M4zfN/3ek56rvOtPl/1Cz2pVTDRQ4
	Ise3/8Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tJYEn-00000001iAs-2TRZ;
	Fri, 06 Dec 2024 13:19:17 +0000
Received: from mgamail.intel.com ([192.198.163.14])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tJYEl-00000001i9z-1DXP
	for linux-nvme@lists.infradead.org;
	Fri, 06 Dec 2024 13:19:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733491155; x=1765027155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ReJyLj4SdzIR5dt17fE0IRPkn0ixnhvwFQ8E8A1Bd50=;
  b=OCbdwrDAaB0XO+P6aIxf+9LCZJyE1DtajVsfBtEJgQS1IKy31863yEjr
   OWq/EJNmYQwStBw805yPCjcDziUWvzBCuoHCBhGGBcT74QPErFJ4Fmi/S
   FyvewcUVsdk3qvETPYfRgRkJ+Wla1dQMsyqveS64CzeB3p7MmPMG5W0NP
   f6Yg0NC38WeEKj8kuNEmiAvKuDBH2kn+fgxLOi5HfiDVptF3k6hn+1aVr
   aqwoFf4Sw9DBb0PgkTaECLjwlykWvXt8rAdQsmFXCOrkjKImAWBQHiJRD
   uYoVSFsuG1jDkQXWAW8NMo6nqQnxaLRUMLqyR2qzE9OF+BLjuKc1jkmkU
   g==;
X-CSE-ConnectionGUID: rA9SO7F/QB2MWVO9dJPx0Q==
X-CSE-MsgGUID: 7/7H9g8lSzute8qKikfn1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11278"; a="34080517"
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="34080517"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:19:11 -0800
X-CSE-ConnectionGUID: MzWSVAckTBqH+m6g+yoiQQ==
X-CSE-MsgGUID: tnGVdlFhRKCG/Vvc0iOvFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,213,1728975600"; 
   d="scan'208";a="94766654"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 06 Dec 2024 05:19:08 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tJYEb-00015D-31;
	Fri, 06 Dec 2024 13:19:05 +0000
Date: Fri, 6 Dec 2024 21:18:52 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk, hch@lst.de,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, sagi@grimberg.me, asml.silence@gmail.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv11 10/10] nvme: use fdp streams if write stream is
 provided
Message-ID: <202412062116.SzYvrv5L-lkp@intel.com>
References: <20241206015308.3342386-11-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206015308.3342386-11-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241206_051915_344175_6B5B4158 
X-CRM114-Status: GOOD (  11.28  )
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
patch link:    https://lore.kernel.org/r/20241206015308.3342386-11-kbusch%40meta.com
patch subject: [PATCHv11 10/10] nvme: use fdp streams if write stream is provided
config: i386-randconfig-061 (https://download.01.org/0day-ci/archive/20241206/202412062116.SzYvrv5L-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241206/202412062116.SzYvrv5L-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412062116.SzYvrv5L-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/nvme/host/core.c: note: in included file (through drivers/nvme/host/nvme.h):
   include/linux/nvme.h:790:44: sparse: sparse: array of flexible structures
>> drivers/nvme/host/core.c:2261:34: sparse: sparse: cast to restricted __le16
   drivers/nvme/host/core.c: note: in included file (through include/linux/async.h):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +2261 drivers/nvme/host/core.c

  2209	
  2210	static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
  2211	{
  2212		struct nvme_fdp_ruh_status_desc *ruhsd;
  2213		struct nvme_ns_head *head = ns->head;
  2214		struct nvme_fdp_ruh_status *ruhs;
  2215		struct nvme_command c = {};
  2216		u32 fdp, fdp_idx;
  2217		int size, ret, i;
  2218	
  2219		ret = nvme_get_features(ns->ctrl, NVME_FEAT_FDP, info->endgid, NULL, 0,
  2220					&fdp);
  2221		if (ret)
  2222			goto err;
  2223	
  2224		if (!(fdp & NVME_FDP_FDPE))
  2225			goto err;
  2226	
  2227		fdp_idx = (fdp >> NVME_FDP_FDPCIDX_SHIFT) & NVME_FDP_FDPCIDX_MASK;
  2228		ret = nvme_check_fdp(ns, info, fdp_idx);
  2229		if (ret || !info->runs)
  2230			goto err;
  2231	
  2232		size = struct_size(ruhs, ruhsd, NVME_MAX_PLIDS);
  2233		ruhs = kzalloc(size, GFP_KERNEL);
  2234		if (!ruhs) {
  2235			ret = -ENOMEM;
  2236			goto err;
  2237		}
  2238	
  2239		c.imr.opcode = nvme_cmd_io_mgmt_recv;
  2240		c.imr.nsid = cpu_to_le32(head->ns_id);
  2241		c.imr.mo = NVME_IO_MGMT_RECV_MO_RUHS;
  2242		c.imr.numd = cpu_to_le32(nvme_bytes_to_numd(size));
  2243		ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
  2244		if (ret)
  2245			goto free;
  2246	
  2247		head->nr_plids = le16_to_cpu(ruhs->nruhsd);
  2248		if (!head->nr_plids)
  2249			goto free;
  2250	
  2251		head->nr_plids = min(head->nr_plids, NVME_MAX_PLIDS);
  2252		head->plids = kcalloc(head->nr_plids, sizeof(head->plids),
  2253				      GFP_KERNEL);
  2254		if (!head->plids) {
  2255			ret = -ENOMEM;
  2256			goto free;
  2257		}
  2258	
  2259		for (i = 0; i < head->nr_plids; i++) {
  2260			ruhsd = &ruhs->ruhsd[i];
> 2261			head->plids[i] = le16_to_cpu(ruhsd->pid);
  2262		}
  2263	
  2264		kfree(ruhs);
  2265		return 0;
  2266	
  2267	free:
  2268		kfree(ruhs);
  2269	err:
  2270		head->nr_plids = 0;
  2271		info->runs = 0;
  2272		return ret;
  2273	}
  2274	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

