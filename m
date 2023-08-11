Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615CEC0015E
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Aug 2023 21:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F2QCXlx2iU2QFsTm1ME2F1Q4OPNaqUJlaGebHWFuUbM=; b=fC7suF0VV+3g3HbS17PPyehbv0
	VKKoFnABhPxq/iKx/8WKBe0C8WrkIvuKV/wszLqS2Ks4lQtdEzsBr0bePMZILtrG+v6zt70AV2mgy
	xlVLU6ZhDq3Dt91rURXsMix5h+00RGeaVyGCSYReLOLzeiyw907SB0Znw6NeiwAWDGLhL5ro71kgz
	fNmPHCbM65I7qeJwvTOkgefoi9ftDO7QXKkgbd0NvVm0oBNXts6pUjhUU2l+Z4IX7Pv1S77dQgAci
	eMnTPeEwyn0AIDtj7Kt5MoGvHQbM+szuFSg1FRlRERX778fO6+Gy2h+MiRCx8GFPO1W/FnVDr+l/L
	YLVNqBIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qUZUh-00Bfi5-2y;
	Fri, 11 Aug 2023 21:16:27 +0000
Received: from mgamail.intel.com ([134.134.136.100])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qUZUf-00BfhE-1i
	for linux-nvme@lists.infradead.org;
	Fri, 11 Aug 2023 21:16:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691788585; x=1723324585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r3gM2YsGq24wLI63levM/2uhpcljlyD/xcFHlYhLSl8=;
  b=bm7lo8/9H0MJOBrZ4n1Xr3yx1Gu1sMlsm0sB57HDBBo//IRSuFfGTZ87
   sdIBP3lCZpLhJzs/nLkk4gI+pccKmPB8gyEr94/KRA5Yu94E24x8LEnp8
   HGicYaTJSqtAGjm2rXKt3XkgRylA9jsZGxgoaqaOzvb6zk1YjMpFp+wgw
   fyefdqclwVuwbxu46nEsTr4L82t+FBeRWLy42iGWQnGua6vmR+KEAMq/D
   rHlkIR/jtba+BwtDfptjFOeba4hrBSGqPv2Yog2b9wfXaerxbyfCmY3tI
   Qxc+eTn9eW2h6Wdlo0Cy8lkcnvieD5PJUqvxjeOuxSkSn/iaLcMut74T2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="438098270"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="438098270"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 14:15:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10799"; a="802817157"
X-IronPort-AV: E=Sophos;i="6.01,166,1684825200"; 
   d="scan'208";a="802817157"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 11 Aug 2023 14:15:52 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qUZU8-00082u-06;
	Fri, 11 Aug 2023 21:15:52 +0000
Date: Sat, 12 Aug 2023 05:15:10 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	martin.petersen@oracle.com, mcgrof@kernel.org, dlemoal@kernel.org,
	gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Vincent Fu <vincent.fu@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 11/11] null_blk: add support for copy offload
Message-ID: <202308120529.EW7DuUW7-lkp@intel.com>
References: <20230811105300.15889-12-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811105300.15889-12-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230811_141625_611458_C57BEA88 
X-CRM114-Status: GOOD (  12.54  )
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

Hi Nitesh,

kernel test robot noticed the following build errors:

[auto build test ERROR on f7dc24b3413851109c4047b22997bd0d95ed52a2]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-and-sysfs-for-copy-offload-support/20230811-192259
base:   f7dc24b3413851109c4047b22997bd0d95ed52a2
patch link:    https://lore.kernel.org/r/20230811105300.15889-12-nj.shetty%40samsung.com
patch subject: [PATCH v14 11/11] null_blk: add support for copy offload
config: hexagon-randconfig-r032-20230811 (https://download.01.org/0day-ci/archive/20230812/202308120529.EW7DuUW7-lkp@intel.com/config)
compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project.git 4a5ac14ee968ff0ad5d2cc1ffa0299048db4c88a)
reproduce: (https://download.01.org/0day-ci/archive/20230812/202308120529.EW7DuUW7-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308120529.EW7DuUW7-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: __tracepoint_nullb_copy_op
   >>> referenced by atomic-arch-fallback.h:444 (include/linux/atomic/atomic-arch-fallback.h:444)
   >>>               drivers/block/null_blk/main.o:(null_process_cmd) in archive vmlinux.a
   >>> referenced by atomic-arch-fallback.h:444 (include/linux/atomic/atomic-arch-fallback.h:444)
   >>>               drivers/block/null_blk/main.o:(null_process_cmd) in archive vmlinux.a
--
>> ld.lld: error: undefined symbol: __traceiter_nullb_copy_op
   >>> referenced by trace.h:71 (drivers/block/null_blk/trace.h:71)
   >>>               drivers/block/null_blk/main.o:(null_process_cmd) in archive vmlinux.a
   >>> referenced by trace.h:71 (drivers/block/null_blk/trace.h:71)
   >>>               drivers/block/null_blk/main.o:(null_process_cmd) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

