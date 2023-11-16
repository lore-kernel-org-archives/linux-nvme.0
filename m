Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6732C2BB3F
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Nov 2023 00:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G/d6MpgYRxgSN/WGssKgxGGkKwl5hUAzqP/NtEDATt4=; b=2sq0G2JHb3DvyRvuHQlYDB8FDo
	ul5OdnMHAVCWyPkHJOvfCE2HZxr30/KVfRnW6muWnz5/2GWaH68bgJd92flIeWUDgM/q3a4mr0ng9
	Rtl76oLBnwRBuJ2OzpRPDBkK62LCZ9iK5zGIhQEBsqOf2JWVPEiK7jO09Yz+u44yml4IO2zPYHaJV
	vx+OtO3KAflcpmdkhIottVCAko2Vq2hwStLySTK4j0SjWBfd+bCfLMQwWM7JA6ZfUkgXHd+UotEo0
	kENYL9xFYVg6xHfhuzqjMfxycM/zVuqvhnCNOPZEHu+skRBTemhu6nTGhDayya1XLzW1GPF0TUtqn
	XeXwqBjQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3QP3-0025fK-0I;
	Thu, 16 Nov 2023 00:38:41 +0000
Received: from mgamail.intel.com ([192.55.52.93])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3QOw-0025eo-0H
	for linux-nvme@lists.infradead.org;
	Thu, 16 Nov 2023 00:38:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700095114; x=1731631114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6Nban/4GtABuUf72xG+2olETq56cTiUKc24hK+K823A=;
  b=mZlLsV1gq2t2c5BFegd57FmfFz7UF8IxPQTB4mNzciAY9hvX2lZaUp3K
   ANWxRWZi54SDyv5pRkvNfDagKnFTz05uzPPdFyzh+mNjnfqbhWxGYEpLe
   7kSvRd5fYbXLCyKijITAMfpVUO7dZfE83t83MJkMSoS9UEAf56bb46hZF
   RR5bR7v5biDpQck6XihDycusWrZxk9b++gab80UqeGAVHFo1rae07B7Qy
   feFOel/60F92rb01sKdfVAvVIjgz6Y1bGlavYGCDQNHC90Tl/zYYEm9G4
   HHRyOZxwF9HXm6PFioKEBRpG/RvoG8Hg+tggRNP89iIon0zEn5HPqFHya
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="388150580"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="388150580"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 16:38:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="888739641"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="888739641"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Nov 2023 16:38:04 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3QOP-00013E-2V;
	Thu, 16 Nov 2023 00:38:01 +0000
Date: Thu, 16 Nov 2023 08:37:46 +0800
From: kernel test robot <lkp@intel.com>
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de,
	kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
	davem@davemloft.net, kuba@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Boris Pismenny <borisp@nvidia.com>,
	aaptel@nvidia.com, aurelien.aptel@gmail.com, smalin@nvidia.com,
	malin1024@gmail.com, ogerlitz@nvidia.com, yorayz@nvidia.com,
	galshalom@nvidia.com, mgurtovoy@nvidia.com, edumazet@google.com,
	pabeni@redhat.com, dsahern@kernel.org, ast@kernel.org,
	jacob.e.keller@intel.com
Subject: Re: [PATCH v19 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <202311160837.5lnRXiOm-lkp@intel.com>
References: <20231114124255.765473-2-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114124255.765473-2-aaptel@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_163834_160514_8B21A186 
X-CRM114-Status: GOOD (  12.20  )
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

Hi Aurelien,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]
[also build test WARNING on net-next/main linus/master v6.7-rc1 next-20231115]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aurelien-Aptel/net-Introduce-direct-data-placement-tcp-offload/20231114-205106
base:   net/main
patch link:    https://lore.kernel.org/r/20231114124255.765473-2-aaptel%40nvidia.com
patch subject: [PATCH v19 01/20] net: Introduce direct data placement tcp offload
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20231116/202311160837.5lnRXiOm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-12) 11.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311160837.5lnRXiOm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311160837.5lnRXiOm-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/core/skbuff.c:79:
>> include/net/ulp_ddp.h:317:6: warning: no previous prototype for 'ulp_ddp_is_cap_active' [-Wmissing-prototypes]
     317 | bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
         |      ^~~~~~~~~~~~~~~~~~~~~


vim +/ulp_ddp_is_cap_active +317 include/net/ulp_ddp.h

   316	
 > 317	bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
   318	{
   319		return false;
   320	}
   321	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

