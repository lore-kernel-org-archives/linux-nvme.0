Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66B8DEDEC4A
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 12:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=anB4Rrtg2E/pPJRP+NkViWGtN+eLRyiVKs97sKu5U9g=; b=GDXCc0D2JuENwRowkLNYc0Ug3O
	+k+r55B89wL4EoadJCpqm5HNJ6xEdxBC+h1GvMEfuJ3ClluiZxC8dYg/vFuCEGgQ47ohUuQ8qddl6
	dnDQW7sk0AoUgcxZzIqiIW9u8y4WnzdI7oKOEvglt4iP1PTZaCkqIYSSIDksoTcPx/9u6n4nMUOh1
	+riOywrVyojLosTTwpC3SG83dKV70ka8OnXTuFPfi93u/HdDHnAfs6i3eBqWi2PJ3+nRR87X5Cvep
	jS/i0lsqsIeWoiBU7KmMFJcWcJd5E1EZgI4SA19Ha0iKhKZzdHTNdrV87w8mUDDYb8yEcs9JcE40u
	CJxFJIhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgOqD-005qGF-0J;
	Wed, 13 Sep 2023 12:19:33 +0000
Received: from mgamail.intel.com ([134.134.136.126])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgOq9-005qF3-1P
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 12:19:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694607569; x=1726143569;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X1Pn9TpUNoyPdD3j0+oAS9diSSpPQYYq5l0i8RYiScQ=;
  b=PDOAYhv7nJW6FcPgXQJ0gow4OTNNYlDbIu88x5tmmMx/Q7Wce4/CpYu0
   mKRycHMcBi3t0d2Xtwfc5ZQzbFtBb9ehiyUhkMZQjWgxpkf6eWI6vuwUt
   88u6CQyxAYxllClN32Q+jyy7aXuffb/KoAU/5Njun1hVZ2EXwcYWuwvaV
   l4NrhM4r8e8r4ZFt3xVBvvgBlH/h6y939stkDTSAjphgQyFPX1GP0kvCK
   NRCjSa3OEXRvK9D0luJtXduk6hLKHJyMPW9dJJ5RVH4e5oQRqBXnbbdtm
   PnG+5bL2Swz8XuR3FU/pmOgRkAf9b5mfnrgHC+VKXXAGewNHirjMiJ+rN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363673113"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="363673113"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 05:19:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="779169400"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="779169400"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 13 Sep 2023 05:19:25 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgOq3-00002J-0E;
	Wed, 13 Sep 2023 12:19:23 +0000
Date: Wed, 13 Sep 2023 20:19:03 +0800
From: kernel test robot <lkp@intel.com>
To: Ping Gan <jacky_gam_2001@163.com>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: oe-kbuild-all@lists.linux.dev, ping_gan@dell.com,
	jacky_gam_2001@163.com
Subject: Re: [PATCH 2/4] nvmet: Add polling queue task for nvme target
Message-ID: <202309131959.1zH6sjmk-lkp@intel.com>
References: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_051929_572004_8CF64E4F 
X-CRM114-Status: GOOD (  16.43  )
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

Hi Ping,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v6.6-rc1]
[also build test WARNING on linus/master next-20230913]
[cannot apply to hch-configfs/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ping-Gan/nvmet-Add-nvme-target-polling-queue-task-parameters/20230913-164112
base:   v6.6-rc1
patch link:    https://lore.kernel.org/r/84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001%40163.com
patch subject: [PATCH 2/4] nvmet: Add polling queue task for nvme target
config: arc-randconfig-r004-20230913 (https://download.01.org/0day-ci/archive/20230913/202309131959.1zH6sjmk-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309131959.1zH6sjmk-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309131959.1zH6sjmk-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/nvme/target/polling-queue-thread.c: In function '__nvmet_pq_ring_do_enqueue':
>> drivers/nvme/target/polling-queue-thread.c:150:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
     150 |                         ring[idx++] = obj_table[i++]; /* fallthrough */ \
         |                         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:278:9: note: in expansion of macro 'ENQUEUE_PTRS'
     278 |         ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:151:17: note: here
     151 |                 case 2: \
         |                 ^~~~
   drivers/nvme/target/polling-queue-thread.c:278:9: note: in expansion of macro 'ENQUEUE_PTRS'
     278 |         ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:152:37: warning: this statement may fall through [-Wimplicit-fallthrough=]
     152 |                         ring[idx++] = obj_table[i++]; /* fallthrough */ \
         |                         ~~~~~~~~~~~~^~~~~~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:278:9: note: in expansion of macro 'ENQUEUE_PTRS'
     278 |         ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:153:17: note: here
     153 |                 case 1: \
         |                 ^~~~
   drivers/nvme/target/polling-queue-thread.c:278:9: note: in expansion of macro 'ENQUEUE_PTRS'
     278 |         ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c: In function '__nvmet_pq_ring_do_dequeue':
   drivers/nvme/target/polling-queue-thread.c:181:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
     181 |                         obj_table[i++] = ring[idx++]; /* fallthrough */ \
         |                                        ^
   drivers/nvme/target/polling-queue-thread.c:298:9: note: in expansion of macro 'DEQUEUE_PTRS'
     298 |         DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:182:17: note: here
     182 |                 case 2: \
         |                 ^~~~
   drivers/nvme/target/polling-queue-thread.c:298:9: note: in expansion of macro 'DEQUEUE_PTRS'
     298 |         DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:183:40: warning: this statement may fall through [-Wimplicit-fallthrough=]
     183 |                         obj_table[i++] = ring[idx++]; /* fallthrough */ \
         |                                        ^
   drivers/nvme/target/polling-queue-thread.c:298:9: note: in expansion of macro 'DEQUEUE_PTRS'
     298 |         DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~
   drivers/nvme/target/polling-queue-thread.c:184:17: note: here
     184 |                 case 1: \
         |                 ^~~~
   drivers/nvme/target/polling-queue-thread.c:298:9: note: in expansion of macro 'DEQUEUE_PTRS'
     298 |         DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
         |         ^~~~~~~~~~~~


vim +150 drivers/nvme/target/polling-queue-thread.c

   131	
   132	//below is derived from FreeBSD's bufring.h
   133	/* the actual enqueue of pointers on the ring.
   134	 * Placed here since identical code needed in both
   135	 * single and multi producer enqueue functions */
   136	#define ENQUEUE_PTRS(r, ring_start, prod_head, obj_table, n, obj_type) do { \
   137		unsigned int i; \
   138		const u32 size = (r)->size; \
   139		u32 idx = prod_head & (r)->mask; \
   140		obj_type *ring = (obj_type *)ring_start; \
   141		if (likely(idx + n < size)) { \
   142			for (i = 0; i < (n & ((~(unsigned)0x3))); i += 4, idx += 4) { \
   143				ring[idx] = obj_table[i]; \
   144				ring[idx+1] = obj_table[i+1]; \
   145				ring[idx+2] = obj_table[i+2]; \
   146				ring[idx+3] = obj_table[i+3]; \
   147			} \
   148			switch (n & 0x3) { \
   149			case 3: \
 > 150				ring[idx++] = obj_table[i++]; /* fallthrough */ \
   151			case 2: \
   152				ring[idx++] = obj_table[i++]; /* fallthrough */ \
   153			case 1: \
   154				ring[idx++] = obj_table[i++]; \
   155			} \
   156		} else { \
   157			for (i = 0; idx < size; i++, idx++)\
   158				ring[idx] = obj_table[i]; \
   159			for (idx = 0; i < n; i++, idx++) \
   160				ring[idx] = obj_table[i]; \
   161		} \
   162	} while (0)
   163	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

