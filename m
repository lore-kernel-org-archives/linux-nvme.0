Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3D5ECAAA1
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 04:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FSGf3/K9bnABCwE5Wiph1qYBtDDTB9+t53HS6T+a4U0=; b=ZphiAbCDr9m6QkEzlvl+dagxS9
	u2n/DsYESkGX16wNyZ7TXdj38Aesz94C/LRiJPpnXTHMeLiCXWf9oRmuL3joY1haYfLI11NfMRxAK
	JcqIYUNq5f+SONRiDiF/fh1qty9IblYx//nhMP7Ia/XK5j2FP4Jj2xtVoSvAcN9nC9cyKcNyM/75Q
	O5qIM9XuV4n6j7ijpYzJaEfk9yGjcXdWIEvR5hzSv5tzqNBnKy4FS5Mff2O1KOUN1XuLFbMpMDP71
	TVeZfc3aWSXxvskHO5RRXGoZc5Qz2vLQyJMo2/YYzG2kxCnHOEi1pCVKBDDrMBTYm6gWMpTju41DL
	PcpI7grQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWVUh-00C9nQ-Vu; Fri, 09 Sep 2022 04:19:56 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWVUe-00C9kE-TO
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 04:19:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662697192; x=1694233192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eSrNIJmzCvQPmppednT9KsYGtdgqhbjbMBSL7ABNuFE=;
  b=WteSb/uUGNk1oJeibWjG1kW19KpkR/NH/m0SR41t99ZcJd/MCIfBNszI
   mEXa7ddSsNqa3Dqoy79q2BEIHTf/FgDIvPMKBH7jml/Lc5PEbXIgB5X2L
   yX95t+xYwjLDI6P4iLaPjSlTFkANMgz/Yu8N3UmVrkuJvw4kKRYp0PwGu
   mkZyIZCvUvfpxWJImepBoyVuaK5nLwX01UAZhN/jeWIZSFVTXXtqSZKeM
   +DwiXQSvUhL2syi4nqzVxCMb9sauMPkmuZ9tcXdH7SWo74JsF6CDAav5r
   bdCgxdJjJUCBAOcIbR+1Oe+TrzFEP9TtuMps5koHVpF67fuvZxlep8KgD
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280419112"
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="280419112"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 21:19:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,302,1654585200"; 
   d="scan'208";a="704273208"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Sep 2022 21:19:47 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oWVUY-0000i7-1P;
	Fri, 09 Sep 2022 04:19:46 +0000
Date: Fri, 9 Sep 2022 12:19:16 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, asml.silence@gmail.com
Cc: kbuild-all@lists.01.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH for-next v6 1/5] io_uring: add io_uring_cmd_import_fixed
Message-ID: <202209091233.3r9bDGWS-lkp@intel.com>
References: <20220908183511.2253-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908183511.2253-2-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_211953_052776_6FE2ACF1 
X-CRM114-Status: GOOD (  12.58  )
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

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linus/master v6.0-rc4 next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/io_uring-add-io_uring_cmd_import_fixed/20220909-033508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: riscv-nommu_virt_defconfig (https://download.01.org/0day-ci/archive/20220909/202209091233.3r9bDGWS-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0b61830b28b6a720a99d34aba08d3d466fe516ec
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kanchan-Joshi/io_uring-add-io_uring_cmd_import_fixed/20220909-033508
        git checkout 0b61830b28b6a720a99d34aba08d3d466fe516ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv64-linux-ld: kernel/exit.o: in function `io_uring_cmd_import_fixed':
>> exit.c:(.text+0x642): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x6e8): first defined here
   riscv64-linux-ld: fs/exec.o: in function `io_uring_cmd_import_fixed':
   exec.c:(.text+0xc6e): multiple definition of `io_uring_cmd_import_fixed'; kernel/fork.o:fork.c:(.text+0x6e8): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

