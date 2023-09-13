Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DB6BEDEC4D
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Sep 2023 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cq17OYaD07BXxI+pjYSqBIPoCewWYQSSomUM7bcIIwg=; b=JolvKOqlzBM7SrAtvaJ4Kky9li
	ZbCL8gNLPe+oMpxee2b+rCI3EFg2FWpdeDGf02npFNNIRl8CWuCuuBAJ2gOPhIKsdRNBhJ0PPifDp
	g3Fzx2FRQ3ulAK75GurqLlmzu7zo2qAbxIbQjLv+J+0uuXTE91hxBYnrLL+bXZRxNu+a+SY8lI5va
	4qgkHF20H30iY9mLCNuB8IlL2d+bATWLGVsRsFsOObdGiweajRMdiHElCjHcBf2LQxYSpnegDMhHB
	fBkz1/3hITG4vFxNDPJnDrBEkKmCDsfx/7v1pgev01fclAUrhQJgGYzykU4+0dHRqofaDp/Gi3lUQ
	yWSCzGrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qgPgs-005xLL-2x;
	Wed, 13 Sep 2023 13:13:59 +0000
Received: from mgamail.intel.com ([192.55.52.120])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qgPgo-005xKi-34
	for linux-nvme@lists.infradead.org;
	Wed, 13 Sep 2023 13:13:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694610834; x=1726146834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TvrCpOQI/H6x/uGnlR2xkO6OFiRPA7RLNj+S7U/qINw=;
  b=BZJauEM6PV6sZ9hyplGm/Sp15WzQSXM1HWlaFrsyfexUcWqibLYwWFuY
   C+4q9KZSynkaO1yl/GjAumWpjsSHStd5DM1QAZvXTIM/h0swwnKwIHP/R
   WDhEh/2mC007KrS0ZKFBZdpth1KYp9FXIPTg+EWa8YUMaBSBBeK86loTZ
   SRrbXahZucm+FKD8p00cJZQYei4qOQYsseAZe4tpCsvJb8tNUmL6JuLrR
   wV8OcQQW2EPlL9CAUh0oU5UuoRPJypLKUEeBSxFaQYUQiHudZooDMG6oc
   kwPc4KCxt0LbQiD0szNKUTrzhDLxzv5RxJUv0fgQpCaJqk+AxTuRRpIxH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377568074"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="377568074"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 06:13:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="1074955766"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="1074955766"
Received: from lkp-server02.sh.intel.com (HELO 9ef86b2655e5) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 13 Sep 2023 06:13:48 -0700
Received: from kbuild by 9ef86b2655e5 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1qgPgg-00005N-1I;
	Wed, 13 Sep 2023 13:13:46 +0000
Date: Wed, 13 Sep 2023 21:13:12 +0800
From: kernel test robot <lkp@intel.com>
To: Ping Gan <jacky_gam_2001@163.com>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, ping_gan@dell.com,
	jacky_gam_2001@163.com
