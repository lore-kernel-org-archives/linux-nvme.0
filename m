Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229A9C004C0
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Oct 2023 03:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RjnVLFOXlRo5qH1/fk48z+XiPGxw16E5fHXtwa4n7Gk=; b=wBPUCG9N+CMP5mrMMPDIIwQsQy
	g46lVuuuQ2j1MjzPydtLB0lb6uBQ8D1Wfg61xXjPFYmeX+Vb/yL9R0e3wTJg/xAPqt66SdpNhndro
	C56Xwh7JQtX4xDQ5CksokhyHq/ZYAX8fZ0MTMqXUY/3vAiZ76S2zv8GOyzSvUkxQW5BG0XoUyR0pE
	xlgTvuq/FNkM5ks8XLlPIxruN3l7WEiHq05vjjE1hDg1iBHtgt99jiT8Zzrkv0cKIQUQ5DPmx8I1P
	fNn81POJh78sC19JVfA4l6iM0oYT4FCBZJH4VEXFuv/ld6IuO5sULRPG81i5tNarmjhRRn4+5ruP7
	ouOWvnfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qu33u-003Ryr-2H;
	Sat, 21 Oct 2023 03:54:06 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qu33m-003Rxz-0c
	for linux-nvme@lists.infradead.org;
	Sat, 21 Oct 2023 03:54:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697860438; x=1729396438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KSNO7vOH2xYOL/+j22XGMf283vnlJoT1CRb7A5owLFQ=;
  b=oJZY0lzZe9mRu+V3a5om7YBtUNRwmCzwgNpT/j4JlK/lCj4DzsllTFqk
   B5LgvbdIaxyuhJaHj1GKByPU9+jOENRUG7T+TMgivQqbF6r7ifH/S/XA2
   iTLBxMKEgTom3mq8swce6f7pWbqGEaZ528H63YTyb5A8zXu22lkxuVUoH
   7PqW/TmqJGkaRe3bzciG3OhDYjxvxRbDFutBRRUjOvOp3tCtFEvnzPFnA
   RV+pnoFlG2A+WrRZixEE5z+3li9/ls6ST6g8376WWdPPf8WQtHESLBqfm
   z9W2iV+wYUbOLkOcHYsCAjA5CwJd2mrkL0/rgEA4I4hQl7t9aSGSTSp0e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="366836731"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="366836731"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 20:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="823451798"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="823451798"
Received: from lkp-server01.sh.intel.com (HELO 8917679a5d3e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 20 Oct 2023 20:53:47 -0700
Received: from kbuild by 8917679a5d3e with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qu33Y-0004Na-2Z;
	Sat, 21 Oct 2023 03:53:44 +0000
Date: Sat, 21 Oct 2023 11:53:01 +0800
From: kernel test robot <lkp@intel.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, io-uring@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, axboe@kernel.dk, hch@lst.de,
	joshi.k@samsung.com, martin.petersen@oracle.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 1/4] block: bio-integrity: add support for user buffers
Message-ID: <202310211117.qmDPOVfI-lkp@intel.com>
References: <20231018151843.3542335-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018151843.3542335-2-kbusch@meta.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_205358_244649_EE1B9F23 
X-CRM114-Status: GOOD (  11.87  )
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

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.6-rc6 next-20231020]
[cannot apply to axboe-block/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Keith-Busch/block-bio-integrity-add-support-for-user-buffers/20231018-232704
base:   linus/master
patch link:    https://lore.kernel.org/r/20231018151843.3542335-2-kbusch%40meta.com
patch subject: [PATCH 1/4] block: bio-integrity: add support for user buffers
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20231021/202310211117.qmDPOVfI-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20231021/202310211117.qmDPOVfI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202310211117.qmDPOVfI-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/blkdev.h:17:0,
                    from init/main.c:85:
   include/linux/bio.h: In function 'bio_integrity_map_user':
>> include/linux/bio.h:798:1: error: expected ';' before '}' token
    }
    ^
--
   In file included from include/linux/blkdev.h:17:0,
                    from lib/vsprintf.c:47:
   include/linux/bio.h: In function 'bio_integrity_map_user':
>> include/linux/bio.h:798:1: error: expected ';' before '}' token
    }
    ^
   lib/vsprintf.c: In function 'va_format':
   lib/vsprintf.c:1682:2: warning: function 'va_format' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     buf += vsnprintf(buf, end > buf ? end - buf : 0, va_fmt->fmt, va);
     ^~~


vim +798 include/linux/bio.h

   793	
   794	static inline int bio_integrity_map_user(struct bio *bio, void __user *ubuf,
   795						 unsigned int len, u32 seed, u32 maxvecs)
   796	{
   797		return -EINVAL
 > 798	}
   799	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

