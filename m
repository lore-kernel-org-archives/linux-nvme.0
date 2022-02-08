Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB62AC433F5
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Feb 2022 03:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FSiGX2GpG4SHh8ta4grt+UXbv+aXreXZj8RVjH06Gnw=; b=l8NF2HCPSVF1h/Dotb15GbTalj
	Co5e+WBHyN8ndvnTJVoOsvfe3R/1j6xteI7+n57cZQkdC84CYolMObBJy0LLCgBcswl1Q1DjyeUU0
	ZX5mhXdLVNRCytuYD7tCe8HMXJvdmvAqn2Ygbh+eQ/5Cw0Ofe42LAu6IUYrLjNDJIUJM1S48NkafD
	/GrPOJ0eZQ1rTc8hFPyrXkoPeeIK1SaGBhMdc1KfHxfG0oI7bbS1KsHXHs83xpTaAy/AVhC9+pUCj
	1Alel1o4eVAYiTMIUaCuF0hBY8YbvUhPg+FUlCnhuK0QoREwQp8Wy674yZI5HQUcGqBhVtykZDlGf
	38Y2fGNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHH4C-00CMCF-4e; Tue, 08 Feb 2022 03:21:20 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHH48-00CMB1-Q0
 for linux-nvme@lists.infradead.org; Tue, 08 Feb 2022 03:21:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644290476; x=1675826476;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=u02kYfGC73TZw2v+W0u+Q/i7ojPqo05Ik1eLlj2+NyY=;
 b=crR9ocTvWTjHvUcqsXGqhN/S1eiMQqA3zz3AknTeAlLhVsI4Zj1rcVHf
 kSNVH4IQ5dDikPhQUZzdn7XFNOLtzF8FLRpTPDdt7AmLHJXbKMAo1ZZ4G
 ZryUHdZUlY2keGqAkuIr//Xhpg1ubJhmyMDg9bftAi/vlEhoyyIasOucW
 vCYpxpAoN1oocRq6zQM/KVCwWVPRD8dmLtcU2Jk/P9bY7XhNUvHlhKLAA
 ioC/r2mMijl/Efij/i3ergdCglGEjPmHuHx0DmZsdWm5hvAgPmYwDLNjx
 lPBOKhsF1i5fLoi7v3ipID3S95UyyQ2CODGElaMJOobOO/gIpLE3gREGS A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10251"; a="246451121"
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="246451121"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Feb 2022 19:21:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,351,1635231600"; d="scan'208";a="499422663"
Received: from lkp-server01.sh.intel.com (HELO 9dd77a123018) ([10.239.97.150])
 by orsmga002.jf.intel.com with ESMTP; 07 Feb 2022 19:21:08 -0800
Received: from kbuild by 9dd77a123018 with local (Exim 4.92)
 (envelope-from <lkp@intel.com>)
 id 1nHH3z-0001He-La; Tue, 08 Feb 2022 03:21:07 +0000
Date: Tue, 8 Feb 2022 11:20:49 +0800
From: kernel test robot <lkp@intel.com>
To: Nitesh Shetty <nj.shetty@samsung.com>, mpatocka@redhat.com
Cc: kbuild-all@lists.01.org, javier@javigon.com, chaitanyak@nvidia.com,
 linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, axboe@kernel.dk, msnitzer@redhat.com
Subject: Re: [PATCH v2 05/10] block: add emulation for copy
Message-ID: <202202081132.axCkiVgv-lkp@intel.com>
References: <20220207141348.4235-6-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207141348.4235-6-nj.shetty@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220207_192116_871481_BD3CBBE9 
X-CRM114-Status: GOOD (  18.87  )
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
config: nios2-randconfig-r001-20220207 (https://download.01.org/0day-ci/archive/20220208/202202081132.axCkiVgv-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/a7bb30870db803af4ad955a968992222bcfb478f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-make-bio_map_kern-non-static/20220207-231407
        git checkout a7bb30870db803af4ad955a968992222bcfb478f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   block/blk-lib.c:185:5: warning: no previous prototype for 'blk_copy_offload' [-Wmissing-prototypes]
     185 | int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
         |     ^~~~~~~~~~~~~~~~
>> block/blk-lib.c:275:5: warning: no previous prototype for 'blk_submit_rw_buf' [-Wmissing-prototypes]
     275 | int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
         |     ^~~~~~~~~~~~~~~~~


vim +/blk_submit_rw_buf +275 block/blk-lib.c

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
 > 275	int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
   276					sector_t sector, unsigned int op, gfp_t gfp_mask)
   277	{
   278		struct request_queue *q = bdev_get_queue(bdev);
   279		struct bio *bio, *parent = NULL;
   280		sector_t max_hw_len = min_t(unsigned int, queue_max_hw_sectors(q),
   281				queue_max_segments(q) << (PAGE_SHIFT - SECTOR_SHIFT)) << SECTOR_SHIFT;
   282		sector_t len, remaining;
   283		int ret;
   284	
   285		for (remaining = buf_len; remaining > 0; remaining -= len) {
   286			len = min_t(int, max_hw_len, remaining);
   287	retry:
   288			bio = bio_map_kern(q, buf, len, gfp_mask);
   289			if (IS_ERR(bio)) {
   290				len >>= 1;
   291				if (len)
   292					goto retry;
   293				return PTR_ERR(bio);
   294			}
   295	
   296			bio->bi_iter.bi_sector = sector >> SECTOR_SHIFT;
   297			bio->bi_opf = op;
   298			bio_set_dev(bio, bdev);
   299			bio->bi_end_io = NULL;
   300			bio->bi_private = NULL;
   301	
   302			if (parent) {
   303				bio_chain(parent, bio);
   304				submit_bio(parent);
   305			}
   306			parent = bio;
   307			sector += len;
   308			buf = (char *) buf + len;
   309		}
   310		ret = submit_bio_wait(bio);
   311		bio_put(bio);
   312	
   313		return ret;
   314	}
   315	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

