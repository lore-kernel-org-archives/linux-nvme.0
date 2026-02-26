Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCE7FD9E26
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 23:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdwzqhRp4qxPqKKb0OWWZskoOaCtGavTTciXuhQ/ZJU=; b=sJ6vsiESNGzzDxt+YXEs44+PY9
	s0p50Z5YUMFqVKivxaC9bY0D9KBDOiDdD2/saMaROrMkGUouqeRI5HMBnHnfAVUXgdJMGqklt88Q7
	Scm0s1myUw9CDiDrPLyHgCrGi5bdNyPPgTqLMIXi99gCeY3nLOpZcg52sFmbXNICIUup29XlwyG5Y
	S8TqtQmMD47CoWije8H6BH3hYU5Cb1oFwytZpfg/DnV1Rxu3srhzC7BcZnAEYFraTvfAUoj5mB6at
	sqk1OZLndM1MblbQNZlH6hHDsR434DzyY75H39midTXcSpb5N6JnUfdI8vVobUsLBzue6mB2QdTkP
	0mYQbA5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvlDH-00000007Om8-0w4H;
	Thu, 26 Feb 2026 23:56:11 +0000
Received: from mgamail.intel.com ([198.175.65.17])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvlDA-00000007Olk-2VJF
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 23:56:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772150166; x=1803686166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SmmrWtMSwUw+hrAhOFKeqnpp76D7j72JxFhTZwm44L0=;
  b=RpTM7dnM3R5cNmV6CmiFxk8rE9YtWQA8ZnRDSC78Sr3tPEW2Z5pBsONU
   b0xdwLZLFi3ZYkV+cgUDF23IcqK0YUeaEBLs0QfsaTTUg9NdwYsWUJa1A
   8aNBbiQQMvPbji/bMohRjth4yx46lNmQlnPCcWzvqTkDytNxWhLlbQArg
   Bey/vcwKeRoPX6+pihVVfwb4UZSZ6G0oDcLztiuF3J4M6GdwqN0rJwS3x
   xurOKcP1edYSGcuPGNbHPgh0+jsYyOjr/BugA6ON4RsA/QRtDeIdq0xH3
   6/rRYiLv9dQ/nqdHXTgLCiNEj9m2uB/YsvH1DSubjiohUhzMKmxKtPtU3
   Q==;
X-CSE-ConnectionGUID: 6iZTwlzMT5K01dX/sY8dGA==
X-CSE-MsgGUID: q9YFDS+kSr+O6EtNeq7ssA==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="73198710"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="73198710"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 15:56:03 -0800
X-CSE-ConnectionGUID: 2qR8cDV4SxCwUYtkZLTPtA==
X-CSE-MsgGUID: HgtHMzKwTHatOts0Xal6UA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216751162"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 26 Feb 2026 15:55:59 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvlD2-00000000A1X-2NdK;
	Thu, 26 Feb 2026 23:55:56 +0000
Date: Fri, 27 Feb 2026 07:55:49 +0800
From: kernel test robot <lkp@intel.com>
To: Daniel Wagner <wagi@kernel.org>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Ming Lei <ming.lei@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Guangwu Zhang <guazhang@redhat.com>,
	Chengming Zhou <zhouchengming@bytedance.com>,
	Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
	Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 1/3] nvme: failover requests for inactive hctx
Message-ID: <202602270720.cugNS3m1-lkp@intel.com>
References: <20260226-revert-cpu-read-lock-v1-1-eb005072566e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226-revert-cpu-read-lock-v1-1-eb005072566e@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_155605_862862_45A135F7 
X-CRM114-Status: GOOD (  17.00  )
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

Hi Daniel,

kernel test robot noticed the following build errors:

[auto build test ERROR on 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f]

