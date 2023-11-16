Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D0BC072A2
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Nov 2023 02:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3p/VVt6cJ50slhqDy+9XV+ik669YdochUy7EEqvWr9g=; b=1hRMJWCmhquF7xKp9AVNcmQo6r
	VBQmWoyToUt9tE+y+bneHlqKoEW0cG/0aSUk7upcA76hd0t+025mT7yZncLCfrfhK89ZRONpaXRv7
	CVe8G+ZQrV2Srb4BkLNddUlyWLw6WCS3SoB8xN6jpgybNRyNoQ1AuTJP2FJask+OPHKB92BLhzr6T
	wX8arZe3YFLC3HeZdfxqK2NQhRz5jlWu+BzjClkR9+Vx5ltTewjRWLw+WBfehKVZBYgNJq2u3zcjn
	pqXofSkAXD9bMHqVaONjXN9S9LbPGJgCRL4mkdirF4mCm5/T7OtxRuAruj+6kp9rrmLHagkOH1+SM
	vqEiIFtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Rqk-002D8I-1H;
	Thu, 16 Nov 2023 02:11:22 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r3Rqh-002D7X-0O
	for linux-nvme@lists.infradead.org;
	Thu, 16 Nov 2023 02:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700100679; x=1731636679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hhlyXxGrC/E9zAEp+Y8MQVMk7XkRKYj0CGW6kL41jyg=;
  b=ZY+f6HeCtk8a9/Wgw7ADIwrzUrgqKvrh+Y3fUqaWhlpBaruTtyk/IT97
   6ZGbT2GWlTjl+S4yLmc5INj3y6wVEPVMbivdsOF3MyekFllYGqR22Tb4S
   M/3Vb17N5L3atItKE4ZaXCjw02amnXDGjmM0cT6veWzViscXGV5uEYbD6
   7p+ebUUE0FOZjo9UaSHXrJlgJdZ0A2MyRGS6SXGIOBP2R1+wpZrDhG+/T
   lgY3UXGvDJjGS/xsKZUuC5btTdOGfSwdH0vJDYWPh2kglGRpRjGkFQjJG
   73ruuxkUqm7whF3/aoXgr1pGn0luRDSG/vp0Z8XGbhvyOv3GJ651dE/TN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="371181333"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="371181333"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 18:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1096629973"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="1096629973"
Received: from lkp-server02.sh.intel.com (HELO b8de5498638e) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Nov 2023 18:11:11 -0800
Received: from kbuild by b8de5498638e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1r3RqH-00017W-3B;
	Thu, 16 Nov 2023 02:10:57 +0000
Date: Thu, 16 Nov 2023 10:09:48 +0800
From: kernel test robot <lkp@intel.com>
To: Aurelien Aptel <aaptel@nvidia.com>, linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org, sagi@grimberg.me, hch@lst.de,
	kbusch@kernel.org, axboe@fb.com, chaitanyak@nvidia.com,
	davem@davemloft.net, kuba@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Boris Pismenny <borisp@nvidia.com>, aaptel@nvidia.com,
	aurelien.aptel@gmail.com, smalin@nvidia.com, malin1024@gmail.com,
	ogerlitz@nvidia.com, yorayz@nvidia.com, galshalom@nvidia.com,
	mgurtovoy@nvidia.com, edumazet@google.com, pabeni@redhat.com,
	dsahern@kernel.org, ast@kernel.org, jacob.e.keller@intel.com
Subject: Re: [PATCH v19 01/20] net: Introduce direct data placement tcp
 offload
Message-ID: <202311161023.IHztbwM3-lkp@intel.com>
References: <20231114124255.765473-2-aaptel@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231114124255.765473-2-aaptel@nvidia.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231115_181119_174710_601F4CFD 
X-CRM114-Status: GOOD (  12.33  )
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
config: x86_64-rhel-8.3-rust (https://download.01.org/0day-ci/archive/20231116/202311161023.IHztbwM3-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231116/202311161023.IHztbwM3-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202311161023.IHztbwM3-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/core/skbuff.c:79:
>> include/net/ulp_ddp.h:317:6: warning: no previous prototype for function 'ulp_ddp_is_cap_active' [-Wmissing-prototypes]
   bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
        ^
   include/net/ulp_ddp.h:317:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool ulp_ddp_is_cap_active(struct net_device *netdev, int cap_bit_nr)
   ^
   static 
   1 warning generated.


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

