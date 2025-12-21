Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29310E66886
	for <linux-nvme@archiver.kernel.org>; Sun, 21 Dec 2025 13:02:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Zy6waU7EezOvcAwAlD3ROgn9Xyow4GE/ZTEdH+hEbbM=; b=bV/dSS9RxfGy3hfO5WZQTgkLoX
	Ufzn/gU7Tj0sKXBpJrOwtz3v4G16PPXAS7CpLkGOnZ0f63hcK2C2dtnV9vRCQnsUSBr9JH6O3Uzai
	TnSeIomV3UYbMnGCxd54TPATQrwW7sKf8Hx/gi71YmGCRAmrWgL1pyeWeak0xOwad5xrE1Szoav7k
	yxFApirpPrfzXjizLEjAB4I7WpB+CAaLrtbpUIlP1xcvVU+/Z9wDOOsSfsV23ESjO0JayiN6qHDcK
	zeMLAwv/indOGn5cpHAL9r3eevqduD7uECp9FPxA/cTS4ZD+SKn4b3hrAGgRH5bdxI4rd0Ctp4TCQ
	jYEhAdkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXJ4Y-0000000CRwK-2xmo;
	Sun, 21 Dec 2025 13:02:06 +0000
Received: from mgamail.intel.com ([192.198.163.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vXJ4V-0000000CRvw-0lR8
	for linux-nvme@lists.infradead.org;
	Sun, 21 Dec 2025 13:02:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766322123; x=1797858123;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IelPuQfpRKpMJVdVfQngugsAIYeDlUYPxZTLwugxbgg=;
  b=ER1Ik8HCkSNidPJusuCBSOzgpU6+wfTGksbvdFIGtuHm7Y1lcBoU8Y1U
   aBQ0wiVv1AiQk3LOw8kXVa+sV8tKoHOwQH4upbPYSfcnz/EzZ3LvNPW14
   pYfC+flf8P7VtLfdd+UO3qVsC7Vv7cbpX+EfKHDtUt5pNjC6A7YIjqrzQ
   BOPaY4Zfde0tcxKUWxWLtEi+MmzUeDfQ1nplyxjkmj6wtNaGYRnaUjvL0
   AVjKZ3l9gzQxjgAG4y9M6DouCsxZXRSgIrcIUzWh6QloqdavYB/rIkifo
   aVdrNYMjnk0i82vHwQetNotFl0MRMraQPY/WXn7vsUyO862uBVx9CvkZC
   w==;
X-CSE-ConnectionGUID: /99mV2a/TSW2GKGN4Sp0gw==
X-CSE-MsgGUID: JpzbK3gpSBWZ0deDHEMj/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11649"; a="68084630"
X-IronPort-AV: E=Sophos;i="6.21,166,1763452800"; 
   d="scan'208";a="68084630"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2025 05:02:02 -0800
X-CSE-ConnectionGUID: tSMa9SGsQR6X4MkfEPOybw==
X-CSE-MsgGUID: zpzgTZWNSviZ9bksHBD5rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,166,1763452800"; 
   d="scan'208";a="198547878"
Received: from igk-lkp-server01.igk.intel.com (HELO 8a0c053bdd2a) ([10.211.93.152])
  by orviesa010.jf.intel.com with ESMTP; 21 Dec 2025 05:02:01 -0800
Received: from kbuild by 8a0c053bdd2a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vXJ4Q-00000000548-17Dx;
	Sun, 21 Dec 2025 13:01:58 +0000
Date: Sun, 21 Dec 2025 14:01:10 +0100
From: kernel test robot <lkp@intel.com>
To: Vitaliy Filippov <vitalifster@gmail.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Vitaliy Filippov <vitalifster@gmail.com>
Subject: Re: [PATCH] Do not require atomic writes to be power of 2 sized and
 aligned on length boundary
Message-ID: <202512211420.W7jr2osh-lkp@intel.com>
References: <20251220173833.71176-1-vitalifster@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251220173833.71176-1-vitalifster@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251221_050203_637068_84A6CDC9 
X-CRM114-Status: GOOD (  10.39  )
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

Hi Vitaliy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on brauner-vfs/vfs.all]
[also build test WARNING on linus/master v6.19-rc1 next-20251219]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vitaliy-Filippov/Do-not-require-atomic-writes-to-be-power-of-2-sized-and-aligned-on-length-boundary/20251221-014115
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git vfs.all
patch link:    https://lore.kernel.org/r/20251220173833.71176-1-vitalifster%40gmail.com
patch subject: [PATCH] Do not require atomic writes to be power of 2 sized and aligned on length boundary
config: x86_64-kexec (https://download.01.org/0day-ci/archive/20251221/202512211420.W7jr2osh-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251221/202512211420.W7jr2osh-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202512211420.W7jr2osh-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> fs/read_write.c:1805:9: warning: unused variable 'len' [-Wunused-variable]
    1805 |         size_t len = iov_iter_count(iter);
         |                ^~~
   1 warning generated.


vim +/len +1805 fs/read_write.c

c34fc6f26ab86d Prasad Singamsetty 2024-06-20  1802  
c3be7ebbbce520 John Garry         2024-10-19  1803  int generic_atomic_write_valid(struct kiocb *iocb, struct iov_iter *iter)
c34fc6f26ab86d Prasad Singamsetty 2024-06-20  1804  {
c34fc6f26ab86d Prasad Singamsetty 2024-06-20 @1805  	size_t len = iov_iter_count(iter);

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

