Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E0DEE14A9
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Sep 2023 22:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8xDJjUBmbc5qaCZ6jQRb1LnHNqaZ4Bmvx2YNwo0sBgQ=; b=0Yb50H34QnHmaSmFDkls9Viskp
	C/whcjJX430FKxFiGM4I1fEC5328RU/SZr44Ul0ndbZm7+yz67ygNNX/VyORYRnrRWIixYSR0vPXu
	zL5kBZVI0dfDgu+DYnA571iVhZNYUaiSYFz4je6zc5ZWGwoDpe9BHDvC9oiLqyS3rxkrRuXoO63+F
	XG1cPnvc3mwrAXQUqDs2A/MRu9XBZPEwAWfszTz8CWHNP5mDb//69MBOtc/tIWEcBOYz0x/ZiYrZ4
	PRuoxIhECd1ixXCMXpkqbQNuD9hadEqkPEOfhr89/1udaTzAQZ8CS1pBZTnyn+6dpgNda/ZuiyPwL
	EwTwRjEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qe0bK-00Awxr-1a;
	Wed, 06 Sep 2023 22:02:18 +0000
Received: from mgamail.intel.com ([192.55.52.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qe0bH-00AwvR-2U
	for linux-nvme@lists.infradead.org;
	Wed, 06 Sep 2023 22:02:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694037735; x=1725573735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pAdvumZWRQ6k+Y91B7l2q4WBR9cPrmf9k41yWB8wT30=;
  b=D2KhrTzLkaYivQRGahhREcQJpLke1Q/ndqx9zWeUr/3MaMRvrzaAKg5n
   L3Hod2tUJKf1gBEgonhXV0WkFmOdhsj+GBuigw/mwnbIQwZkJXrP0gVHY
   UiqSX7KONpE1KXBo0jxeqNk3L+HxMrG3ShOTiY1a3dYps18/KLIOcfaIO
   xolN1d3dl7fZuCQrRSzBUleRJ8v/jqv3AoWA+2oBr6xifoHELdAKPNubE
   WnCqXWnT40fma/6Yohk8GnZCKKgNrs5tuFcdZXMzHLTf53NG+gDgeX0g1
   mLwskg7k4DEfaK02aZPCJSGc2EPorWDgX+lv8DvBFSkw1uZWBRUsdWmum
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="357507876"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="357507876"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 15:02:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="718438474"
X-IronPort-AV: E=Sophos;i="6.02,233,1688454000"; 
   d="scan'208";a="718438474"
Received: from lkp-server01.sh.intel.com (HELO 59b3c6e06877) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 06 Sep 2023 15:02:06 -0700
Received: from kbuild by 59b3c6e06877 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qe0b6-0000d2-00;
	Wed, 06 Sep 2023 22:02:04 +0000
Date: Thu, 7 Sep 2023 06:01:50 +0800
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
	martin.petersen@oracle.com, mcgrof@kernel.org, gost.dev@samsung.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Vincent Fu <vincent.fu@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v15 12/12] null_blk: add support for copy offload
Message-ID: <202309070542.P9utuu9p-lkp@intel.com>
References: <20230906163844.18754-13-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906163844.18754-13-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230906_150215_823526_71D1B814 
X-CRM114-Status: GOOD (  12.72  )
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on c50216cfa084d5eb67dc10e646a3283da1595bb6]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-and-sysfs-for-copy-offload-support/20230907-015817
base:   c50216cfa084d5eb67dc10e646a3283da1595bb6
patch link:    https://lore.kernel.org/r/20230906163844.18754-13-nj.shetty%40samsung.com
patch subject: [PATCH v15 12/12] null_blk: add support for copy offload
config: arm-randconfig-001-20230907 (https://download.01.org/0day-ci/archive/20230907/202309070542.P9utuu9p-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project.git f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230907/202309070542.P9utuu9p-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309070542.P9utuu9p-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from drivers/block/null_blk/main.c:15:
   In file included from drivers/block/null_blk/./trace.h:104:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
>> drivers/block/null_blk/./trace.h:94:34: warning: format specifies type 'unsigned long' but the argument has type 'size_t' (aka 'unsigned int') [-Wformat]
                             __entry->dst, __entry->src, __entry->len)
                             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~
   include/trace/stages/stage3_trace_output.h:6:17: note: expanded from macro '__entry'
   #define __entry field
                   ^
   include/trace/stages/stage3_trace_output.h:9:43: note: expanded from macro 'TP_printk'
   #define TP_printk(fmt, args...) fmt "\n", args
                                   ~~~       ^
   include/trace/trace_events.h:45:16: note: expanded from macro 'TRACE_EVENT'
                                PARAMS(print));                   \
                                ~~~~~~~^~~~~~~
   include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
   #define PARAMS(args...) args
                           ^~~~
   include/trace/trace_events.h:203:27: note: expanded from macro 'DECLARE_EVENT_CLASS'
           trace_event_printf(iter, print);                                \
                                    ^~~~~
   1 warning generated.


vim +94 drivers/block/null_blk/./trace.h

    72	
    73	TRACE_EVENT(nullb_copy_op,
    74			TP_PROTO(struct request *req,
    75				 sector_t dst, sector_t src, size_t len),
    76			TP_ARGS(req, dst, src, len),
    77			TP_STRUCT__entry(
    78					 __array(char, disk, DISK_NAME_LEN)
    79					 __field(enum req_op, op)
    80					 __field(sector_t, dst)
    81					 __field(sector_t, src)
    82					 __field(size_t, len)
    83			),
    84			TP_fast_assign(
    85				       __entry->op = req_op(req);
    86				       __assign_disk_name(__entry->disk, req->q->disk);
    87				       __entry->dst = dst;
    88				       __entry->src = src;
    89				       __entry->len = len;
    90			),
    91			TP_printk("%s req=%-15s: dst=%llu, src=%llu, len=%lu",
    92				  __print_disk_name(__entry->disk),
    93				  blk_op_str(__entry->op),
  > 94				  __entry->dst, __entry->src, __entry->len)
    95	);
    96	#endif /* _TRACE_NULLB_H */
    97	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

