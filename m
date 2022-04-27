Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB216C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 12:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ca3u+t38taLInbwr+HBNpBD4h56KecQqqAlLgXw85Jc=; b=qTRRsDrleTyS8beKBzXXs1pa1F
	bLyNIzmnSLvZ99/3xn5FP2FoJUi94DSW0MQPqIAdwilEB0mck+yZ1JddIcGe/XOotUBxCM8pWY2Kk
	E9Wg+ihCvYWBDdLmkx3FbvYcgaAUEfEsllzveX0y1MKCB+/HvGC95yO3nZoh0GtDV2yc1F6zt8TPX
	SmsHtseWb0nr5jUTiPnS9VC1OepYmQ5oIJi5NIoibPRi2mwni0M2bwCmOUiwDniiitft8frOA7bBn
	2C1WzLsqLB213Vdq+41AgZyaxOBNoMSlhDx3rqDNsF5A5GAS5/lL9qy72ariW1asIOtEYt29heBzW
	UCxlz34w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njh6H-001Mne-7v; Wed, 27 Apr 2022 12:48:57 +0000
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njVI9-00GkHk-Cb
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 00:12:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651018345; x=1682554345;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=IJKeTxABZvXswFfO4b9L3mkC7AWJ8dJxlHjKnja64Dw=;
 b=iiKG0q/PoRv4q70gUH2Usth7+7xfOgtYDQOk11B6HOp54fSFPTYG+cUk
 g2l86vit3USt07LiAJKY2cSS8LC7yBztmZWZKyaq7jdtbS/K6tff53cPo
 Jeuy9a4MQSU9Pq24oMUsUAYYtw/Jpq6nWtFZwemXrctcwqqE6SqFiEbbr
 QOGz1RoNsnlOifD8Ick63fZNuzwKS/49fEGyfi6LGJ9piiSguH6Ha4Q84
 6rHKpC6A4cTIGiY4GaO82BslO8SMrPzpmzuh2/7vPGD0xs3JbD5aZuVo5
 EJT9ddpBpdW23VwHb8bm6wNfKQjYATP/ID0iWtOPTfD28Ne7KZkVnyb2z Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265286169"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="265286169"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 17:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="807761334"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by fmsmga006.fm.intel.com with ESMTP; 26 Apr 2022 17:12:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1njVHx-00046e-BM;
 Wed, 27 Apr 2022 00:12:13 +0000
Date: Wed, 27 Apr 2022 08:11:24 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>
Cc: llvm@lists.linux.dev, kbuild-all@lists.01.org, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, msnitzer@redhat.com,
 bvanassche@acm.org, martin.petersen@oracle.com, hare@suse.de,
 kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
 osandov@fb.com, lsf-pc@lists.linux-foundation.org,
 djwong@kernel.org, josef@toxicpanda.com, clm@fb.com,
 dsterba@suse.com, tytso@mit.edu, jack@suse.com,
 nitheshshetty@gmail.com, gost.dev@samsung.com,
 Nitesh Shetty <nj.shetty@samsung.com>, Arnav Dawn <arnav.dawn@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>, James Smart <james.smart@broadcom.com>
Subject: Re: [PATCH v4 02/10] block: Add copy offload support infrastructure
Message-ID: <202204270754.pM0Ewhl5-lkp@intel.com>
References: <20220426101241.30100-3-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-3-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_171225_515332_6F54B8F6 
X-CRM114-Status: GOOD (  16.60  )
X-Mailman-Approved-At: Wed, 27 Apr 2022 05:48:55 -0700
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

