Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4123FC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 12:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QgX57wnQfudwAlYEy/qKTFLb1irhOD8HoOrFnQW0t18=; b=GtU/a3inoeYCznOfgZpdeIcORn
	dMrsDV6mk+eN+OM5uJDmY67aScj2wbA5rPe06RPISd0Zw3Cy+id3Oq1WcR7FQGekdjvMF9V22jACV
	PrzynxReESO6AWYGr8EE1g6Ez7QHQq9gZgyBla0TUQtiYDw7Tq03D6RAOEzuBC7nnKGjmgvoJHIgc
	ta9jx7Zd9Gkr9kMeGEVUNQDFW7DkfqKVGUE2KhnyQbaP2M5a91NvM050HKo8MweVQYNwTF74kPJOw
	iYi1e3MChfOHOzNb8Z/Oudk8uDGGv8xkpkOqtV3A+NXekkAoIKXGw3v+7dMWHvuGOAGJ0zZ/VGXFR
	KtGW+EcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njh6P-001Mrv-K0; Wed, 27 Apr 2022 12:49:05 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njWYZ-00GtX5-9w
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 01:33:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651023207; x=1682559207;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=G8Dj4gKe1sLtxGIzX7r31BTbZr1Rfh1JubY3941+Lps=;
 b=R8u/emWcKDmand8rNaz+3QfDASXXpouPWSPTsiHlGNo3yLgt5ZoKHgH8
 JKPsXenCNpLC//N1hvuazm9GjDFx9Gf35WLhfpXWpij216ns2lJVn3MwT
 3hpt6v+teN61fzE4eKvkp2HPk3UkthzyszlyQnes8vdIx9EFVX3fzo0l0
 xQJSlD2APEbrqOI8VKgY9kfXPQwNg5b5NIufQzd6281n7iaB+pHDDg8dM
 QRyH7hUSuFzlS+J39BhttIXZ4eeiythBMKjdKNKV6aEGBdN5ti4rBsDQk
 kilJ1y1TFCf+n1lShDBSwtSvPgUHkBS2hsVHvEHYuRtnmyXF19WYXv0XS A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265939925"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="265939925"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Apr 2022 18:33:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; d="scan'208";a="617279875"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
 by fmsmga008.fm.intel.com with ESMTP; 26 Apr 2022 18:33:17 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
 (envelope-from <lkp@intel.com>) id 1njWYO-0004BM-D3;
 Wed, 27 Apr 2022 01:33:16 +0000
Date: Wed, 27 Apr 2022 09:33:04 +0800
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
 Nitesh Shetty <nj.shetty@samsung.com>, Vincent Fu <vincent.fu@samsung.com>,
 Arnav Dawn <arnav.dawn@samsung.com>,
 Alasdair Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH v4 04/10] block: add emulation for copy
Message-ID: <202204270913.Ecb3uQx1-lkp@intel.com>
References: <20220426101241.30100-5-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426101241.30100-5-nj.shetty@samsung.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220426_183327_427037_C5B44E34 
X-CRM114-Status: GOOD (  14.92  )
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
config: hexagon-randconfig-r041-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270913.Ecb3uQx1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c406c5145dc7d628d4197f6726c23a3f1179b88e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nitesh-Shetty/block-Introduce-queue-limits-for-copy-offload-support/20220426-201825
        git checkout c406c5145dc7d628d4197f6726c23a3f1179b88e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   block/blk-lib.c:178:5: warning: no previous prototype for function 'blk_copy_offload' [-Wmissing-prototypes]
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
       ^
   block/blk-lib.c:178:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blk_copy_offload(struct block_device *src_bdev, int nr_srcs,
   ^
   static 
>> block/blk-lib.c:276:5: warning: no previous prototype for function 'blk_submit_rw_buf' [-Wmissing-prototypes]
   int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
       ^
   block/blk-lib.c:276:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
   ^
   static 
   2 warnings generated.


vim +/blk_submit_rw_buf +276 block/blk-lib.c

   275	
 > 276	int blk_submit_rw_buf(struct block_device *bdev, void *buf, sector_t buf_len,
   277					sector_t sector, unsigned int op, gfp_t gfp_mask)
   278	{
   279		struct request_queue *q = bdev_get_queue(bdev);
   280		struct bio *bio, *parent = NULL;
   281		sector_t max_hw_len = min_t(unsigned int, queue_max_hw_sectors(q),
   282				queue_max_segments(q) << (PAGE_SHIFT - SECTOR_SHIFT)) << SECTOR_SHIFT;
   283		sector_t len, remaining;
   284		int ret;
   285	
   286		for (remaining = buf_len; remaining > 0; remaining -= len) {
   287			len = min_t(int, max_hw_len, remaining);
   288	retry:
   289			bio = bio_map_kern(q, buf, len, gfp_mask);
   290			if (IS_ERR(bio)) {
   291				len >>= 1;
   292				if (len)
   293					goto retry;
   294				return PTR_ERR(bio);
   295			}
   296	
   297			bio->bi_iter.bi_sector = sector >> SECTOR_SHIFT;
   298			bio->bi_opf = op;
   299			bio_set_dev(bio, bdev);
   300			bio->bi_end_io = NULL;
   301			bio->bi_private = NULL;
   302	
   303			if (parent) {
   304				bio_chain(parent, bio);
   305				submit_bio(parent);
   306			}
   307			parent = bio;
   308			sector += len;
   309			buf = (char *) buf + len;
   310		}
   311		ret = submit_bio_wait(bio);
   312		bio_put(bio);
   313	
   314		return ret;
   315	}
   316	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

