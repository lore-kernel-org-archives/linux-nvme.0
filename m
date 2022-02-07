Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2945C433EF
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Feb 2022 23:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qaqjn7JcDvWzbO9MBpbsHxCX4xaUTgakD9lGWauCCMw=; b=EWDIA1JJQVIWYXPBi82fmy4YEr
	SFqIuOL27jXo/CTFonFGhfTpWv0YNWNGyc5IhiDzg8DfUr2z3lBGa9G2IiLWmJWSIYEokbvTAfsE0
	HgYHWD4/ZiNm6oKrkmuNqQnwIg553XxzT9PZy5b8C531fj70mSm3hZXBBtGtXpVeVpMLpTV5L1X7m
	zceklKyC57Vg9POU2Q9JwV+GFSsR8Bvy+X4L8EVmOv6c0MXvmaohKcFNAJLTze5vqoN1Qcu8dxgV5
	n0JtNtNADa1OBtxHW7V+V08stOKDhfJz1qBV27wBdlRfZBDj5iC1I16G9s/b6O3Gd+XDZLeI7Ny9m
	XQI2MEhg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHDPY-00By2J-P4; Mon, 07 Feb 2022 23:27:08 +0000
Received: from mga17.intel.com ([192.55.52.151])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHDPU-00By1e-Jo
 for linux-nvme@lists.infradead.org; Mon, 07 Feb 2022 23:27:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644276424; x=1675812424;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IwunybhnixPrrYpo9YKYsqV3BW8fxMDBh8jQBLZjjnA=;
 b=P6bkNCRkyTocikyPQ+74ZBhC4ys22Im9GEzbrdbTeyXlieTuPwDhMc7C
 a4I+rcQjanMvPo/YMXv/7X8XJswa462rt3TOE8RUMwaaQfFfyMCSJEU0E
 GTpKRSBK22SB6QI/eOSnmmr55KDOiJQZEMVhjI/sXRxUikyLEPyg+AOof
 60zjRq7QKcj0r/35cDUUZ0qoapwQ1LzDsvJrtbxA8a0bBZjxDJfMItXo4
 6CLJWDcLOhnNyHGFF2s0GstdK8OLMopbv5hogImHhflFyLK1ku3a0VnSD
 3X3ZOkiNyS4fKVUSP8LX+baeUV6M9ET+qNaD8CuT7GDN+qoap5N77U5MF A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="229478400"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="229478400"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 15:27:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="481746035"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
 by orsmga003.jf.intel.com with ESMTP; 07 Feb 2022 15:27:00 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nHDPP-00015f-CT; Mon, 07 Feb 2022 23:26:59 +0000
Date: Tue, 8 Feb 2022 07:26:02 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>, mpatocka@redhat.com
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org, javier@javigon.com,
 chaitanyak@nvidia.com, linux-block@vger.kernel.org,
 linux-scsi@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 axboe@kernel.dk, msnitzer@redhat.com
Subject: Re: [PATCH v2 03/10] block: Add copy offload support infrastructure
Message-ID: <202202080735.lyaEe5Bq-lkp@intel.com>
References: <20220207141348.4235-4-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-4-nj.shetty@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_152704_709258_99D58FE9 
X-CRM114-Status: GOOD (  17.45  )
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

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on axboe-block/for-next]
[also build test WARNING on next-20220207]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: hexagon-randconfig-r045-20220207 (https://download.01.org/0day-ci/archive/20220208/202202080735.lyaEe5Bq-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0d8850ae2cae85d49bea6ae0799fa41c7202c05c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/12a9801a7301f1a1e2ea355c5a4438dab17894cf
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
        git checkout 12a9801a7301f1a1e2ea355c5a4438dab17894cf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/blk-lib.c:185:5: warning: no previous prototype for function 'blk_copy_offload' [-Wmissing-prototypes]
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
       ^
   block/blk-lib.c:185:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
   ^
   static 
   1 warning generated.


vim +/blk_copy_offload +185 block/blk-lib.c

   180	
   181	/*
   182	 * blk_copy_offload	- Use device's native copy offload feature
   183	 * Go through user provide payload, prepare new payload based on device's copy offload limits.
   184	 */
 > 185	int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
   186			struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
   187	{
   188		struct request_queue *sq = bdev_get_queue(src_bdev);
   189		struct request_queue *dq = bdev_get_queue(dst_bdev);
   190		struct bio *read_bio, *write_bio;
   191		struct copy_ctx *ctx;
   192		struct cio *cio;
   193		struct page *token;
   194		sector_t src_blk, copy_len, dst_blk;
   195		sector_t remaining, max_copy_len = LONG_MAX;
   196		int ri = 0, ret = 0;
   197	
   198		cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
   199		if (!cio)
   200			return -ENOMEM;
   201		atomic_set(&cio->refcount, 0);
   202		cio->rlist = rlist;
   203	
   204		max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_sectors,
   205				(sector_t)dq->limits.max_copy_sectors);
   206		max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
   207				(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;
   208	
   209		for (ri = 0; ri < nr_srcs; ri++) {
   210			cio->rlist[ri].comp_len = rlist[ri].len;
   211			for (remaining = rlist[ri].len, src_blk = rlist[ri].src, dst_blk = rlist[ri].dst;
   212				remaining > 0;
   213				remaining -= copy_len, src_blk += copy_len, dst_blk += copy_len) {
   214				copy_len = min(remaining, max_copy_len);
   215	
   216				token = alloc_page(gfp_mask);
   217				if (unlikely(!token)) {
   218					ret = -ENOMEM;
   219					goto err_token;
   220				}
   221	
   222				read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
   223						gfp_mask);
   224				if (!read_bio) {
   225					ret = -ENOMEM;
   226					goto err_read_bio;
   227				}
   228				read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
   229				read_bio->bi_iter.bi_size = copy_len;
   230				__bio_add_page(read_bio, token, PAGE_SIZE, 0);
   231				ret = submit_bio_wait(read_bio);
   232				if (ret) {
   233					bio_put(read_bio);
   234					goto err_read_bio;
   235				}
   236				bio_put(read_bio);
   237				ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
   238				if (!ctx) {
   239					ret = -ENOMEM;
   240					goto err_read_bio;
   241				}
   242				ctx->cio = cio;
   243				ctx->range_idx = ri;
   244				ctx->start_sec = rlist[ri].src;
   245	
   246				write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
   247						gfp_mask);
   248				if (!write_bio) {
   249					ret = -ENOMEM;
   250					goto err_read_bio;
   251				}
   252	
   253				write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
   254				write_bio->bi_iter.bi_size = copy_len;
   255				__bio_add_page(write_bio, token, PAGE_SIZE, 0);
   256				write_bio->bi_end_io = bio_copy_end_io;
   257				write_bio->bi_private = ctx;
   258				atomic_inc(&cio->refcount);
   259				submit_bio(write_bio);
   260			}
   261		}
   262	
   263		/* Wait for completion of all IO's*/
   264		return cio_await_completion(cio);
   265	
   266	err_read_bio:
   267		__free_page(token);
   268	err_token:
   269		rlist[ri].comp_len = min_t(sector_t, rlist[ri].comp_len, (rlist[ri].len - remaining));
   270	
   271		cio->io_err = ret;
   272		return cio_await_completion(cio);
   273	}
   274	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