Subject: Re: [PATCH 2/4] nvmet: Add polling queue task for nvme target
Message-ID: <202309132115.8j2dhGX4-lkp@intel.com>
References: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84d7f188e892b5b0ba251a4601455d7a137075f3.1694592708.git.jacky_gam_2001@163.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230913_061355_004929_AF15AB86 
X-CRM114-Status: GOOD (  15.19  )
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
config: i386-randconfig-013-20230913 (https://download.01.org/0day-ci/archive/20230913/202309132115.8j2dhGX4-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230913/202309132115.8j2dhGX4-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309132115.8j2dhGX4-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/nvme/target/polling-queue-thread.c:278:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
           ^
   drivers/nvme/target/polling-queue-thread.c:151:3: note: expanded from macro 'ENQUEUE_PTRS'
                   case 2: \
                   ^
>> drivers/nvme/target/polling-queue-thread.c:278:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
   drivers/nvme/target/polling-queue-thread.c:153:3: note: expanded from macro 'ENQUEUE_PTRS'
                   case 1: \
                   ^
   drivers/nvme/target/polling-queue-thread.c:298:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
           DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
           ^
   drivers/nvme/target/polling-queue-thread.c:182:3: note: expanded from macro 'DEQUEUE_PTRS'
                   case 2: \
                   ^
   drivers/nvme/target/polling-queue-thread.c:298:2: warning: unannotated fall-through between switch labels [-Wimplicit-fallthrough]
   drivers/nvme/target/polling-queue-thread.c:184:3: note: expanded from macro 'DEQUEUE_PTRS'
                   case 1: \
                   ^
   drivers/nvme/target/polling-queue-thread.c:357:1: warning: unused function '__nvmet_pq_ring_full' [-Wunused-function]
   __nvmet_pq_ring_full(const struct nvmet_pq_ring *r)
   ^
   drivers/nvme/target/polling-queue-thread.c:366:1: warning: unused function '__nvmet_pq_ring_empty' [-Wunused-function]
   __nvmet_pq_ring_empty(const struct nvmet_pq_ring *r)
   ^
   drivers/nvme/target/polling-queue-thread.c:375:1: warning: unused function '__nvmet_pq_ring_get_size' [-Wunused-function]
   __nvmet_pq_ring_get_size(const struct nvmet_pq_ring *r)
   ^
   drivers/nvme/target/polling-queue-thread.c:384:1: warning: unused function '__nvmet_pq_ring_get_capacity' [-Wunused-function]
   __nvmet_pq_ring_get_capacity(const struct nvmet_pq_ring *r)
   ^
   8 warnings generated.
--
>> drivers/nvme/target/polling-queue-thread.c:345: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Return the number of free entries in a ring.
   drivers/nvme/target/polling-queue-thread.c:354: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Test if a ring is full.
   drivers/nvme/target/polling-queue-thread.c:363: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Test if a ring is empty.
   drivers/nvme/target/polling-queue-thread.c:372: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Return the size of the ring.
   drivers/nvme/target/polling-queue-thread.c:381: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Return the number of elements which can be stored in the ring.


vim +278 drivers/nvme/target/polling-queue-thread.c

   265	
   266	static inline u32
   267	__nvmet_pq_ring_do_enqueue(struct nvmet_pq_ring *r,
   268								void **obj_table, u32 n, u32 *free_space)
   269	{
   270		uint32_t prod_head, prod_next;
   271		uint32_t free_entries;
   272	
   273		n = __nvmet_pq_ring_move_prod_head(r, n, &prod_head,
   274										&prod_next, &free_entries);
   275		if (n == 0)
   276			goto end;
   277	
 > 278		ENQUEUE_PTRS(r, &r[1], prod_head, obj_table, n, void *);
   279	
   280		__nvmet_pq_ring_update_tail(&r->prod, prod_head, prod_next, 1);
   281	end:
   282		if (free_space != NULL)
   283			*free_space = free_entries - n;
   284		return n;
   285	}
   286	
   287	static inline u32
   288	__nvmet_pq_ring_do_dequeue(struct nvmet_pq_ring *r,
   289								void **obj_table, u32 n, u32 *available)
   290	{
   291		uint32_t cons_head, cons_next;
   292		uint32_t entries;
   293	
   294		n = __nvmet_pq_ring_move_cons_head(r, n, &cons_head, &cons_next, &entries);
   295		if (n == 0)
   296			goto end;
   297	
   298		DEQUEUE_PTRS(r, &r[1], cons_head, obj_table, n, void *);
   299	
   300		__nvmet_pq_ring_update_tail(&r->cons, cons_head, cons_next, 0);
   301	
   302	end:
   303		if (available != NULL)
   304			*available = entries - n;
   305		return n;
   306	}
   307	
   308	static inline u32
   309	nvmet_pq_ring_enqueue_bulk(struct nvmet_pq_ring *r,
   310								void **obj_table, u32 n, u32 *free_space)
   311	{
   312		return __nvmet_pq_ring_do_enqueue(r, obj_table, n, free_space);
   313	}
   314	
   315	static inline int
   316	nvmet_pq_ring_enqueue(struct nvmet_pq_ring *r, void **obj)
   317	{
   318		return nvmet_pq_ring_enqueue_bulk(r, obj, 1, NULL) ? 0 : -ENOBUFS;
   319	}
   320	
   321	static inline u32
   322	nvmet_pq_ring_dequeue_bulk(struct nvmet_pq_ring *r,
   323								void **obj_table, u32 n, u32 *available)
   324	{
   325		return __nvmet_pq_ring_do_dequeue(r, obj_table, n, available);
   326	}
   327	
   328	static inline int
   329	nvmet_pq_ring_dequeue(struct nvmet_pq_ring *r, void **obj_p)
   330	{
   331		return nvmet_pq_ring_dequeue_bulk(r, obj_p, 1, NULL) ? 0 : -ENOENT;
   332	}
   333	
   334	static inline u32
   335	__nvmet_pq_ring_count(const struct nvmet_pq_ring *r)
   336	{
   337		u32 prod_tail = smp_load_acquire(&r->prod.tail);
   338		u32 cons_tail = smp_load_acquire(&r->cons.tail);
   339		u32 count = (prod_tail - cons_tail) & r->mask;
   340		u32 capacity = smp_load_acquire(&r->capacity);
   341		return (count > capacity) ? capacity : count;
   342	}
   343	
   344	/**
 > 345	 * Return the number of free entries in a ring.
   346	 */
   347	static inline u32
   348	__nvmet_pq_ring_free_count(const struct nvmet_pq_ring *r)
   349	{
   350		return smp_load_acquire(&r->capacity) - __nvmet_pq_ring_count(r);
   351	}
   352	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

