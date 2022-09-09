Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12FCC54EE9
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Sep 2022 02:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+i3G4fpN6ZhDB/VBuENpvqkYWesaoQqDc2x4QWRptHI=; b=lBKDs/ukFoqetIp+BGprFXAaYg
	ews6mrqb/B7HqMjYCySA04HAbWpHxND0MSrHotrzLw7FX2CWolVwI6RdZ7EkvW+YmuZAj80/AKQXp
	Dn/XOCuPjL4NkutLz0xGvGAjDB4k/W/hLBnuOqw52imuCgruQRpjHIUD9FpfomYtHSODjrnrpXKCX
	on6T7Btr1cbwv8ZuPIGnyNbEEmn9mf/oGaRAqhtuRXlOyQUe13gJAR6X4FsMPFoK9/8F0fMIGFVjg
	gyGZOsQ6bnHEbR55UHvYVWAzHxexHcTyiST/QK1UD6DYBgbmw1ZQmIJ0kq3qGfpXxxxOf80Zalt/o
	135G8vPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWUDI-00BPX0-6K; Fri, 09 Sep 2022 02:57:52 +0000
Received: from mga18.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oWUDF-00BPW0-AD
	for linux-nvme@lists.infradead.org; Fri, 09 Sep 2022 02:57:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662692269; x=1694228269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GYQjXMogk3Q/eRyj0b2IEL6FDeWTskgZLPR8V3YfuB4=;
  b=XKtfE9DnyJpNllBTwNKwF0pfwnfgf8DPI8FQoTh7WiCFpBlGK7QSrftK
   gEpNUpTl64ebJE9h7LKdDlHeQgorMgV80TG/41vvqvECwDxjhWQACItQk
   ejjorYhgq3v55Ze7VXhmK4KF8GHd00/09EqB7yDZxUlClsmwNYQN9t/91
   7yP3wcrMVzDSAnyxUwQ+nJnBSzImkcPj8OiWBynxVZegERhYqjPNndTgZ
   7qwJWHIJxGM3Ct9qkobTLoKNTGErsT7XCqsWmUI1nVHsDWztmxy+0uq5W
   LecLj2DbcNkrC0nPVcO33JTAj6yvzNFggDy9DlAMF9D1yMqUyKRplLa5x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="280407622"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="280407622"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 19:57:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="943610211"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Sep 2022 19:57:44 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1oWUD9-0000dR-2e;
	Fri, 09 Sep 2022 02:57:43 +0000
Date: Fri, 9 Sep 2022 10:57:13 +0800
From: kernel test robot <lkp@intel.com>
To: Kanchan Joshi <joshi.k@samsung.com>, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, asml.silence@gmail.com
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH for-next v6 1/5] io_uring: add io_uring_cmd_import_fixed
Message-ID: <202209091034.1uWUabFo-lkp@intel.com>
References: <20220908183511.2253-2-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908183511.2253-2-joshi.k@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220908_195749_422669_E9BCAAAB 
X-CRM114-Status: GOOD (  14.87  )
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on linus/master v6.0-rc4 next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Kanchan-Joshi/io_uring-add-io_uring_cmd_import_fixed/20220909-033508
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220909/202209091034.1uWUabFo-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0b61830b28b6a720a99d34aba08d3d466fe516ec
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kanchan-Joshi/io_uring-add-io_uring_cmd_import_fixed/20220909-033508
        git checkout 0b61830b28b6a720a99d34aba08d3d466fe516ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash net/unix/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/unix/scm.c:11:
>> include/linux/io_uring.h:65:5: warning: no previous prototype for function 'io_uring_cmd_import_fixed' [-Wmissing-prototypes]
   int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
       ^
   include/linux/io_uring.h:65:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
   ^
   static 
   1 warning generated.


vim +/io_uring_cmd_import_fixed +65 include/linux/io_uring.h

    46	
    47	static inline void io_uring_files_cancel(void)
    48	{
    49		if (current->io_uring) {
    50			io_uring_unreg_ringfd();
    51			__io_uring_cancel(false);
    52		}
    53	}
    54	static inline void io_uring_task_cancel(void)
    55	{
    56		if (current->io_uring)
    57			__io_uring_cancel(true);
    58	}
    59	static inline void io_uring_free(struct task_struct *tsk)
    60	{
    61		if (tsk->io_uring)
    62			__io_uring_free(tsk);
    63	}
    64	#else
  > 65	int io_uring_cmd_import_fixed(u64 ubuf, unsigned long len, int rw,
    66				      struct iov_iter *iter, void *ioucmd)
    67	{
    68		return -EOPNOTSUPP;
    69	}
    70	static inline void io_uring_cmd_done(struct io_uring_cmd *cmd, ssize_t ret,
    71			ssize_t ret2)
    72	{
    73	}
    74	static inline void io_uring_cmd_complete_in_task(struct io_uring_cmd *ioucmd,
    75				void (*task_work_cb)(struct io_uring_cmd *))
    76	{
    77	}
    78	static inline struct sock *io_uring_get_socket(struct file *file)
    79	{
    80		return NULL;
    81	}
    82	static inline void io_uring_task_cancel(void)
    83	{
    84	}
    85	static inline void io_uring_files_cancel(void)
    86	{
    87	}
    88	static inline void io_uring_free(struct task_struct *tsk)
    89	{
    90	}
    91	static inline const char *io_uring_get_opcode(u8 opcode)
    92	{
    93		return "";
    94	}
    95	#endif
    96	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

