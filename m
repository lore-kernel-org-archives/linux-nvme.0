Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2603BCA0EE9
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Aug 2025 20:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JC9joVh3uacdmJGMpZmhKWSQLvR3gNP5UHY+C89VLpw=; b=d0a+Cy9f1y/KQw5LYI7PdkU5cm
	qD/fADn4NeO8a3xmNG0S5oehwBydOIXZV6QV6HzHVzfEk01tiwI7CFdAZErgiNqO7vvKVh6BVHv0M
	jLW53h9JqwL4Sgd/eK7OQRutaT6fT4CFuGUfwS/PF7H6bHxXrNwHiaJhA5+Jj8nwgJy+zdzF+jCpi
	sIY87DxcrymRZrfU7tol9hM1y6EMo2otevAI7vk2icm40Ck3uRYExA3FiMoHSJJNOweYp+XVx0JEZ
	f31J/NYJOcaF+NJTb75uQ1InysQVisJ6fXFt3bSHwuAt6QI9yGm1U0mtHEkNRdWGVZCljFpZZ6dy3
	quuMT7WQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un0un-00000003Ro2-2xOh;
	Fri, 15 Aug 2025 20:20:41 +0000
Received: from mgamail.intel.com ([192.198.163.15])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1un0eq-00000003Ot8-3DGC
	for linux-nvme@lists.infradead.org;
	Fri, 15 Aug 2025 20:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755288253; x=1786824253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KdoNFM0JyALmDBeXeK9bjvyngTHO5qk2sJ3MRHhIr5Y=;
  b=DtTV8OcBzCvJRJTBdMIDdU/U1yg8X2HI6fZNw7Z2H4Qjs5p7clZXykJ8
   hKhGNTR7B4Orn7iFqD/MYm1rRNoqrbigRz3pO2tF1axw36MaMUy6xjJjc
   J18+1FOI2KiJMIJfMCb2sMANUo8ST5LlgA7Oku0j80SNkqMR1frCb5Qu0
   o2nfx/GNnIS2Nl7De9+9lJyzR/39IWdbMsIASz9VMlthx7HKlru3Agjsb
   gULM7A6cUGEzKJ6+U+IffJGaELFp3kTshUGtcxhlkG2Jr1G4cMGBETF7A
   WaDMJ8hGe9mcNGQ0nt5lLKL9tg2I3SEsyJ8jBtSirJpmAKQZDyofpmbk0
   g==;
X-CSE-ConnectionGUID: 3hInw0H0TXK5iblLMGtLUQ==
X-CSE-MsgGUID: dcntBOwuTPqEoTQRV3/Xmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11523"; a="57716981"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="57716981"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2025 13:04:06 -0700
X-CSE-ConnectionGUID: p62lv+19RGmetwWyYZhq1A==
X-CSE-MsgGUID: ipz8qSBhSIme0DYb3mWaXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; 
   d="scan'208";a="167048938"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 15 Aug 2025 13:04:02 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1un0eZ-000CIy-2g;
	Fri, 15 Aug 2025 20:03:57 +0000
Date: Sat, 16 Aug 2025 04:03:19 +0800
From: kernel test robot <lkp@intel.com>
To: alistair23@gmail.com, chuck.lever@oracle.com, hare@kernel.org,
	kernel-tls-handshake@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-nfs@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, kbusch@kernel.org,
	axboe@kernel.dk, hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 2/8] net/handshake: Make handshake_req_cancel public
Message-ID: <202508160354.iNoLUr4h-lkp@intel.com>
References: <20250815050210.1518439-3-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815050210.1518439-3-alistair.francis@wdc.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250815_130412_841731_0C08603F 
X-CRM114-Status: GOOD (  12.60  )
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

Hi,

kernel test robot noticed the following build warnings:

[auto build test WARNING on trondmy-nfs/linux-next]
[also build test WARNING on net/main net-next/main linus/master linux-nvme/for-next v6.17-rc1 next-20250815]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/alistair23-gmail-com/net-handshake-Store-the-key-serial-number-on-completion/20250815-130804
base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-next
patch link:    https://lore.kernel.org/r/20250815050210.1518439-3-alistair.francis%40wdc.com
patch subject: [PATCH 2/8] net/handshake: Make handshake_req_cancel public
config: arm-mps2_defconfig (https://download.01.org/0day-ci/archive/20250816/202508160354.iNoLUr4h-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 93d24b6b7b148c47a2fa228a4ef31524fa1d9f3f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250816/202508160354.iNoLUr4h-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508160354.iNoLUr4h-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/handshake/request.c:312:6: warning: no previous prototype for function 'handshake_req_cancel' [-Wmissing-prototypes]
     312 | bool handshake_req_cancel(struct sock *sk)
         |      ^
   net/handshake/request.c:312:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
     312 | bool handshake_req_cancel(struct sock *sk)
         | ^
         | static 
   1 warning generated.


vim +/handshake_req_cancel +312 net/handshake/request.c

3b3009ea8abb71 Chuck Lever 2023-04-17  300  
3b3009ea8abb71 Chuck Lever 2023-04-17  301  /**
3b3009ea8abb71 Chuck Lever 2023-04-17  302   * handshake_req_cancel - Cancel an in-progress handshake
3b3009ea8abb71 Chuck Lever 2023-04-17  303   * @sk: socket on which there is an ongoing handshake
3b3009ea8abb71 Chuck Lever 2023-04-17  304   *
3b3009ea8abb71 Chuck Lever 2023-04-17  305   * Request cancellation races with request completion. To determine
3b3009ea8abb71 Chuck Lever 2023-04-17  306   * who won, callers examine the return value from this function.
3b3009ea8abb71 Chuck Lever 2023-04-17  307   *
3b3009ea8abb71 Chuck Lever 2023-04-17  308   * Return values:
3b3009ea8abb71 Chuck Lever 2023-04-17  309   *   %true - Uncompleted handshake request was canceled
3b3009ea8abb71 Chuck Lever 2023-04-17  310   *   %false - Handshake request already completed or not found
3b3009ea8abb71 Chuck Lever 2023-04-17  311   */
3b3009ea8abb71 Chuck Lever 2023-04-17 @312  bool handshake_req_cancel(struct sock *sk)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

