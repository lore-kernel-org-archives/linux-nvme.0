Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14D6C25B5F
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 09:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uCDem50XKNgUkZF8yXN/2SRseUbmlKmQ8HVM65RgEmk=; b=va7KxL8N7AysNmDcEqLNemJhuf
	t9+qY6YwMPI3cAYV9KVen51nDCoarTuZp5gDWO5SQF+kjipP1GUSyq2Tj/Wvzxm1CLVcJcZ8oxw+/
	BgE8wTYm8jWh+HD8ufSw3w4/K0rCjEy/yhwKAaARdxysGdj2lFjxzYSrlMK/nOq2IemBY9FHnt8da
	W2MtaIx9HO1eZCrgkyMQgFNDgs7ZQGMoZ1M9l4BeGBOtbgpvk/PmjywccOEJViPJJyQpdRgN1Pu09
	t0Ie4cG2Twdmji4DvkYPvbHoZqxdj+NR4AzXYyGbs/eG5F6Wr82SucBTmReztD+MNTSrGafu50zQl
	v+myHokQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5iuf-00000007cNy-2KSE;
	Sat, 11 May 2024 09:21:05 +0000
Received: from mgamail.intel.com ([192.198.163.9])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5iuc-00000007cNL-2HnZ
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 09:21:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715419263; x=1746955263;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DQpBtq68IfqYnNb/DPavjwmyzLGM9CygTz2lBL5qqeQ=;
  b=fxZGs2KcEZYuvDWqHSSxMcZJ+TiT/BGtE7WsoRFPzmcYkHfp3bvu4uwS
   9KseMsEY8GcBmV+9BkJmmJZedrb34H8H2Np+VaQqmbaqQT/VHCJ7/kTwI
   DV9Ewxu1V+ZUR930drcAVDaCDrZVgGhO3PphITIEvxIvfO734zyJp3hlj
   jLM0aKzgbD5k1oXn1smlsiKRc901NMZNyUchSNkKKmO3b2r2cfn2PbT5y
   EokjLJ2oJI/eLLyETCHvGszcxK/VpmEIafWkZExxbweSNU8ip1+1PcxXL
   78fmaQfKKdUFKuscmOoAnmB03gjjJjM0GtwJ8eyrTBi/YItp0WJrqqzrN
   g==;
X-CSE-ConnectionGUID: 47z42ojiS2qmER7HHeuMog==
X-CSE-MsgGUID: O3L5anOaQayG6lf7n2JzXA==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="22085919"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="22085919"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2024 02:21:01 -0700
X-CSE-ConnectionGUID: nl1xlx3/T5KwlxtJMV0OuA==
X-CSE-MsgGUID: Kvgj9g/tQYm3dL8Jt8bxyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="34406985"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 11 May 2024 02:20:57 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s5iuV-0007BA-0k;
	Sat, 11 May 2024 09:20:55 +0000
Date: Sat, 11 May 2024 17:20:00 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, kbusch@kernel.org,
	hch@lst.de
Cc: oe-kbuild-all@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, javier.gonz@samsung.com,
	bvanassche@acm.org, david@fromorbit.com, slava@dubeyko.com,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>,
	Hui Qi <hui81.qi@samsung.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH] nvme: enable FDP support
Message-ID: <202405111758.Ts2xnoZH-lkp@intel.com>
References: <20240510134015.29717-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240510134015.29717-1-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240511_022102_698409_E94AC282 
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

Hi Kanchan,

kernel test robot noticed the following build warnings:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.9-rc7 next-20240510]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/nvme-enable-FDP-support/20240510-214900
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
patch link:    https://lore.kernel.org/r/20240510134015.29717-1-joshi.k%40samsung.com
patch subject: [PATCH] nvme: enable FDP support
config: x86_64-randconfig-121-20240511 (https://download.01.org/0day-ci/archive/20240511/202405111758.Ts2xnoZH-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.5.0-4ubuntu2) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240511/202405111758.Ts2xnoZH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405111758.Ts2xnoZH-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/core.c:2120:30: sparse: sparse: cast to restricted __le16
   drivers/nvme/host/core.c:2126:38: sparse: sparse: cast to restricted __le16
   drivers/nvme/host/core.c: note: in included file (through include/linux/wait.h, include/linux/wait_bit.h, include/linux/fs.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true

vim +2120 drivers/nvme/host/core.c

  2098	
  2099	static int nvme_fetch_fdp_plids(struct nvme_ns *ns, u32 nsid)
  2100	{
  2101		struct nvme_command c = {};
  2102		struct nvme_fdp_ruh_status *ruhs;
  2103		struct nvme_fdp_ruh_status_desc *ruhsd;
  2104		int size, ret, i;
  2105	
  2106		size = sizeof(*ruhs) + NVME_MAX_PLIDS * sizeof(*ruhsd);
  2107		ruhs = kzalloc(size, GFP_KERNEL);
  2108		if (!ruhs)
  2109			return -ENOMEM;
  2110	
  2111		c.imr.opcode = nvme_cmd_io_mgmt_recv;
  2112		c.imr.nsid = cpu_to_le32(nsid);
  2113		c.imr.mo = 0x1;
  2114		c.imr.numd =  cpu_to_le32((size >> 2) - 1);
  2115	
  2116		ret = nvme_submit_sync_cmd(ns->queue, &c, ruhs, size);
  2117		if (ret)
  2118			goto out;
  2119	
> 2120		ns->head->nr_plids = le16_to_cpu(ruhs->nruhsd);
  2121		ns->head->nr_plids =
  2122			min_t(u16, ns->head->nr_plids, NVME_MAX_PLIDS);
  2123	
  2124		for (i = 0; i < ns->head->nr_plids; i++) {
  2125			ruhsd = &ruhs->ruhsd[i];
  2126			ns->head->plids[i] = le16_to_cpu(ruhsd->pid);
  2127		}
  2128	out:
  2129		kfree(ruhs);
  2130		return ret;
  2131	}
  2132	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