[auto build test WARNING on next-20220422]
[cannot apply to axboe-block/for-next device-mapper-dm/for-next linus/master v5.18-rc4 v5.18-rc3 v5.18-rc2 v5.18-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
base:    e7d6987e09a328d4a949701db40ef63fbb970670
config: hexagon-randconfig-r041-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270754.pM0Ewhl5-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/3e91cba65ef73ba116953031d5548da7fd33a150
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout 3e91cba65ef73ba116953031d5548da7fd33a150
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> block/blk-lib.c:178:5: warning: no previous prototype for function 'blk_copy_offload' [-Wmissing-prototypes]
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
       ^
   block/blk-lib.c:178:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
   ^
   static 
   1 warning generated.


vim +/blk_copy_offload +178 block/blk-lib.c

   173	
   174	/*
   175	 * blk_copy_offload	- Use device's native copy offload feature
   176	 * Go through user provide payload, prepare new payload based on device's copy offload limits.
   177	 */
 > 178	int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
   179			struct range_entry *rlist, struct block_device *dst_bdev, gfp_t gfp_mask)
   180	{
   181		struct request_queue *sq = bdev_get_queue(src_bdev);
   182		struct request_queue *dq = bdev_get_queue(dst_bdev);
   183		struct bio *read_bio, *write_bio;
   184		struct copy_ctx *ctx;
   185		struct cio *cio;
   186		struct page *token;
   187		sector_t src_blk, copy_len, dst_blk;
   188		sector_t remaining, max_copy_len = LONG_MAX;
   189		unsigned long flags;
   190		int ri = 0, ret = 0;
   191	
   192		cio = kzalloc(sizeof(struct cio), GFP_KERNEL);
   193		if (!cio)
   194			return -ENOMEM;
   195		cio->rlist = rlist;
   196		spin_lock_init(&cio->lock);
   197	
   198		max_copy_len = min_t(sector_t, sq->limits.max_copy_sectors, dq->limits.max_copy_sectors);
   199		max_copy_len = min3(max_copy_len, (sector_t)sq->limits.max_copy_range_sectors,
   200				(sector_t)dq->limits.max_copy_range_sectors) << SECTOR_SHIFT;
   201	
   202		for (ri = 0; ri < nr_srcs; ri++) {
   203			cio->rlist[ri].comp_len = rlist[ri].len;
   204			src_blk = rlist[ri].src;
   205			dst_blk = rlist[ri].dst;
   206			for (remaining = rlist[ri].len; remaining > 0; remaining -= copy_len) {
   207				copy_len = min(remaining, max_copy_len);
   208	
   209				token = alloc_page(gfp_mask);
   210				if (unlikely(!token)) {
   211					ret = -ENOMEM;
   212					goto err_token;
   213				}
   214	
   215				ctx = kzalloc(sizeof(struct copy_ctx), gfp_mask);
   216				if (!ctx) {
   217					ret = -ENOMEM;
   218					goto err_ctx;
   219				}
   220				ctx->cio = cio;
   221				ctx->range_idx = ri;
   222				ctx->start_sec = dst_blk;
   223	
   224				read_bio = bio_alloc(src_bdev, 1, REQ_OP_READ | REQ_COPY | REQ_NOMERGE,
   225						gfp_mask);
   226				if (!read_bio) {
   227					ret = -ENOMEM;
   228					goto err_read_bio;
   229				}
   230				read_bio->bi_iter.bi_sector = src_blk >> SECTOR_SHIFT;
   231				__bio_add_page(read_bio, token, PAGE_SIZE, 0);
   232				/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
   233				read_bio->bi_iter.bi_size = copy_len;
   234				ret = submit_bio_wait(read_bio);
   235				bio_put(read_bio);
   236				if (ret)
   237					goto err_read_bio;
   238	
   239				write_bio = bio_alloc(dst_bdev, 1, REQ_OP_WRITE | REQ_COPY | REQ_NOMERGE,
   240						gfp_mask);
   241				if (!write_bio) {
   242					ret = -ENOMEM;
   243					goto err_read_bio;
   244				}
   245				write_bio->bi_iter.bi_sector = dst_blk >> SECTOR_SHIFT;
   246				__bio_add_page(write_bio, token, PAGE_SIZE, 0);
   247				/*__bio_add_page increases bi_size by len, so overwrite it with copy len*/
   248				write_bio->bi_iter.bi_size = copy_len;
   249				write_bio->bi_end_io = bio_copy_end_io;
   250				write_bio->bi_private = ctx;
   251	
   252				spin_lock_irqsave(&cio->lock, flags);
   253				++cio->refcount;
   254				spin_unlock_irqrestore(&cio->lock, flags);
   255	
   256				submit_bio(write_bio);
   257				src_blk += copy_len;
   258				dst_blk += copy_len;
   259			}
   260		}
   261	
   262		/* Wait for completion of all IO's*/
   263		return cio_await_completion(cio);
   264	
   265	err_read_bio:
   266		kfree(ctx);
   267	err_ctx:
   268		__free_page(token);
   269	err_token:
   270		rlist[ri].comp_len = min_t(sector_t, rlist[ri].comp_len, (rlist[ri].len - remaining));
   271	
   272		cio->io_err = ret;
   273		return cio_await_completion(cio);
   274	}
   275	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