url:    https://github.com/intel-lab-lkp/linux/commits/Daniel-Wagner/nvme-failover-requests-for-inactive-hctx/20260226-224213
base:   6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
patch link:    https://lore.kernel.org/r/20260226-revert-cpu-read-lock-v1-1-eb005072566e%40kernel.org
patch subject: [PATCH 1/3] nvme: failover requests for inactive hctx
config: x86_64-randconfig-r071-20260227 (https://download.01.org/0day-ci/archive/20260227/202602270720.cugNS3m1-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch version: v0.5.0-8994-gd50c5a4c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270720.cugNS3m1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602270720.cugNS3m1-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/nvme/host/core.c:457:13: error: redefinition of 'nvme_failover_req'
     457 | static void nvme_failover_req(struct request *req)
         |             ^~~~~~~~~~~~~~~~~
   In file included from drivers/nvme/host/core.c:27:
   drivers/nvme/host/nvme.h:1020:20: note: previous definition of 'nvme_failover_req' with type 'void(struct request *)'
    1020 | static inline void nvme_failover_req(struct request *req)
         |                    ^~~~~~~~~~~~~~~~~
   drivers/nvme/host/core.c: In function 'nvme_failover_req':
>> drivers/nvme/host/core.c:472:50: error: 'struct nvme_ctrl' has no member named 'ana_log_buf'
     472 |         if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
         |                                                  ^~
>> drivers/nvme/host/core.c:474:48: error: 'struct nvme_ctrl' has no member named 'ana_work'; did you mean 'ka_work'?
     474 |                 queue_work(nvme_wq, &ns->ctrl->ana_work);
         |                                                ^~~~~~~~
         |                                                ka_work
   In file included from include/linux/sched.h:37,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/async.h:14,
                    from drivers/nvme/host/core.c:7:
>> drivers/nvme/host/core.c:477:36: error: 'struct nvme_ns_head' has no member named 'requeue_lock'
     477 |         spin_lock_irqsave(&ns->head->requeue_lock, flags);
         |                                    ^~
   include/linux/spinlock.h:244:48: note: in definition of macro 'raw_spin_lock_irqsave'
     244 |                 flags = _raw_spin_lock_irqsave(lock);   \
         |                                                ^~~~
   drivers/nvme/host/core.c:477:9: note: in expansion of macro 'spin_lock_irqsave'
     477 |         spin_lock_irqsave(&ns->head->requeue_lock, flags);
         |         ^~~~~~~~~~~~~~~~~
>> drivers/nvme/host/core.c:494:33: error: 'struct nvme_ns_head' has no member named 'requeue_list'
     494 |         blk_steal_bios(&ns->head->requeue_list, req);
         |                                 ^~
   drivers/nvme/host/core.c:495:41: error: 'struct nvme_ns_head' has no member named 'requeue_lock'
     495 |         spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
         |                                         ^~
>> drivers/nvme/host/core.c:499:40: error: 'struct nvme_ns_head' has no member named 'requeue_work'
     499 |         kblockd_schedule_work(&ns->head->requeue_work);
         |                                        ^~


vim +/nvme_failover_req +457 drivers/nvme/host/core.c

   456	
 > 457	static void nvme_failover_req(struct request *req)
   458	{
   459		struct nvme_ns *ns = req->q->queuedata;
   460		u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
   461		unsigned long flags;
   462		struct bio *bio;
   463	
   464		if (nvme_ns_head_multipath(ns->head))
   465			nvme_mpath_clear_current_path(ns);
   466	
   467		/*
   468		 * If we got back an ANA error, we know the controller is alive but not
   469		 * ready to serve this namespace.  Kick of a re-read of the ANA
   470		 * information page, and just try any other available path for now.
   471		 */
 > 472		if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
   473			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
 > 474			queue_work(nvme_wq, &ns->ctrl->ana_work);
   475		}
   476	
 > 477		spin_lock_irqsave(&ns->head->requeue_lock, flags);
   478		for (bio = req->bio; bio; bio = bio->bi_next) {
   479			if (nvme_ns_head_multipath(ns->head))
   480				bio_set_dev(bio, ns->head->disk->part0);
   481			if (bio->bi_opf & REQ_POLLED) {
   482				bio->bi_opf &= ~REQ_POLLED;
   483				bio->bi_cookie = BLK_QC_T_NONE;
   484			}
   485			/*
   486			 * The alternate request queue that we may end up submitting
   487			 * the bio to may be frozen temporarily, in this case REQ_NOWAIT
   488			 * will fail the I/O immediately with EAGAIN to the issuer.
   489			 * We are not in the issuer context which cannot block. Clear
   490			 * the flag to avoid spurious EAGAIN I/O failures.
   491			 */
   492			bio->bi_opf &= ~REQ_NOWAIT;
   493		}
 > 494		blk_steal_bios(&ns->head->requeue_list, req);
   495		spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
   496	
   497		nvme_req(req)->status = 0;
   498		nvme_end_req(req);
 > 499		kblockd_schedule_work(&ns->head->requeue_work);
   500	}
   501	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

